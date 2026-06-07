# cdc_minimal

Small tool CDC fixture separate from `data/cdc_protocol`.

`cdc_minimal.sv` intentionally includes CDC hazards marked with
`CDC_MINIMAL_001` through `CDC_MINIMAL_005`:

- asynchronous reset release into `dst_clk`
- direct sampling of a one-cycle `src_clk` pulse by `dst_clk`
- direct capture of an 8-bit bus without a bundled-data protocol
- reconvergence of async and sampled toggle paths
- direct sampling of a source-domain toggle by `aux_clk`

`cdc_minimal.sgdc` provides the clock and reset constraints needed for
tool CDC analysis.

Run:

```bash
python3 scripts/run_lint_tool.py data/cdc_minimal \
  --top cdc_minimal_top \
  --check cdc \
  --out data/cdc_minimal/cdc_minimal_tool_report.json
```
