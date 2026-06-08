# MintBench

MintBench is a reproducible public benchmark for evaluating HDL lint tools on issue localization, clock-domain crossing (CDC) checks, root-cause analysis (RCA), and scale-oriented regression checks.

The repository keeps curated benchmark inputs under `data/` and canonical release artifacts under `release/`. The release layer is rebuilt from repository-local inputs by `scripts/build_mintbench_release.py`.

## Release Snapshot

The checked-in release metadata lives in:

- `release/mintbench_manifest.json`
- `release/mintbench_stats.md`

For build and scoring details, see `docs/reproducibility.md`.

## Benchmark Tracks

| Track | Task | Data | Size | Gold labels |
| --- | --- | --- | ---: | --- |
| RTL lint localization | Locate planted HDL lint issues in single-module designs | `data/rtl_lint_localization/json/` | 312 programs | 921 issue labels across 14 taxonomy families |
| CDC verification | Detect CDC violations in multi-module fixtures | `data/cdc/` | 2 fixtures | 45 CDC violations |
| RCA | Identify the root cause behind cascaded lint reports | `data/root_cause_analysis/` | 9 scenarios | 15 root-cause labels |
| Scalability | Measure linter behavior on processor-scale designs (1 baseline design + 11 open-source designs) | `data/scalability/` | 12 designs (24 variants) | 63 violations in CPU1 injected variant, 21 in each of the other 11 injected variants, 0 in all clean variants |

### Scalability Designs

The scalability track includes the following design pairs (each with `clean/` and `injected/` variants):
- **Baseline design**: `cpu1` (RISC-V core design, 63 injected violations)
- **Open-source designs** (21 injected violations each):
  - `caliptra_top` (Caliptra Root of Trust top module)
  - `cv32e40p_core` (CV32E40P RISC-V processor core)
  - `cva6` (CVA6 RISC-V processor core)
  - `ibex_core` / `ibex_top` (Ibex RISC-V processor core and top level)
  - `opentitan_ast` / `opentitan_gpio` / `opentitan_otp_ctrl` (OpenTitan blocks)
  - `pulpino_core_region` / `pulpino_top` (PULPino microcontroller core region and top level)
  - `scr1_top_axi` (SCR1 RISC-V processor core with AXI interface)


## Release Build

Rebuild the canonical release artifacts with:

```bash
python3 scripts/build_mintbench_release.py
```

This command regenerates:

- `release/mintbench_manifest.json`
- `release/mintbench_stats.md`
- `release/annotations/lint_localization.jsonl`
- `release/annotations/cdc.jsonl`
- `release/annotations/rca.jsonl`
- `release/annotations/scalability.jsonl`

The build is deterministic for a fixed checkout and uses only the Python standard library.

## Deterministic Scoring

Score a predictions file with:

```bash
python3 scripts/score_mintbench.py \
  --manifest release/mintbench_manifest.json \
  --predictions predictions.json \
  --output scores.json
```

The scorer reports:

- exact-match instance count
- micro precision
- micro recall
- micro F1
- macro F1
- per-task metrics

Exact matching uses task-specific keys:

- `lint_localization`: taxonomy label and line number
- `cdc_verification`: CDC rule, file name, and line number
- `rca`: root-cause file name, line number, and root-cause type
- `scalability`: reported rule, file name, and line number

Prediction files are JSON objects keyed by `instance_id`. Each value may be a list or an object containing `violations`, `targets`, or `root_causes`.

## Auxiliary Analysis

MintBench includes an optional auxiliary analysis step for predictions that are close but not exact. This step is separate from deterministic scoring and can vary by backend.

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

Report deterministic scores as the primary result. Treat auxiliary analysis as supporting analysis only, and include the service target, endpoint, date, analysis version, and sampling settings when reporting it.

## Reproducibility

See `docs/reproducibility.md` for the prediction schema, scoring definitions, environment requirements, and publication checklist.
