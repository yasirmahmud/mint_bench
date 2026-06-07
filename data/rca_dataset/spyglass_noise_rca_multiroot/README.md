# SpyGlass Noise RCA Dataset (`spyglass_noise_rca_multiroot`)

This dataset is a small multi-module SystemVerilog "project" designed to mimic **SpyGlass-style linter noise** where **multiple independent root mistakes** each cause many **dependent secondary violations**.

## Layout

- `buggy/`: Contains three independent root bugs (each in a different file).
- `fixed/`: Identical design, with all root bugs fixed.
- Top module (both variants): `sg_mroot_top`

> Note: Run tools on `buggy/` or `fixed/` (not the dataset root) to avoid compiling both variants at once.

## Root Causes (3) and Secondary Errors

All three root causes are simple width-definition mistakes that propagate through a small local pipeline of 5 stages. Each stage has `DATA_W=32` ports, but is connected to an internal bus of width `BUS_W`, producing **2 dependent width mismatches per stage** (`data_in` and `data_out`) → **10 W110 violations per root cause**.

### Root cause A

File: `buggy/sg_mroot_subsys_a.sv`

```sv
localparam int BUS_W = DATA_W - 8;
```

### Root cause B

File: `buggy/sg_mroot_subsys_b.sv`

```sv
localparam int BUS_W = DATA_W - 1;
```

### Root cause C

File: `buggy/sg_mroot_subsys_c.sv`

```sv
localparam int BUS_W = DATA_W - 4;
```

## How to Reproduce (SpyGlass)

`scripts/spyglass_run.py` runs SpyGlass remotely over SSH. If the default host/user does not work in your environment, pass `--hostname` and `--username`.

Run SpyGlass on the buggy design:

```bash
python scripts/spyglass_run.py data/spyglass_noise_rca_multiroot/buggy --top sg_mroot_top --out outputs/spyglass_noise_rca_multiroot_buggy.json
```

Then run SpyGlass on the fixed design:

```bash
python scripts/spyglass_run.py data/spyglass_noise_rca_multiroot/fixed --top sg_mroot_top --out outputs/spyglass_noise_rca_multiroot_fixed.json
```

Expected (typical):
- Buggy: `violation_count = 30` (all `W110`, with 10 per subsystem file)
- Fixed: `violation_count = 0`
