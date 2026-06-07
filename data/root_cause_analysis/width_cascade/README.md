# Width Cascade

This scenario evaluates root-cause analysis for cascaded width reports caused by a single top-level parameter mismatch.

## Layout

- `injected/`: design variant containing the intentional root cause
- `fixed/`: reference variant with the root cause removed

## Root Cause

The top-level bus-width parameter is set inconsistently with the intended data width, causing dependent width mismatches in connected modules.

Canonical labels are generated in `release/annotations/rca.jsonl` by `scripts/build_mintbench_release.py`.
