# cdc_protocol

`cdc_protocol.sv` is a compact multi-module SystemVerilog CDC benchmark.
It intentionally contains 34 CDC issues tagged with `CDC_001` through
`CDC_034`.

`cdc_protocol_tool_report.json` is a tool-style ground-truth report for those
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

Run the tool CDC flow against this fixture with:

```bash
python3 scripts/run_lint_tool.py data/cdc_protocol \
  --top cdc_protocol_top \
  --check cdc \
  --out data/cdc_protocol/cdc_protocol_tool_report_run.json
```
