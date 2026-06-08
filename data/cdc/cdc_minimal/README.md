# cdc_minimal

Small tool CDC fixture separate from `data/cdc/cdc_protocol`.

`cdc_minimal.sv` intentionally includes CDC hazards marked with
`CDC_MINIMAL_001` through `CDC_MINIMAL_005`:

- asynchronous reset release into `dst_clk`
- direct sampling of a one-cycle `src_clk` pulse by `dst_clk`
- direct capture of an 8-bit bus without a bundled-data protocol
- reconvergence of async and sampled toggle paths
- direct sampling of a source-domain toggle by `aux_clk`

`cdc_minimal.sgdc` provides the clock and reset constraints needed for
tool CDC analysis.

### Evaluation

To evaluate a CDC tool on this design:
1. Run your CDC verification tool using the source files `cdc_minimal.sv` and constraints `cdc_minimal.sgdc`.
2. Format the tool's findings into a predictions file according to the benchmark prediction schema (see `docs/reproducibility.md`).
3. Compare the predictions against the pre-generated tool report `cdc_minimal_tool_report.json` using the benchmark scoring script `scripts/score_mintbench.py`.



