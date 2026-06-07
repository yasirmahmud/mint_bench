# SpyGlass Noise RCA Dataset (`spyglass_noise_rca_packet`)

This dataset is a small multi-module SystemVerilog "project" designed to mimic **SpyGlass-style linter noise** where a **single root mistake** causes many **dependent secondary violations**.

## Layout

- `buggy/`: Contains the intentional root bug.
- `fixed/`: Identical design, with only the root bug fixed.
- Top module (both variants): `sg_pkt_top`

> Note: Run tools on `buggy/` or `fixed/` (not the dataset root) to avoid compiling both variants at once.

## Root vs. Secondary Errors

### Root bug

File: `buggy/sg_pkt_top.sv`

The design-wide payload width is controlled by:

```sv
localparam int BUS_W = DATA_W - 8;
```

This is **wrong**; the intended width is `DATA_W` (32). The incorrect `BUS_W` makes the internal payload bus **24-bit**, but several submodules use **32-bit** ports (`DATA_W=32` by default).

### Dependent secondary violations

Because `BUS_W` propagates through the hierarchy, SpyGlass reports multiple width-related violations (typically `W110`) across:

- `buggy/sg_pkt_top.sv` (probe instance)
- `buggy/sg_pkt_fabric.sv` (router/crc/flags/arbiter instances)

Fixing the single `BUS_W` line eliminates all dependent width mismatches.

## How to Reproduce (SpyGlass)

`scripts/spyglass_run.py` runs SpyGlass remotely over SSH. If the default host/user does not work in your environment, pass `--hostname` and `--username`.

Run SpyGlass on the buggy design:

```bash
python scripts/spyglass_run.py data/spyglass_noise_rca_packet/buggy --top sg_pkt_top --out outputs/spyglass_noise_rca_packet_buggy.json
```

Then run SpyGlass on the fixed design:

```bash
python scripts/spyglass_run.py data/spyglass_noise_rca_packet/fixed --top sg_pkt_top --out outputs/spyglass_noise_rca_packet_fixed.json
```

Compare `violation_count` and/or the `violations[]` list in the two JSON outputs:
- `outputs/spyglass_noise_rca_packet_buggy.json` should contain **multiple** dependent violations.
- `outputs/spyglass_noise_rca_packet_fixed.json` should contain **none**.

Expected (typical):
- Buggy: `violation_count = 11` (width mismatches; commonly `W110`)
- Fixed: `violation_count = 0`

## Local Sanity Check (No SpyGlass Required)

You can also validate the same characteristic locally:

```bash
python scripts/extras/verilator_run.py data/spyglass_noise_rca_packet/buggy --top sg_pkt_top --out /tmp/sg_pkt_buggy_verilator.json
python scripts/extras/verilator_run.py data/spyglass_noise_rca_packet/fixed --top sg_pkt_top --out /tmp/sg_pkt_fixed_verilator.json
```

Expected:
- Buggy: 11 `WIDTHEXPAND` warnings
- Fixed: 0 warnings
