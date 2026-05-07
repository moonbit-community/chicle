# Rust taffy Structure Alignment

This document records architecture alignment between `moon_taffy` and the pinned Rust upstream `taffy v0.5.2`, including language-level deltas and the local file-structure mapping used to keep the MoonBit port navigable against the Rust reference.

## Structural constraints

MoonBit directories are package boundaries. A direct copy of Rust's nested module tree (`compute/grid`, `tree`, `style`, `util`) would create many MoonBit packages and force public cross-package APIs or circular dependencies. The implementation therefore keeps one internal package at `Milky2018/moon_taffy/internal/style`, but names files after the Rust module paths.

## Architecture alignment status

- Rust uses a trait-driven layout engine (`LayoutPartialTree`, `LayoutPartialTreeExt`, `TraverseTree`, `RoundTree`, `PrintTree`) that can run over custom tree implementations. MoonBit keeps a concrete `TaffyTree` arena, but mirrors the trait surface as tree methods (`child_ids`, `child_count`, `get_child_id`, `get_style`, unrounded/final layout accessors).
- Rust has a first-class `Cache` model with one final layout entry and nine measure cache slots integrated with dirty tracking. MoonBit mirrors that cache shape and clears caches through dirty propagation.
- Rust layout execution is recursive through `perform_child_layout`. MoonBit mostly follows this model, but includes an iterative fast path for deep default single-child flex chains so the legacy `wasm` backend does not overflow the stack.
- Rust `Layout` stores order, location, size, content size, scrollbar size, border, and padding. MoonBit exposes the same `Layout` field shape; fields not yet computed by an algorithm are zero-initialized.
- Rust splits sizing types into `Dimension`, `LengthPercentage`, `LengthPercentageAuto`, `MinTrackSizingFunction`, and `MaxTrackSizingFunction`. MoonBit exposes `LengthPercentage` and `LengthPercentageAuto`, while grid track sizing still uses the current `Dimension` representation internally.
- Rust exposes feature-gated ecosystem APIs such as print/debug helpers, serde integration, and custom tree traits. MoonBit focuses on the layout engine, style model, tree mutation/query APIs, and basic JSON conversion.
- Rust uses `f32`; MoonBit uses `Double`. Upstream tests pass, but extreme floating-point boundary cases may not be bit-for-bit identical.
- Rust APIs primarily return `Result`; MoonBit APIs use `raise TaffyError` where errors are surfaced, and keep some constructors infallible for ergonomic MoonBit use.

## File mapping

| Rust upstream path | MoonBit internal file |
| --- | --- |
| `src/geometry.rs` | `geometry.mbt` |
| `src/style/mod.rs` | `style_mod.mbt` |
| `src/style/alignment.rs` | `style_alignment.mbt` |
| `src/style/dimension.rs` | `style_dimension.mbt` |
| `src/style/flex.rs` | `style_flex.mbt` |
| `src/style/grid.rs` | `style_grid.mbt` |
| `src/style_helpers.rs` | `style_helpers.mbt` |
| `src/tree/cache.rs` | `tree_cache.mbt` |
| `src/tree/layout.rs` | `tree_layout.mbt` |
| `src/tree/node.rs` | `tree_node.mbt` |
| `src/tree/taffy_tree.rs` | `tree_taffy_tree.mbt` |
| `src/tree/traits.rs` | `tree_traits.mbt` |
| `src/compute/mod.rs` | `compute_mod.mbt` |
| `src/compute/leaf.rs` | `compute_leaf.mbt` |
| `src/compute/block.rs` | `compute_block.mbt` |
| `src/compute/flexbox.rs` | `compute_flexbox.mbt` |
| `src/compute/common/*` | `compute_common_alignment.mbt`, `compute_common_content_size.mbt`, `compute_common_margin.mbt` |
| `src/compute/grid/mod.rs` | `compute_grid_mod.mbt` |
| `src/compute/grid/alignment.rs` | `compute_grid_alignment.mbt` |
| `src/compute/grid/placement.rs` | `compute_grid_placement.mbt` |
| `src/compute/grid/track_sizing.rs` | `compute_grid_track_sizing.mbt` |
| `src/compute/grid/explicit_grid.rs` | folded into `compute_grid_mod.mbt` and grid helpers |
| `src/compute/grid/implicit_grid.rs` | folded into `compute_grid_mod.mbt` and grid helpers |
| `src/util/math.rs` | `util_math.mbt` |
| `src/util/resolve.rs` | `util_resolve.mbt` |
| `src/util/debug.rs`, `src/util/print.rs`, `src/util/sys.rs` | not ported as public utilities |

## Current verification contract

- Generated upstream layout tests under `taffy-reference/tests/generated/` are ported and passing.
- Top-level upstream compatibility tests for caching, measure, min/max overrides, relayout, root constraints, rounding, serde, and border/padding regressions are ported and passing.
- `moon check`, `moon check --warn-list +unnecessary_annotation`, and `moon test --no-render --target all` are expected to pass before publishing.
