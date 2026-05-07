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
test "upstream/generated/flex/parent_wrap_child_size_overflowing_parent" {
  // Ported from taffy-reference/tests/generated/flex/parent_wrap_child_size_overflowing_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(200.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 200.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/percent_absolute_position" {
  // Ported from taffy-reference/tests/generated/flex/percent_absolute_position.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(1.0), height=auto())),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(1.0), height=auto())),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=percent(1.0), height=length(50.0)))
    .with_inset(
      Rect(left=percent(0.5), right=auto(), top=auto(), bottom=auto()),
    ),
    [node00, node01],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(60.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 60.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 30.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 30.0)
  assert_eq(l00.size.height, 50.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 30.0)
  assert_eq(l01.size.height, 50.0)
  assert_eq(l01.location.x, 30.0)
  assert_eq(l01.location.y, 0.0)
}

///|
test "upstream/generated/flex/percent_within_flex_grow" {
  // Ported from taffy-reference/tests/generated/flex/percent_within_flex_grow.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(1.0), height=auto())),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0),
    [node10],
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(350.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 350.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 150.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 100.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 150.0)
  assert_eq(l10.size.height, 0.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 250.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_absolute_position" {
  // Ported from taffy-reference/tests/generated/flex/percentage_absolute_position.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=percent(0.3), right=auto(), top=percent(0.1), bottom=auto()),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/percentage_container_in_wrapping_container" {
  // Ported from taffy-reference/tests/generated/flex/percentage_container_in_wrapping_container.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node001 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_center())
    .with_size(Size(width=percent(1.0), height=auto())),
    [node000, node001],
  )
  let node0 = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 50.0)
  assert_eq(l0.location.y, 75.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 50.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 50.0)
  assert_eq(l000.size.height, 50.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
  let l001 = taffy.layout(node001)
  assert_eq(l001.size.width, 50.0)
  assert_eq(l001.size.height, 50.0)
  assert_eq(l001.location.x, 50.0)
  assert_eq(l001.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_different_width_height" {
  // Ported from taffy-reference/tests/generated/flex/percentage_different_width_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=percent(0.3))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=percent(0.3))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(200.0), height=length(300.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 300.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 90.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 90.0)
  assert_eq(l1.location.x, 200.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_different_width_height_column" {
  // Ported from taffy-reference/tests/generated/flex/percentage_different_width_height_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=percent(0.3))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(300.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 300.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 210.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 90.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 210.0)
}

///|
test "upstream/generated/flex/percentage_flex_basis" {
  // Ported from taffy-reference/tests/generated/flex/percentage_flex_basis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_basis(percent(0.5)),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_basis(percent(0.25)),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 125.0)
  assert_eq(l0.size.height, 200.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 75.0)
  assert_eq(l1.size.height, 200.0)
  assert_eq(l1.location.x, 125.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_flex_basis_cross" {
  // Ported from taffy-reference/tests/generated/flex/percentage_flex_basis_cross.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_basis(percent(0.5)),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_basis(percent(0.25)),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(400.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 250.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 150.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 250.0)
}

///|
test "upstream/generated/flex/percentage_flex_basis_cross_max_height" {
  // Ported from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(percent(0.1))
    .with_max_size(Size(width=auto(), height=percent(0.6))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(4.0)
    .with_flex_basis(percent(0.1))
    .with_max_size(Size(width=auto(), height=percent(0.2))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(400.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 240.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 80.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 240.0)
}

///|
test "upstream/generated/flex/percentage_flex_basis_cross_max_width" {
  // Ported from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(percent(0.1))
    .with_max_size(Size(width=percent(0.6), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(4.0)
    .with_flex_basis(percent(0.15))
    .with_max_size(Size(width=percent(0.2), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(400.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 120.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 300.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 100.0)
}

///|
test "upstream/generated/flex/percentage_flex_basis_cross_min_height" {
  // Ported from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_min_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_min_size(Size(width=auto(), height=percent(0.6))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(2.0)
    .with_min_size(Size(width=auto(), height=percent(0.1))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(400.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 240.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 160.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 240.0)
}

///|
test "upstream/generated/flex/percentage_flex_basis_cross_min_width" {
  // Ported from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_min_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(percent(0.1))
    .with_min_size(Size(width=percent(0.6), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(4.0)
    .with_flex_basis(percent(0.15))
    .with_min_size(Size(width=percent(0.2), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(400.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 300.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 100.0)
}

///|
test "upstream/generated/flex/percentage_flex_basis_main_max_height" {
  // Ported from taffy-reference/tests/generated/flex/percentage_flex_basis_main_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(percent(0.1))
    .with_max_size(Size(width=auto(), height=percent(0.6))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(4.0)
    .with_flex_basis(percent(0.1))
    .with_max_size(Size(width=auto(), height=percent(0.2))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(200.0), height=length(400.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 52.0)
  assert_eq(l0.size.height, 240.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 148.0)
  assert_eq(l1.size.height, 80.0)
  assert_eq(l1.location.x, 52.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_flex_basis_main_max_width" {
  // Ported from taffy-reference/tests/generated/flex/percentage_flex_basis_main_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(percent(0.15))
    .with_max_size(Size(width=percent(0.6), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(4.0)
    .with_flex_basis(percent(0.1))
    .with_max_size(Size(width=percent(0.2), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(200.0), height=length(400.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 120.0)
  assert_eq(l0.size.height, 400.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 400.0)
  assert_eq(l1.location.x, 120.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_flex_basis_main_min_width" {
  // Ported from taffy-reference/tests/generated/flex/percentage_flex_basis_main_min_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(percent(0.15))
    .with_min_size(Size(width=percent(0.6), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(4.0)
    .with_flex_basis(percent(0.1))
    .with_min_size(Size(width=percent(0.2), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(200.0), height=length(400.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 120.0)
  assert_eq(l0.size.height, 400.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 80.0)
  assert_eq(l1.size.height, 400.0)
  assert_eq(l1.location.x, 120.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_main_max_height" {
  // Ported from taffy-reference/tests/generated/flex/percentage_main_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(Style::default().with_flex_basis(length(15.0)))
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_basis(length(48.0))
    .with_max_size(Size(width=auto(), height=percent(0.33))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_flex_start())
    .with_size(Size(width=auto(), height=length(151.0))),
    [node00, node01],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(71.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 71.0)
  assert_eq(lnode.size.height, 151.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 71.0)
  assert_eq(l0.size.height, 151.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 0.0)
  assert_eq(l00.size.height, 15.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 0.0)
  assert_eq(l01.size.height, 48.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 15.0)
}

///|
test "upstream/generated/flex/percentage_margin_should_calculate_based_only_on_width" {
  // Ported from taffy-reference/tests/generated/flex/percentage_margin_should_calculate_based_only_on_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_margin(
      Rect(
        left=percent(0.1),
        right=percent(0.1),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 160.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 20.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 10.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_moderate_complexity" {
  // Ported from taffy-reference/tests/generated/flex/percentage_moderate_complexity.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=percent(0.45), height=auto()))
    .with_margin(
      Rect(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    )
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(3.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=percent(0.5), height=auto()))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    )
    .with_padding(
      Rect(
        left=percent(0.03),
        right=percent(0.03),
        top=percent(0.03),
        bottom=percent(0.03),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=auto()))
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(3.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
}

///|
test "upstream/generated/flex/percentage_moderate_complexity2" {
  // Ported from taffy-reference/tests/generated/flex/percentage_moderate_complexity2.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=percent(0.5), height=auto()))
    .with_padding(
      Rect(
        left=percent(0.1),
        right=percent(0.1),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 20.0)
}

///|
test "upstream/generated/flex/percentage_multiple_nested_with_padding_margin_and_percentage_values" {
  // Ported from taffy-reference/tests/generated/flex/percentage_multiple_nested_with_padding_margin_and_percentage_values.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=percent(0.45), height=auto()))
    .with_margin(
      Rect(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    )
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(3.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=percent(0.5), height=auto()))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    )
    .with_padding(
      Rect(
        left=percent(0.03),
        right=percent(0.03),
        top=percent(0.03),
        bottom=percent(0.03),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_flex_basis(percent(0.1))
    .with_min_size(Size(width=percent(0.6), height=auto()))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    )
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(3.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
    [node00],
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(4.0)
    .with_flex_basis(percent(0.15))
    .with_min_size(Size(width=percent(0.2), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 190.0)
  assert_eq(l0.size.height, 48.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 5.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 92.0)
  assert_eq(l00.size.height, 25.0)
  assert_eq(l00.location.x, 8.0)
  assert_eq(l00.location.y, 8.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 36.0)
  assert_eq(l000.size.height, 6.0)
  assert_eq(l000.location.x, 10.0)
  assert_eq(l000.location.y, 10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 142.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 58.0)
}

///|
test "upstream/generated/flex/percentage_padding_should_calculate_based_only_on_width" {
  // Ported from taffy-reference/tests/generated/flex/percentage_padding_should_calculate_based_only_on_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_padding(
      Rect(
        left=percent(0.1),
        right=percent(0.1),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 10.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 20.0)
}

///|
test "upstream/generated/flex/percentage_position_bottom_right" {
  // Ported from taffy-reference/tests/generated/flex/percentage_position_bottom_right.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=percent(0.55), height=percent(0.15)))
    .with_inset(
      Rect(left=auto(), right=percent(0.2), top=auto(), bottom=percent(0.1)),
    ),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(500.0), height=length(500.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 500.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 275.0)
  assert_eq(l0.size.height, 75.0)
  assert_eq(l0.location.x, -100.0)
  assert_eq(l0.location.y, -50.0)
}

///|
test "upstream/generated/flex/percentage_position_left_top" {
  // Ported from taffy-reference/tests/generated/flex/percentage_position_left_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=percent(0.45), height=percent(0.55)))
    .with_inset(
      Rect(left=percent(0.1), right=auto(), top=percent(0.2), bottom=auto()),
    ),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(400.0), height=length(400.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 400.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 180.0)
  assert_eq(l0.size.height, 220.0)
  assert_eq(l0.location.x, 40.0)
  assert_eq(l0.location.y, 80.0)
}

///|
test "upstream/generated/flex/percentage_size_based_on_parent_inner_size" {
  // Ported from taffy-reference/tests/generated/flex/percentage_size_based_on_parent_inner_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(0.5), height=percent(0.5))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(400.0)))
    .with_padding(
      Rect(
        left=length(20.0),
        right=length(20.0),
        top=length(20.0),
        bottom=length(20.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 80.0)
  assert_eq(l0.size.height, 180.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 20.0)
}
