from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]


def read_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def write_report(path: Path | None, report: dict[str, Any]) -> None:
    text = json.dumps(report, indent=2, sort_keys=True) + "\n"
    if path is None:
        sys.stdout.write(text)
        return
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


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
    return (item.get("rule") or item.get("taxonomy_title") or item.get("description"), file_name, line)


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
    if not gold_norm and not pred_norm:
        precision = 1.0
        recall = 1.0
        f1 = 1.0
    else:
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


def summarize(rows: list[dict[str, Any]]) -> dict[str, Any]:
    total_tp = sum(r["tp"] for r in rows)
    total_fp = sum(r["fp"] for r in rows)
    total_fn = sum(r["fn"] for r in rows)
    precision = total_tp / (total_tp + total_fp) if total_tp + total_fp else 0.0
    recall = total_tp / (total_tp + total_fn) if total_tp + total_fn else 0.0
    f1 = (2 * precision * recall / (precision + recall)) if precision + recall else 0.0
    exact = sum(1 for r in rows if r["exact_match"])
    macro_f1 = sum(r["f1"] for r in rows) / len(rows) if rows else 0.0

    summary: dict[str, Any] = {
        "instances": len(rows),
        "exact_match_instances": exact,
        "micro_precision": round(precision, 4),
        "micro_recall": round(recall, 4),
        "micro_f1": round(f1, 4),
        "macro_f1": round(macro_f1, 4),
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
            "macro_f1": round(sum(x["f1"] for x in task_rows) / len(task_rows), 4),
        }
    return summary


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--manifest", required=True)
    ap.add_argument("--predictions", required=True)
    ap.add_argument("--output", help="Optional path for the JSON score report. Defaults to stdout.")
    args = ap.parse_args()

    manifest = read_json(Path(args.manifest))
    preds = read_json(Path(args.predictions))

    rows: list[dict[str, Any]] = []
    for track in manifest["tracks"]:
        ann_path = ROOT / track["annotation_file"]
        for gold_row in [json.loads(line) for line in ann_path.read_text(encoding="utf-8").splitlines() if line.strip()]:
            pred_row = preds.get(gold_row["instance_id"])
            rows.append(score_instance(gold_row, pred_row))

    write_report(Path(args.output) if args.output else None, {"summary": summarize(rows), "instances": rows})


if __name__ == "__main__":
    main()
