from __future__ import annotations

import json
import re
import sys
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[1]


def read_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def numbers(text: str) -> list[int]:
    return [int(match.replace(",", "")) for match in re.findall(r"\d[\d,]*", text)]


def markdown_table_rows(path: Path) -> dict[str, list[str]]:
    rows: dict[str, list[str]] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        stripped = line.strip()
        if not stripped.startswith("|") or "---" in stripped:
            continue
        cells = [cell.strip() for cell in stripped.strip("|").split("|")]
        if cells:
            rows[cells[0]] = cells
    return rows


def track_stats(manifest: dict[str, Any], name: str) -> dict[str, Any]:
    for track in manifest["tracks"]:
        if track["name"] == name:
            return track["stats"]
    raise KeyError(f"Missing track in manifest: {name}")


def require_row_numbers(
    failures: list[str],
    rows: dict[str, list[str]],
    row_label: str,
    expected: list[int],
    source: str,
) -> None:
    if row_label not in rows:
        failures.append(f"{source}: missing row {row_label!r}")
        return
    actual = numbers(" ".join(rows[row_label][1:]))
    for value in expected:
        if value not in actual:
            failures.append(f"{source}: row {row_label!r} missing expected count {value}; found {actual}")


def main() -> int:
    manifest = read_json(ROOT / "release" / "mintbench_manifest.json")
    readme_rows = markdown_table_rows(ROOT / "README.md")
    stats_rows = markdown_table_rows(ROOT / "release" / "mintbench_stats.md")
    failures: list[str] = []

    lint = track_stats(manifest, "rtl_lint_localization")
    cdc = track_stats(manifest, "cdc_verification")
    rca = track_stats(manifest, "rca")
    scalability = track_stats(manifest, "scalability")

    expected_readme = [
        ("RTL lint localization", [lint["instances"], lint["errors"], lint["taxonomy_families"]]),
        ("CDC verification", [cdc["instances"], cdc["violations"]]),
        ("Root-cause analysis", [rca["instances"], rca["root_cause_annotations"]]),
        (
            "Scalability",
            [
                scalability["designs"],
                scalability["source_file_count"],
                scalability["violation_count"],
            ],
        ),
    ]
    for row_label, expected in expected_readme:
        require_row_numbers(failures, readme_rows, row_label, expected, "README.md")

    expected_stats = [
        ("RTL lint localization", [lint["instances"], lint["errors"], lint["taxonomy_families"]]),
        ("CDC verification", [cdc["instances"], cdc["violations"]]),
        ("RCA", [rca["instances"], rca["root_cause_annotations"]]),
        ("Scalability", [scalability["designs"], scalability["violation_count"]]),
    ]
    for row_label, expected in expected_stats:
        require_row_numbers(failures, stats_rows, row_label, expected, "release/mintbench_stats.md")

    if failures:
        for failure in failures:
            print(failure, file=sys.stderr)
        return 1

    print("Release documentation counts match release/mintbench_manifest.json.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
