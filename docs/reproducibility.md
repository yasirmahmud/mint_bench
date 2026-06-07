# MintBench Reproducibility Notes

This document defines the benchmark release process, prediction schema, scoring method, and publication checklist.

## Environment

Required:

- Python 3.10 or newer
- No Python package dependencies for release generation or deterministic scoring

Optional:

- An external analysis service for `scripts/secondary_analysis_mintbench.py`

## Canonical Release

Rebuild the release layer from repository-local inputs:

```bash
python3 scripts/build_mintbench_release.py
```

The release script is deterministic for a fixed repository checkout. It sorts input files, writes stable JSON keys, and records aggregate track statistics in `release/mintbench_manifest.json`.

## Prediction Schema

Predictions are stored as a JSON object keyed by benchmark `instance_id`:

```json
{
  "multi_error_1": {
    "violations": [
      {
        "taxonomy_title": "1. SYNTAX STRUCTURE",
        "line": 42
      }
    ]
  }
}
```

Accepted per-instance fields:

- `violations`
- `targets`
- `root_causes`

Accepted item aliases:

- `rule` or `taxonomy_title`
- `line`, `error_line`, or `line_number`
- `file`, `file_name`, or `file_path`
- `type`, `root_type`, or `root_cause_type`

## Deterministic Metrics

For each instance, MintBench normalizes gold and predicted labels into task-specific tuples:

| Task | Match tuple |
| --- | --- |
| `lint_localization` | `(taxonomy_title, line)` |
| `cdc_verification` | `(rule, file_name, line)` |
| `rca` | `(file_name, line, root_type)` |
| `scalability` | `(rule, file_name, line)` |

The scorer computes:

- True positives: exact tuple overlap
- False positives: predicted tuples absent from gold
- False negatives: gold tuples absent from predictions
- Precision: `tp / (tp + fp)`
- Recall: `tp / (tp + fn)`
- F1: harmonic mean of precision and recall
- Exact-match instance: normalized prediction set equals normalized gold set
- Micro F1: aggregate counts across instances
- Macro F1: mean of instance F1 values

Run:

```bash
python3 scripts/score_mintbench.py \
  --manifest release/mintbench_manifest.json \
  --predictions predictions.json \
  --output scores.json
```

## Auxiliary Analysis Protocol

The auxiliary analysis step is optional and is intended for cases where tool output uses different wording but appears to identify the same issue. It must not replace deterministic scoring in the main benchmark table.

Required environment variables:

- `MINTBENCH_ANALYSIS_ACCESS_TOKEN`
- `MINTBENCH_ANALYSIS_TARGET`

Optional environment variables:

- `MINTBENCH_ANALYSIS_BASE_URL`
- `MINTBENCH_ANALYSIS_TEMPERATURE`

Run:

```bash
python3 scripts/secondary_analysis_mintbench.py \
  --manifest release/mintbench_manifest.json \
  --predictions predictions.json \
  --output analysis_results.jsonl
```

Report the following with any auxiliary analysis result:

- API endpoint family
- Service target
- Evaluation date
- Analysis version
- Temperature
- Number of analyzed instances
- Whether exact gold labels were visible to the analysis backend

## Publication Checklist

Before public release:

- Rebuild `release/` from a clean checkout.
- Run deterministic scoring on a small validation predictions file.
- Keep only curated benchmark inputs referenced by the release builder.
- Avoid including external source exports unless their redistribution terms are documented.
- Document any service-assisted analysis as auxiliary and non-deterministic.
- Include benchmark version and commit hash in reported results.
