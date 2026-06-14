from __future__ import annotations

import json
import re
import sys
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
REPORT_PATH = ROOT / "docs" / "validation_report.md"


@dataclass
class TrackResult:
    name: str
    instances: int = 0
    labels: int = 0
    problems: list[str] = field(default_factory=list)
    checks: list[str] = field(default_factory=list)

    @property
    def passed(self) -> bool:
        return not self.problems


def read_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def line_count(text: str) -> int:
    return len(text.splitlines())


def line_at(lines: list[str], line_number: int) -> str:
    return lines[line_number - 1] if 1 <= line_number <= len(lines) else ""


def context(lines: list[str], line_number: int, radius: int = 2) -> str:
    start = max(1, line_number - radius)
    end = min(len(lines), line_number + radius)
    return "\n".join(lines[start - 1 : end])


def identifiers(text: str) -> set[str]:
    ignore = {
        "a",
        "an",
        "and",
        "are",
        "as",
        "at",
        "be",
        "but",
        "by",
        "can",
        "cause",
        "causes",
        "creating",
        "in",
        "inside",
        "is",
        "it",
        "of",
        "or",
        "so",
        "the",
        "to",
        "with",
        "without",
    }
    return {
        token
        for token in re.findall(r"[A-Za-z_][A-Za-z0-9_$]*", text)
        if len(token) > 2 and token.lower() not in ignore
    }


def has_hdl_evidence(text: str) -> bool:
    code_lines = [
        line.strip()
        for line in text.splitlines()
        if line.strip() and not line.strip().startswith("//")
    ]
    return any(re.search(r"\b(always|assign|module|if|case|localparam|parameter|logic|wire|reg)\b|[<>=(){}.;]", line) for line in code_lines)


def source_path_from_release(value: str) -> Path:
    return ROOT / value.replace("\\", "/")


def validate_lint_localization() -> TrackResult:
    result = TrackResult(
        "RTL lint localization",
        checks=[
            "Each JSON instance parses and contains embedded module code.",
            "Each gold label has taxonomy, description, and positive in-bounds line number.",
            "Duplicate `(taxonomy_title, error_line)` labels are rejected within an instance.",
            "The labeled line has nearby non-comment HDL evidence.",
        ],
    )
    for path in sorted((ROOT / "data" / "rtl_lint_localization" / "json").glob("multi_error_*.json")):
        result.instances += 1
        try:
            payload = read_json(path)
        except Exception as exc:
            result.problems.append(f"{path.relative_to(ROOT)}: invalid JSON: {exc}")
            continue

        module_code = payload.get("module_code")
        errors = payload.get("errors")
        if not isinstance(module_code, str) or not module_code.strip():
            result.problems.append(f"{path.relative_to(ROOT)}: missing non-empty module_code")
            continue
        if not isinstance(errors, list):
            result.problems.append(f"{path.relative_to(ROOT)}: errors must be a list")
            continue

        lines = module_code.splitlines()
        seen: set[tuple[str, int]] = set()
        for idx, error in enumerate(errors):
            result.labels += 1
            taxonomy = error.get("taxonomy_title")
            description = error.get("error_description")
            line_number = error.get("error_line")
            if not isinstance(taxonomy, str) or not taxonomy.strip():
                result.problems.append(f"{path.relative_to(ROOT)} error {idx}: missing taxonomy_title")
            if not isinstance(description, str) or not description.strip():
                result.problems.append(f"{path.relative_to(ROOT)} error {idx}: missing error_description")
            if not isinstance(line_number, int) or line_number <= 0:
                result.problems.append(f"{path.relative_to(ROOT)} error {idx}: invalid error_line {line_number!r}")
                continue
            if line_number > len(lines):
                result.problems.append(
                    f"{path.relative_to(ROOT)} error {idx}: line {line_number} exceeds {len(lines)} source lines"
                )
                continue
            key = (taxonomy or "", line_number)
            if key in seen:
                result.problems.append(f"{path.relative_to(ROOT)} error {idx}: duplicate lint label {key}")
            seen.add(key)
            if not has_hdl_evidence(context(lines, line_number)):
                result.problems.append(
                    f"{path.relative_to(ROOT)} error {idx}: no HDL evidence near line {line_number}"
                )
    return result


def validate_cdc() -> TrackResult:
    result = TrackResult(
        "CDC verification",
        checks=[
            "Each error report parses and has a colocated HDL source file.",
            "Each gold violation has description, file name, and positive in-bounds line number.",
            "Duplicate `(file_name, line, description)` violations are rejected within a fixture.",
            "The labeled line has nearby HDL evidence and either a CDC marker or named-signal overlap.",
        ],
    )
    for report_path in sorted((ROOT / "data" / "cdc").glob("*/*_errors.json")):
        result.instances += 1
        try:
            payload = read_json(report_path)
        except Exception as exc:
            result.problems.append(f"{report_path.relative_to(ROOT)}: invalid JSON: {exc}")
            continue

        errors = payload.get("errors") or payload.get("violations")
        if not isinstance(errors, list):
            result.problems.append(f"{report_path.relative_to(ROOT)}: errors must be a list")
            continue

        seen: set[tuple[str, int, str]] = set()
        for idx, error in enumerate(errors):
            result.labels += 1
            file_name = error.get("file_name")
            description = error.get("description")
            line_number = error.get("line")
            if not isinstance(file_name, str) or not file_name.strip():
                result.problems.append(f"{report_path.relative_to(ROOT)} error {idx}: missing file_name")
                continue
            if not isinstance(description, str) or not description.strip():
                result.problems.append(f"{report_path.relative_to(ROOT)} error {idx}: missing description")
            source_path = report_path.parent / file_name
            if not source_path.exists():
                result.problems.append(f"{report_path.relative_to(ROOT)} error {idx}: missing source {file_name}")
                continue
            lines = source_path.read_text(encoding="utf-8", errors="ignore").splitlines()
            if not isinstance(line_number, int) or line_number <= 0:
                result.problems.append(f"{report_path.relative_to(ROOT)} error {idx}: invalid line {line_number!r}")
                continue
            if line_number > len(lines):
                result.problems.append(
                    f"{report_path.relative_to(ROOT)} error {idx}: line {line_number} exceeds {len(lines)} source lines"
                )
                continue
            key = (file_name, line_number, description or "")
            if key in seen:
                result.problems.append(f"{report_path.relative_to(ROOT)} error {idx}: duplicate CDC violation {key}")
            seen.add(key)

            window = context(lines, line_number, radius=3)
            overlap = identifiers(description or "") & identifiers(window)
            if not has_hdl_evidence(window):
                result.problems.append(
                    f"{report_path.relative_to(ROOT)} error {idx}: no HDL evidence near line {line_number}"
                )
            if "CDC_" not in window and not overlap:
                result.problems.append(
                    f"{report_path.relative_to(ROOT)} error {idx}: no CDC marker or signal overlap near line {line_number}"
                )
    return result


def validate_rca() -> TrackResult:
    result = TrackResult(
        "Root-cause analysis",
        checks=[
            "Each released RCA row references existing injected and fixed directories.",
            "Each root cause has type, description, file path, and positive in-bounds line number.",
            "Duplicate `(file, line, root_type)` labels are rejected within an RCA scenario.",
            "The labeled line has nearby root-cause evidence from HDL code, comments, or shared identifiers.",
        ],
    )
    ann_path = ROOT / "release" / "annotations" / "rca.jsonl"
    for raw in ann_path.read_text(encoding="utf-8").splitlines():
        if not raw.strip():
            continue
        row = json.loads(raw)
        result.instances += 1
        injected_dir = source_path_from_release(row.get("injected_dir", ""))
        fixed_dir = source_path_from_release(row.get("fixed_dir", ""))
        if not injected_dir.is_dir():
            result.problems.append(f"{row.get('instance_id')}: missing injected_dir {row.get('injected_dir')}")
        if not fixed_dir.is_dir():
            result.problems.append(f"{row.get('instance_id')}: missing fixed_dir {row.get('fixed_dir')}")
        if int(row.get("injected_violation_count", -1)) <= int(row.get("fixed_violation_count", -1)):
            result.problems.append(f"{row.get('instance_id')}: injected count must exceed fixed count")

        seen: set[tuple[str, int, str]] = set()
        for idx, root_cause in enumerate(row.get("root_causes", [])):
            result.labels += 1
            file_value = root_cause.get("file")
            root_type = root_cause.get("root_type")
            description = root_cause.get("description")
            line_number = root_cause.get("line")
            if not isinstance(file_value, str) or not file_value.strip():
                result.problems.append(f"{row.get('instance_id')} root {idx}: missing file")
                continue
            if not isinstance(root_type, str) or not root_type.strip():
                result.problems.append(f"{row.get('instance_id')} root {idx}: missing root_type")
            if not isinstance(description, str) or not description.strip():
                result.problems.append(f"{row.get('instance_id')} root {idx}: missing description")
            source_path = source_path_from_release(file_value)
            if not source_path.exists():
                result.problems.append(f"{row.get('instance_id')} root {idx}: missing source {file_value}")
                continue
            lines = source_path.read_text(encoding="utf-8", errors="ignore").splitlines()
            if not isinstance(line_number, int) or line_number <= 0:
                result.problems.append(f"{row.get('instance_id')} root {idx}: invalid line {line_number!r}")
                continue
            if line_number > len(lines):
                result.problems.append(
                    f"{row.get('instance_id')} root {idx}: line {line_number} exceeds {len(lines)} source lines"
                )
                continue
            key = (file_value, line_number, root_type or "")
            if key in seen:
                result.problems.append(f"{row.get('instance_id')} root {idx}: duplicate RCA root {key}")
            seen.add(key)
            window = context(lines, line_number, radius=3)
            overlap = identifiers(description or "") & identifiers(window)
            if not has_hdl_evidence(window):
                result.problems.append(
                    f"{row.get('instance_id')} root {idx}: no HDL evidence near line {line_number}"
                )
            if not overlap and "ROOT BUG" not in window:
                result.problems.append(
                    f"{row.get('instance_id')} root {idx}: no root-cause identifier overlap near line {line_number}"
                )
    return result


def render_report(results: list[TrackResult]) -> str:
    total_instances = sum(result.instances for result in results)
    total_labels = sum(result.labels for result in results)
    total_problems = sum(len(result.problems) for result in results)
    status = "PASS" if total_problems == 0 else "FAIL"

    lines = [
        "# Non-Scalability Validation Report",
        "",
        f"Status: **{status}**",
        "",
        "This report is generated by `python3 scripts/validate_non_scalability_tracks.py`.",
        "It validates the RTL lint localization, CDC verification, and RCA tracks that are not covered by the scalability-only validation report.",
        "",
        "## Summary",
        "",
        "| Track | Instances | Labels checked | Problems |",
        "| --- | ---: | ---: | ---: |",
    ]
    for result in results:
        lines.append(
            f"| {result.name} | {result.instances} | {result.labels} | {len(result.problems)} |"
        )
    lines.extend(
        [
            f"| **Total** | **{total_instances}** | **{total_labels}** | **{total_problems}** |",
            "",
            "## Validation Criteria",
            "",
        ]
    )
    for result in results:
        lines.append(f"### {result.name}")
        for check in result.checks:
            lines.append(f"- {check}")
        lines.append("")

    lines.extend(
        [
            "## Ambiguity Policy",
            "",
            "- This checker verifies that each label is source-grounded and structurally reproducible; it is not a substitute for commercial signoff.",
            "- Semantic evidence is intentionally conservative: the checker requires nearby HDL code plus CDC markers or identifier overlap where applicable.",
            "- Any future label that is semantically valid but lacks local source evidence should be documented as an ambiguous case before release.",
            "",
            "## Problems",
            "",
        ]
    )
    problems = [problem for result in results for problem in result.problems]
    if not problems:
        lines.append("No validation problems were found.")
    else:
        for problem in problems:
            lines.append(f"- {problem}")
    lines.append("")
    return "\n".join(lines)


def main() -> int:
    results = [validate_lint_localization(), validate_cdc(), validate_rca()]
    report = render_report(results)
    REPORT_PATH.write_text(report, encoding="utf-8")
    print(report)
    return 0 if all(result.passed for result in results) else 1


if __name__ == "__main__":
    raise SystemExit(main())
