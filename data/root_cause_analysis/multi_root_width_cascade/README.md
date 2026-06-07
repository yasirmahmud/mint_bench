# Multi-Root Width Cascade

This scenario evaluates root-cause analysis when several independent width mismatches create cascaded reports.

## Layout

- `injected/`: design variant containing the intentional root causes
- `fixed/`: reference variant with the root causes removed

## Root Causes

Three subsystem files each define an inconsistent bus width. The expected answer is the set of all root locations.

Canonical labels are generated in `release/annotations/rca.jsonl` by `scripts/build_mintbench_release.py`.
