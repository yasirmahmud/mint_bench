# MintBench

MintBench is a publication-oriented benchmark suite for HDL linting, CDC analysis, and root-cause analysis (RCA).
The repository keeps the raw source data under `data/` and adds a standardized release layer under `release/` so the
suite can be described and evaluated like a conventional research benchmark.

## Tracks

| Track | Task | Data | Size | Ground truth |
| --- | --- | --- | ---: | --- |
| RTL lint localization | Predict the planted lint issues in a single-module design | `data/benchmark/json/` | 312 programs | 921 planted errors across 14 taxonomy families |
| CDC verification | Detect CDC violations in multi-module fixtures | `data/bench_cdc/`, `data/cdc_smoke/` | 2 fixtures | 45 total CDC violations |
| RCA | Identify the root cause behind cascaded lint noise | `data/rca_dataset/` | 9 scenarios | 15 root-cause annotations, including one composite scenario |
| Scalability | Measure linter behavior on a larger processor-scale design | `data/big_bench/cpu1/` | 2 variants | 63 violations in the buggy variant, 0 in the clean variant |

## Release Artifacts

The release tooling writes machine-readable outputs under `release/`:

- `release/mintbench_manifest.json`
- `release/mintbench_stats.md`
- `release/annotations/lint_localization.jsonl`
- `release/annotations/cdc.jsonl`
- `release/annotations/rca.jsonl`
- `release/annotations/scalability.jsonl`

Generate them with:

```bash
python3 scripts/build_mintbench_release.py
```

## Evaluation Framework

The benchmark uses task-specific exact-match scoring:

- `lint_localization`: exact match on planted issue type and line number
- `cdc_verification`: exact match on CDC rule, file, and line number
- `rca`: exact match on root-cause file and line number
- `scalability`: report the observed violation count and runtime; use the clean/bad pair as a regression check

Score a predictions file against the generated release annotations with:

```bash
python3 scripts/score_mintbench.py \
  --manifest release/mintbench_manifest.json \
  --predictions my_predictions.json
```

The scorer accepts a tolerant JSON format:

- top-level keys are instance IDs
- each value may contain `violations`, `targets`, or `root_causes`
- each predicted item may use either `rule` or `taxonomy_title`, and either `line` or `error_line`

## Publication Notes

The raw data already includes per-fixture readmes and tool outputs. The release layer adds:

- a single canonical naming scheme
- a reproducible annotation format
- task-specific evaluation rules
- summary statistics suitable for a benchmark table in an IEEE-style paper

The code under `scripts/` is intentionally dependency-free so the benchmark can be rebuilt on a fresh machine.
