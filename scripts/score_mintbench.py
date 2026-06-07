#!/usr/bin/env python3
"""Score MintBench predictions against the generated benchmark manifest.

The predictions JSON is intentionally tolerant:

- top-level keys are instance IDs
- each instance may contain `violations`, `targets`, or `root_causes`
- predicted items may use either `rule` or `taxonomy_title`
- predicted items may use either `line` or `error_line`

For the intended benchmark release, exact match is the primary metric.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]


def read_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text())


def normalize_item(item: dict[str, Any], task: str) -> tuple[Any, ...]:
    file_name = item.get("file_name") or item.get("file") or item.get("file_path")
    file_name = Path(file_name).name if file_name else None
    line = item.get("line") or item.get("error_line") or item.get("line_number")
    line = int(line) if line is not None else None

    if task == "lint_localization":
        label = item.get("taxonomy_title") or item.get("rule")
        return (label, line)
    if task == "rca":
        root_type = item.get("root_type") or item.get("type") or item.get("root_cause_type")
        return (file_name, line, root_type)
    return (item.get("rule") or item.get("taxonomy_title"), file_name, line)


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


def score_instance(gold_row: dict[str, Any], pred_row: Any) -> dict[str, Any]:
    task = gold_row["task"]
    if task == "rca":
        gold_items = gold_row["root_causes"]
    elif task == "lint_localization":
        gold_items = gold_row["gold_errors"]
    else:
        gold_items = gold_row.get("gold_violations", gold_row.get("violations", []))

    pred_items = extract_prediction_items(pred_row)

    gold_norm = {normalize_item(item, task) for item in gold_items}
    pred_norm = {normalize_item(item, task) for item in pred_items}

    tp = len(gold_norm & pred_norm)
    fp = len(pred_norm - gold_norm)
    fn = len(gold_norm - pred_norm)
    precision = tp / (tp + fp) if tp + fp else 0.0
    recall = tp / (tp + fn) if tp + fn else 0.0
    f1 = (2 * precision * recall / (precision + recall)) if precision + recall else 0.0

    return {
        "instance_id": gold_row["instance_id"],
        "task": task,
        "gold_count": len(gold_norm),
        "pred_count": len(pred_norm),
        "tp": tp,
        "fp": fp,
        "fn": fn,
        "precision": round(precision, 4),
        "recall": round(recall, 4),
        "f1": round(f1, 4),
        "exact_match": gold_norm == pred_norm,
    }


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--manifest", required=True)
    ap.add_argument("--predictions", required=True)
    args = ap.parse_args()

    manifest = read_json(Path(args.manifest))
    preds = read_json(Path(args.predictions))

    rows: list[dict[str, Any]] = []
    for track in manifest["tracks"]:
        ann_path = ROOT / track["annotation_file"]
        for gold_row in [json.loads(line) for line in ann_path.read_text().splitlines() if line.strip()]:
            pred_row = preds.get(gold_row["instance_id"])
            rows.append(score_instance(gold_row, pred_row))

    total_tp = sum(r["tp"] for r in rows)
    total_fp = sum(r["fp"] for r in rows)
    total_fn = sum(r["fn"] for r in rows)
    precision = total_tp / (total_tp + total_fp) if total_tp + total_fp else 0.0
    recall = total_tp / (total_tp + total_fn) if total_tp + total_fn else 0.0
    f1 = (2 * precision * recall / (precision + recall)) if precision + recall else 0.0
    exact = sum(1 for r in rows if r["exact_match"])

    summary = {
        "instances": len(rows),
        "exact_match_instances": exact,
        "micro_precision": round(precision, 4),
        "micro_recall": round(recall, 4),
        "micro_f1": round(f1, 4),
        "per_task": {},
    }
    for task in sorted({r["task"] for r in rows}):
        task_rows = [r for r in rows if r["task"] == task]
        tp = sum(r["tp"] for r in task_rows)
        fp = sum(r["fp"] for r in task_rows)
        fn = sum(r["fn"] for r in task_rows)
        p = tp / (tp + fp) if tp + fp else 0.0
        r = tp / (tp + fn) if tp + fn else 0.0
        f = (2 * p * r / (p + r)) if p + r else 0.0
        summary["per_task"][task] = {
            "instances": len(task_rows),
            "exact_match_instances": sum(1 for x in task_rows if x["exact_match"]),
            "micro_precision": round(p, 4),
            "micro_recall": round(r, 4),
            "micro_f1": round(f, 4),
        }

    print(json.dumps({"summary": summary, "instances": rows}, indent=2))


if __name__ == "__main__":
    main()
