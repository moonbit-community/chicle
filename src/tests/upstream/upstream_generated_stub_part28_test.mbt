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
test "upstream/generated/flex/percentage_size_of_flex_basis" {
  // Ported from taffy-reference/tests/generated/flex/percentage_size_of_flex_basis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(1.0), height=length(100.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_flex_basis(length(50.0)),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
    [node0],
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
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_sizes_should_not_prevent_flex_shrinking" {
  // Ported from taffy-reference/tests/generated/flex/percentage_sizes_should_not_prevent_flex_shrinking.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(Style::default())
  let node0 = taffy.new_with_children(
    Style::default().with_size(Size(width=percent(1.2), height=auto())),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(200.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 200.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 0.0)
  assert_eq(l00.size.height, 200.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_width_height" {
  // Ported from taffy-reference/tests/generated/flex/percentage_width_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(0.3), height=percent(0.3))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(200.0), height=length(400.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 120.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/percentage_width_height_undefined_parent_size" {
  // Ported from taffy-reference/tests/generated/flex/percentage_width_height_undefined_parent_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(0.5), height=percent(0.5))),
  )
  let node = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 0.0)
  assert_eq(lnode.size.height, 0.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/position_root_with_rtl_should_position_withoutdirection" {
  // Ported from taffy-reference/tests/generated/flex/position_root_with_rtl_should_position_withoutdirection.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(52.0), height=length(52.0)))
    .with_inset(
      Rect(left=length(72.0), right=auto(), top=auto(), bottom=auto()),
    ),
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 52.0)
  assert_eq(lnode.size.height, 52.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 52.0)
  assert_eq(l0.size.height, 52.0)
  assert_eq(l0.location.x, 72.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/relative_position_should_not_nudge_siblings" {
  // Ported from taffy-reference/tests/generated/flex/relative_position_should_not_nudge_siblings.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(15.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(15.0), bottom=auto()),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 15.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 25.0)
}

///|
test "upstream/generated/flex/rounding_flex_basis_flex_grow_row_prime_number_width" {
  // Ported from taffy-reference/tests/generated/flex/rounding_flex_basis_flex_grow_row_prime_number_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node1 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node2 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node3 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node4 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(113.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 113.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 23.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 22.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 23.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 23.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 45.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 22.0)
  assert_eq(l3.size.height, 100.0)
  assert_eq(l3.location.x, 68.0)
  assert_eq(l3.location.y, 0.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 23.0)
  assert_eq(l4.size.height, 100.0)
  assert_eq(l4.location.x, 90.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/rounding_flex_basis_flex_grow_row_width_of_100" {
  // Ported from taffy-reference/tests/generated/flex/rounding_flex_basis_flex_grow_row_width_of_100.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node1 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node2 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 33.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 34.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 33.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 33.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 67.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/rounding_flex_basis_flex_shrink_row" {
  // Ported from taffy-reference/tests/generated/flex/rounding_flex_basis_flex_shrink_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_flex_shrink(1.0).with_flex_basis(length(100.0)),
  )
  let node1 = taffy.new_leaf(Style::default().with_flex_basis(length(25.0)))
  let node2 = taffy.new_leaf(Style::default().with_flex_basis(length(25.0)))
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(101.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 101.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 67.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 17.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 67.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 17.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 84.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/rounding_flex_basis_overrides_main_size" {
  // Ported from taffy-reference/tests/generated/flex/rounding_flex_basis_overrides_main_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(length(50.0))
    .with_size(Size(width=auto(), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(113.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 113.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 64.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 25.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 64.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 24.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 89.0)
}

///|
test "upstream/generated/flex/rounding_fractial_input_1" {
  // Ported from taffy-reference/tests/generated/flex/rounding_fractial_input_1.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(length(50.0))
    .with_size(Size(width=auto(), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(113.4))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 113.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 64.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 25.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 64.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 24.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 89.0)
}

///|
test "upstream/generated/flex/rounding_fractial_input_2" {
  // Ported from taffy-reference/tests/generated/flex/rounding_fractial_input_2.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(length(50.0))
    .with_size(Size(width=auto(), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(113.6))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 114.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 65.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 24.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 65.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 25.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 89.0)
}

///|
test "upstream/generated/flex/rounding_fractial_input_3" {
  // Ported from taffy-reference/tests/generated/flex/rounding_fractial_input_3.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(length(50.0))
    .with_size(Size(width=auto(), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(113.4))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 113.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 64.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 25.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 64.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 24.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 89.0)
}

///|
test "upstream/generated/flex/rounding_fractial_input_4" {
  // Ported from taffy-reference/tests/generated/flex/rounding_fractial_input_4.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(length(50.0))
    .with_size(Size(width=auto(), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(113.4))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 113.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 64.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 25.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 64.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 24.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 89.0)
}

///|
test "upstream/generated/flex/rounding_fractial_input_5" {
  // Ported from taffy-reference/tests/generated/flex/rounding_fractial_input_5.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.3), height=length(100.3))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.3), height=length(100.3))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(963.333), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 963.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 101.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 381.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 482.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/rounding_fractial_input_6" {
  // Ported from taffy-reference/tests/generated/flex/rounding_fractial_input_6.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(2.0), height=length(10.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(2.0), height=length(10.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=percent(0.5), height=auto())),
    [node00, node01],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(2.0), height=length(10.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(2.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=percent(0.5), height=auto())),
    [node10, node11],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(7.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 7.0)
  assert_eq(lnode.size.height, 20.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 4.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 2.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 2.0)
  assert_eq(l01.size.height, 10.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 3.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 4.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 2.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 2.0)
  assert_eq(l11.size.height, 10.0)
  assert_eq(l11.location.x, 0.0)
  assert_eq(l11.location.y, 10.0)
}

///|
test "upstream/generated/flex/rounding_fractial_input_7" {
  // Ported from taffy-reference/tests/generated/flex/rounding_fractial_input_7.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(1.0), height=length(10.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(1.0), height=length(10.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=percent(0.25), height=auto())),
    [node00, node01],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(1.0), height=length(10.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(1.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=percent(0.25), height=auto())),
    [node10, node11],
  )
  let node20 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(1.0), height=length(10.0))),
  )
  let node21 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(1.0), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=percent(0.25), height=auto())),
    [node20, node21],
  )
  let node30 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(1.0), height=length(10.0))),
  )
  let node31 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(1.0), height=length(10.0))),
  )
  let node3 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=percent(0.25), height=auto())),
    [node30, node31],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(7.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 7.0)
  assert_eq(lnode.size.height, 20.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 2.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 1.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 1.0)
  assert_eq(l01.size.height, 10.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 2.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 2.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 1.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 1.0)
  assert_eq(l11.size.height, 10.0)
  assert_eq(l11.location.x, 0.0)
  assert_eq(l11.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 1.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 4.0)
  assert_eq(l2.location.y, 0.0)
  let l20 = taffy.layout(node20)
  assert_eq(l20.size.width, 1.0)
  assert_eq(l20.size.height, 10.0)
  assert_eq(l20.location.x, 0.0)
  assert_eq(l20.location.y, 0.0)
  let l21 = taffy.layout(node21)
  assert_eq(l21.size.width, 1.0)
  assert_eq(l21.size.height, 10.0)
  assert_eq(l21.location.x, 0.0)
  assert_eq(l21.location.y, 10.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 2.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 5.0)
  assert_eq(l3.location.y, 0.0)
  let l30 = taffy.layout(node30)
  assert_eq(l30.size.width, 1.0)
  assert_eq(l30.size.height, 10.0)
  assert_eq(l30.location.x, 0.0)
  assert_eq(l30.location.y, 0.0)
  let l31 = taffy.layout(node31)
  assert_eq(l31.size.width, 1.0)
  assert_eq(l31.size.height, 10.0)
  assert_eq(l31.location.x, 0.0)
  assert_eq(l31.location.y, 10.0)
}

///|
test "upstream/generated/flex/rounding_inner_node_controversy_combined" {
  // Ported from taffy-reference/tests/generated/flex/rounding_inner_node_controversy_combined.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=percent(1.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=percent(1.0), height=auto())),
  )
  let node110 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=percent(1.0), height=auto())),
  )
  let node11 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=percent(1.0), height=auto())),
    [node110],
  )
  let node12 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=percent(1.0), height=auto())),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=percent(1.0))),
    [node10, node11, node12],
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=percent(1.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(640.0), height=length(320.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 640.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 213.0)
  assert_eq(l0.size.height, 320.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 214.0)
  assert_eq(l1.size.height, 320.0)
  assert_eq(l1.location.x, 213.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 214.0)
  assert_eq(l10.size.height, 107.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 214.0)
  assert_eq(l11.size.height, 106.0)
  assert_eq(l11.location.x, 0.0)
  assert_eq(l11.location.y, 107.0)
  let l110 = taffy.layout(node110)
  assert_eq(l110.size.width, 214.0)
  assert_eq(l110.size.height, 106.0)
  assert_eq(l110.location.x, 0.0)
  assert_eq(l110.location.y, 0.0)
  let l12 = taffy.layout(node12)
  assert_eq(l12.size.width, 214.0)
  assert_eq(l12.size.height, 107.0)
  assert_eq(l12.location.x, 0.0)
  assert_eq(l12.location.y, 213.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 213.0)
  assert_eq(l2.size.height, 320.0)
  assert_eq(l2.location.x, 427.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/rounding_inner_node_controversy_horizontal" {
  // Ported from taffy-reference/tests/generated/flex/rounding_inner_node_controversy_horizontal.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
    [node10],
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(320.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 10.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 107.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 106.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 107.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 106.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 107.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 213.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/rounding_inner_node_controversy_vertical" {
  // Ported from taffy-reference/tests/generated/flex/rounding_inner_node_controversy_vertical.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=length(10.0), height=auto())),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=length(10.0), height=auto())),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=length(10.0), height=auto())),
    [node10],
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=length(10.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=auto(), height=length(320.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 10.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 107.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 106.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 107.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 10.0)
  assert_eq(l10.size.height, 106.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 10.0)
  assert_eq(l2.size.height, 107.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 213.0)
}

///|
test "upstream/generated/flex/rounding_total_fractial" {
  // Ported from taffy-reference/tests/generated/flex/rounding_total_fractial.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(0.7)
    .with_flex_basis(length(50.3))
    .with_size(Size(width=auto(), height=length(20.3))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.6)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.1)
    .with_size(Size(width=auto(), height=length(10.7))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(87.4), height=length(113.4))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 87.0)
  assert_eq(lnode.size.height, 113.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 87.0)
  assert_eq(l0.size.height, 59.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 87.0)
  assert_eq(l1.size.height, 30.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 59.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 87.0)
  assert_eq(l2.size.height, 24.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 89.0)
}

///|
test "upstream/generated/flex/rounding_total_fractial_nested" {
  // Ported from taffy-reference/tests/generated/flex/rounding_total_fractial_nested.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(length(0.3))
    .with_size(Size(width=auto(), height=length(9.9)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=auto(), bottom=length(13.3)),
    ),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(4.0)
    .with_flex_basis(length(0.3))
    .with_size(Size(width=auto(), height=length(1.1)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(13.3), bottom=auto()),
    ),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(0.7)
    .with_flex_basis(length(50.3))
    .with_size(Size(width=auto(), height=length(20.3))),
    [node00, node01],
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.6)
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.1)
    .with_size(Size(width=auto(), height=length(10.7))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(87.4), height=length(113.4))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 87.0)
  assert_eq(lnode.size.height, 113.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 87.0)
  assert_eq(l0.size.height, 59.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 87.0)
  assert_eq(l00.size.height, 12.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, -13.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 87.0)
  assert_eq(l01.size.height, 47.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 25.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 87.0)
  assert_eq(l1.size.height, 30.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 59.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 87.0)
  assert_eq(l2.size.height, 24.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 89.0)
}

///|
test "upstream/generated/flex/scroll_size" {
  // Ported from taffy-reference/tests/generated/flex/scroll_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_align_items(align_items_start())
    .with_justify_content(justify_content_start())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 100.0, 0.0, 0.0)
}

///|
test "upstream/generated/flex/simple_child" {
  // Ported from taffy-reference/tests/generated/flex/simple_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
    [node000],
  )
  let node010 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node011 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node01 = taffy.new_with_children(Style::default(), [node010, node011])
  let node0 = taffy.new_with_children(
    Style::default().with_size(Size(width=percent(1.0), height=percent(1.0))),
    [node00, node01],
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
  assert_eq(l00.size.width, 10.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 10.0)
  assert_eq(l000.size.height, 10.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 20.0)
  assert_eq(l01.size.height, 100.0)
  assert_eq(l01.location.x, 10.0)
  assert_eq(l01.location.y, 0.0)
  let l010 = taffy.layout(node010)
  assert_eq(l010.size.width, 10.0)
  assert_eq(l010.size.height, 10.0)
  assert_eq(l010.location.x, 0.0)
  assert_eq(l010.location.y, 45.0)
  let l011 = taffy.layout(node011)
  assert_eq(l011.size.width, 10.0)
  assert_eq(l011.size.height, 10.0)
  assert_eq(l011.location.x, 10.0)
  assert_eq(l011.location.y, 45.0)
}

///|
test "upstream/generated/flex/single_flex_child_after_absolute_child" {
  // Ported from taffy-reference/tests/generated/flex/single_flex_child_after_absolute_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=percent(1.0), height=percent(1.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_flex_shrink(0.0).with_flex_basis(length(174.0)),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(428.0), height=length(845.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 428.0)
  assert_eq(lnode.size.height, 845.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 428.0)
  assert_eq(l0.size.height, 845.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 428.0)
  assert_eq(l1.size.height, 671.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 428.0)
  assert_eq(l2.size.height, 174.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 671.0)
}
