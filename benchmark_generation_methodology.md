# Benchmark Generation Methodology

This document describes the methodology used to construct the MintBench benchmark.

## 1. Design Collection
Open-source Verilog/SystemVerilog designs were collected primarily from VerilogDB, a large-scale repository of curated RTL designs, supplemented with several large and complex design files collected directly from their original GitHub repositories. This combination ensured broad coverage across design styles, project scales, and application domains.

## 2. Baseline Establishment and Validation
To establish a high-quality baseline, all collected designs were lint-cleaned using Synopsys SpyGlass and subsequently cross-checked with Verilator to reduce dependence on any single linting tool. Only designs that were free of reported violations across the selected linting tools were retained as benchmark seeds. This validation process helps mitigate potential tool-specific bias in the benchmark construction.

## 3. Violation Injection (Mutation)
Lint violations were then injected using a set of Abstract Syntax Tree (AST)- and Control Flow Graph (CFG)-based mutation operators designed to emulate realistic RTL coding mistakes and coding-guideline violations. These mutations introduced a diverse range of syntactic, structural, and semantic lint issues while preserving the overall integrity and compilability of the original designs whenever applicable.

## 4. Multi-Stage Quality Validation
To ensure benchmark correctness and label quality, each injected violation underwent a multi-stage validation process:
- **Automated Analysis**: First, the mutated designs were analyzed using Verilator and SpyGlass to verify the presence of the intended issue and to evaluate detection coverage across different linting frameworks.
- **Expert Manual Review**: Second, violations that could not be reliably detected or classified by existing tools were manually reviewed by experienced RTL engineers. Human evaluation was particularly used for advanced design-quality issues and semantic coding problems that are beyond the detection capability of conventional rule-based lint checkers.

Only mutations that were confirmed to correspond to the intended lint category through automated analysis and/or expert review were retained in the final benchmark.

## Summary
This methodology produces a realistic and accurately labeled HDL linting benchmark while minimizing tool-specific bias and improving the reliability of benchmark ground truth.
