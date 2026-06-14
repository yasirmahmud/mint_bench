# Tasks

## 1. Resolve Release Consistency Problems
- [x] Fix the scalability label-count mismatch: `README.md` reports 8,660 labels, while the rebuilt release reports 5,546.
- [x] Rebuild `release/` from a clean checkout and verify `README.md`, `release/mintbench_manifest.json`, and `release/mintbench_stats.md` agree.
- [x] Add a lightweight consistency check that fails when documented track counts diverge from generated release metadata.

## 2. Strengthen Validation Evidence
- [x] Add independent validation reports for RTL lint localization, CDC verification, and RCA, not only scalability.
- [x] Check every gold label for source existence, line-number validity, duplicate labels, and task-specific semantic correctness.
- [x] Document the validation protocol, reviewer criteria, and any known ambiguous cases in `docs/reproducibility.md` or a dedicated validation report.

## 3. Reduce Synthetic Benchmark Bias
- [ ] Document which instances are generated, planted, transformed, or derived from real open-source RTL.
- [ ] Add real-world lint/CDC cases where possible, or clearly separate synthetic and real-source subsets in the manifest.
- [ ] Report results separately for synthetic fixtures and realistic/open-source design corpora.

## 4. Add Baseline Results
- [ ] Run representative HDL linting baselines such as Verilator, slang, Yosys, and any available commercial or academic tools.
- [ ] Add baseline tables with precision, recall, F1, exact-match counts, runtime, and failure modes by track.
- [ ] Include at least one simple baseline and one strong HDL-aware baseline so reviewers can judge benchmark difficulty.

## 5. Fix Reproducibility Defects
- [ ] Normalize generated manifest and annotation paths to POSIX-style separators, even when the release builder runs on Windows.
- [ ] Fix CDC instance IDs so examples and annotation rows use the same canonical names.
- [ ] Add a checked-in validation predictions file that produces expected nonzero scores under `scripts/score_mintbench.py`.
- [ ] Ensure `docs/example_benchmark_format.json` exactly matches real instance IDs and gold-label schema examples.

## 6. Tighten License and Provenance
- [ ] Record exact upstream repository commits for each bundled third-party HDL corpus.
- [ ] Include or reference the specific license file for each third-party source corpus.
- [ ] Verify redistribution compatibility for every bundled design and document any exclusions or modifications.

## 7. Prepare Top-Journal Artifact Package
- [ ] Add a benchmark-card section covering limitations, intended use, non-use cases, and dataset composition by source type.
- [ ] Include artifact-review instructions that start from a clean clone and reproduce the release, validation checks, and scoring.
- [ ] Add a publication-ready summary explaining novelty relative to existing HDL lint, EDA, and code-analysis benchmarks.
