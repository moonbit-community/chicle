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
test "upstream/generated/block/block_absolute_aspect_ratio_aspect_ratio_overrides_height_of_full_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_aspect_ratio_overrides_height_of_full_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 360.0)
  assert_eq(c.size.height, 120.0)
  assert_eq(c.location.x, 20.0)
  assert_eq(c.location.y, 15.0)
}

///|
test "upstream/generated/block/block_absolute_aspect_ratio_fill_height" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=percent(0.5), height=auto()))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(left=percent(0.05), right=auto(), top=percent(0.05), bottom=auto()),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 200.0)
  assert_eq(c.size.height, 67.0)
  assert_eq(c.location.x, 20.0)
  assert_eq(c.location.y, 15.0)
}

///|
test "upstream/generated/block/block_absolute_aspect_ratio_fill_height_from_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_height_from_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 320.0)
  assert_eq(c.size.height, 107.0)
  assert_eq(c.location.x, 40.0)
  assert_eq(c.location.y, 15.0)
}

///|
test "upstream/generated/block/block_absolute_aspect_ratio_fill_max_height" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let child = taffy.new_leaf_with_context(
    Style::default()
    .with_position(position_absolute())
    .with_max_size(Size(width=length(50.0), height=auto()))
    .with_aspect_ratio(3.0),
    TextMeasure::{
      text_content: "HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 50.0)
  assert_eq(c.size.height, 17.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_aspect_ratio_fill_max_width" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let child = taffy.new_leaf_with_context(
    Style::default()
    .with_position(position_absolute())
    .with_max_size(Size(width=auto(), height=length(50.0)))
    .with_aspect_ratio(0.5),
    TextMeasure::{
      text_content: "HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 25.0)
  assert_eq(c.size.height, 50.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_aspect_ratio_fill_min_height" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_min_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_min_size(Size(width=length(50.0), height=auto()))
    .with_aspect_ratio(3.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 50.0)
  assert_eq(c.size.height, 17.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_aspect_ratio_fill_min_width" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_min_width.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_min_size(Size(width=auto(), height=length(50.0)))
    .with_aspect_ratio(0.5),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 25.0)
  assert_eq(c.size.height, 50.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_aspect_ratio_fill_width" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_width.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=auto(), height=percent(0.2)))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(left=percent(0.05), right=auto(), top=percent(0.05), bottom=auto()),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 180.0)
  assert_eq(c.size.height, 60.0)
  assert_eq(c.location.x, 20.0)
  assert_eq(c.location.y, 15.0)
}

///|
test "upstream/generated/block/block_absolute_aspect_ratio_fill_width_from_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_width_from_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(left=auto(), right=auto(), top=percent(0.3), bottom=percent(0.5)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 180.0)
  assert_eq(c.size.height, 60.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 90.0)
}

///|
test "upstream/generated/block/block_absolute_aspect_ratio_height_overrides_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_height_overrides_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=auto(), height=percent(0.1)))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(left=auto(), right=auto(), top=percent(0.3), bottom=percent(0.5)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 90.0)
  assert_eq(c.size.height, 30.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 90.0)
}

///|
test "upstream/generated/block/block_absolute_aspect_ratio_width_overrides_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_width_overrides_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 400.0)
  assert_eq(root_layout.size.height, 300.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 160.0)
  assert_eq(c.size.height, 53.0)
  assert_eq(c.location.x, 40.0)
  assert_eq(c.location.y, 15.0)
}

///|
test "upstream/generated/block/block_absolute_child_with_margin_x" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_child_with_margin_x.rs
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
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(7.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(5.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(20.0), height=length(37.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 20.0)
  assert_eq(root_layout.size.height, 37.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 9.0)
  assert_eq(l0.size.height, 9.0)
  assert_eq(l0.location.x, 7.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 9.0)
  assert_eq(l1.size.height, 9.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 9.0)
  assert_eq(l2.size.height, 9.0)
  assert_eq(l2.location.x, 10.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_child_with_margin_y" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_child_with_margin_y.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(7.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(7.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(5.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(20.0), height=length(37.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 20.0)
  assert_eq(root_layout.size.height, 37.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 9.0)
  assert_eq(l0.size.height, 9.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 7.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 9.0)
  assert_eq(l1.size.height, 9.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 9.0)
  assert_eq(l2.size.height, 9.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_child_with_max_height" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_child_with_max_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(150.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_max_size(Size(width=auto(), height=length(100.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=auto(), bottom=length(20.0)),
    ),
    [node00],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 200.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 80.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 150.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_layout_child_order" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_layout_child_order.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(60.0), height=length(40.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(110.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 110.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 40.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 60.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 40.0)
}

///|
test "upstream/generated/block/block_absolute_layout_no_size" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_layout_no_size.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default().with_position(position_absolute()),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 0.0)
  assert_eq(c.size.height, 0.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_layout_percentage_bottom_based_on_parent_height" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_layout_percentage_bottom_based_on_parent_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=percent(0.5), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=auto(), bottom=percent(0.5)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=auto()))
    .with_inset(
      Rect(left=auto(), right=auto(), top=percent(0.1), bottom=percent(0.1)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(200.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 200.0)
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
test "upstream/generated/block/block_absolute_layout_percentage_height" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_layout_percentage_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=percent(0.5)))
    .with_inset(
      Rect(left=length(10.0), right=auto(), top=length(10.0), bottom=auto()),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(200.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 10.0)
  assert_eq(c.size.height, 50.0)
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_layout_row_width_height_end_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_layout_row_width_height_end_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=length(10.0), top=auto(), bottom=length(10.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 10.0)
  assert_eq(c.size.height, 10.0)
  assert_eq(c.location.x, 80.0)
  assert_eq(c.location.y, 80.0)
}

///|
test "upstream/generated/block/block_absolute_layout_start_top_end_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_layout_start_top_end_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 80.0)
  assert_eq(c.size.height, 80.0)
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_layout_width_height_end_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_layout_width_height_end_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=length(10.0), top=auto(), bottom=length(10.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 10.0)
  assert_eq(c.size.height, 10.0)
  assert_eq(c.location.x, 80.0)
  assert_eq(c.location.y, 80.0)
}

///|
test "upstream/generated/block/block_absolute_layout_width_height_start_top" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_layout_width_height_start_top.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=length(10.0), right=auto(), top=length(10.0), bottom=auto()),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 10.0)
  assert_eq(c.size.height, 10.0)
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_layout_width_height_start_top_end_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_layout_width_height_start_top_end_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 10.0)
  assert_eq(c.size.height, 10.0)
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_layout_within_border" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_layout_within_border.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_border(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 40.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 50.0)
  assert_eq(l2.location.x, 20.0)
  assert_eq(l2.location.y, 20.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 50.0)
  assert_eq(l3.location.x, 30.0)
  assert_eq(l3.location.y, 30.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_bottom_and_top_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_and_top_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=auto(), bottom=auto()),
    )
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(10.0), bottom=length(20.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 50.0)
  assert_eq(c.size.height, 50.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 70.0)
}
