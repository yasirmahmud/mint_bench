from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path
from statistics import mean
from typing import Any, Iterable


ROOT = Path(__file__).resolve().parents[1]
RELEASE = ROOT / "release"
ANNOTATIONS = RELEASE / "annotations"


def read_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path: Path, payload: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def write_jsonl(path: Path, rows: Iterable[dict[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as fh:
        for row in rows:
            fh.write(json.dumps(row, sort_keys=True))
            fh.write("\n")


def line_count(text: str) -> int:
    return text.count("\n") + (0 if not text else 1)


def basename(path: str | None) -> str | None:
    if path is None:
        return None
    return Path(path).name


def normalize_violation(v: dict[str, Any]) -> dict[str, Any]:
    return {
        "id": v.get("id"),
        "rule": v.get("rule"),
        "taxonomy_title": v.get("taxonomy_title"),
        "severity": v.get("severity"),
        "classification": v.get("classification"),
        "file_name": basename(v.get("file_name") or v.get("file_path")),
        "file_path": v.get("file_path"),
        "line": int(v.get("line_number") or v.get("line") or 0),
        "column": int(v.get("column") or 0),
        "description": v.get("description") or v.get("error_description"),
        "traditional_static_blind_spot": v.get("traditional_static_blind_spot"),
    }


def lint_annotations() -> tuple[list[dict[str, Any]], dict[str, Any]]:
    src_dir = ROOT / "data" / "rtl_lint_localization" / "json"
    rows: list[dict[str, Any]] = []
    error_counts: list[int] = []
    source_sizes: list[int] = []
    taxonomies: set[str] = set()

    for path in sorted(src_dir.glob("multi_error_*.json"), key=lambda p: int(p.stem.split("_")[-1])):
        payload = read_json(path)
        errors = payload["errors"]
        taxonomies.update(e["taxonomy_title"] for e in errors)
        error_counts.append(len(errors))
        source_code = payload["module_code"]
        source_sizes.append(line_count(source_code))
        rows.append(
            {
                "instance_id": path.stem,
                "task": "lint_localization",
                "source_path": str(path.relative_to(ROOT)),
                "source_format": "module_code_errors",
                "module_code": source_code,
                "source_line_count": line_count(source_code),
                "gold_errors": [
                    {
                        "taxonomy_title": e["taxonomy_title"],
                        "error_description": e["error_description"],
                        "error_line": int(e["error_line"]),
                    }
                    for e in errors
                ],
                "gold_error_count": len(errors),
            }
        )

    stats = {
        "instances": len(rows),
        "errors": sum(error_counts),
        "taxonomy_families": len(taxonomies),
        "min_errors_per_instance": min(error_counts),
        "max_errors_per_instance": max(error_counts),
        "mean_errors_per_instance": round(mean(error_counts), 3),
        "mean_source_lines": round(mean(source_sizes), 3),
    }
    return rows, stats


def tool_report(path: Path, task: str) -> tuple[list[dict[str, Any]], dict[str, Any]]:
    payload = read_json(path)
    rows = [
        {
            "instance_id": path.stem,
            "task": task,
            "source_path": str(path.relative_to(ROOT)),
            "top": payload.get("top"),
            "design_label": payload.get("design_label"),
            "check": payload.get("check"),
            "goal": payload.get("goals"),
            "gold_violation_count": payload.get("violation_count"),
            "gold_violations": [normalize_violation(v) for v in payload.get("violations", [])],
        }
    ]
    stats = {
        "violation_count": payload.get("violation_count"),
        "top": payload.get("top"),
    }
    return rows, stats


def cdc_annotations() -> tuple[list[dict[str, Any]], dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for rel in [
        "data/cdc/cdc_minimal/cdc_minimal_tool_report.json",
        "data/cdc/cdc_protocol/cdc_protocol_tool_report.json",
    ]:
        row, _ = tool_report(ROOT / rel, "cdc_verification")
        rows.extend(row)
    stats = {
        "instances": len(rows),
        "violations": sum(int(r["gold_violation_count"]) for r in rows),
        "mean_violations_per_instance": round(mean(int(r["gold_violation_count"]) for r in rows), 3),
    }
    return rows, stats


RCA_SPECS = [
    {
        "instance_id": "hierarchy_resolution",
        "dataset_path": "data/root_cause_analysis/hierarchy_resolution",
        "top": "sg_bh_top",
        "injected_dir": "data/root_cause_analysis/hierarchy_resolution/injected",
        "fixed_dir": "data/root_cause_analysis/hierarchy_resolution/fixed",
        "injected_violation_count": 34,
        "fixed_violation_count": 0,
        "root_causes": [
            {
                "root_id": "unresolved_unit",
                "root_type": "unresolved_hierarchy",
                "file": "data/root_cause_analysis/hierarchy_resolution/injected/sg_bh_subsystem.sv",
                "line": 31,
        "description": "Typo in the instantiated module name sg_bh_unti causes unresolved hierarchy reports.",
            }
        ],
    },
    {
        "instance_id": "width_cascade",
        "dataset_path": "data/root_cause_analysis/width_cascade",
        "top": "sg_noise_top",
        "injected_dir": "data/root_cause_analysis/width_cascade/injected",
        "fixed_dir": "data/root_cause_analysis/width_cascade/fixed",
        "injected_violation_count": 11,
        "fixed_violation_count": 0,
        "root_causes": [
            {
                "root_id": "width_top",
                "root_type": "width_mismatch",
                "file": "data/root_cause_analysis/width_cascade/injected/sg_noise_top.sv",
                "line": 10,
                "description": "TOP_W is set to 24 instead of DATA_W, causing cascading width mismatches.",
            }
        ],
    },
    {
        "instance_id": "multi_root_width_cascade",
        "dataset_path": "data/root_cause_analysis/multi_root_width_cascade",
        "top": "sg_mroot_top",
        "injected_dir": "data/root_cause_analysis/multi_root_width_cascade/injected",
        "fixed_dir": "data/root_cause_analysis/multi_root_width_cascade/fixed",
        "injected_violation_count": 30,
        "fixed_violation_count": 0,
        "root_causes": [
            {
                "root_id": "width_a",
                "root_type": "width_mismatch",
                "file": "data/root_cause_analysis/multi_root_width_cascade/injected/sg_mroot_subsys_a.sv",
                "line": 8,
                "description": "BUS_W is DATA_W - 8 instead of DATA_W.",
            },
            {
                "root_id": "width_b",
                "root_type": "width_mismatch",
                "file": "data/root_cause_analysis/multi_root_width_cascade/injected/sg_mroot_subsys_b.sv",
                "line": 8,
                "description": "BUS_W is DATA_W - 1 instead of DATA_W.",
            },
            {
                "root_id": "width_c",
                "root_type": "width_mismatch",
                "file": "data/root_cause_analysis/multi_root_width_cascade/injected/sg_mroot_subsys_c.sv",
                "line": 8,
                "description": "BUS_W is DATA_W - 4 instead of DATA_W.",
            },
        ],
    },
    {
        "instance_id": "x_state_package",
        "dataset_path": "data/root_cause_analysis/x_state_package",
        "top": "sg_x_top",
        "injected_dir": "data/root_cause_analysis/x_state_package/injected",
        "fixed_dir": "data/root_cause_analysis/x_state_package/fixed",
        "injected_violation_count": 4,
        "fixed_violation_count": 0,
        "root_causes": [
            {
                "root_id": "x_seed_pkg",
                "root_type": "x_propagation",
                "file": "data/root_cause_analysis/x_state_package/injected/sg_x_00_pkg.sv",
                "line": 4,
                "description": "RESET_SEED is initialized to 'x in the shared package.",
            }
        ],
    },
    {
        "instance_id": "x_state_local",
        "dataset_path": "data/root_cause_analysis/x_state_local",
        "top": "sg_xnp_top",
        "injected_dir": "data/root_cause_analysis/x_state_local/injected",
        "fixed_dir": "data/root_cause_analysis/x_state_local/fixed",
        "injected_violation_count": 4,
        "fixed_violation_count": 0,
        "root_causes": [
            {
                "root_id": "x_seed_top",
                "root_type": "x_propagation",
                "file": "data/root_cause_analysis/x_state_local/injected/sg_xnp_top.sv",
                "line": 14,
                "description": "RESET_SEED is initialized to 'x directly in the top module.",
            }
        ],
    },
    {
        "instance_id": "assignment_semantics_package",
        "dataset_path": "data/root_cause_analysis/assignment_semantics_package",
        "top": "sg_bnb_top",
        "injected_dir": "data/root_cause_analysis/assignment_semantics_package/injected",
        "fixed_dir": "data/root_cause_analysis/assignment_semantics_package/fixed",
        "injected_violation_count": 48,
        "fixed_violation_count": 0,
        "root_causes": [
            {
                "root_id": "bnb_macro_pkg",
                "root_type": "assignment_semantics",
                "file": "data/root_cause_analysis/assignment_semantics_package/injected/sg_bnb_defs.sv",
                "line": 10,
                "description": "The shared macro expands to blocking assignment instead of non-blocking assignment.",
            }
        ],
    },
    {
        "instance_id": "assignment_semantics_local",
        "dataset_path": "data/root_cause_analysis/assignment_semantics_local",
        "top": "sg_bnbn_top",
        "injected_dir": "data/root_cause_analysis/assignment_semantics_local/injected",
        "fixed_dir": "data/root_cause_analysis/assignment_semantics_local/fixed",
        "injected_violation_count": 36,
        "fixed_violation_count": 0,
        "root_causes": [
            {
                "root_id": "bnb_macro_local",
                "root_type": "assignment_semantics",
                "file": "data/root_cause_analysis/assignment_semantics_local/injected/sg_bnbn_defs.sv",
                "line": 11,
                "description": "The shared macro expands to blocking assignment instead of non-blocking assignment.",
            }
        ],
    },
    {
        "instance_id": "packet_width_cascade",
        "dataset_path": "data/root_cause_analysis/packet_width_cascade",
        "top": "sg_pkt_top",
        "injected_dir": "data/root_cause_analysis/packet_width_cascade/injected",
        "fixed_dir": "data/root_cause_analysis/packet_width_cascade/fixed",
        "injected_violation_count": 11,
        "fixed_violation_count": 0,
        "root_causes": [
            {
                "root_id": "packet_width",
                "root_type": "width_mismatch",
                "file": "data/root_cause_analysis/packet_width_cascade/injected/sg_pkt_top.sv",
                "line": 10,
                "description": "BUS_W is set to DATA_W - 8 instead of DATA_W, causing a width cascade in packet logic.",
            }
        ],
    },
    {
        "instance_id": "composite_root_causes",
        "dataset_path": "data/root_cause_analysis/composite_root_causes",
        "top": "sg_all_top",
        "injected_dir": "data/root_cause_analysis/composite_root_causes/injected",
        "fixed_dir": "data/root_cause_analysis/composite_root_causes/fixed",
        "injected_violation_count": 75,
        "fixed_violation_count": 0,
        "root_causes": [
            {
                "root_id": "unresolved_hierarchy",
                "root_type": "unresolved_hierarchy",
                "file": "data/root_cause_analysis/composite_root_causes/injected/sg_bh_subsystem.sv",
                "line": 31,
                "description": "Typo in the instantiated module name sg_bh_unti causes unresolved hierarchy reports.",
            },
            {
                "root_id": "width_top",
                "root_type": "width_mismatch",
                "file": "data/root_cause_analysis/composite_root_causes/injected/sg_noise_top.sv",
                "line": 10,
                "description": "TOP_W is set to 24 instead of DATA_W, causing cascading width mismatches.",
            },
            {
                "root_id": "width_a",
                "root_type": "width_mismatch",
                "file": "data/root_cause_analysis/composite_root_causes/injected/sg_mroot_subsys_a.sv",
                "line": 8,
                "description": "BUS_W is DATA_W - 8 instead of DATA_W.",
            },
            {
                "root_id": "width_b",
                "root_type": "width_mismatch",
                "file": "data/root_cause_analysis/composite_root_causes/injected/sg_mroot_subsys_b.sv",
                "line": 8,
                "description": "BUS_W is DATA_W - 1 instead of DATA_W.",
            },
            {
                "root_id": "width_c",
                "root_type": "width_mismatch",
                "file": "data/root_cause_analysis/composite_root_causes/injected/sg_mroot_subsys_c.sv",
                "line": 8,
                "description": "BUS_W is DATA_W - 4 instead of DATA_W.",
            },
        ],
    },
]


def rca_annotations() -> tuple[list[dict[str, Any]], dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    total_roots = 0
    for spec in RCA_SPECS:
        root_count = len(spec["root_causes"])
        total_roots += root_count
        rows.append(
            {
                "instance_id": spec["instance_id"],
                "task": "rca",
                "dataset_path": spec["dataset_path"],
                "top": spec["top"],
                "injected_dir": spec["injected_dir"],
                "fixed_dir": spec["fixed_dir"],
                "injected_violation_count": spec["injected_violation_count"],
                "fixed_violation_count": spec["fixed_violation_count"],
                "root_cause_count": root_count,
                "root_causes": spec["root_causes"],
            }
        )
    stats = {
        "instances": len(rows),
        "root_cause_annotations": total_roots,
        "paired_scenarios": len(rows),
    }
    return rows, stats


def scalability_design_dirs() -> list[Path]:
    return sorted(
        [p for p in (ROOT / "data" / "scalability").iterdir() if p.is_dir()],
        key=lambda p: p.name,
    )


def load_scalability_report(design_dir: Path) -> tuple[Path, dict[str, Any], list[dict[str, Any]]]:
    injected_dir = design_dir / "injected"
    tool_reports = sorted(injected_dir.glob("*_tool_report.json"))
    if tool_reports:
        report_path = tool_reports[0]
        payload = read_json(report_path)
        violations = payload.get("violations", [])
        return report_path, payload, violations

    error_reports = sorted(injected_dir.glob("*_errors.json"))
    if error_reports:
        report_path = error_reports[0]
        payload = read_json(report_path)
        violations = payload.get("errors", [])
        return report_path, payload, violations

    raise FileNotFoundError(f"No scalability report found under {injected_dir}")


def infer_scalability_top(design_dir: Path, payload: dict[str, Any]) -> str:
    top = payload.get("top")
    if top:
        return str(top)

    clean_sources = sorted((design_dir / "clean").glob("*.sv"))
    if len(clean_sources) == 1:
        return clean_sources[0].stem

    return design_dir.name


def scalability_annotations() -> tuple[list[dict[str, Any]], dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    clean_violation_count = 0
    injected_violation_count = 0
    total_source_files = 0

    for design_dir in scalability_design_dirs():
        report_path, payload, violations = load_scalability_report(design_dir)
        top = infer_scalability_top(design_dir, payload)
        design_label = payload.get("design_label") or design_dir.name
        source_file_count = len(list((design_dir / "clean").glob("*.sv")))
        total_source_files += source_file_count

        clean_row = {
            "instance_id": f"{design_dir.name}_clean",
            "task": "scalability",
            "variant": "clean",
            "source_path": str((design_dir / "clean" / f"{top}.sv").relative_to(ROOT)),
            "top": top,
            "design_label": design_label,
            "violation_count": 0,
            "violations": [],
            "source_file_count": source_file_count,
        }
        rows.append(clean_row)
        clean_violation_count += 0

        injected_row = {
            "instance_id": f"{design_dir.name}_injected",
            "task": "scalability",
            "variant": "injected",
            "source_path": str(report_path.relative_to(ROOT)),
            "top": top,
            "design_label": design_label,
            "violation_count": payload.get("violation_count", len(violations)),
            "violations": [normalize_violation(v) for v in violations],
            "source_file_count": source_file_count,
        }
        rows.append(injected_row)
        injected_violation_count += int(injected_row["violation_count"])

    stats = {
        "designs": len(rows) // 2,
        "pairs": len(rows) // 2,
        "instances": len(rows),
        "clean_violation_count": clean_violation_count,
        "injected_violation_count": injected_violation_count,
        "source_file_count": total_source_files,
    }
    return rows, stats


def build_manifest() -> dict[str, Any]:
    lint_rows, lint_stats = lint_annotations()
    cdc_rows, cdc_stats = cdc_annotations()
    rca_rows, rca_stats = rca_annotations()
    scale_rows, scale_stats = scalability_annotations()

    manifest = {
        "suite_name": "MintBench",
        "version": "1.1.0",
        "generated_from": "curated benchmark data under data/",
        "reproducibility": {
            "release_builder": "scripts/build_mintbench_release.py",
            "deterministic_scorer": "scripts/score_mintbench.py",
            "optional_analysis": "scripts/secondary_analysis_mintbench.py",
            "python_dependencies": "standard library only for release building and deterministic scoring",
        },
        "scoring": {
            "primary": "deterministic exact-match scoring",
            "metrics": ["exact_match_instances", "micro_precision", "micro_recall", "micro_f1", "macro_f1"],
            "auxiliary_analysis": "optional semantic analysis requiring user-provided service credentials",
        },
        "tracks": [
            {
                "name": "rtl_lint_localization",
                "task": "lint_localization",
                "annotation_file": "release/annotations/lint_localization.jsonl",
                "stats": lint_stats,
            },
            {
                "name": "cdc_verification",
                "task": "cdc_verification",
                "annotation_file": "release/annotations/cdc.jsonl",
                "stats": cdc_stats,
            },
            {
                "name": "rca",
                "task": "rca",
                "annotation_file": "release/annotations/rca.jsonl",
                "stats": rca_stats,
            },
            {
                "name": "scalability",
                "task": "scalability",
                "annotation_file": "release/annotations/scalability.jsonl",
                "stats": scale_stats,
            },
        ],
    }

    write_json(RELEASE / "mintbench_manifest.json", manifest)
    write_jsonl(ANNOTATIONS / "lint_localization.jsonl", lint_rows)
    write_jsonl(ANNOTATIONS / "cdc.jsonl", cdc_rows)
    write_jsonl(ANNOTATIONS / "rca.jsonl", rca_rows)
    write_jsonl(ANNOTATIONS / "scalability.jsonl", scale_rows)

    stats_md = []
    stats_md.append("# MintBench Summary\n")
    stats_md.append("| Track | Instances | Key statistic |\n| --- | ---: | --- |\n")
    stats_md.append(f"| RTL lint localization | {lint_stats['instances']} | {lint_stats['errors']} planted errors across {lint_stats['taxonomy_families']} taxonomy families |\n")
    stats_md.append(f"| CDC verification | {cdc_stats['instances']} | {cdc_stats['violations']} total CDC violations |\n")
    stats_md.append(f"| RCA | {rca_stats['instances']} | {rca_stats['root_cause_annotations']} root-cause annotations |\n")
    stats_md.append(f"| Scalability | {scale_stats['pairs']} design pairs | {scale_stats['injected_violation_count']} violations across injected variants, {scale_stats['clean_violation_count']} across clean variants |\n")
    stats_md.append("\n## Evaluation Notes\n\n")
    stats_md.append("- Lint and CDC tasks use exact-match issue localization.\n")
    stats_md.append("- RCA uses exact-match root-cause file/line scoring.\n")
    stats_md.append("- Scalability covers every design pair under `data/scalability/` and uses exact-match violation scoring.\n")
    stats_md.append("- Optional auxiliary analysis is enabled through user-provided service credentials.\n")
    (RELEASE / "mintbench_stats.md").write_text("".join(stats_md), encoding="utf-8")

    return manifest


def main() -> None:
    RELEASE.mkdir(parents=True, exist_ok=True)
    ANNOTATIONS.mkdir(parents=True, exist_ok=True)
    manifest = build_manifest()
    print(json.dumps(
        {
            "suite_name": manifest["suite_name"],
            "version": manifest["version"],
            "tracks": [track["name"] for track in manifest["tracks"]],
        },
        indent=2,
    ))


if __name__ == "__main__":
    main()


