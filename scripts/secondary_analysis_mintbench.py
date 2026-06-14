from __future__ import annotations

import argparse
import json
import os
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
ANALYSIS_VERSION = "mintbench-aux-analysis-v1"


def read_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def annotation_rows(manifest: dict[str, Any]) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for track in manifest["tracks"]:
        ann_path = ROOT / track["annotation_file"]
        for line in ann_path.read_text(encoding="utf-8").splitlines():
            if line.strip():
                rows.append(json.loads(line))
    return rows


def extract_prediction_items(pred: Any) -> list[dict[str, Any]]:
    if pred is None:
        return []
    if isinstance(pred, list):
        return [x for x in pred if isinstance(x, dict)]
    if isinstance(pred, dict):
        for key in ("violations", "targets", "root_causes"):
            value = pred.get(key)
            if isinstance(value, list):
                return [x for x in value if isinstance(x, dict)]
    return []


def require_analysis_config() -> tuple[str, str, str, float]:
    access_token = os.environ.get("MINTBENCH_ANALYSIS_ACCESS_TOKEN")
    target = os.environ.get("MINTBENCH_ANALYSIS_TARGET")
    base_url = os.environ.get("MINTBENCH_ANALYSIS_BASE_URL", "https://api.example.com/v1").rstrip("/")
    temperature = float(os.environ.get("MINTBENCH_ANALYSIS_TEMPERATURE", "0"))

    missing = []
    if not access_token:
        missing.append("MINTBENCH_ANALYSIS_ACCESS_TOKEN")
    if not target:
        missing.append("MINTBENCH_ANALYSIS_TARGET")
    if missing:
        sys.stderr.write(
            "Auxiliary analysis requires user-provided service configuration. "
            f"Please set {', '.join(missing)} and rerun this command.\n"
        )
        raise SystemExit(2)
    return access_token, target, base_url, temperature


def build_messages(row: dict[str, Any], prediction: Any) -> list[dict[str, str]]:
    payload = {
        "instance_id": row["instance_id"],
        "task": row["task"],
        "predicted_items": extract_prediction_items(prediction),
    }
    system = "Assess HDL linter benchmark predictions and return compact JSON only."
    user = {
        "analysis_version": ANALYSIS_VERSION,
        "rubric": {
            "score_1": "prediction identifies the same issue location and issue type",
            "score_0_5": "prediction identifies a related issue but has a minor label or location mismatch",
            "score_0": "prediction misses the issue or reports unrelated issues",
        },
        "required_output": {
            "instance_id": row["instance_id"],
            "semantic_score": "number from 0 to 1",
            "matched_gold_count": "integer",
            "false_positive_count": "integer",
            "false_negative_count": "integer",
            "rationale": "short technical reason",
        },
        "case": payload,
    }
    return [
        {"role": "system", "content": system},
        {"role": "user", "content": json.dumps(user, sort_keys=True)},
    ]


def call_analysis_endpoint(
    *,
    access_token: str,
    target: str,
    base_url: str,
    temperature: float,
    messages: list[dict[str, str]],
    timeout: int,
) -> dict[str, Any]:
    body = json.dumps(
        {
            "model": target,
            "messages": messages,
            "temperature": temperature,
            "response_format": {"type": "json_object"},
        }
    ).encode("utf-8")
    req = urllib.request.Request(
        f"{base_url}/chat/completions",
        data=body,
        headers={
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/json",
        },
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            response = json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as exc:
        detail = exc.read().decode("utf-8", errors="replace")
        raise RuntimeError(f"Analysis request failed with HTTP {exc.code}: {detail}") from exc

    content = response["choices"][0]["message"]["content"]
    return json.loads(content)


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--manifest", required=True)
    ap.add_argument("--predictions", required=True)
    ap.add_argument("--output", required=True)
    ap.add_argument("--limit", type=int, help="Optional maximum number of instances to compare.")
    ap.add_argument("--timeout", type=int, default=60)
    ap.add_argument("--sleep", type=float, default=0.0, help="Seconds to wait between API calls.")
    args = ap.parse_args()

    access_token, target, base_url, temperature = require_analysis_config()
    manifest = read_json(Path(args.manifest))
    predictions = read_json(Path(args.predictions))
    rows = annotation_rows(manifest)
    if args.limit is not None:
        rows = rows[: args.limit]

    out_path = Path(args.output)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("w", encoding="utf-8") as out:
        for row in rows:
            analysis = call_analysis_endpoint(
                access_token=access_token,
                target=target,
                base_url=base_url,
                temperature=temperature,
                messages=build_messages(row, predictions.get(row["instance_id"])),
                timeout=args.timeout,
            )
            record = {
                "instance_id": row["instance_id"],
                "task": row["task"],
                "analysis_version": ANALYSIS_VERSION,
                "target": target,
                "base_url": base_url,
                "temperature": temperature,
                "analysis": analysis,
            }
            out.write(json.dumps(record, sort_keys=True) + "\n")
            out.flush()
            if args.sleep:
                time.sleep(args.sleep)


if __name__ == "__main__":
    main()
