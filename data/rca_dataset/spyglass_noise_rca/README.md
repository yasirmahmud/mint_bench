# SpyGlass Noise RCA Dataset (`spyglass_noise_rca`)

This dataset is a small multi-module SystemVerilog "project" designed to mimic **SpyGlass-style linter noise** where a **single root mistake** causes many **dependent secondary violations**.

## Layout

- `buggy/`: Contains the intentional root bug.
- `fixed/`: Identical design, with only the root bug fixed.
- Top module (both variants): `sg_noise_top`

> Note: Run tools on `buggy/` or `fixed/` (not the dataset root) to avoid compiling both variants at once.

## Root vs. Secondary Errors

### Root bug

File: `buggy/sg_noise_top.sv`

The design-wide payload width is controlled by:

```sv
localparam int TOP_W = 24;
```

This is **wrong**; the intended width is `DATA_W` (32). The incorrect `TOP_W` makes the internal payload bus **24-bit**, but several submodules use **32-bit** ports (`DATA_W=32` by default).

### Dependent secondary violations

Because `TOP_W` propagates through the hierarchy, SpyGlass reports multiple width-related violations (typically `W110`) across:

- `buggy/sg_noise_top.sv` (probe instance)
- `buggy/sg_noise_subsystem.sv` (router/checksum/status/arbiter instances)

Fixing the single `TOP_W` line eliminates all dependent width mismatches.

## How to Reproduce (SpyGlass)

Run SpyGlass on the buggy design:

```bash
python scripts/spyglass_run.py data/spyglass_noise_rca/buggy --top sg_noise_top --out outputs/spyglass_noise_rca_buggy.json
```

Then run SpyGlass on the fixed design:

```bash
python scripts/spyglass_run.py data/spyglass_noise_rca/fixed --top sg_noise_top --out outputs/spyglass_noise_rca_fixed.json
```

Compare `violation_count` and/or the `violations[]` list in the two JSON outputs:
- `outputs/spyglass_noise_rca_buggy.json` should contain **multiple** dependent violations.
- `outputs/spyglass_noise_rca_fixed.json` should contain **none**.

Expected (as generated in this repo):
- Buggy: `violation_count = 11` (all `W110` width mismatches)
- Fixed: `violation_count = 0`
