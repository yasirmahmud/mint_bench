# Publication Manifest

This manifest defines the intended public release surface for MintBench as a benchmark for HDL linting.

## Publishable Release Surface

| Path | Status | Notes |
| --- | --- | --- |
| `README.md` | Publish | Entry point for benchmark users and reviewers. |
| `LICENSE` | Publish | Apache-2.0 license for original MintBench materials. |
| `THIRD_PARTY_NOTICES.md` | Publish | Required notices for bundled third-party HDL sources. |
| `data/` | Publish | Verified benchmark assets and source fixtures. |
| `release/` | Publish | Deterministic release manifest, annotation JSONL files, and summary statistics. |
| `scripts/build_mintbench_release.py` | Publish | Rebuilds the release layer from `data/`. |
| `scripts/score_mintbench.py` | Publish | Primary deterministic scorer. |
| `scripts/secondary_analysis_mintbench.py` | Publish | Optional auxiliary analysis protocol. |
| `docs/` | Publish | Reproducibility, schema, benchmark card, and checklist documentation. |

## Non-Publishable Workspace Material

Development, provenance, validation, raw-design, and generated-cache material is kept under `non_publish/`. That directory is not part of the canonical benchmark release surface and should be excluded from archives submitted as the benchmark artifact unless reviewers explicitly request provenance material.

## Release Invariants

- `data/` is the authoritative source of benchmark assets.
- `release/` must be rebuildable with `python3 scripts/build_mintbench_release.py`.
- Deterministic benchmark results must be reported from `scripts/score_mintbench.py`.
- Optional semantic analysis must be reported separately from deterministic scoring.
- Third-party source notices must remain consistent with the bundled files under `data/`.
