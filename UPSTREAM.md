# Upstream reference

This repo is a MoonBit port of the Rust crate **taffy**.

- Upstream: `DioxusLabs/taffy`
- Series: `0.5.x`
- Pinned tag: `v0.5.2`
- Pinned commit: `770e10403ee96a2f484617c79faa7dc0bfe83994`

The upstream source is checked out locally in `taffy-reference/` and is gitignored.

## Port coverage

- Generated upstream layout tests under `taffy-reference/tests/generated/` are ported into MoonBit tests.
- Top-level upstream compatibility tests for caching, measure, min/max overrides, relayout, root constraints, rounding, serde, and border/padding regressions are ported.
