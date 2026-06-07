# SpyGlass Blocking vs Non-Blocking Mix-up RCA Dataset (`spyglass_bnb_mixup_rca`)

This dataset is a small SystemVerilog project designed to mimic a **blocking vs non-blocking assignment mix-up** where a **single root mistake** causes many **secondary violations**.

## Layout

- `buggy/`: Contains the intentional root bug (macro uses blocking assignment).
- `fixed/`: Identical design, with only the root bug fixed (macro uses non-blocking assignment).
- Top module (both variants): `sg_bnb_top`

> Note: Run tools on `buggy/` or `fixed/` (not the dataset root) to avoid compiling both variants at once.

## Root vs. Secondary Errors

### Root bug: wrong assignment operator in shared macro

File: `buggy/sg_bnb_defs.sv`

The design uses a shared macro for sequential register updates. In the buggy version the macro expands to a **blocking** assignment (`=`) instead of a **non-blocking** assignment (`<=`).

This creates a classic mix-up pattern:
- reset path uses `<=`
- data path uses `=` (via the macro)

### Dependent secondary violations

File: `buggy/sg_bnb_top.sv`

The macro is used for 16 pipeline registers. SpyGlass typically reports one or more violations per register about mixing blocking/non-blocking assignments (and/or blocking assignment in sequential logic).

Fixing the macro in `sg_bnb_defs.sv` removes all dependent secondary messages.

## How to Reproduce (SpyGlass)

Run SpyGlass on the buggy design:

```bash
python scripts/spyglass_run.py data/spyglass_bnb_mixup_rca/buggy --top sg_bnb_top --out outputs/spyglass_bnb_mixup_rca_buggy.json
```

Then run SpyGlass on the fixed design:

```bash
python scripts/spyglass_run.py data/spyglass_bnb_mixup_rca/fixed --top sg_bnb_top --out outputs/spyglass_bnb_mixup_rca_fixed.json
```

Expected (as generated in this repo):
- Buggy: `violation_count = 48` (16 regs × {`SYNTH_77`, `W336`, `W505`})
- Fixed: `violation_count = 0`
