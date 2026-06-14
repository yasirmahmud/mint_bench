# MintBench Benchmark Card

## Intended Use

MintBench evaluates HDL linting systems on issue localization, CDC violation detection, root-cause identification, and larger-design scalability. It is intended for academic benchmarking, regression testing of HDL analysis tools, and reproducibility studies in RTL quality assurance.

## Tasks

| Task | Description | Primary target |
| --- | --- | --- |
| RTL lint localization | Identify planted lint issues in SystemVerilog/Verilog examples. | Issue type and line number |
| CDC verification | Identify clock-domain crossing violations in CDC fixtures. | Rule, file, and line number |
| Root-cause analysis | Identify root causes behind cascaded lint reports. | Root-cause file, line, and type |
| Scalability | Evaluate behavior on larger RTL design corpora. | Rule or description, file, and line number |

## Data Organization

The benchmark assets are organized under `data/`:

- `data/rtl_lint_localization/`
- `data/cdc/`
- `data/root_cause_analysis/`
- `data/scalability/`

Release annotations and aggregate metadata are stored under `release/`.

## Evaluation

The primary evaluation protocol is deterministic exact-match scoring. The scorer normalizes gold and predicted labels into task-specific tuples and computes exact-match instance count, micro precision, micro recall, micro F1, macro F1, and per-task metrics.

Auxiliary semantic analysis is available only as a supplemental protocol and must not replace deterministic scoring in the main benchmark table.

## Reproducibility

Release generation and deterministic scoring use only the Python standard library. A fixed repository checkout should produce stable release metadata and annotation files.

## Limitations

- Exact-match scoring is intentionally strict and may under-credit semantically close but differently worded tool outputs.
- The benchmark emphasizes lint-style static-analysis outputs and is not a substitute for simulation, formal verification, synthesis signoff, or full CDC closure.
- Larger-design scalability cases are curated flat source corpora and annotations, not full upstream project checkouts with complete build systems.

## Reporting Requirements

Public reports should include:

- MintBench release version
- repository commit hash
- benchmark tracks evaluated
- deterministic scoring command
- prediction schema used
- primary deterministic metrics
- any excluded instances
- auxiliary analysis settings, if used
