# Third-Party Notices

MintBench includes a small set of bundled third-party HDL source trees in `data/scalability/` so the benchmark can evaluate lint and root-cause tools on realistic processor-scale designs.

The files retain their upstream notices and licenses. The top-level benchmark glue, release scripts, generated manifests, and documentation are licensed separately under Apache-2.0; see [LICENSE](LICENSE).

## Bundled Source Trees

| Path | Upstream project | License signal in source tree | Notes |
| --- | --- | --- | --- |
| `data/scalability/cva6/` | CVA6 | Solderpad Hardware License v0.51 | Source files contain Solderpad copyright notices. |
| `data/scalability/cv32e40p_core/` | CV32E40P | Solderpad Hardware License v0.51 | Source files contain Solderpad copyright notices. |
| `data/scalability/pulpino_core_region/` | PULPino | Solderpad Hardware License v0.51 | Source files contain Solderpad copyright notices. |
| `data/scalability/pulpino_top/` | PULPino | Solderpad Hardware License v0.51 | Source files contain Solderpad copyright notices. |
| `data/scalability/ibex_core/` | Ibex | Apache-2.0 | Source files include Apache-2.0 headers. |
| `data/scalability/ibex_top/` | Ibex | Apache-2.0 | Source files include Apache-2.0 headers. |
| `data/scalability/opentitan_ast/` | OpenTitan | Apache-2.0 | Source files include Apache-2.0 headers. |
| `data/scalability/opentitan_gpio/` | OpenTitan | Apache-2.0 | Source files include Apache-2.0 headers. |
| `data/scalability/opentitan_otp_ctrl/` | OpenTitan | Apache-2.0 | Source files include Apache-2.0 headers. |
| `data/scalability/scr1_top_axi/` | SCR1 | Solderpad Hardware License v0.51 | Upstream project identifies the core as open sourced under SHL-0.51. |

## Upstream References

- CVA6 project README and source headers
- CV32E40P source headers
- PULPino source headers
- Ibex source headers
- OpenTitan source headers
- SCR1 upstream repository: [syntacore/scr1](https://github.com/syntacore/scr1)

If additional third-party source trees are added later, append them here before release.
