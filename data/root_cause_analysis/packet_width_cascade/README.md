# Packet Width Cascade

This scenario evaluates root-cause analysis for width mismatches in packet-processing logic.

## Layout

- `injected/`: design variant containing the intentional root cause
- `fixed/`: reference variant with the root cause removed

## Root Cause

The packet top-level configuration narrows an internal bus width, which creates dependent width reports across packet logic.

Canonical labels are generated in `release/annotations/rca.jsonl` by `scripts/build_mintbench_release.py`.
