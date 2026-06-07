# Hierarchy Resolution

This scenario evaluates root-cause analysis for cascaded reports caused by an unresolved module instance.

## Layout

- `injected/`: design variant containing the intentional root cause
- `fixed/`: reference variant with the root cause removed

## Root Cause

The injected variant instantiates a module name with a typographical error, which prevents hierarchy resolution and produces dependent connectivity reports.

Canonical labels are generated in `release/annotations/rca.jsonl` by `scripts/build_mintbench_release.py`.
