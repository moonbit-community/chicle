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
test "upstream/generated/flex/gap_column_gap_determines_parent_width" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_determines_parent_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_stretch())
    .with_gap(Size(width=length(10.0), height=length(0.0)))
    .with_size(Size(width=auto(), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 80.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 20.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 50.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_flexible" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_flexible.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(80.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 80.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_flexible_undefined_parent" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_flexible_undefined_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=auto(), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 20.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 10.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 0.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 20.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_inflexible" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_inflexible.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_gap(Size(width=length(10.0), height=length(0.0)))
    .with_size(Size(width=length(80.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 80.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_inflexible_undefined_parent" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_inflexible_undefined_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_gap(Size(width=length(10.0), height=length(0.0)))
    .with_size(Size(width=auto(), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 80.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_justify_center" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_justify_center.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_center())
    .with_gap(Size(width=length(10.0), height=length(0.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 70.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_justify_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_justify_flex_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_flex_end())
    .with_gap(Size(width=length(10.0), height=length(0.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 80.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_justify_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_justify_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_flex_start())
    .with_gap(Size(width=length(10.0), height=length(0.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_justify_space_around" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_justify_space_around.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_space_around())
    .with_gap(Size(width=length(10.0), height=length(0.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 3.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 77.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_justify_space_between" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_justify_space_between.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_space_between())
    .with_gap(Size(width=length(10.0), height=length(0.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 80.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_justify_space_evenly" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_justify_space_evenly.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_space_evenly())
    .with_gap(Size(width=length(10.0), height=length(0.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 75.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_mixed_flexible" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_mixed_flexible.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_gap(Size(width=length(10.0), height=length(0.0)))
    .with_size(Size(width=length(80.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 80.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_cyclic_partially_shrinkable" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_percentage_cyclic_partially_shrinkable.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(20.0), height=length(40.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(40.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(20.0), height=length(40.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_gap(Size(width=percent(0.5), height=length(0.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 60.0)
  assert_eq(lnode.size.height, 40.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 80.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_cyclic_shrinkable" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_percentage_cyclic_shrinkable.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(40.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(40.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(40.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_gap(Size(width=percent(0.2), height=length(0.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 60.0)
  assert_eq(lnode.size.height, 40.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 12.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 12.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 24.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 12.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 48.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_cyclic_unshrinkable" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_percentage_cyclic_unshrinkable.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(20.0), height=length(40.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(20.0), height=length(40.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(20.0), height=length(40.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_gap(Size(width=percent(0.2), height=length(0.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 60.0)
  assert_eq(lnode.size.height, 40.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 32.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 64.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_flexible" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_percentage_flexible.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_gap(Size(width=percent(0.1), height=length(20.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 27.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 26.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 37.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 27.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 73.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_flexible_with_padding" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_percentage_flexible_with_padding.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_gap(Size(width=percent(0.1), height=length(20.0)))
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 21.0)
  assert_eq(l0.size.height, 80.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 22.0)
  assert_eq(l1.size.height, 80.0)
  assert_eq(l1.location.x, 39.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 21.0)
  assert_eq(l2.size.height, 80.0)
  assert_eq(l2.location.x, 69.0)
  assert_eq(l2.location.y, 10.0)
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_inflexible" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_percentage_inflexible.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_gap(Size(width=percent(0.2), height=length(0.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 80.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_row_gap_wrapping" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_row_gap_wrapping.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node8 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(80.0), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 80.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 40.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 40.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 60.0)
  assert_eq(l5.location.y, 40.0)
  let l6 = taffy.layout(node6)
  assert_eq(l6.size.width, 20.0)
  assert_eq(l6.size.height, 20.0)
  assert_eq(l6.location.x, 0.0)
  assert_eq(l6.location.y, 80.0)
  let l7 = taffy.layout(node7)
  assert_eq(l7.size.width, 20.0)
  assert_eq(l7.size.height, 20.0)
  assert_eq(l7.location.x, 30.0)
  assert_eq(l7.location.y, 80.0)
  let l8 = taffy.layout(node8)
  assert_eq(l8.size.width, 20.0)
  assert_eq(l8.size.height, 20.0)
  assert_eq(l8.location.x, 60.0)
  assert_eq(l8.location.y, 80.0)
}

///|
test "upstream/generated/flex/gap_column_gap_start_index" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_start_index.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(80.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 80.0)
  assert_eq(lnode.size.height, 20.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 30.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 60.0)
  assert_eq(l3.location.y, 0.0)
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_center" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_center.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_center())
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 20.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 20.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 60.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 60.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 60.0)
  assert_eq(l5.location.y, 60.0)
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_flex_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_flex_end())
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 40.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 40.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 40.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 80.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 80.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 60.0)
  assert_eq(l5.location.y, 80.0)
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_flex_start())
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 40.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 40.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 60.0)
  assert_eq(l5.location.y, 40.0)
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_space_around" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_space_around.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_space_around())
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 10.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 70.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 70.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 60.0)
  assert_eq(l5.location.y, 70.0)
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_space_between" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_space_between.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_space_between())
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 80.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 80.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 60.0)
  assert_eq(l5.location.y, 80.0)
}
