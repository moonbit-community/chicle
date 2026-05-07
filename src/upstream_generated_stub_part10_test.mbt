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
test "upstream/generated/flex/absolute_aspect_ratio_width_overrides_inset" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_width_overrides_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=percent(0.4), height=auto()))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(
        left=percent(0.1),
        right=percent(0.1),
        top=percent(0.05),
        bottom=auto(),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 160.0)
  assert_eq(l0.size.height, 53.0)
  assert_eq(l0.location.x, 40.0)
  assert_eq(l0.location.y, 15.0)
}

///|
test "upstream/generated/flex/absolute_child_with_cross_margin" {
  // Ported from taffy-reference/tests/generated/flex/absolute_child_with_cross_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(28.0), height=length(27.0))),
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_position(position_absolute())
    .with_align_content(align_content_stretch())
    .with_flex_grow(0.0)
    .with_flex_shrink(1.0)
    .with_size(Size(width=percent(1.0), height=length(15.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(4.0),
        bottom=length(0.0),
      ),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(25.0), height=length(27.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_space_between())
    .with_min_size(Size(width=length(311.0), height=length(0.0)))
    .with_max_size(
      Size(width=length(311.0), height=length(36893500000000000000.0)),
    ),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 311.0)
  assert_eq(l_node.size.height, 27.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 28.0)
  assert_eq(l0.size.height, 27.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 311.0)
  assert_eq(l1.size.height, 15.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 4.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 25.0)
  assert_eq(l2.size.height, 27.0)
  assert_eq(l2.location.x, 286.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_child_with_main_margin" {
  // Ported from taffy-reference/tests/generated/flex/absolute_child_with_main_margin.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect(
        left=length(7.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(20.0), height=length(37.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 20.0)
  assert_eq(l_node.size.height, 37.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 9.0)
  assert_eq(l0.size.height, 9.0)
  assert_eq(l0.location.x, 7.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_child_with_max_height" {
  // Ported from taffy-reference/tests/generated/flex/absolute_child_with_max_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(30.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_position(position_absolute())
    .with_flex_direction(flex_direction_column())
    .with_max_size(Size(width=auto(), height=length(100.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=auto(), bottom=length(20.0)),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 200.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 30.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 150.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 30.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_child_with_max_height_larger_shrinkable_grandchild" {
  // Ported from taffy-reference/tests/generated/flex/absolute_child_with_max_height_larger_shrinkable_grandchild.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(1.0)
    .with_flex_basis(length(150.0))
    .with_size(Size(width=length(100.0), height=auto())),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_position(position_absolute())
    .with_flex_direction(flex_direction_column())
    .with_max_size(Size(width=auto(), height=length(100.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=auto(), bottom=length(20.0)),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 200.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 80.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(110.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 110.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 25.0)
  assert_eq(l0.location.y, 30.0)
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_bottom_position" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_bottom_position.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(60.0), height=length(40.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=auto(), bottom=length(10.0)),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(110.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 110.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 25.0)
  assert_eq(l0.location.y, 50.0)
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_left_position" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_left_position.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(60.0), height=length(40.0)))
    .with_inset(Rect(left=length(5.0), right=auto(), top=auto(), bottom=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(110.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 110.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 30.0)
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_right_position" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_right_position.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(60.0), height=length(40.0)))
    .with_inset(Rect(left=auto(), right=length(5.0), top=auto(), bottom=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(110.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 110.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 45.0)
  assert_eq(l0.location.y, 30.0)
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_top_position" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_top_position.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(60.0), height=length(40.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(10.0), bottom=auto()),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(110.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 110.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 25.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_flex_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_flex_end())
    .with_justify_content(justify_content_flex_end())
    .with_size(Size(width=length(110.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 110.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 50.0)
  assert_eq(l0.location.y, 60.0)
}

///|
test "upstream/generated/flex/absolute_layout_align_items_center" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_align_items_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_size(Size(width=length(110.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 110.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 30.0)
}

///|
test "upstream/generated/flex/absolute_layout_align_items_center_on_child_only" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_align_items_center_on_child_only.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_center())
    .with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(110.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 110.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 30.0)
}

///|
test "upstream/generated/flex/absolute_layout_child_order" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_child_order.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(110.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 110.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 55.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 30.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 25.0)
  assert_eq(l1.location.y, 30.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 55.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 55.0)
  assert_eq(l2.location.y, 30.0)
}

///|
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_column_container" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_column_container.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 80.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_column_container_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_column_container_flex_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_flex_end())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_row_container" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_row_container.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 80.0)
}

///|
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_row_container_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_row_container_flex_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_flex_end())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_layout_justify_content_center" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_justify_content_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(110.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 110.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 25.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_layout_no_size" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_no_size.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_position(position_absolute()),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_layout_percentage_bottom_based_on_parent_height" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_percentage_bottom_based_on_parent_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=percent(0.5), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=auto(), bottom=percent(0.5)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=auto()))
    .with_inset(
      Rect(left=auto(), right=auto(), top=percent(0.1), bottom=percent(0.1)),
    ),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(200.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 200.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 100.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 90.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 10.0)
  assert_eq(l2.size.height, 160.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 20.0)
}

///|
test "upstream/generated/flex/absolute_layout_percentage_height" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_percentage_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=percent(0.5)))
    .with_inset(
      Rect(left=length(10.0), right=auto(), top=length(10.0), bottom=auto()),
    ),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(200.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 200.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/absolute_layout_row_width_height_end_bottom" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_row_width_height_end_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=length(10.0), top=auto(), bottom=length(10.0)),
    ),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 80.0)
  assert_eq(l0.location.y, 80.0)
}

///|
test "upstream/generated/flex/absolute_layout_start_top_end_bottom" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_start_top_end_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
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
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 80.0)
  assert_eq(l0.size.height, 80.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/absolute_layout_width_height_end_bottom" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_width_height_end_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=length(10.0), top=auto(), bottom=length(10.0)),
    ),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 80.0)
  assert_eq(l0.location.y, 80.0)
}
