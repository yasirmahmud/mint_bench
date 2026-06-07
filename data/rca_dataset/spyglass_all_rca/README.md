# SpyGlass RCA "All Errors" Dataset (`spyglass_all_rca`)

This dataset combines three RCA patterns into a **single** multi-module SystemVerilog project so a single SpyGlass run produces:

1) **Blackhole / unresolved hierarchy** root cause + many secondary undriven/unused messages  
2) **Single-root width mistake** that cascades into many dependent `W110` violations  
3) **Multi-root width mistakes** (3 independent roots) that each cascade into many dependent `W110` violations

## Layout

- `buggy/`: Contains all root bugs (blackhole + single-root + multi-root).
- `fixed/`: Identical design, with only the root bugs fixed.
- Top module (both variants): `sg_all_top`

> Note: Run tools on `buggy/` or `fixed/` (not the dataset root) to avoid compiling both variants at once.

## Root Causes Included

### A) Blackhole root cause (unresolved module)

File: `buggy/sg_bh_subsystem.sv`

The subsystem instantiates `sg_bh_blackhloe` (typo), which does not exist. This typically produces one unresolved-hierarchy message plus many secondary undriven/unused violations.

### B) Single-root width mistake (noise cascade)

File: `buggy/sg_noise_top.sv`

`TOP_W` is incorrectly set to `24` (should be `DATA_W`), causing width mismatches through `sg_noise_probe` and `sg_noise_subsystem`.

### C) Multi-root width mistakes (3 independent roots)

Files:
- `buggy/sg_mroot_subsys_a.sv`
- `buggy/sg_mroot_subsys_b.sv`
- `buggy/sg_mroot_subsys_c.sv`

Each file defines a wrong localparam `BUS_W` which feeds a 5-stage pipeline, creating 10 dependent width mismatches per root cause.

## How to Reproduce (SpyGlass)

Run SpyGlass on the buggy design:

```bash
python scripts/spyglass_run.py data/spyglass_all_rca/buggy --top sg_all_top --out outputs/spyglass_all_rca_buggy.json
```

Then run SpyGlass on the fixed design:

```bash
python scripts/spyglass_run.py data/spyglass_all_rca/fixed --top sg_all_top --out outputs/spyglass_all_rca_fixed.json
```

Expected (typical):
- Buggy: `violation_count = 75` (blackhole=34, single-root noise=11, multi-root noise=30)
- Fixed: `violation_count = 0`

## RCA Script Check

Run the Neo4j-backed RCA script on the buggy report:

```bash
python scripts/rca.py --source data/spyglass_all_rca/buggy --log outputs/spyglass_all_rca_buggy.json
```

It should report:
- the unresolved blackhole instance, and
- the width parameters responsible for the cascaded `W110` violations.
