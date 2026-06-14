#!/usr/bin/env python3
from __future__ import annotations

import os
import shutil
from pathlib import Path


REPOS = [
    "Caliptra",
    "caliptra-rtl",
    "opentitan",
    "cheshire",
    "basilisk",
    "cva6",
    "pulp",
    "pulpissimo",
    "openpiton",
    "black-parrot",
    "ara",
    "hw",
    "ibex",
    "Cores-VeeR-EL2",
    "mor1kx",
    "or1200",
    "chipyard",
    "rocket-chip",
    "riscv-boom",
    "litex",
    "RTL-Repo",
    "llm-verilog-synthesis",
]

MAX_BYTES = 1 * 1024 * 1024

SKIP_PATH_PARTS = {
    "test",
    "tests",
    "tb",
    "sim",
    "vip",
    "coverage",
    "bench",
    "formal",
    "example",
    "examples",
    "docs",
    "doc",
    "scripts",
    "firmware",
    "sw",
    "fpga_tests",
    "target",
}

SKIP_NAME_MARKERS = (
    "tb_",
    "_tb.",
    "testbench",
    "fixture",
    "cov",
    "vip",
)


def should_skip(rel_path: Path) -> bool:
    parts = [part.lower() for part in rel_path.parts[:-1]]
    if "target" in parts:
        idx = parts.index("target")
        if idx + 1 < len(parts) and parts[idx + 1] in {"sim", "test"}:
            return True
    if any(part in SKIP_PATH_PARTS for part in parts):
        return True
    name = rel_path.name.lower()
    return any(marker in name for marker in SKIP_NAME_MARKERS)


def flatten(rel_path: Path) -> str:
    return "__".join(rel_path.parts)


def main() -> None:
    root = Path(__file__).resolve().parents[1]
    src_root = root / "large_design"
    dst_root = root / "large_design_minimal"

    if dst_root.exists():
        shutil.rmtree(dst_root)
    dst_root.mkdir(parents=True, exist_ok=True)

    for repo in REPOS:
        src = src_root / repo
        dst = dst_root / repo
        dst.mkdir(parents=True, exist_ok=True)

        copied = 0
        skipped_large = 0
        skipped_other = 0

        for dirpath, _, filenames in os.walk(src):
            for filename in filenames:
                if not filename.endswith((".v", ".sv")):
                    continue
                full = Path(dirpath) / filename
                rel = full.relative_to(src)
                if should_skip(rel):
                    skipped_other += 1
                    continue
                size = full.stat().st_size
                if size > MAX_BYTES:
                    skipped_large += 1
                    continue
                out = dst / flatten(rel)
                shutil.copy2(full, out)
                copied += 1

        print(
            f"{repo}\tcopy={copied}\tskip_other={skipped_other}\tskip_large={skipped_large}"
        )


if __name__ == "__main__":
    main()
