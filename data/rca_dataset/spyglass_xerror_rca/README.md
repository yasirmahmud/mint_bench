# SpyGlass X-Error RCA Dataset (`spyglass_xerror_rca`)

This dataset is a small multi-module SystemVerilog "project" designed to mimic **X-propagation** linter noise where a **single root source of `X`** triggers multiple dependent secondary violations across control, arithmetic, and memory logic.

## Layout

- `buggy/`: Contains the intentional root bug (single `X` source).
- `fixed/`: Identical design, with only the root bug fixed.
- Top module (both variants): `sg_x_top`

> Note: Run tools on `buggy/` or `fixed/` (not the dataset root) to avoid compiling both variants at once.

## Root vs. Secondary Errors

### Root bug: shared reset seed is `X`

File: `buggy/sg_x_00_pkg.sv`

The design intentionally routes all reset initializations through a single constant:

```sv
localparam logic [31:0] RESET_SEED = 'x;
```

This is the **single root source** of `X` in the project. Multiple modules slice/cast from `RESET_SEED` when resetting state, so one bad constant produces many dependent warnings.

### Dependent secondary causes: `X` fanout into multiple constructs

In the buggy variant, SpyGlass reports multiple `NoAssignX-ML` messages because several sequential elements reset from `RESET_SEED`:

- `buggy/sg_x_counter.sv`: `addr` reset
- `buggy/sg_x_mem.sv`: `rdata` reset
- `buggy/sg_x_datapath.sv`: `out` reset
- `buggy/sg_x_checker.sv`: `addr_ok` reset

Functionally, once `addr` is `X`, it also propagates through:

- **Control flow**: `if` + `case` decisions use `addr` in `sg_x_control.sv`.
- **Arithmetic**: add/shift operations consume `addr`-derived values in `sg_x_datapath.sv`.
- **Array indexing**: `addr` indexes a small RAM in `sg_x_mem.sv`.
- **Assertions**: immediate assertions check `addr` validity in `sg_x_checker.sv`.

Fixing only `RESET_SEED` (changing it to `'0` in `fixed/sg_x_00_pkg.sv`) removes the single `X` source and eliminates all dependent messages.

## How to Reproduce (SpyGlass)

Run SpyGlass on the buggy design:

```bash
python scripts/spyglass_run.py data/spyglass_xerror_rca/buggy --top sg_x_top --out outputs/spyglass_xerror_rca_buggy.json
```

Then run SpyGlass on the fixed design:

```bash
python scripts/spyglass_run.py data/spyglass_xerror_rca/fixed --top sg_x_top --out outputs/spyglass_xerror_rca_fixed.json
```

Compare `violation_count` and/or the `violations[]` list in the two JSON outputs:
- Buggy should contain the root `X`-assignment plus dependent secondary violations.
- Fixed should contain none.

Expected (as generated in this repo):
- Buggy: `violation_count = 4` (all `NoAssignX-ML`)
- Fixed: `violation_count = 0`
