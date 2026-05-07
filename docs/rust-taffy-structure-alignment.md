# Rust taffy Structure Alignment

This document records architecture alignment between `moon_taffy` and the pinned Rust upstream `taffy v0.5.2`, including language-level deltas and the local file-structure mapping used to keep the MoonBit port navigable against the Rust reference.

## Structural constraints

MoonBit directories are package boundaries. A direct copy of Rust's nested module tree (`compute/grid`, `tree`, `style`, `util`) would create many MoonBit packages and force public cross-package APIs or circular dependencies. The implementation therefore keeps one internal package at `Milky2018/moon_taffy/internal/style`, but names files after the Rust module paths.

## Architecture alignment status

- Rust uses a trait-driven layout engine (`LayoutPartialTree`, `LayoutPartialTreeExt`, `TraverseTree`, `RoundTree`, `PrintTree`) that can run over custom tree implementations. MoonBit keeps a concrete `TaffyTree` arena, but routes all internal algorithms through an internal `TaffyView` that owns the measure callback for the layout run; compute functions no longer pass `measure_function` as a loose argument through the algorithm stack.
- Rust has a first-class `Cache` model with one final layout entry and nine measure cache slots integrated with dirty tracking. MoonBit mirrors that cache shape and clears caches through dirty propagation.
- Cache lookup follows Rust taffy's looser match rules: known dimensions may match either the original known inputs or the cached output size, while unknown dimensions compare available space.
- Rust layout execution is recursive through `perform_child_layout`. MoonBit routes normal layout through the same recursive dispatch path, with a narrow stack-safety trampoline for deep default single-child chains so the legacy `wasm` backend preserves Rust's observable measurement behavior without overflowing the JavaScript stack.
- Rust `TaffyTree` separates node data, children, parents, node context, and config. MoonBit now mirrors this arena split with `nodes`, `children`, `parents`, `node_context_data`, and `config` arrays on `TaffyTree`; compatibility node fields were removed instead of being kept as mirrors.
- Rust stores `unrounded_layout` separately from `final_layout` and gates rounding through `TaffyConfig`. MoonBit now keeps the same two layout buffers and uses `TaffyConfig.use_rounding` to decide whether to round or copy unrounded output into final output.
- Rust `Layout` stores order, location, size, content size, scrollbar size, border, and padding. MoonBit exposes the same `Layout` field shape; fields not yet computed by an algorithm are zero-initialized.
- Rust exposes `LayoutInput`, `LayoutOutput`, `RunMode`, `SizingMode`, and `RequestedAxis` as low-level compute contract types. MoonBit exposes the same shapes and routes compute-size probes through `LayoutInput`.
- Internal compute dispatch now returns `LayoutOutput` through the cached/uncached path, matching Rust taffy's `compute_cached_layout` result flow. Root execution, recursive child execution, stack-safety trampoline, and rounding now live in `compute_mod.mbt`; tree query code only validates high-level `TaffyTree` API calls and constructs `TaffyView`. Recursive child execution is routed through `TaffyView::perform_child_layout`, `TaffyView::compute_child_layout`, and `TaffyView::measure_child_size`, mirroring Rust taffy's `LayoutPartialTreeExt` boundary instead of exposing loose package-level wrapper functions.
- Layout algorithms now write computed layouts through a single internal store boundary (`TaffyTree::set_unrounded_layout` / `TaffyTree::set_final_layout`) instead of assigning directly to node storage from each algorithm body.
- Grid architecture now keeps Rust taffy's explicit-grid, implicit-grid, and track-count boundaries as separate internal files. `compute_grid_mod.mbt` no longer owns the explicit/implicit track-count estimation and track construction logic directly.
- Grid auto-placement now uses `GridItem` placement records as the mutable placement source of truth before deriving track-sizing arrays, matching Rust taffy's grid item staging model more closely than the previous scattered parallel placement arrays.
- Rust splits sizing types into `Dimension`, `LengthPercentage`, `LengthPercentageAuto`, `MinTrackSizingFunction`, and `MaxTrackSizingFunction`. MoonBit exposes those public type shapes and conversion helpers into the established `Dimension` representation used by the current grid layout implementation.
- Rust exposes feature-gated ecosystem APIs such as print/debug helpers, serde integration, and custom tree traits. MoonBit focuses on the layout engine, style model, tree mutation/query APIs, and basic JSON conversion.
- Rust uses `f32`; MoonBit uses `Double`. Upstream tests pass, but extreme floating-point boundary cases may not be bit-for-bit identical.
- Rust APIs primarily return `Result`; MoonBit APIs use `raise TaffyError` where errors are surfaced, and keep some constructors infallible for ergonomic MoonBit use.

## File mapping

| Rust upstream path | MoonBit internal file |
| --- | --- |
| `src/geometry.rs` | `geometry.mbt` |
| `src/prelude.rs` | folded into root package exports; a literal `prelude` package conflicts with MoonBit core prelude aliasing |
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
| `src/compute/grid/explicit_grid.rs` | `compute_grid_explicit_grid.mbt` |
| `src/compute/grid/implicit_grid.rs` | `compute_grid_implicit_grid.mbt` |
| `src/compute/grid/placement.rs` | `compute_grid_placement.mbt` |
| `src/compute/grid/track_sizing.rs` | `compute_grid_track_sizing.mbt` |
| `src/compute/grid/types/coordinates.rs` | `compute_grid_types_coordinates.mbt` |
| `src/compute/grid/types/cell_occupancy.rs` | `compute_grid_types_cell_occupancy.mbt` |
| `src/compute/grid/types/grid_item.rs` | `compute_grid_types_grid_item.mbt` |
| `src/compute/grid/types/grid_track.rs` | `compute_grid_types_grid_track.mbt` |
| `src/compute/grid/types/grid_track_counts.rs` | `compute_grid_types_grid_track_counts.mbt` |
| `src/util/math.rs` | `util_math.mbt` |
| `src/util/resolve.rs` | `util_resolve.mbt` |
| `src/util/debug.rs`, `src/util/print.rs`, `src/util/sys.rs` | not ported as public utilities |

## Current verification contract

- Generated upstream layout tests under `taffy-reference/tests/generated/` are ported and passing.
- Top-level upstream compatibility tests for caching, measure, min/max overrides, relayout, root constraints, rounding, serde, and border/padding regressions are ported and passing.
- `moon check`, `moon check --warn-list +unnecessary_annotation`, and `moon test --no-render --target all` are expected to pass before publishing.
