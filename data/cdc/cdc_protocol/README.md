# cdc_protocol

`cdc_protocol.sv` is a compact multi-module SystemVerilog CDC benchmark.
It intentionally contains 34 CDC issues tagged with `CDC_001` through
`CDC_034`.

`cdc_protocol_errors.json` is the ground-truth annotation file for those
issues. It uses the standardized benchmark format from
`docs/example_benchmark_format.json`.

The benchmark focuses on semantic and protocol CDC hazards: bundled-data hold
violations, reconvergent synchronized controls, pulse-width assumptions, reset
release hazards, binary/Gray pointer misuse, debug/test-domain feedback, and
cross-module provenance loss.

### Evaluation

To evaluate this design:
1. Analyze the source file `cdc_protocol.sv`.
2. Format the findings into a predictions file according to the benchmark prediction schema (see `docs/reproducibility.md`).
3. Compare the predictions against `cdc_protocol_errors.json` using the benchmark scoring script `scripts/score_mintbench.py`.


