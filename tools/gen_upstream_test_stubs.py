#!/usr/bin/env python3
from __future__ import annotations

import re
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
UPSTREAM = REPO_ROOT / "taffy-reference" / "tests"

GENERATED_DIR = UPSTREAM / "generated"

PORTED = {
    # Already ported (real tests)
    "rounding_doesnt_leave_gaps",
    "root_with_percentage_size",
    "root_with_no_size",
    "root_with_larger_size",
    "root_padding_and_border_larger_than_definite_size",
    "toggle_root_display_none",
    "toggle_root_display_none_with_children",
    "flex_root_ignored",
}


def mbt_block(test_id: str, todo: str) -> str:
    return (
        "///|\n"
        "#skip\n"
        f'test "{test_id}" {{\n'
        f"  // TODO: port from {todo}\n"
        "  ()\n"
        "}\n"
    )


def rust_test_fns(path: Path) -> list[str]:
    # Very small parser: find `#[test]` then `fn name(`.
    text = path.read_text("utf-8", errors="replace")
    out: list[str] = []
    for m in re.finditer(r"(?m)^\s*#\s*\[\s*test\s*]\s*\n\s*fn\s+([A-Za-z0-9_]+)\s*\(", text):
        out.append(m.group(1))
    return out


def main() -> None:
    if not GENERATED_DIR.exists():
        raise SystemExit(f"missing upstream dir: {GENERATED_DIR}")

    generated_blocks: list[str] = []
    for rs_path in sorted(GENERATED_DIR.rglob("*.rs")):
        name = rs_path.stem
        if name in PORTED:
            continue
        rel = rs_path.relative_to(REPO_ROOT)
        rel_dir = rs_path.parent.relative_to(GENERATED_DIR)
        test_id = f"upstream/generated/{rel_dir.as_posix()}/{name}"
        generated_blocks.append(mbt_block(test_id, rel.as_posix()))

    misc_blocks: list[str] = []
    for rs_path in sorted(UPSTREAM.glob("*.rs")):
        for name in rust_test_fns(rs_path):
            if name in PORTED:
                continue
            rel = rs_path.relative_to(REPO_ROOT)
            test_id = f"upstream/{rs_path.stem}/{name}"
            misc_blocks.append(mbt_block(test_id, rel.as_posix()))

    (REPO_ROOT / "upstream_generated_stub_test.mbt").write_text("".join(generated_blocks), "utf-8")
    (REPO_ROOT / "upstream_misc_stub_test.mbt").write_text("".join(misc_blocks), "utf-8")

    print(f"wrote {len(generated_blocks)} generated stubs")
    print(f"wrote {len(misc_blocks)} misc stubs")


if __name__ == "__main__":
    main()

