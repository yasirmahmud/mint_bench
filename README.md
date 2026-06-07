# MintBench

MintBench is a reproducible public benchmark for evaluating HDL lint tools on issue localization, clock-domain crossing (CDC) checks, root-cause analysis (RCA), and scale-oriented regression checks.

The benchmark separates curated source fixtures under `data/` from canonical release artifacts under `release/`. All release files are rebuilt from repository-local inputs by `scripts/build_mintbench_release.py`.

## Benchmark Tracks

| Track | Task | Data | Size | Gold labels |
| --- | --- | --- | ---: | --- |
| RTL lint localization | Locate planted HDL lint issues in single-module designs | `data/rtl_lint_localization/json/` | 312 programs | 921 issue labels across 14 taxonomy families |
| CDC verification | Detect CDC violations in multi-module fixtures | `data/cdc/` | 2 fixtures | 45 CDC violations |
| RCA | Identify the root cause behind cascaded lint reports | `data/root_cause_analysis/` | 9 scenarios | 15 root-cause labels |
| Scalability | Measure linter behavior on a processor-scale design pair | `data/scalability/cpu1/` | 2 variants | 63 violations in the injected-issue variant, 0 in the clean variant |

## Rebuild

```bash
python3 scripts/build_mintbench_release.py
```

This command writes:

- `release/mintbench_manifest.json`
- `release/mintbench_stats.md`
- `release/annotations/lint_localization.jsonl`
- `release/annotations/cdc.jsonl`
- `release/annotations/rca.jsonl`
- `release/annotations/scalability.jsonl`

## Deterministic Scoring

Score a predictions file with:

```bash
python3 scripts/score_mintbench.py \
  --manifest release/mintbench_manifest.json \
  --predictions predictions.json \
  --output scores.json
```

The scorer reports exact-match instance count, micro precision, micro recall, micro F1, macro F1, and per-task metrics. Exact matching uses task-specific keys:

- `lint_localization`: taxonomy label and line number
- `cdc_verification`: CDC rule, file name, and line number
- `rca`: root-cause file name, line number, and root-cause type
- `scalability`: reported rule, file name, and line number

Prediction files are JSON objects keyed by `instance_id`. Each value may be a list or an object containing `violations`, `targets`, or `root_causes`.

## Auxiliary Analysis

MintBench includes an optional auxiliary analysis step for predictions that are close but not exact. The analysis step is separated from the deterministic scorer because it requires an external service and can vary by backend.

Before running it, provide an access token and service target:

```bash
export MINTBENCH_ANALYSIS_ACCESS_TOKEN="..."
export MINTBENCH_ANALYSIS_TARGET="..."
python3 scripts/secondary_analysis_mintbench.py \
  --manifest release/mintbench_manifest.json \
  --predictions predictions.json \
  --output analysis_results.jsonl
```

Optional settings:

- `MINTBENCH_ANALYSIS_BASE_URL`: external endpoint root, default `https://api.example.com/v1`
- `MINTBENCH_ANALYSIS_TEMPERATURE`: default `0`
- `--limit`: evaluate a small number of instances for calibration

Report deterministic scores as the primary result. Report auxiliary analysis scores only as supporting analysis, including service target, endpoint, date, analysis version, and sampling settings.

## Reproducibility

The core release and deterministic scorer use only the Python standard library. See `docs/reproducibility.md` for the prediction schema, scoring definitions, and publication checklist.


