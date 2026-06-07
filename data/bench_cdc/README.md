# bench_cdc

`bench_cdc_hard.sv` is a compact multi-module SystemVerilog CDC benchmark.
It intentionally contains 34 CDC issues tagged with `CDC_001` through
`CDC_034`.

`bench_cdc_spyglass.json` is a SpyGlass-style ground-truth report for those
issues. It preserves the same top-level shape used by the existing benchmark
reports in this repository:

- `top`
- `design_label`
- `input_dir`
- `source_files`
- `report_path`
- `violation_count`
- `violations`

Each violation also includes CDC-specific metadata such as source/destination
clock, hierarchy, taxonomy title, and a short note explaining why the issue is
intended to be difficult for purely structural static CDC checks.

The benchmark focuses on semantic and protocol CDC hazards: bundled-data hold
violations, reconvergent synchronized controls, pulse-width assumptions, reset
release hazards, binary/Gray pointer misuse, debug/test-domain feedback, and
cross-module provenance loss.

Run the SpyGlass CDC flow against this fixture with:

```bash
python3 src/sg_src/spyglass_run.py data/bench_cdc \
  --top bench_cdc_top \
  --check cdc \
  --out data/bench_cdc/bench_cdc_spyglass_run.json
```
