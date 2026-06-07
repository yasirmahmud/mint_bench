# Assignment Semantics Local

This scenario evaluates root-cause analysis for cascaded reports caused by an assignment-semantics defect defined inside the local design files.

## Layout

- `injected/`: design variant containing the intentional root cause
- `fixed/`: reference variant with the root cause removed

## Root Cause

The shared update macro expands to a blocking assignment where a non-blocking assignment is expected for sequential logic.

Canonical labels are generated in `release/annotations/rca.jsonl` by `scripts/build_mintbench_release.py`.
