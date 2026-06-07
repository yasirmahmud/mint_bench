# cdc_smoke

Small SpyGlass CDC smoke-test fixture separate from `data/bench_cdc`.

`cdc_smoke.sv` intentionally includes CDC hazards marked with
`CDC_SMOKE_001` through `CDC_SMOKE_005`:

- asynchronous reset release into `dst_clk`
- direct sampling of a one-cycle `src_clk` pulse by `dst_clk`
- direct capture of an 8-bit bus without a bundled-data protocol
- reconvergence of async and sampled toggle paths
- direct sampling of a source-domain toggle by `aux_clk`

`cdc_smoke.sgdc` provides the clock and reset constraints needed for
SpyGlass CDC analysis.

Run:

```bash
python3 src/sg_src/spyglass_run.py data/cdc_smoke \
  --top cdc_smoke_top \
  --check cdc \
  --out data/cdc_smoke/cdc_smoke_spyglass_cdc.json
```
