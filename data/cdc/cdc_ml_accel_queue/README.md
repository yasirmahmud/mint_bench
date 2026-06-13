# cdc_ml_accel_queue

ML accelerator queue CDC benchmark containing six intentional clock-domain crossing defects.

The design focuses on:

- multi-bit data capture without a bundled-data protocol
- direct consumption of a one-cycle source-domain pulse
- reconvergence between a raw toggle and destination history
- independent synchronization of an encoded control vector
- reset-as-data use across clock domains
- mixed-domain auxiliary snapshots without a snapshot handshake

Ground-truth annotations are stored in `cdc_ml_accel_queue_errors.json` using the standardized benchmark format from `docs/example_benchmark_format.json`.
