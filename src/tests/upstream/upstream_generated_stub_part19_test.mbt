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
test "upstream/generated/flex/flex_direction_row_reverse" {
  // Ported from taffy-reference/tests/generated/flex/flex_direction_row_reverse.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_row_reverse())
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
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 90.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 10.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 70.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_grow_child" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(length(0.0))
    .with_size(Size(width=auto(), height=length(100.0))),
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 0.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_grow_flex_basis_percent_min_max" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_flex_basis_percent_min_max.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(0.0)
    .with_flex_basis(length(0.0))
    .with_size(Size(width=auto(), height=length(20.0)))
    .with_min_size(Size(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(0.0)
    .with_flex_basis(percent(0.5))
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_max_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(120.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 120.0)
  assert_eq(lnode.size.height, 20.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 100.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_grow_height_maximized" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_height_maximized.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_basis(length(200.0)),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(100.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_min_size(Size(width=auto(), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=length(500.0))),
    [node00, node01],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(500.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 500.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 400.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 100.0)
  assert_eq(l01.size.height, 100.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 400.0)
}

///|
test "upstream/generated/flex/flex_grow_in_at_most_container" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_in_at_most_container.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_basis(length(0.0)),
  )
  let node0 = taffy.new_with_children(Style::default(), [node00])
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_flex_start())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 0.0)
  assert_eq(l00.size.height, 0.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_grow_less_than_factor_one" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_less_than_factor_one.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(0.2)
    .with_flex_shrink(0.0)
    .with_flex_basis(length(40.0)),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_flex_grow(0.2).with_flex_shrink(0.0),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_flex_grow(0.4).with_flex_shrink(0.0),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(500.0), height=length(200.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 500.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 132.0)
  assert_eq(l0.size.height, 200.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 92.0)
  assert_eq(l1.size.height, 200.0)
  assert_eq(l1.location.x, 132.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 184.0)
  assert_eq(l2.size.height, 200.0)
  assert_eq(l2.location.x, 224.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_grow_root_minimized" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_root_minimized.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_basis(length(200.0)),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(100.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_min_size(Size(width=auto(), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=length(500.0))),
    [node00, node01],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=length(500.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 300.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 300.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 200.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 100.0)
  assert_eq(l01.size.height, 100.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 200.0)
}

///|
test "upstream/generated/flex/flex_grow_shrink_at_most" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_shrink_at_most.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
  )
  let node0 = taffy.new_with_children(Style::default(), [node00])
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
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 0.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_grow_to_min" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_to_min.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=length(500.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_max_column" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_within_constrained_max_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_flex_shrink(1.0).with_flex_basis(length(100.0)),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_max_size(Size(width=auto(), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 67.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 33.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 67.0)
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_max_row" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_within_constrained_max_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_flex_shrink(1.0).with_flex_basis(length(100.0)),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=auto(), height=length(100.0)))
    .with_max_size(Size(width=length(100.0), height=auto())),
    [node00, node01],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 67.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 33.0)
  assert_eq(l01.size.height, 100.0)
  assert_eq(l01.location.x, 67.0)
  assert_eq(l01.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_max_width" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_within_constrained_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_max_size(Size(width=length(300.0), height=auto())),
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
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 200.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_min_column" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_within_constrained_min_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_min_size(Size(width=auto(), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 0.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_min_max_column" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_within_constrained_min_max_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_min_size(Size(width=auto(), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 0.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_min_row" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_within_constrained_min_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=auto(), height=length(100.0)))
    .with_min_size(Size(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_grow_within_max_width" {
  // Ported from taffy-reference/tests/generated/flex/flex_grow_within_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_max_size(Size(width=length(100.0), height=auto())),
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
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_row_relative_all_sides" {
  // Ported from taffy-reference/tests/generated/flex/flex_row_relative_all_sides.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(40.0), height=auto()))
    .with_inset(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/flex_shrink_by_outer_margin_with_max_size" {
  // Ported from taffy-reference/tests/generated/flex/flex_shrink_by_outer_margin_with_max_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(100.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=auto(), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=length(80.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 20.0)
  assert_eq(lnode.size.height, 80.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 100.0)
}

///|
test "upstream/generated/flex/flex_shrink_flex_grow_child_flex_shrink_other_child" {
  // Ported from taffy-reference/tests/generated/flex/flex_shrink_flex_grow_child_flex_shrink_other_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(0.0)
    .with_flex_shrink(1.0)
    .with_size(Size(width=length(500.0), height=length(100.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_size(Size(width=length(500.0), height=length(100.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(500.0), height=length(500.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 500.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 250.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 250.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 250.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_shrink_flex_grow_row" {
  // Ported from taffy-reference/tests/generated/flex/flex_shrink_flex_grow_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(0.0)
    .with_flex_shrink(1.0)
    .with_size(Size(width=length(500.0), height=length(100.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(0.0)
    .with_flex_shrink(1.0)
    .with_size(Size(width=length(500.0), height=length(100.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(500.0), height=length(500.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 500.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 250.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 250.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 250.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_shrink_to_zero" {
  // Ported from taffy-reference/tests/generated/flex/flex_shrink_to_zero.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(1.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(75.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 75.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 50.0)
  assert_eq(l2.location.x, 50.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_wrap_align_stretch_fits_one_row" {
  // Ported from taffy-reference/tests/generated/flex/flex_wrap_align_stretch_fits_one_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/flex_wrap_children_with_min_main_overriding_flex_basis" {
  // Ported from taffy-reference/tests/generated/flex/flex_wrap_children_with_min_main_overriding_flex_basis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_basis(length(50.0))
    .with_size(Size(width=auto(), height=length(50.0)))
    .with_min_size(Size(width=length(55.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_basis(length(50.0))
    .with_size(Size(width=auto(), height=length(50.0)))
    .with_min_size(Size(width=length(55.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 55.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 55.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/flex/flex_wrap_wrap_to_child_height" {
  // Ported from taffy-reference/tests/generated/flex/flex_wrap_wrap_to_child_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=auto())),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_flex_start()),
    [node00],
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 100.0)
  assert_eq(l000.size.height, 100.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 100.0)
}

///|
test "upstream/generated/flex/gap_column_gap_child_margins" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_child_margins.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_margin(
      Rect(
        left=length(2.0),
        right=length(2.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_margin(
      Rect(
        left=length(15.0),
        right=length(15.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
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
  assert_eq(l0.size.width, 2.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 2.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 2.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 26.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 2.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 63.0)
  assert_eq(l2.location.y, 0.0)
}
