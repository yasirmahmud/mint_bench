# cdc_minimal

Small CDC fixture separate from `data/cdc/cdc_protocol`.

`cdc_minimal.sv` intentionally includes CDC hazards marked with
`CDC_MINIMAL_001` through `CDC_MINIMAL_005`:

- asynchronous reset release into `dst_clk`
- direct sampling of a one-cycle `src_clk` pulse by `dst_clk`
- direct capture of an 8-bit bus without a bundled-data protocol
- reconvergence of async and sampled toggle paths
- direct sampling of a source-domain toggle by `aux_clk`

`cdc_minimal.sgdc` provides the clock and reset constraints needed for
CDC analysis.

### Evaluation

To evaluate this design:
1. Analyze the source file `cdc_minimal.sv` with constraints from `cdc_minimal.sgdc`.
2. Format the findings into a predictions file according to the benchmark prediction schema (see `docs/reproducibility.md`).
3. Compare the predictions against `cdc_minimal_errors.json` using the benchmark scoring script `scripts/score_mintbench.py`.



