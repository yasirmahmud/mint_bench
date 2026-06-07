# X-State Local

This scenario evaluates root-cause analysis for X-state propagation introduced directly in a top-level design file.

## Layout

- `injected/`: design variant containing the intentional root cause
- `fixed/`: reference variant with the root cause removed

## Root Cause

The injected variant initializes a reset seed to an unknown value, which propagates through dependent logic.

Canonical labels are generated in `release/annotations/rca.jsonl` by `scripts/build_mintbench_release.py`.
