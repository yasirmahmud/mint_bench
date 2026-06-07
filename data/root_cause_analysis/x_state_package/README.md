# X-State Package

This scenario evaluates root-cause analysis for X-state propagation introduced through a shared package-style definition.

## Layout

- `injected/`: design variant containing the intentional root cause
- `fixed/`: reference variant with the root cause removed

## Root Cause

The injected variant initializes a shared reset seed to an unknown value, which propagates through dependent logic.

Canonical labels are generated in `release/annotations/rca.jsonl` by `scripts/build_mintbench_release.py`.
