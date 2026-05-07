// Copyright 2025 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

///|
struct MiscFixedMeasure {
  width : Double
  height : Double
}

///|
struct MiscAspectRatioMeasure {
  width : Double
  height_ratio : Double
}

///|
fn[T] misc_unwrap_or(value : T?, fallback : T) -> T {
  match value {
    Some(v) => v
    None => fallback
  }
}

///|
fn misc_fixed_measure(
  known_dimensions : Size[Double?],
  _available_space : Size[AvailableSpace],
  _node_id : NodeId,
  node_context : MiscFixedMeasure?,
  _style : Style,
) -> Size[Double] {
  let ctx = match node_context {
    Some(v) => v
    None => MiscFixedMeasure::{ width: 0.0, height: 0.0 }
  }
  Size(
    width=misc_unwrap_or(known_dimensions.width, ctx.width),
    height=misc_unwrap_or(known_dimensions.height, ctx.height),
  )
}

///|
fn misc_aspect_ratio_measure(
  known_dimensions : Size[Double?],
  _available_space : Size[AvailableSpace],
  _node_id : NodeId,
  node_context : MiscAspectRatioMeasure?,
  _style : Style,
) -> Size[Double] {
  let ctx = match node_context {
    Some(v) => v
    None => return Size::zero()
  }
  let width = misc_unwrap_or(known_dimensions.width, ctx.width)
  let height = misc_unwrap_or(known_dimensions.height, width * ctx.height_ratio)
  Size(width~, height~)
}

///|
fn misc_square_measure(
  known_dimensions : Size[Double?],
  _available_space : Size[AvailableSpace],
  _node_id : NodeId,
  _node_context : Unit?,
  _style : Style,
) -> Size[Double] {
  let height = misc_unwrap_or(known_dimensions.height, 50.0)
  let width = misc_unwrap_or(known_dimensions.width, height)
  Size(width~, height~)
}

///|
fn misc_count_measure(
  known_dimensions : Size[Double?],
  _available_space : Size[AvailableSpace],
  _node_id : NodeId,
  node_context : Array[Int]?,
  _style : Style,
) -> Size[Double] {
  match node_context {
    Some(ctx) => ctx[0] = ctx[0] + 1
    None => ()
  }
  Size(
    width=misc_unwrap_or(known_dimensions.width, 50.0),
    height=misc_unwrap_or(known_dimensions.height, 50.0),
  )
}

///|
fn[C] misc_assert_layout_xywh(
  taffy : TaffyTree[C],
  node : NodeId,
  x : Double,
  y : Double,
  width : Double,
  height : Double,
) -> Unit raise Error {
  let layout = taffy.layout(node)
  assert_eq(layout.location.x, x)
  assert_eq(layout.location.y, y)
  assert_eq(layout.size.width, width)
  assert_eq(layout.size.height, height)
}

///|
test "upstream/caching/measure_count_flexbox" {
  let taffy : TaffyTree[Array[Int]] = TaffyTree()
  let leaf_counter = [0]
  let leaf = taffy.new_leaf_with_context(Style::default(), leaf_counter)
  let mut node = taffy.new_with_children(Style::default(), [leaf])
  for _ in 0..<100 {
    node = taffy.new_with_children(Style::default(), [node])
  }
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_count_measure,
  )
  match taffy.node_context(leaf) {
    Some(ctx) => assert_eq(ctx[0], 4)
    None => panic()
  }
}

///|
test "upstream/caching/measure_count_grid" {
  let taffy : TaffyTree[Array[Int]] = TaffyTree()
  let leaf_counter = [0]
  let leaf = taffy.new_leaf_with_context(
    Style::default().with_display(display_grid()),
    leaf_counter,
  )
  let mut node = taffy.new_with_children(Style::default(), [leaf])
  for _ in 0..<100 {
    node = taffy.new_with_children(Style::default(), [node])
  }
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_count_measure,
  )
  match taffy.node_context(leaf) {
    Some(ctx) => assert_eq(ctx[0], 4)
    None => panic()
  }
}

///|
test "upstream/measure/measure_root" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(Style::default(), MiscFixedMeasure::{
    width: 100.0,
    height: 100.0,
  })
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(node).size.width, 100.0)
  assert_eq(taffy.layout(node).size.height, 100.0)
}

///|
test "upstream/measure/measure_child" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child = taffy.new_leaf_with_context(Style::default(), MiscFixedMeasure::{
    width: 100.0,
    height: 100.0,
  })
  let node = taffy.new_with_children(Style::default(), [child])
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(node).size.width, 100.0)
  assert_eq(taffy.layout(node).size.height, 100.0)
  assert_eq(taffy.layout(child).size.width, 100.0)
  assert_eq(taffy.layout(child).size.height, 100.0)
}

///|
test "upstream/measure/measure_child_constraint" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child = taffy.new_leaf_with_context(Style::default(), MiscFixedMeasure::{
    width: 100.0,
    height: 100.0,
  })
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
    [child],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(node).size.width, 50.0)
  assert_eq(taffy.layout(node).size.height, 100.0)
  assert_eq(taffy.layout(child).size.width, 100.0)
  assert_eq(taffy.layout(child).size.height, 100.0)
}

///|
test "upstream/measure/measure_child_constraint_padding_parent" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child = taffy.new_leaf_with_context(Style::default(), MiscFixedMeasure::{
    width: 100.0,
    height: 100.0,
  })
  let node = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=length(50.0), height=auto()))
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [child],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  misc_assert_layout_xywh(taffy, node, 0.0, 0.0, 50.0, 120.0)
  misc_assert_layout_xywh(taffy, child, 10.0, 10.0, 100.0, 100.0)
}

///|
test "upstream/measure/measure_child_with_flex_grow" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let child1 = taffy.new_leaf_with_context(
    Style::default().with_flex_grow(1.0),
    MiscFixedMeasure::{ width: 10.0, height: 50.0 },
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
    [child0, child1],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(child1).size.width, 50.0)
  assert_eq(taffy.layout(child1).size.height, 50.0)
}

///|
test "upstream/measure/measure_child_with_flex_shrink" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_flex_shrink(0.0),
  )
  let child1 = taffy.new_leaf_with_context(Style::default(), MiscFixedMeasure::{
    width: 100.0,
    height: 50.0,
  })
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
    [child0, child1],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(child1).size.width, 100.0)
  assert_eq(taffy.layout(child1).size.height, 50.0)
}

///|
test "upstream/measure/remeasure_child_after_growing" {
  let taffy : TaffyTree[MiscAspectRatioMeasure] = TaffyTree()
  let child0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let child1 = taffy.new_leaf_with_context(
    Style::default().with_flex_grow(1.0),
    MiscAspectRatioMeasure::{ width: 10.0, height_ratio: 2.0 },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=length(100.0), height=auto()))
    .with_align_items(align_items_start()),
    [child0, child1],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_aspect_ratio_measure,
  )
  assert_eq(taffy.layout(child1).size.width, 50.0)
  assert_eq(taffy.layout(child1).size.height, 100.0)
}

///|
test "upstream/measure/remeasure_child_after_shrinking" {
  let taffy : TaffyTree[MiscAspectRatioMeasure] = TaffyTree()
  let child0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_flex_shrink(0.0),
  )
  let child1 = taffy.new_leaf_with_context(Style::default(), MiscAspectRatioMeasure::{
    width: 100.0,
    height_ratio: 2.0,
  })
  let node = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=length(100.0), height=auto()))
    .with_align_items(align_items_start()),
    [child0, child1],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_aspect_ratio_measure,
  )
  assert_eq(taffy.layout(child1).size.width, 100.0)
  assert_eq(taffy.layout(child1).size.height, 200.0)
}

///|
test "upstream/measure/remeasure_child_after_stretching" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf_with_context(Style::default(), ())
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_square_measure,
  )
  assert_eq(taffy.layout(child).size.width, 100.0)
  assert_eq(taffy.layout(child).size.height, 100.0)
}

///|
test "upstream/measure/width_overrides_measure" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
    MiscFixedMeasure::{ width: 100.0, height: 100.0 },
  )
  let node = taffy.new_with_children(Style::default(), [child])
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(child).size.width, 50.0)
  assert_eq(taffy.layout(child).size.height, 100.0)
}

///|
test "upstream/measure/height_overrides_measure" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(50.0))),
    MiscFixedMeasure::{ width: 100.0, height: 100.0 },
  )
  let node = taffy.new_with_children(Style::default(), [child])
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(child).size.width, 100.0)
  assert_eq(taffy.layout(child).size.height, 50.0)
}

///|
test "upstream/measure/flex_basis_overrides_measure" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child0 = taffy.new_leaf(
    Style::default().with_flex_basis(length(50.0)).with_flex_grow(1.0),
  )
  let child1 = taffy.new_leaf_with_context(
    Style::default().with_flex_basis(length(50.0)).with_flex_grow(1.0),
    MiscFixedMeasure::{ width: 100.0, height: 100.0 },
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(200.0), height=length(100.0))),
    [child0, child1],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(child0).size.width, 100.0)
  assert_eq(taffy.layout(child0).size.height, 100.0)
  assert_eq(taffy.layout(child1).size.width, 100.0)
  assert_eq(taffy.layout(child1).size.height, 100.0)
}

///|
test "upstream/measure/stretch_overrides_measure" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child = taffy.new_leaf_with_context(Style::default(), MiscFixedMeasure::{
    width: 50.0,
    height: 50.0,
  })
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(child).size.width, 50.0)
  assert_eq(taffy.layout(child).size.height, 100.0)
}

///|
test "upstream/measure/measure_absolute_child" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child = taffy.new_leaf_with_context(
    Style::default().with_position(position_absolute()),
    MiscFixedMeasure::{ width: 50.0, height: 50.0 },
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(child).size.width, 50.0)
  assert_eq(taffy.layout(child).size.height, 50.0)
}

///|
test "upstream/measure/ignore_invalid_measure" {
  let taffy : TaffyTree[MiscFixedMeasure] = TaffyTree()
  let child = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout_with_measure(
    node,
    Size::max_content(),
    misc_fixed_measure,
  )
  assert_eq(taffy.layout(child).size.width, 100.0)
  assert_eq(taffy.layout(child).size.height, 100.0)
}

///|
test "upstream/min_max_overrides/min_overrides_max" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_min_size(Size(width=length(100.0), height=length(100.0)))
    .with_max_size(Size(width=length(10.0), height=length(10.0))),
  )
  taffy.compute_layout(
    child,
    Size(
      width=available_space_definite(100.0),
      height=available_space_definite(100.0),
    ),
  )
  let layout = taffy.layout(child)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
}

///|
test "upstream/min_max_overrides/max_overrides_size" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_max_size(Size(width=length(10.0), height=length(10.0))),
  )
  taffy.compute_layout(
    child,
    Size(
      width=available_space_definite(100.0),
      height=available_space_definite(100.0),
    ),
  )
  let layout = taffy.layout(child)
  assert_eq(layout.size.width, 10.0)
  assert_eq(layout.size.height, 10.0)
}

///|
test "upstream/min_max_overrides/min_overrides_size" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_min_size(Size(width=length(100.0), height=length(100.0))),
  )
  taffy.compute_layout(
    child,
    Size(
      width=available_space_definite(100.0),
      height=available_space_definite(100.0),
    ),
  )
  let layout = taffy.layout(child)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
}

///|
test "upstream/relayout/relayout" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(8.0), height=length(80.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_align_self(align_items_center())
    .with_size(Size(width=auto(), height=auto())),
    [node1],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=percent(1.0), height=percent(1.0))),
    [node0],
  )
  let available : Size[AvailableSpace] = Size(
    width=available_space_definite(100.0),
    height=available_space_definite(100.0),
  )
  taffy.compute_layout(node, available)
  let initial = taffy.layout(node).location
  let initial0 = taffy.layout(node0).location
  let initial1 = taffy.layout(node1).location
  for _ in 1..<10 {
    taffy.compute_layout(node, available)
    let l = taffy.layout(node).location
    let l0 = taffy.layout(node0).location
    let l1 = taffy.layout(node1).location
    assert_eq(l.x, initial.x)
    assert_eq(l.y, initial.y)
    assert_eq(l0.x, initial0.x)
    assert_eq(l0.y, initial0.y)
    assert_eq(l1.x, initial1.x)
    assert_eq(l1.y, initial1.y)
  }
}

///|
test "upstream/relayout/toggle_flex_child_display_none" {
  let hidden_style = Style::default()
    .with_display(display_none())
    .with_size(Size(width=length(100.0), height=length(100.0)))
  let flex_style = Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(100.0), height=length(100.0)))
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node = taffy.new_leaf(hidden_style)
  let root = taffy.new_with_children(flex_style, [node])
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, node, 0.0, 0.0, 0.0, 0.0)
  taffy.set_style(
    node,
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(100.0), height=length(100.0))),
  )
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, node, 0.0, 0.0, 100.0, 100.0)
  taffy.set_style(
    node,
    Style::default()
    .with_display(display_none())
    .with_size(Size(width=length(100.0), height=length(100.0))),
  )
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, node, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/relayout/toggle_flex_container_display_none" {
  let hidden_style = Style::default()
    .with_display(display_none())
    .with_size(Size(width=length(100.0), height=length(100.0)))
  let flex_style = Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(100.0), height=length(100.0)))
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node = taffy.new_leaf(hidden_style)
  let root = taffy.new_with_children(hidden_style, [node])
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, root, 0.0, 0.0, 0.0, 0.0)
  taffy.set_style(root, flex_style)
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, root, 0.0, 0.0, 100.0, 100.0)
  taffy.set_style(root, hidden_style)
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, root, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/relayout/toggle_grid_child_display_none" {
  let hidden_style = Style::default()
    .with_display(display_none())
    .with_size(Size(width=length(100.0), height=length(100.0)))
  let grid_style = Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0)))
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node = taffy.new_leaf(hidden_style)
  let root = taffy.new_with_children(grid_style, [node])
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, node, 0.0, 0.0, 0.0, 0.0)
  taffy.set_style(
    node,
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
  )
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, node, 0.0, 0.0, 100.0, 100.0)
  taffy.set_style(
    node,
    Style::default()
    .with_display(display_none())
    .with_size(Size(width=length(100.0), height=length(100.0))),
  )
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, node, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/relayout/toggle_grid_container_display_none" {
  let hidden_style = Style::default()
    .with_display(display_none())
    .with_size(Size(width=length(100.0), height=length(100.0)))
  let grid_style = Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0)))
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node = taffy.new_leaf(hidden_style)
  let root = taffy.new_with_children(hidden_style, [node])
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, root, 0.0, 0.0, 0.0, 0.0)
  taffy.set_style(root, grid_style)
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, root, 0.0, 0.0, 100.0, 100.0)
  taffy.set_style(root, hidden_style)
  taffy.compute_layout(root, Size::max_content())
  misc_assert_layout_xywh(taffy, root, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/relayout/relayout_is_stable_with_rounding" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let inner = taffy.new_leaf(
    Style::default().with_min_size(Size(width=length(300.0), height=auto())),
  )
  let wrapper = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=length(150.0), height=auto()))
    .with_justify_content(justify_content_end()),
    [inner],
  )
  let outer = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=percent(1.0), height=auto()))
    .with_inset(Rect(left=length(1.5), right=auto(), top=auto(), bottom=auto())),
    [wrapper],
  )
  let root = taffy.new_with_children(
    Style::default().with_size(
      Size(width=length(1920.0), height=length(1080.0)),
    ),
    [outer],
  )
  taffy.mark_dirty(root)
  taffy.compute_layout(root, Size::max_content())
  let root0 = taffy.layout(root)
  let outer0 = taffy.layout(outer)
  let wrapper0 = taffy.layout(wrapper)
  let inner0 = taffy.layout(inner)
  for _ in 0..<5 {
    taffy.mark_dirty(root)
    taffy.compute_layout(root, Size::max_content())
    let r = taffy.layout(root)
    let o = taffy.layout(outer)
    let w = taffy.layout(wrapper)
    let i = taffy.layout(inner)
    assert_eq(r.location.x, root0.location.x)
    assert_eq(r.location.y, root0.location.y)
    assert_eq(r.size.width, root0.size.width)
    assert_eq(r.size.height, root0.size.height)
    assert_eq(o.location.x, outer0.location.x)
    assert_eq(o.location.y, outer0.location.y)
    assert_eq(o.size.width, outer0.size.width)
    assert_eq(o.size.height, outer0.size.height)
    assert_eq(w.location.x, wrapper0.location.x)
    assert_eq(w.location.y, wrapper0.location.y)
    assert_eq(w.size.width, wrapper0.size.width)
    assert_eq(w.size.height, wrapper0.size.height)
    assert_eq(i.location.x, inner0.location.x)
    assert_eq(i.location.y, inner0.location.y)
    assert_eq(i.size.width, inner0.size.width)
    assert_eq(i.size.height, inner0.size.height)
  }
}

///|
test "upstream/serde/serde_can_serialize" {
  let style = Style::default()
  let _ = style.to_json().stringify()
}

///|
test "upstream/serde/serde_can_deserialize_partial_values" {
  let json_str =
    #|{
    #|  "inset": {
    #|    "left": { "Length": 22 },
    #|    "right": "Auto"
    #|  },
    #|  "size": {
    #|    "width": { "Percent": 50 }
    #|  },
    #|  "min_size": {
    #|    "height": { "Length": 10 }
    #|  },
    #|  "max_size": {
    #|    "width": "Auto"
    #|  },
    #|  "margin": {
    #|    "right": { "Length": 99.0 },
    #|    "bottom": { "Length": 99.0 }
    #|  },
    #|  "padding": {
    #|    "left": { "Length": 99.0 }
    #|  },
    #|  "border": {
    #|    "bottom": { "Length": 99.0 }
    #|  },
    #|  "gap": {
    #|    "width": { "Length": 99.0 }
    #|  },
    #|  "grid_row": { "start": "Auto" },
    #|  "grid_column": { "end": "Auto" }
    #|}
  let json = @json.parse(json_str)
  let style : Style = @json.from_json(json)
  match style.inset.left {
    DimLength(v) => assert_eq(v, 22.0)
    _ => panic()
  }
  match style.inset.right {
    DimAuto => ()
    _ => panic()
  }
  match style.size.width {
    DimPercent(v) => assert_eq(v, 50.0)
    _ => panic()
  }
  match style.min_size.height {
    DimLength(v) => assert_eq(v, 10.0)
    _ => panic()
  }
  match style.max_size.width {
    DimAuto => ()
    _ => panic()
  }
  match style.margin.right {
    DimLength(v) => assert_eq(v, 99.0)
    _ => panic()
  }
  match style.margin.bottom {
    DimLength(v) => assert_eq(v, 99.0)
    _ => panic()
  }
  match style.padding.left {
    DimLength(v) => assert_eq(v, 99.0)
    _ => panic()
  }
  match style.border.bottom {
    DimLength(v) => assert_eq(v, 99.0)
    _ => panic()
  }
  match style.gap.width {
    DimLength(v) => assert_eq(v, 99.0)
    _ => panic()
  }
  match style.grid_row.start {
    PlaceAuto => ()
    _ => panic()
  }
  match style.grid_column.end {
    PlaceAuto => ()
    _ => panic()
  }
}
