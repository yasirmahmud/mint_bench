# SpyGlass Blocking vs Non-Blocking Mix-up RCA Dataset (No Package) (`spyglass_bnb_mixup_rca_nopkg`)

This dataset is a small multi-module SystemVerilog "project" designed to mimic a **blocking vs non-blocking assignment mix-up** where a **single root mistake** (one shared macro) causes many **secondary violations** across multiple modules.

## Layout

- `buggy/`: Contains the intentional root bug (macro uses blocking assignment).
- `fixed/`: Identical design, with only the root bug fixed (macro uses non-blocking assignment).
- Top module (both variants): `sg_bnbn_top`

> Note: Run tools on `buggy/` or `fixed/` (not the dataset root) to avoid compiling both variants at once.

## Root vs. Secondary Errors

### Root bug: wrong assignment operator in shared macro

File: `buggy/sg_bnbn_defs.sv`

The design uses a shared macro for sequential register updates:

- Buggy: `` `define SG_BNBN_ASSIGN(lhs, rhs) lhs = rhs `` (blocking)
- Fixed: `` `define SG_BNBN_ASSIGN(lhs, rhs) lhs <= rhs `` (non-blocking)

That single operator mix-up creates a classic pattern in every `always_ff` block:
- reset path uses `<=`
- data path uses `=` (via the macro)

### Dependent secondary violations (10+)

Files (buggy):
- `buggy/sg_bnbn_control.sv`
- `buggy/sg_bnbn_datapath.sv`
- `buggy/sg_bnbn_pipe.sv`

Each module has multiple sequential registers updated through `SG_BNBN_ASSIGN`, so SpyGlass typically reports many dependent messages like "Both blocking & non-blocking assignments are being done on the variable (...)".

Fixing only `sg_bnbn_defs.sv` removes all dependent secondary messages.

## How to Reproduce (SpyGlass)

Run SpyGlass on the buggy design:

```bash
python scripts/spyglass_run.py data/spyglass_bnb_mixup_rca_nopkg/buggy --top sg_bnbn_top --out outputs/spyglass_bnb_mixup_rca_nopkg_buggy.json
```

Then run SpyGlass on the fixed design:

```bash
python scripts/spyglass_run.py data/spyglass_bnb_mixup_rca_nopkg/fixed --top sg_bnbn_top --out outputs/spyglass_bnb_mixup_rca_nopkg_fixed.json
```

Expected (as generated in this repo):
- Buggy: `violation_count = 36` (12 regs × {`SYNTH_77`, `W336`, `W505`})
- Fixed: `violation_count = 0`
