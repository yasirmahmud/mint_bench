# Tasks

## 1. Fix Generator Issues
- [x] Modify [generate_benchmark_jsons.py](file://wsl.localhost/Ubuntu-22.04/home/yasir/mint_bench/non_publish/tools/generate_benchmark_jsons.py#L151-L164) to stop unconditionally flagging latch and driver issues on standard sequential logic blocks.
- [x] Run `python3 non_publish/tools/generate_benchmark_jsons.py` to regenerate `benchmark.json` files for all scalability designs.

## 2. Rebuild Release Manifests and Files
- [x] Run `python3 scripts/build_mintbench_release.py` to deterministicly regenerate the files in the `release/` directory.

## 3. Improve Validation Checkers
- [x] Modify [validate_semantic.py](file://wsl.localhost/Ubuntu-22.04/home/yasir/mint_bench/non_publish/benchmark_checker/validate_semantic.py#L151-L181) to implement more robust semantic checking of warnings (i.e. checking if latches/multi-drivers are actually inferred or logically possible, or removing the check if not feasible via regex).
- [x] Run the validation suite to ensure zero synthetic-only correctness failures and update `benchmark_check_report.md`.

## 4. Fix Data Leakage in Evaluator
- [x] Modify [secondary_analysis_mintbench.py](file://wsl.localhost/Ubuntu-22.04/home/yasir/mint_bench/scripts/secondary_analysis_mintbench.py#L74-L102) to remove the inclusion of `gold_items` in the payload sent to the LLM evaluator.
