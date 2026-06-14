# basic_async_control_crossings

Small CDC fixture separate from `data/cdc/multi_protocol_cdc_hazards`.

`basic_async_control_crossings.sv` intentionally includes CDC hazards marked with
`CDC_MINIMAL_001` through `CDC_MINIMAL_005`:

- asynchronous reset release into `dst_clk`
- direct sampling of a one-cycle `src_clk` pulse by `dst_clk`
- direct capture of an 8-bit bus without a bundled-data protocol
- reconvergence of async and sampled toggle paths
- direct sampling of a source-domain toggle by `aux_clk`

`basic_async_control_crossings.sgdc` provides the clock and reset constraints needed for
CDC analysis.

### Evaluation

To evaluate this design:
1. Analyze the source file `basic_async_control_crossings.sv` with constraints from `basic_async_control_crossings.sgdc`.
2. Format the findings into a predictions file according to the benchmark prediction schema (see `docs/reproducibility.md`).
3. Compare the predictions against `basic_async_control_crossings_errors.json` using the benchmark scoring script `scripts/score_mintbench.py`.


