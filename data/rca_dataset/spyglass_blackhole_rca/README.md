# SpyGlass Black-Hole RCA Dataset (`spyglass_blackhole_rca`)

This dataset is a small multi-module SystemVerilog "project" designed to mimic **unresolved hierarchy / missing module** failures where a **single root mistake** creates a "black hole" that causes many **secondary connectivity violations** (undriven/unused noise).

## Layout

- `buggy/`: Contains the intentional root bug (unresolved hierarchy).
- `fixed/`: Identical design, with only the root bug fixed.
- Top module (both variants): `sg_bh_top`

> Note: Run tools on `buggy/` or `fixed/` (not the dataset root) to avoid compiling both variants at once.

## Root vs. Secondary Errors

### Root bug: unresolved hierarchy (missing module)

File: `buggy/sg_bh_subsystem.sv`

The subsystem instantiates the blackhole block with a **typo** in the module name:

```sv
sg_bh_blackhloe #(
  .DATA_W(DATA_W)
) u_blackhole (.*);
```

The intended module is `sg_bh_blackhole` (defined in `sg_bh_blackhole.sv`).

This is a classic "black hole" failure mode: because the linter cannot resolve the instance, it cannot
reliably reason about port directions/drivers inside that block.

### Dependent secondary violations: undriven + unused noise

Signals connected to the unresolved instance tend to get misclassified as:
- **Undriven**: nets that are read elsewhere but would have been driven by the missing module's outputs.
- **Unused**: nets that are driven (assigned) but whose only consumer would have been the missing module's inputs.

In this dataset, the subsystem connects 10 inputs and 10 outputs to the blackhole instance, which typically
produces many secondary messages in addition to the unresolved-module error.

Common secondary rules you may see include `W528` (set but not read) for the would-be inputs and `W123` / `UndrivenInTerm-ML` for the would-be outputs.

## How to Reproduce (SpyGlass)

`scripts/spyglass_run.py` runs SpyGlass remotely over SSH. If the default host/user does not work in your environment, pass `--hostname` and `--username`.

Run SpyGlass on the buggy design:

```bash
python scripts/spyglass_run.py data/spyglass_blackhole_rca/buggy --top sg_bh_top --out outputs/spyglass_blackhole_rca_buggy.json
```

Then run SpyGlass on the fixed design:

```bash
python scripts/spyglass_run.py data/spyglass_blackhole_rca/fixed --top sg_bh_top --out outputs/spyglass_blackhole_rca_fixed.json
```

Compare `violation_count` and/or the `violations[]` list in the two JSON outputs:
- Buggy should contain the unresolved-hierarchy error plus many undriven/unused secondary violations.
- Fixed should contain none.

Expected (as generated in this repo):
- Buggy: `violation_count = 34` (root unresolved-hierarchy + 10 undriven sinks + 10 unused sources + extra helper messages)
- Fixed: `violation_count = 0`
