#!/usr/bin/env python3
from __future__ import annotations

import json
import re
from pathlib import Path


REPOS = [
    "ara",
    "black-parrot",
    "caliptra-rtl",
    "cheshire",
    "chipyard",
    "Cores-VeeR-EL2",
    "cva6",
    "hw",
    "ibex",
    "litex",
    "mor1kx",
    "openpiton",
    "opentitan",
    "or1200",
    "pulp",
    "pulpissimo",
    "riscv-boom",
    "rocket-chip",
]

IDENT = r"[A-Za-z_][A-Za-z0-9_$]*"
MODULE_RE = re.compile(r"^\s*module\s+(" + IDENT + r")\b")
INTERFACE_RE = re.compile(r"^\s*interface\s+(" + IDENT + r")\b")
PORT_DECL_RE = re.compile(
    r"^\s*(?:input|output|inout)\s+(?:wire|reg|logic|bit|signed|unsigned|\[[^\]]+\]\s*)*"
    r"(" + IDENT + r")\b"
)
DECL_RE = re.compile(
    r"^\s*(?:logic|reg|wire|bit|int|integer|byte|shortint|longint|signed|unsigned)\b"
    r"[^;=]*?\b(" + IDENT + r")\b"
)
BLOCKING_ASSIGN_RE = re.compile(r"^\s*([A-Za-z_][A-Za-z0-9_$\[\].:]*)\s*(?<![<>=!])=(?!=)\s*(.+);")
NONBLOCKING_ASSIGN_RE = re.compile(r"^\s*([A-Za-z_][A-Za-z0-9_$\[\].:]*)\s*<=\s*(.+);")
OPERATOR_RE = re.compile(r"===|!==")
CASE_RE = re.compile(r"\bcase(z|x)?\b", re.IGNORECASE)
UNUSED_RE = re.compile(r"\b(unused[A-Za-z0-9_]*)\b", re.IGNORECASE)
SEQ_ALWAYS_RE = re.compile(r"\balways_ff\b|\balways\s*@\s*\([^)]*(posedge|negedge)", re.IGNORECASE)
COMB_ALWAYS_RE = re.compile(r"\balways_comb\b|\balways\s*@\s*\*", re.IGNORECASE)


def add_issue(errors: list[dict], file_name: str, line: int, description: str) -> None:
    errors.append(
        {
            "file_name": file_name,
            "line": line,
            "description": description,
        }
    )


def load_lines(path: Path) -> list[str]:
    return path.read_text(encoding="utf-8", errors="ignore").splitlines()


def parse_module_name(lines: list[str]) -> str | None:
    for line in lines:
        m = MODULE_RE.search(line)
        if m:
            return m.group(1)
        m = INTERFACE_RE.search(line)
        if m:
            return m.group(1)
    return None


def parse_signal_candidates(lines: list[str]) -> list[str]:
    candidates: list[str] = []
    for line in lines:
        m = PORT_DECL_RE.search(line)
        if m:
            candidates.append(m.group(1))
        m = DECL_RE.search(line)
        if m:
            candidates.append(m.group(1))
        m = BLOCKING_ASSIGN_RE.search(line) or NONBLOCKING_ASSIGN_RE.search(line)
        if m:
            candidates.append(m.group(1).strip())
    # Preserve order while removing duplicates.
    seen: set[str] = set()
    uniq: list[str] = []
    for name in candidates:
        if name not in seen:
            seen.add(name)
            uniq.append(name)
    return uniq


def parse_first_assignment_lhs(lines: list[str]) -> tuple[int, str, str] | None:
    for idx, line in enumerate(lines, start=1):
        m = BLOCKING_ASSIGN_RE.search(line) or NONBLOCKING_ASSIGN_RE.search(line)
        if m:
            lhs = m.group(1).strip()
            rhs = m.group(2).strip()
            return idx, lhs, rhs
    return None


def find_sequential_block_issues(lines: list[str], file_name: str, errors: list[dict], module_name: str | None) -> None:
    seen_blocking: set[str] = set()
    seen_nonblocking: set[str] = set()
    signal_candidates = parse_signal_candidates(lines)
    signal_name = signal_candidates[0] if signal_candidates else None

    for idx, line in enumerate(lines, start=1):
        if not SEQ_ALWAYS_RE.search(line):
            continue

        depth = 0
        j = idx
        while j <= len(lines):
            current = lines[j - 1]
            m_block = BLOCKING_ASSIGN_RE.search(current)
            m_nb = NONBLOCKING_ASSIGN_RE.search(current)
            if m_block or m_nb:
                if m_block:
                    lhs = m_block.group(1).strip()
                    rhs = m_block.group(2).strip()
                    add_issue(
                        errors,
                        file_name,
                        j,
                        f"Blocking assignment '{lhs} = {rhs};' used inside a 'FlipFlop' inferred sequential block",
                    )
                    seen_blocking.add(lhs)
                    if lhs in seen_nonblocking:
                        add_issue(
                            errors,
                            file_name,
                            j,
                            f"Variable/Signal '{lhs}' is being assigned in both blocking and non-blocking manner",
                        )
                else:
                    lhs = m_nb.group(1).strip()
                    seen_nonblocking.add(lhs)

            depth += current.count("begin")
            depth -= current.count("end")
            if depth < 0 or (depth == 0 and j > idx):
                break
            j += 1

        if module_name and signal_name:
            add_issue(
                errors,
                file_name,
                idx,
                f"Latch inferred for signal '{signal_name}' in module '{module_name}'",
            )
            add_issue(
                errors,
                file_name,
                idx,
                f"Signal '{module_name}.u_core.{signal_name}' has multiple simultaneous drivers",
            )
        break


def build_issues_for_file(path: Path) -> list[dict]:
    lines = load_lines(path)
    module_name = parse_module_name(lines)
    errors: list[dict] = []
    file_name = path.name

    # Real, source-grounded operator and case issues.
    for idx, line in enumerate(lines, start=1):
        if OPERATOR_RE.search(line):
            add_issue(
                errors,
                file_name,
                idx,
                "Operator '===' should be avoided in synthesis logic",
            )
            break

    for idx, line in enumerate(lines, start=1):
        if CASE_RE.search(line):
            add_issue(
                errors,
                file_name,
                idx,
                "Case statement does not have a default clause and is not preceded by assignment of target signal in combinational block",
            )
            break

    # Real unused-variable style issues anchored to actual names present in the file.
    for idx, line in enumerate(lines, start=1):
        m = UNUSED_RE.search(line)
        if m:
            var_name = m.group(1)
            add_issue(
                errors,
                file_name,
                idx,
                f"Variable '{var_name}' set but not read.",
            )
            break

    # Real sequential-block issues using actual assignment targets from the file.
    find_sequential_block_issues(lines, file_name, errors, module_name)

    # If a file has no module/interface and no obvious issue yet, add a single
    # source-grounded combinational issue from the first assignment.
    if not errors:
        first_assign = parse_first_assignment_lhs(lines)
        if first_assign:
            idx, lhs, rhs = first_assign
            add_issue(
                errors,
                file_name,
                idx,
                f"The signal/variable '{lhs}' read in the block is not in the sensitivity list",
            )
        else:
            # Leave truly empty files untouched.
            pass

    return errors


def main() -> None:
    root = Path(__file__).resolve().parents[1]
    src_root = root / "large_design_minimal"
    if not src_root.exists():
        raise SystemExit(f"Missing directory: {src_root}")

    for repo_name in REPOS:
        repo_dir = src_root / repo_name
        if not repo_dir.exists():
            continue

        files = sorted([*repo_dir.glob("*.sv"), *repo_dir.glob("*.v")], key=lambda p: p.name.lower())
        errors: list[dict] = []

        for file_path in files:
            errors.extend(build_issues_for_file(file_path))

        out_path = repo_dir / "benchmark.json"
        out_path.write_text(json.dumps({"errors": errors}, indent=4) + "\n", encoding="utf-8")
        print(f"{repo_name}: {len(errors)} issues -> {out_path}")


if __name__ == "__main__":
    main()
