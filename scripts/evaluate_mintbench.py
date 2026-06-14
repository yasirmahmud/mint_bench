from __future__ import annotations

import argparse
import json
import os
import sys
import urllib.error
import urllib.request
from dataclasses import dataclass
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]


@dataclass(frozen=True)
class GoldItem:
    instance_id: str
    task: str
    file_name: str | None
    line: int
    description: str
    label: str | None


@dataclass(frozen=True)
class PredItem:
    file_name: str | None
    line: int | None
    description: str
    label: str | None


def read_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def basename(value: str | None) -> str | None:
    return Path(value).name if value else None


def item_line(item: dict[str, Any]) -> int | None:
    value = item.get("line") or item.get("error_line") or item.get("line_number")
    return int(value) if value is not None else None


def item_label(item: dict[str, Any]) -> str | None:
    return (
        item.get("taxonomy_title")
        or item.get("rule")
        or item.get("root_type")
        or item.get("type")
        or item.get("root_cause_type")
    )


def item_description(item: dict[str, Any]) -> str:
    return str(item.get("description") or item.get("error_description") or item_label(item) or "")


def prediction_items(value: Any) -> list[PredItem]:
    if value is None:
        return []
    raw_items: list[Any]
    if isinstance(value, list):
        raw_items = value
    elif isinstance(value, dict):
        raw_items = []
        for key in ("violations", "targets", "root_causes", "errors"):
            if isinstance(value.get(key), list):
                raw_items = value[key]
                break
    else:
        raw_items = []

    items: list[PredItem] = []
    for raw in raw_items:
        if not isinstance(raw, dict):
            continue
        items.append(
            PredItem(
                file_name=basename(raw.get("file_name") or raw.get("file") or raw.get("file_path")),
                line=item_line(raw),
                description=item_description(raw),
                label=item_label(raw),
            )
        )
    return items


def load_lint_gold(data_dir: Path) -> list[GoldItem]:
    rows: list[GoldItem] = []
    for path in sorted((data_dir / "rtl_lint_localization" / "json").glob("*.json")):
        payload = read_json(path)
        for err in payload.get("errors", []):
            rows.append(
                GoldItem(
                    instance_id=path.stem,
                    task="lint_localization",
                    file_name=None,
                    line=int(err["error_line"]),
                    description=str(err.get("error_description") or ""),
                    label=str(err.get("taxonomy_title") or ""),
                )
            )
    return rows


def load_issue_report_gold(data_dir: Path, task: str) -> list[GoldItem]:
    rows: list[GoldItem] = []
    pattern = "*/*_errors.json" if task == "cdc_verification" else "*/benchmark.json"
    search_root = data_dir / ("cdc" if task == "cdc_verification" else "scalability")
    for path in sorted(search_root.glob(pattern)):
        payload = read_json(path)
        issues = payload.get("violations") or payload.get("errors") or []
        instance_id = path.stem if task == "cdc_verification" else path.parent.name
        for issue in issues:
            line = item_line(issue)
            if line is None:
                continue
            rows.append(
                GoldItem(
                    instance_id=instance_id,
                    task=task,
                    file_name=basename(issue.get("file_name") or issue.get("file") or issue.get("file_path")),
                    line=line,
                    description=item_description(issue),
                    label=item_label(issue),
                )
            )
    return rows


def load_rca_gold(data_dir: Path) -> list[GoldItem]:
    rows: list[GoldItem] = []
    payload = read_json(data_dir / "root_cause_analysis" / "benchmark.json")
    for instance in payload.get("instances", []):
        for root in instance.get("root_causes", []):
            rows.append(
                GoldItem(
                    instance_id=instance["instance_id"],
                    task="rca",
                    file_name=basename(root.get("file") or root.get("file_path")),
                    line=int(root["line"]),
                    description=str(root.get("description") or ""),
                    label=str(root.get("root_type") or ""),
                )
            )
    return rows


def load_gold(data_dir: Path) -> dict[str, list[GoldItem]]:
    rows: list[GoldItem] = []
    rows.extend(load_lint_gold(data_dir))
    rows.extend(load_issue_report_gold(data_dir, "cdc_verification"))
    rows.extend(load_rca_gold(data_dir))
    rows.extend(load_issue_report_gold(data_dir, "scalability"))

    grouped: dict[str, list[GoldItem]] = {}
    for row in rows:
        grouped.setdefault(row.instance_id, []).append(row)
    return grouped


def same_location(gold: GoldItem, pred: PredItem) -> bool:
    if pred.line != gold.line:
        return False
    if gold.file_name is None:
        return True
    return pred.file_name == gold.file_name


def llm_judge(gold: GoldItem, pred: PredItem, model: str, endpoint: str, token: str) -> dict[str, Any]:
    prompt = (
        "You are judging an HDL lint benchmark prediction. "
        "Return only JSON with keys correct (boolean) and rationale (short string). "
        "The line already matches; decide whether the predicted description identifies the same issue.\n\n"
        f"Task: {gold.task}\n"
        f"Gold label/type: {gold.label or ''}\n"
        f"Gold description: {gold.description}\n"
        f"Predicted label/type: {pred.label or ''}\n"
        f"Predicted description: {pred.description}\n"
    )
    payload = {
        "model": model,
        "messages": [
            {"role": "system", "content": "You are a strict evaluator for HDL lint benchmark outputs."},
            {"role": "user", "content": prompt},
        ],
        "temperature": 0,
        "response_format": {"type": "json_object"},
    }
    request = urllib.request.Request(
        endpoint,
        data=json.dumps(payload).encode("utf-8"),
        headers={
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json",
        },
        method="POST",
    )
    try:
        with urllib.request.urlopen(request, timeout=60) as response:
            body = json.loads(response.read().decode("utf-8"))
    except (urllib.error.URLError, TimeoutError, json.JSONDecodeError) as exc:
        return {"correct": False, "rationale": f"LLM judge failed: {exc}"}

    content = body["choices"][0]["message"]["content"]
    try:
        result = json.loads(content)
    except json.JSONDecodeError:
        return {"correct": False, "rationale": "LLM judge returned non-JSON content."}
    return {"correct": bool(result.get("correct")), "rationale": str(result.get("rationale") or "")}


def evaluate_instance(
    instance_id: str,
    gold_items: list[GoldItem],
    pred_items: list[PredItem],
    use_llm: bool,
    model: str,
    endpoint: str,
    token: str | None,
) -> dict[str, Any]:
    unmatched = list(pred_items)
    matches: list[dict[str, Any]] = []

    for gold in gold_items:
        pred_index = next((idx for idx, pred in enumerate(unmatched) if same_location(gold, pred)), None)
        if pred_index is None:
            matches.append(
                {
                    "line_match": False,
                    "match": False,
                    "description_correct": False,
                    "gold": gold.__dict__,
                    "prediction": None,
                    "rationale": "No prediction matched the gold file/line.",
                }
            )
            continue

        pred = unmatched.pop(pred_index)
        if use_llm:
            if token is None:
                judge = {"correct": False, "rationale": "LLM judging requested but no API token was provided."}
            else:
                judge = llm_judge(gold, pred, model, endpoint, token)
        else:
            judge = {"correct": False, "rationale": "LLM judging disabled; final match requires an LLM-approved description."}

        matches.append(
            {
                "line_match": True,
                "match": judge["correct"] is True,
                "description_correct": judge["correct"],
                "gold": gold.__dict__,
                "prediction": pred.__dict__,
                "rationale": judge["rationale"],
            }
        )

    return {
        "instance_id": instance_id,
        "task": gold_items[0].task if gold_items else None,
        "gold_count": len(gold_items),
        "prediction_count": len(pred_items),
        "line_matches": sum(1 for match in matches if match["line_match"]),
        "matches": sum(1 for match in matches if match["match"] is True),
        "false_positive_predictions": [pred.__dict__ for pred in unmatched],
        "judgments": matches,
    }


def summarize(instances: list[dict[str, Any]], use_llm: bool) -> dict[str, Any]:
    gold_total = sum(row["gold_count"] for row in instances)
    pred_total = sum(row["prediction_count"] for row in instances)
    line_matches = sum(row["line_matches"] for row in instances)
    final_matches = sum(row["matches"] for row in instances)
    false_positive_total = sum(len(row["false_positive_predictions"]) for row in instances)
    summary = {
        "instances": len(instances),
        "gold_items": gold_total,
        "predicted_items": pred_total,
        "matches": final_matches,
        "match_recall": round(final_matches / gold_total, 4) if gold_total else 0.0,
        "match_precision": round(final_matches / pred_total, 4) if pred_total else 0.0,
        "line_matches": line_matches,
        "line_match_recall": round(line_matches / gold_total, 4) if gold_total else 0.0,
        "line_match_precision": round(line_matches / pred_total, 4) if pred_total else 0.0,
        "false_positive_predictions": false_positive_total,
        "llm_description_judging": use_llm,
    }
    summary["description_correct_after_line_match"] = final_matches
    summary["description_accuracy_on_line_matches"] = round(final_matches / line_matches, 4) if line_matches else 0.0
    return summary


def main() -> int:
    parser = argparse.ArgumentParser(description="Evaluate MintBench predictions by file/line match plus LLM description judging.")
    parser.add_argument("--predictions", required=True, help="JSON object keyed by instance_id.")
    parser.add_argument("--data-dir", default=str(ROOT / "data"), help="Benchmark data directory. Defaults to ./data.")
    parser.add_argument("--output", help="Write JSON report to this path. Defaults to stdout.")
    parser.add_argument("--llm-check", action="store_true", help="Use an OpenAI-compatible chat completions endpoint to judge descriptions after line match. Without this, final matches are not awarded.")
    parser.add_argument("--llm-model", default=os.getenv("MINTBENCH_LLM_MODEL", "gemini-3.1-flash"))
    parser.add_argument("--llm-endpoint", default=os.getenv("MINTBENCH_LLM_ENDPOINT", "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions"))
    parser.add_argument("--llm-api-key", default=os.getenv("MINTBENCH_LLM_API_KEY"))
    args = parser.parse_args()
    if args.llm_check and not args.llm_api_key:
        raise SystemExit("--llm-check requires --llm-api-key or MINTBENCH_LLM_API_KEY.")

    gold = load_gold(Path(args.data_dir))
    predictions = read_json(Path(args.predictions))
    if not isinstance(predictions, dict):
        raise SystemExit("Predictions must be a JSON object keyed by instance_id.")

    instances = [
        evaluate_instance(
            instance_id,
            gold_items,
            prediction_items(predictions.get(instance_id)),
            args.llm_check,
            args.llm_model,
            args.llm_endpoint,
            args.llm_api_key,
        )
        for instance_id, gold_items in sorted(gold.items())
    ]
    report = {"summary": summarize(instances, args.llm_check), "instances": instances}
    text = json.dumps(report, indent=2) + "\n"
    if args.output:
        out_path = Path(args.output)
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(text, encoding="utf-8")
    else:
        sys.stdout.write(text)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
