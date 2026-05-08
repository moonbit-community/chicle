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
- Generated tests are split into small package-local files to keep review and regeneration manageable.

## Architecture guardrails

- The supported package boundary is `Milky2018/moon_taffy`; all user-facing implementation types and methods live in the root package so downstream users never need to import an `internal` package.
- Rust module parity is tracked in `docs/rust-taffy-structure-alignment.md`; MoonBit mirrors Rust modules through root-package file names because MoonBit directories are package boundaries.
- Tree mutation code keeps parent/child ownership in one attach/detach path, so constructors and mutation APIs preserve the same node invariants.
- Layout caches mirror Rust taffy's one final-layout slot plus nine measure slots and are invalidated through dirty propagation.
- Deep default single-child flex chains use an iterative fast path so all supported backends, including the legacy `wasm` target, avoid recursive stack overflow.
