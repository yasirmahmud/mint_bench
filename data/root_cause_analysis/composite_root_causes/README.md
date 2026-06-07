# Composite Root Causes

This scenario evaluates root-cause analysis when multiple independent root causes are present in one design.

## Layout

- `injected/`: design variant containing multiple intentional root causes
- `fixed/`: reference variant with the root causes removed

## Root Causes

The scenario combines unresolved hierarchy, width-cascade, and multi-root width-cascade defects. The expected answer is a set of root-cause locations rather than a single location.

Canonical labels are generated in `release/annotations/rca.jsonl` by `scripts/build_mintbench_release.py`.
