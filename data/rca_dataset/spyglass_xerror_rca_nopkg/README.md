# SpyGlass X-Error RCA Dataset (No Package) (`spyglass_xerror_rca_nopkg`)

This dataset is a small multi-module SystemVerilog "project" designed to mimic **X-propagation** linter noise where a **single root source of `X`** triggers multiple dependent secondary violations across control, arithmetic, memory indexing, and assertions.

## Layout

- `buggy/`: Contains the intentional root bug (single `X` source).
- `fixed/`: Identical design, with only the root bug fixed.
- Top module (both variants): `sg_xnp_top`

> Note: Run tools on `buggy/` or `fixed/` (not the dataset root) to avoid compiling both variants at once.

## Root vs. Secondary Errors

### Root bug: top-level reset seed is `X` (no package used)

File: `buggy/sg_xnp_top.sv`

The design routes reset initialization through a single constant in the **top module**:

```sv
localparam logic [31:0] RESET_SEED = 'x;
```

That constant is passed into multiple submodules as a parameter. Each submodule uses `RESET_SEED` to initialize state on reset, which causes multiple `NoAssignX-ML` messages from SpyGlass.

### Propagation logic (in the RTL)

Once `addr` is `X`, it is used in:

- **Control flow**: `if` + `case` decisions in `sg_xnp_control.sv`.
- **Arithmetic**: add/shift operations in `sg_xnp_datapath.sv`.
- **Array indexing**: `addr` indexes a small ROM-like array in `sg_xnp_mem.sv`.
- **Assertions**: an immediate assertion checks address validity in `sg_xnp_checker.sv`.

Fixing only `RESET_SEED` (changing it to `'0` in the fixed variant) removes the single `X` source and eliminates all dependent messages.

## How to Reproduce (SpyGlass)

Run SpyGlass on the buggy design:

```bash
python scripts/spyglass_run.py data/spyglass_xerror_rca_nopkg/buggy --top sg_xnp_top --out outputs/spyglass_xerror_rca_nopkg_buggy.json
```

Then run SpyGlass on the fixed design:

```bash
python scripts/spyglass_run.py data/spyglass_xerror_rca_nopkg/fixed --top sg_xnp_top --out outputs/spyglass_xerror_rca_nopkg_fixed.json
```

Expected (as generated in this repo):
- Buggy: `violation_count = 4` (all `NoAssignX-ML`)
- Fixed: `violation_count = 0`
