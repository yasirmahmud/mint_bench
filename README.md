# MintBench: Benchmark for HDL Linting

MintBench is a publication-ready benchmark for evaluating HDL linting systems. It targets four benchmark tasks that are common in practical RTL quality workflows: lint issue localization, clock-domain crossing (CDC) violation detection, root-cause analysis of cascaded lint reports, and scalability checks on larger open-source RTL designs.

The canonical benchmark assets are under `data/`. The checked-in release layer under `release/` is generated from those assets by the deterministic release builder.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `data/` | Curated and verified benchmark assets. |
| `release/` | Generated benchmark manifest, aggregate statistics, and annotation files. |
| `scripts/build_mintbench_release.py` | Deterministically rebuilds the release layer from `data/`. |
| `scripts/score_mintbench.py` | Deterministic exact-match scorer for benchmark predictions. |
| `scripts/secondary_analysis_mintbench.py` | Optional auxiliary semantic analysis protocol. |
| `docs/` | Reproducibility notes, schema examples, benchmark card, and publication checklist. |
| `non_publish/` | Provenance, development, validation, generated, or raw source material not intended for the public benchmark release surface. |

## Release Snapshot

- Suite name: `MintBench`
- Release version: `1.1.0`
- Primary benchmark type: HDL linting
- Primary scoring: deterministic exact-match scoring
- Release manifest: `release/mintbench_manifest.json`
- Summary statistics: `release/mintbench_stats.md`

## Benchmark Tracks

| Track | Task | Data | Size | Gold labels |
| --- | --- | --- | ---: | --- |
| RTL lint localization | Locate planted HDL lint issues in single-module designs | `data/rtl_lint_localization/json/` | 312 programs | 921 issue labels across 14 taxonomy families |
| CDC verification | Detect CDC violations in CDC-focused fixtures | `data/cdc/` | 60 fixtures | 387 CDC violations |
| Root-cause analysis | Identify the root causes behind cascaded lint reports | `data/root_cause_analysis/` | 9 paired scenarios | 15 root-cause labels |
| Scalability | Measure linter behavior on larger RTL design corpora | `data/scalability/` | 18 designs, 6,188 HDL source files | 8,660 labeled violations |

## Rebuild the Release

```bash
python3 scripts/build_mintbench_release.py
```

This regenerates:

- `release/mintbench_manifest.json`
- `release/mintbench_stats.md`
- `release/annotations/lint_localization.jsonl`
- `release/annotations/cdc.jsonl`
- `release/annotations/rca.jsonl`
- `release/annotations/scalability.jsonl`

The release builder uses only the Python standard library and is deterministic for a fixed checkout.

## Score Predictions

```bash
python3 scripts/score_mintbench.py \
  --manifest release/mintbench_manifest.json \
  --predictions predictions.json \
  --output scores.json
```

Predictions are JSON objects keyed by `instance_id`. Each value may be a list of predicted items or an object containing `violations`, `targets`, or `root_causes`.

Primary metrics:

- exact-match instance count
- micro precision
- micro recall
- micro F1
- macro F1
- per-task metrics

Task-specific exact-match tuples are documented in `docs/reproducibility.md`.

## Optional Auxiliary Analysis

MintBench includes an optional auxiliary analysis script for near-match review. This path is intentionally separate from the primary deterministic score and requires user-provided service credentials:

```bash
export MINTBENCH_ANALYSIS_ACCESS_TOKEN="..."
export MINTBENCH_ANALYSIS_TARGET="..."
python3 scripts/secondary_analysis_mintbench.py \
  --manifest release/mintbench_manifest.json \
  --predictions predictions.json \
  --output analysis_results.jsonl
```

Report deterministic metrics as the primary benchmark result. Treat auxiliary analysis as supplemental and document the service target, endpoint family, date, analysis version, temperature, and sample size.

## Publication Materials

- Reproducibility protocol: `docs/reproducibility.md`
- Benchmark card: `docs/benchmark_card.md`
- Prediction schema example: `docs/example_benchmark_format.json`
- Third-party notices: `THIRD_PARTY_NOTICES.md`
- Repository manifest: `PUBLICATION_MANIFEST.md`

## License

MintBench benchmark materials, scripts, documentation, and generated release metadata are released under Apache-2.0. Third-party HDL source files bundled under `data/` retain their upstream licenses and are documented in `THIRD_PARTY_NOTICES.md`.
