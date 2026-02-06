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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
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
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=percent(0.5), height=auto()))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=percent(0.05),
        right=auto(),
        top=percent(0.05),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
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
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let child = taffy.new_leaf_with_context(
    Style::default()
    .with_position(position_absolute())
    .with_max_size(Size::new(width=length(50.0), height=auto()))
    .with_aspect_ratio(3.0),
    TextMeasure::{
      text_content: "HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let child = taffy.new_leaf_with_context(
    Style::default()
    .with_position(position_absolute())
    .with_max_size(Size::new(width=auto(), height=length(50.0)))
    .with_aspect_ratio(0.5),
    TextMeasure::{
      text_content: "HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_min_size(Size::new(width=length(50.0), height=auto()))
    .with_aspect_ratio(3.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_min_size(Size::new(width=auto(), height=length(50.0)))
    .with_aspect_ratio(0.5),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=auto(), height=percent(0.2)))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=percent(0.05),
        right=auto(),
        top=percent(0.05),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=auto(),
        right=auto(),
        top=percent(0.3),
        bottom=percent(0.5),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=auto(), height=percent(0.1)))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=auto(),
        right=auto(),
        top=percent(0.3),
        bottom=percent(0.5),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=percent(0.4), height=auto()))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
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
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect::new(
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
    .with_size(Size::new(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect::new(
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
    .with_size(Size::new(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect::new(
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
    .with_size(Size::new(width=length(20.0), height=length(37.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect::new(
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
    .with_size(Size::new(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect::new(
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
    .with_size(Size::new(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect::new(
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
    .with_size(Size::new(width=length(20.0), height=length(37.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(150.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_max_size(Size::new(width=auto(), height=length(100.0)))
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=auto(), bottom=length(20.0)),
    ),
    [node00],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(200.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(60.0), height=length(40.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(60.0), height=length(40.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(60.0), height=length(40.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size::new(width=length(110.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default().with_position(position_absolute()),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=percent(0.5), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=auto(), bottom=percent(0.5)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=auto()))
    .with_inset(
      Rect::new(
        left=auto(),
        right=auto(),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(200.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=percent(0.5)))
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=auto(),
        top=length(10.0),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect::new(
        left=auto(),
        right=length(10.0),
        top=auto(),
        bottom=length(10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_inset(
      Rect::new(
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
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect::new(
        left=auto(),
        right=length(10.0),
        top=auto(),
        bottom=length(10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=auto(),
        top=length(10.0),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect::new(
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
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect::new(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect::new(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect::new(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect::new(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_border(
      Rect::new(
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
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(left=length(0.0), right=length(0.0), top=auto(), bottom=auto()),
    )
    .with_inset(
      Rect::new(
        left=auto(),
        right=auto(),
        top=length(10.0),
        bottom=length(20.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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

///|
test "upstream/generated/block/block_absolute_margin_auto_bottom_and_top_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_and_top_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(left=length(0.0), right=length(0.0), top=auto(), bottom=auto()),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_bottom_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=auto(),
      ),
    )
    .with_inset(
      Rect::new(
        left=auto(),
        right=auto(),
        top=length(10.0),
        bottom=length(20.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_bottom_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_and_right_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_and_right_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    )
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=length(20.0),
        top=auto(),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.x, 70.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_and_right_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_and_right_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_child_bigger_than_parent_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_child_bigger_than_parent_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect::new(
        left=auto(),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=length(20.0),
        top=auto(),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(52.0), height=length(52.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 52.0)
  assert_eq(root_layout.size.height, 52.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 72.0)
  assert_eq(c.size.height, 72.0)
  assert_eq(c.location.x, -40.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_child_bigger_than_parent_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_child_bigger_than_parent_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect::new(
        left=auto(),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(52.0), height=length(52.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 52.0)
  assert_eq(root_layout.size.height, 52.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 72.0)
  assert_eq(c.size.height, 72.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_fix_right_child_bigger_than_parent_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_fix_right_child_bigger_than_parent_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect::new(
        left=auto(),
        right=length(10.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=length(20.0),
        top=auto(),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(52.0), height=length(52.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 52.0)
  assert_eq(root_layout.size.height, 52.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 72.0)
  assert_eq(c.size.height, 72.0)
  assert_eq(c.location.x, -50.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_fix_right_child_bigger_than_parent_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_fix_right_child_bigger_than_parent_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect::new(
        left=auto(),
        right=length(10.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(52.0), height=length(52.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 52.0)
  assert_eq(root_layout.size.height, 52.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 72.0)
  assert_eq(c.size.height, 72.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_right_child_bigger_than_parent_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_right_child_bigger_than_parent_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    )
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=length(20.0),
        top=auto(),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(52.0), height=length(52.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 52.0)
  assert_eq(root_layout.size.height, 52.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 72.0)
  assert_eq(c.size.height, 72.0)
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_right_child_bigger_than_parent_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_right_child_bigger_than_parent_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(52.0), height=length(52.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 52.0)
  assert_eq(root_layout.size.height, 52.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 72.0)
  assert_eq(c.size.height, 72.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=auto(),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=length(20.0),
        top=auto(),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.x, 130.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=auto(),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_multiple_children_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_multiple_children_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(100.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=auto(),
        top=length(0.0),
        bottom=length(0.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=length(20.0),
        top=auto(),
        bottom=auto(),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=auto(),
        top=length(0.0),
        bottom=length(0.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=length(20.0),
        right=length(10.0),
        top=auto(),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_align_items(align_items_center())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 20.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_multiple_children_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_multiple_children_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(100.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=auto(),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=auto(),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_align_items(align_items_center())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_right_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_right_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=auto(),
        top=length(0.0),
        bottom=length(0.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=length(20.0),
        top=auto(),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_right_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_right_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=auto(),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_top_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_top_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=auto(),
        bottom=length(0.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=auto(),
        right=auto(),
        top=length(20.0),
        bottom=length(10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.y, 140.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_top_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_top_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=auto(),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_bottom_left_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_bottom_left_with_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=length(20.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(20.0),
      ),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 10.0)
  assert_eq(c.size.height, 10.0)
  assert_eq(c.location.x, 30.0)
  assert_eq(c.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_margin_bottom_left_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_bottom_left_without_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 10.0)
  assert_eq(c.size.height, 10.0)
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_minmax_bottom_right_max" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_minmax_bottom_right_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
    .with_max_size(Size::new(width=length(40.0), height=length(30.0)))
    .with_inset(
      Rect::new(
        left=auto(),
        right=length(10.0),
        top=auto(),
        bottom=length(10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 40.0)
  assert_eq(c.size.height, 30.0)
  assert_eq(c.location.x, 50.0)
  assert_eq(c.location.y, 60.0)
}

///|
test "upstream/generated/block/block_absolute_minmax_bottom_right_min_max" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_minmax_bottom_right_min_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_min_size(Size::new(width=length(50.0), height=length(60.0)))
    .with_max_size(Size::new(width=length(40.0), height=length(30.0)))
    .with_inset(
      Rect::new(
        left=auto(),
        right=length(10.0),
        top=auto(),
        bottom=length(10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 50.0)
  assert_eq(c.size.height, 60.0)
  assert_eq(c.location.x, 40.0)
  assert_eq(c.location.y, 30.0)
}

///|
test "upstream/generated/block/block_absolute_minmax_bottom_right_min_max_preferred" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_minmax_bottom_right_min_max_preferred.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(200.0), height=length(200.0)))
    .with_min_size(Size::new(width=length(50.0), height=length(60.0)))
    .with_max_size(Size::new(width=length(40.0), height=length(30.0)))
    .with_inset(
      Rect::new(
        left=auto(),
        right=length(10.0),
        top=auto(),
        bottom=length(10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 50.0)
  assert_eq(c.size.height, 60.0)
  assert_eq(c.location.x, 40.0)
  assert_eq(c.location.y, 30.0)
}

///|
test "upstream/generated/block/block_absolute_minmax_top_left_bottom_right_max" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_minmax_top_left_bottom_right_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_max_size(Size::new(width=length(40.0), height=length(30.0)))
    .with_inset(
      Rect::new(
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
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 40.0)
  assert_eq(c.size.height, 30.0)
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_minmax_top_left_bottom_right_min_max" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_minmax_top_left_bottom_right_min_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_min_size(Size::new(width=length(50.0), height=length(60.0)))
    .with_max_size(Size::new(width=length(40.0), height=length(30.0)))
    .with_inset(
      Rect::new(
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
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 50.0)
  assert_eq(c.size.height, 60.0)
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_no_styles" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_no_styles.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute()),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 10.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_padding_border_overrides_max_size" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_padding_border_overrides_max_size.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_max_size(Size::new(width=length(12.0), height=length(12.0)))
    .with_padding(
      Rect::new(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    )
    .with_border(
      Rect::new(
        left=length(7.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(5.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 0.0)
  assert_eq(root_layout.size.height, 0.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 22.0)
  assert_eq(c.size.height, 14.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_padding_border_overrides_size" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_padding_border_overrides_size.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(12.0), height=length(12.0)))
    .with_padding(
      Rect::new(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    )
    .with_border(
      Rect::new(
        left=length(7.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(5.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 0.0)
  assert_eq(root_layout.size.height, 0.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 22.0)
  assert_eq(c.size.height, 14.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_align_baseline_child" {
  // Ported from taffy-reference/tests/generated/block/block_align_baseline_child.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(10.0)),
    ),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
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
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 30.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/block/block_align_baseline_child_margin" {
  // Ported from taffy-reference/tests/generated/block/block_align_baseline_child_margin.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 5.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 35.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 5.0)
  assert_eq(l10.location.y, 5.0)
}

///|
test "upstream/generated/block/block_align_baseline_child_margin_percent" {
  // Ported from taffy-reference/tests/generated/block/block_align_baseline_child_margin_percent.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=percent(0.01),
        right=percent(0.01),
        top=percent(0.01),
        bottom=percent(0.01),
      ),
    ),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 5.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 35.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 1.0)
  assert_eq(l10.location.y, 1.0)
}

///|
test "upstream/generated/block/block_align_baseline_child_padding" {
  // Ported from taffy-reference/tests/generated/block/block_align_baseline_child_padding.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(20.0)))
    .with_padding(
      Rect::new(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect::new(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 5.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 45.0)
  assert_eq(l1.location.y, 35.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 5.0)
  assert_eq(l10.location.y, 5.0)
}

///|
test "upstream/generated/block/block_align_baseline_child_top" {
  // Ported from taffy-reference/tests/generated/block/block_align_baseline_child_top.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=length(10.0), bottom=auto()),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
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
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 30.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/block/block_align_baseline_child_top2" {
  // Ported from taffy-reference/tests/generated/block/block_align_baseline_child_top2.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(20.0)))
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=length(5.0), bottom=auto()),
    ),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
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
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 35.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/block/block_align_baseline_double_nested_child" {
  // Ported from taffy-reference/tests/generated/block/block_align_baseline_double_nested_child.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
    [node00],
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(15.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
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
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 30.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 15.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/block/block_aspect_ratio_fill_height" {
  // Ported from taffy-reference/tests/generated/block/block_aspect_ratio_fill_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 40.0)
  assert_eq(c.size.height, 20.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_aspect_ratio_fill_max_height" {
  // Ported from taffy-reference/tests/generated/block/block_aspect_ratio_fill_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_max_size(Size::new(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
    TextMeasure::{
      text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 40.0)
  assert_eq(c.size.height, 60.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_aspect_ratio_fill_max_width" {
  // Ported from taffy-reference/tests/generated/block/block_aspect_ratio_fill_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_max_size(Size::new(width=auto(), height=length(20.0)))
    .with_aspect_ratio(2.0),
    TextMeasure::{
      text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 40.0)
  assert_eq(c.size.height, 20.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_aspect_ratio_fill_min_height" {
  // Ported from taffy-reference/tests/generated/block/block_aspect_ratio_fill_min_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_min_size(Size::new(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 100.0)
  assert_eq(c.size.height, 50.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_aspect_ratio_fill_min_width" {
  // Ported from taffy-reference/tests/generated/block/block_aspect_ratio_fill_min_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_min_size(Size::new(width=auto(), height=length(40.0)))
    .with_aspect_ratio(2.0),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 100.0)
  assert_eq(c.size.height, 50.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_aspect_ratio_fill_width" {
  // Ported from taffy-reference/tests/generated/block/block_aspect_ratio_fill_width.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(40.0)))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 80.0)
  assert_eq(c.size.height, 40.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_basic" {
  // Ported from taffy-reference/tests/generated/block/block_basic.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 50.0)
  assert_eq(layout.size.height, 20.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 50.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 50.0)
  assert_eq(c1.size.height, 10.0)
  assert_eq(c1.location.x, 0.0)
  assert_eq(c1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_border_fixed_size" {
  // Ported from taffy-reference/tests/generated/block/block_border_fixed_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_border(
      Rect::new(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    ),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 50.0)
  assert_eq(layout.size.height, 50.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 38.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 8.0)
  assert_eq(c0.location.y, 2.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 38.0)
  assert_eq(c1.size.height, 10.0)
  assert_eq(c1.location.x, 8.0)
  assert_eq(c1.location.y, 12.0)
}

///|
test "upstream/generated/block/block_border_intrinsic_size" {
  // Ported from taffy-reference/tests/generated/block/block_border_intrinsic_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(10.0)),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_border(
      Rect::new(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    ),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 62.0)
  assert_eq(layout.size.height, 28.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 50.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 8.0)
  assert_eq(c0.location.y, 2.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 50.0)
  assert_eq(c1.size.height, 10.0)
  assert_eq(c1.location.x, 8.0)
  assert_eq(c1.location.y, 12.0)
}

///|
test "upstream/generated/block/block_border_percentage_fixed_size" {
  // Ported from taffy-reference/tests/generated/block/block_border_percentage_fixed_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 50.0)
  assert_eq(layout.size.height, 50.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 50.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
  let c00 = taffy.layout(node00)
  assert_eq(c00.size.width, 50.0)
  assert_eq(c00.size.height, 10.0)
  assert_eq(c00.location.x, 0.0)
  assert_eq(c00.location.y, 0.0)
}

///|
test "upstream/generated/block/block_border_percentage_intrinsic_size" {
  // Ported from taffy-reference/tests/generated/block/block_border_percentage_intrinsic_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 0.0)
  assert_eq(layout.size.height, 10.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 0.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
  let c00 = taffy.layout(node00)
  assert_eq(c00.size.width, 0.0)
  assert_eq(c00.size.height, 10.0)
  assert_eq(c00.location.x, 0.0)
  assert_eq(c00.location.y, 0.0)
}

///|
test "upstream/generated/block/block_display_none" {
  // Ported from taffy-reference/tests/generated/block/block_display_none.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_none())
    .with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 50.0)
  assert_eq(layout.size.height, 20.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 50.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 0.0)
  assert_eq(c1.size.height, 0.0)
  assert_eq(c1.location.x, 0.0)
  assert_eq(c1.location.y, 0.0)
  let c2 = taffy.layout(node2)
  assert_eq(c2.size.width, 50.0)
  assert_eq(c2.size.height, 10.0)
  assert_eq(c2.location.x, 0.0)
  assert_eq(c2.location.y, 10.0)
}

///|
test "upstream/generated/block/block_display_none_with_child" {
  // Ported from taffy-reference/tests/generated/block/block_display_none_with_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node10 = taffy.new_leaf_with_context(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(10.0)),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_with_children(
    Style::default().with_display(display_none()),
    [node10],
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 100.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 0.0)
  assert_eq(c1.size.height, 0.0)
  assert_eq(c1.location.x, 0.0)
  assert_eq(c1.location.y, 0.0)
  let c10 = taffy.layout(node10)
  assert_eq(c10.size.width, 0.0)
  assert_eq(c10.size.height, 0.0)
  assert_eq(c10.location.x, 0.0)
  assert_eq(c10.location.y, 0.0)
  let c2 = taffy.layout(node2)
  assert_eq(c2.size.width, 100.0)
  assert_eq(c2.size.height, 10.0)
  assert_eq(c2.location.x, 0.0)
  assert_eq(c2.location.y, 10.0)
}

///|
test "upstream/generated/block/block_display_none_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_display_none_with_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_none())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=length(10.0), bottom=auto()),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 100.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 0.0)
  assert_eq(c1.size.height, 0.0)
  assert_eq(c1.location.x, 0.0)
  assert_eq(c1.location.y, 0.0)
}

///|
test "upstream/generated/block/block_display_none_with_margin" {
  // Ported from taffy-reference/tests/generated/block/block_display_none_with_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_none())
    .with_size(Size::new(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 0.0)
  assert_eq(c0.size.height, 0.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 100.0)
  assert_eq(c1.size.height, 10.0)
  assert_eq(c1.location.x, 0.0)
  assert_eq(c1.location.y, 0.0)
}

///|
test "upstream/generated/block/block_display_none_with_position_absolute" {
  // Ported from taffy-reference/tests/generated/block/block_display_none_with_position_absolute.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_none())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 0.0)
  assert_eq(c0.size.height, 0.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_inset_fixed" {
  // Ported from taffy-reference/tests/generated/block/block_inset_fixed.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_inset(
      Rect::new(left=length(2.0), right=auto(), top=length(4.0), bottom=auto()),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_inset(
      Rect::new(left=auto(), right=length(6.0), top=auto(), bottom=length(8.0)),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_inset(
      Rect::new(
        left=length(2.0),
        right=length(6.0),
        top=length(4.0),
        bottom=length(8.0),
      ),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 50.0)
  assert_eq(layout.size.height, 30.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 50.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 2.0)
  assert_eq(c0.location.y, 4.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 50.0)
  assert_eq(c1.size.height, 10.0)
  assert_eq(c1.location.x, -6.0)
  assert_eq(c1.location.y, 2.0)
  let c2 = taffy.layout(node2)
  assert_eq(c2.size.width, 50.0)
  assert_eq(c2.size.height, 10.0)
  assert_eq(c2.location.x, 2.0)
  assert_eq(c2.location.y, 24.0)
}

///|
test "upstream/generated/block/block_inset_percentage" {
  // Ported from taffy-reference/tests/generated/block/block_inset_percentage.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_inset(
      Rect::new(
        left=percent(0.02),
        right=auto(),
        top=percent(0.04),
        bottom=auto(),
      ),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_inset(
      Rect::new(
        left=auto(),
        right=percent(0.06),
        top=auto(),
        bottom=percent(0.08),
      ),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_inset(
      Rect::new(
        left=percent(0.02),
        right=percent(0.06),
        top=percent(0.04),
        bottom=percent(0.08),
      ),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 50.0)
  assert_eq(layout.size.height, 30.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 50.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 1.0)
  assert_eq(c0.location.y, 0.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 50.0)
  assert_eq(c1.size.height, 10.0)
  assert_eq(c1.location.x, -3.0)
  assert_eq(c1.location.y, 10.0)
  let c2 = taffy.layout(node2)
  assert_eq(c2.size.width, 50.0)
  assert_eq(c2.size.height, 10.0)
  assert_eq(c2.location.x, 1.0)
  assert_eq(c2.location.y, 20.0)
}

///|
test "upstream/generated/block/block_intrinsic_width" {
  // Ported from taffy-reference/tests/generated/block/block_intrinsic_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(10.0)),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 50.0)
  assert_eq(layout.size.height, 20.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 50.0)
  assert_eq(c0.size.height, 10.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 50.0)
  assert_eq(c1.size.height, 10.0)
  assert_eq(c1.location.x, 0.0)
  assert_eq(c1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_item_max_width" {
  // Ported from taffy-reference/tests/generated/block/block_item_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(50.0)))
    .with_max_size(Size::new(width=length(100.0), height=auto())),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(50.0)))
    .with_max_size(Size::new(width=length(300.0), height=auto())),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 200.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 100.0)
  assert_eq(c0.size.height, 50.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
  let c1 = taffy.layout(node1)
  assert_eq(c1.size.width, 200.0)
  assert_eq(c1.size.height, 50.0)
  assert_eq(c1.location.x, 0.0)
  assert_eq(c1.location.y, 50.0)
}

///|
test "upstream/generated/block/block_item_min_width_overrides_max_width" {
  // Ported from taffy-reference/tests/generated/block/block_item_min_width_overrides_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(50.0)))
    .with_min_size(Size::new(width=length(200.0), height=auto()))
    .with_max_size(Size::new(width=length(50.0), height=auto())),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 200.0)
  assert_eq(c0.size.height, 50.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_auto_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=auto(),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(50.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/block/block_margin_auto_bottom_and_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_bottom_and_top.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(left=length(0.0), right=length(0.0), top=auto(), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(50.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/block/block_margin_auto_left" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_left.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=auto(),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(50.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 150.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/block/block_margin_auto_left_and_right" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_left_and_right.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(50.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 75.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/block/block_margin_auto_left_and_right_with_auto_width" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_left_and_right_with_auto_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(50.0)))
    .with_max_size(Size::new(width=length(100.0), height=auto()))
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 100.0)
  assert_eq(c.size.height, 50.0)
  assert_eq(c.location.x, 50.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_auto_left_child_bigger_than_parent" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_left_child_bigger_than_parent.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect::new(
        left=auto(),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(52.0), height=length(52.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 52.0)
  assert_eq(root_layout.size.height, 52.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 72.0)
  assert_eq(c.size.height, 72.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_auto_left_fix_right_child_bigger_than_parent" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_left_fix_right_child_bigger_than_parent.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect::new(
        left=auto(),
        right=length(10.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(52.0), height=length(52.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 52.0)
  assert_eq(root_layout.size.height, 52.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 72.0)
  assert_eq(c.size.height, 72.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_auto_left_right_child_bigger_than_parent" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_left_right_child_bigger_than_parent.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(52.0), height=length(52.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 52.0)
  assert_eq(root_layout.size.height, 52.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let c = taffy.layout(node0)
  assert_eq(c.size.width, 72.0)
  assert_eq(c.size.height, 72.0)
  assert_eq(c.location.x, 0.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_auto_multiple_children" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_multiple_children.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(100.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=auto(),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=auto(),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(50.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_align_items(align_items_center())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 50.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 100.0)
}

///|
test "upstream/generated/block/block_margin_auto_right" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_right.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=auto(),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(50.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/block/block_margin_auto_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_top.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=auto(),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(50.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/block/block_margin_x_fixed_auto_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_fixed_auto_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(20.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=auto(),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_fixed_auto_left" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_fixed_auto_left.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(20.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=auto(),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 30.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_fixed_auto_left_and_right" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_fixed_auto_left_and_right.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(20.0), height=length(10.0)))
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 15.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_fixed_auto_right" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_fixed_auto_right.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(20.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=auto(),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_fixed_auto_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_fixed_auto_top.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(20.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=auto(),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_fixed_size_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_fixed_size_negative.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(-10.0),
        right=length(-5.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 65.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, -10.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_fixed_size_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_fixed_size_positive.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(5.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 35.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_intrinsic_size_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_intrinsic_size_negative.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(-10.0),
        right=length(-5.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 0.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 15.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, -10.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_intrinsic_size_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_intrinsic_size_positive.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(5.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 15.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 15.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_percentage_fixed_size_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_percentage_fixed_size_negative.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=percent(-0.2),
        right=percent(-0.1),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 65.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, -10.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_percentage_fixed_size_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_percentage_fixed_size_positive.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=percent(0.2),
        right=percent(0.1),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 35.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_percentage_intrinsic_size_other_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_percentage_intrinsic_size_other_negative.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=percent(-0.2),
        right=percent(-0.1),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(100.0), height=length(10.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 130.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, -20.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_percentage_intrinsic_size_other_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_percentage_intrinsic_size_other_positive.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=percent(0.2),
        right=percent(0.1),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(100.0), height=length(10.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 20.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 70.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_x_percentage_intrinsic_size_self_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_percentage_intrinsic_size_self_negative.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(100.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=percent(-0.2),
        right=percent(-0.1),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 10.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, -20.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_x_percentage_intrinsic_size_self_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_percentage_intrinsic_size_self_positive.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(100.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=percent(0.2),
        right=percent(0.1),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 10.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_complex" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_complex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-5.0),
        bottom=length(-5.0),
      ),
    ),
  )
  let node11 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(7.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node12 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-6.0),
        bottom=length(9.0),
      ),
    ),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
    [node10, node11, node12],
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-5.0),
        bottom=length(-5.0),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 0.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, -10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, -10.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 0.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, -5.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 0.0)
  assert_eq(l11.size.height, 10.0)
  assert_eq(l11.location.x, 0.0)
  assert_eq(l11.location.y, 7.0)
  let l12 = taffy.layout(node12)
  assert_eq(l12.size.width, 0.0)
  assert_eq(l12.size.height, 10.0)
  assert_eq(l12.location.x, 0.0)
  assert_eq(l12.location.y, -6.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, -10.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, -10.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_aspect_ratio" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_aspect_ratio.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_aspect_ratio(2.0)
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 65.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 25.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 55.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_border_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_border_bottom.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 30.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 20.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_border_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_border_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 30.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 20.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_height" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(1.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 41.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 1.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 31.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_line_box" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_line_box.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    TextMeasure::{ text_content: "HH", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 50.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 40.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_line_box_with_height_zero" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_line_box_with_height_zero.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(0.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    TextMeasure::{ text_content: "HH", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 40.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 30.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_line_box_with_max_height_zero" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_line_box_with_max_height_zero.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_max_size(Size::new(width=auto(), height=length(0.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    TextMeasure::{ text_content: "HH", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 40.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 30.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_min_height" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_min_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_min_size(Size::new(width=auto(), height=length(1.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 41.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 1.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 31.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_overflow_x_hidden" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_overflow_x_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_hidden(), y=overflow_visible()))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 40.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 30.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_overflow_x_scroll" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_overflow_x_scroll.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_scroll(), y=overflow_visible()))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 40.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 30.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_overflow_y_hidden" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_overflow_y_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_visible(), y=overflow_hidden()))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 40.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 30.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_overflow_y_scroll" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_overflow_y_scroll.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_visible(), y=overflow_scroll()))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 40.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 30.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_padding_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_padding_bottom.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_padding(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(1.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 41.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 1.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 31.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_padding_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_padding_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_padding(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(1.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 41.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 1.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 31.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-5.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-7.0),
        bottom=length(-3.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-2.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 13.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 3.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 3.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_positive.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 30.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 20.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_positive_and_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_positive_and_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(5.0),
        bottom=length(-4.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(7.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 17.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 5.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 7.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_with_absolute_child" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_with_absolute_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node10 = taffy.new_leaf_with_context(
    Style::default()
    .with_position(position_absolute())
    .with_display(display_block()),
    TextMeasure::{ text_content: "HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [node10],
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 50.0)
  assert_eq(root_layout.size.height, 30.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 20.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 20.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_border_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_border_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_x_hidden" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_x_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    )
    .with_overflow(Point::new(x=overflow_hidden(), y=overflow_visible())),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 10.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_x_scroll" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_x_scroll.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_scroll(), y=overflow_visible()))
    .with_scrollbar_width(15.0)
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 45.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 35.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 10.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_y_hidden" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_y_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_visible(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 10.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_y_scroll" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_y_scroll.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_visible(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 35.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 10.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 35.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_padding_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_padding_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    )
    .with_padding(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(1.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 31.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 21.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 11.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_negative_equal" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_negative_equal.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 0.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, -10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_negative_parent_larger" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_negative_parent_larger.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-5.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 0.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, -10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_negative_parent_smaller" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_negative_parent_smaller.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-5.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 0.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, -10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_not_blocked_by_border_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_not_blocked_by_border_bottom.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_not_blocked_by_padding_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_not_blocked_by_padding_bottom.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    )
    .with_padding(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(1.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 21.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 11.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_positive_and_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_positive_and_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node100 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node10 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(5.0),
        bottom=length(0.0),
      ),
    ),
    [node100],
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node10],
  )
  let node200 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node20 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node200],
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-5.0),
        bottom=length(0.0),
      ),
    ),
    [node20],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 5.0)
  let l_node10 = taffy.layout(node10)
  assert_eq(l_node10.size.width, 50.0)
  assert_eq(l_node10.size.height, 10.0)
  assert_eq(l_node10.location.x, 0.0)
  assert_eq(l_node10.location.y, 0.0)
  let l_node100 = taffy.layout(node100)
  assert_eq(l_node100.size.width, 50.0)
  assert_eq(l_node100.size.height, 10.0)
  assert_eq(l_node100.location.x, 0.0)
  assert_eq(l_node100.location.y, 0.0)
  let l_node2 = taffy.layout(node2)
  assert_eq(l_node2.size.width, 50.0)
  assert_eq(l_node2.size.height, 10.0)
  assert_eq(l_node2.location.x, 0.0)
  assert_eq(l_node2.location.y, 20.0)
  let l_node20 = taffy.layout(node20)
  assert_eq(l_node20.size.width, 50.0)
  assert_eq(l_node20.size.height, 10.0)
  assert_eq(l_node20.location.x, 0.0)
  assert_eq(l_node20.location.y, 0.0)
  let l_node200 = taffy.layout(node200)
  assert_eq(l_node200.size.width, 50.0)
  assert_eq(l_node200.size.height, 10.0)
  assert_eq(l_node200.location.x, 0.0)
  assert_eq(l_node200.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_positive_equal" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_positive_equal.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_positive_parent_larger" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_positive_parent_larger.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(5.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_child_collapse_positive_parent_smaller" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_positive_parent_smaller.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(5.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_granchild_collapse_positive_and_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_granchild_collapse_positive_and_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node000 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node0000],
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node1000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node100 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-2.0),
        bottom=length(0.0),
      ),
    ),
    [node1000],
  )
  let node10 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(5.0),
        bottom=length(0.0),
      ),
    ),
    [node100],
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node10],
  )
  let node2000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node200 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(15.0),
        bottom=length(0.0),
      ),
    ),
    [node2000],
  )
  let node20 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(5.0),
        bottom=length(0.0),
      ),
    ),
    [node200],
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node20],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
  let l_node0000 = taffy.layout(node0000)
  assert_eq(l_node0000.size.width, 50.0)
  assert_eq(l_node0000.size.height, 10.0)
  assert_eq(l_node0000.location.x, 0.0)
  assert_eq(l_node0000.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 5.0)
  let l_node10 = taffy.layout(node10)
  assert_eq(l_node10.size.width, 50.0)
  assert_eq(l_node10.size.height, 10.0)
  assert_eq(l_node10.location.x, 0.0)
  assert_eq(l_node10.location.y, 0.0)
  let l_node100 = taffy.layout(node100)
  assert_eq(l_node100.size.width, 50.0)
  assert_eq(l_node100.size.height, 10.0)
  assert_eq(l_node100.location.x, 0.0)
  assert_eq(l_node100.location.y, 0.0)
  let l_node1000 = taffy.layout(node1000)
  assert_eq(l_node1000.size.width, 50.0)
  assert_eq(l_node1000.size.height, 10.0)
  assert_eq(l_node1000.location.x, 0.0)
  assert_eq(l_node1000.location.y, 0.0)
  let l_node2 = taffy.layout(node2)
  assert_eq(l_node2.size.width, 50.0)
  assert_eq(l_node2.size.height, 10.0)
  assert_eq(l_node2.location.x, 0.0)
  assert_eq(l_node2.location.y, 20.0)
  let l_node20 = taffy.layout(node20)
  assert_eq(l_node20.size.width, 50.0)
  assert_eq(l_node20.size.height, 10.0)
  assert_eq(l_node20.location.x, 0.0)
  assert_eq(l_node20.location.y, 0.0)
  let l_node200 = taffy.layout(node200)
  assert_eq(l_node200.size.width, 50.0)
  assert_eq(l_node200.size.height, 10.0)
  assert_eq(l_node200.location.x, 0.0)
  assert_eq(l_node200.location.y, 0.0)
  let l_node2000 = taffy.layout(node2000)
  assert_eq(l_node2000.size.width, 50.0)
  assert_eq(l_node2000.size.height, 10.0)
  assert_eq(l_node2000.location.x, 0.0)
  assert_eq(l_node2000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_first_granchild_collapse_positive_equal" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_first_granchild_collapse_positive_equal.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node000 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node0000],
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
  let l_node0000 = taffy.layout(node0000)
  assert_eq(l_node0000.size.width, 50.0)
  assert_eq(l_node0000.size.height, 10.0)
  assert_eq(l_node0000.location.x, 0.0)
  assert_eq(l_node0000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_border_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_border_bottom.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_x_hidden" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_x_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_hidden(), y=overflow_visible()))
    .with_scrollbar_width(15.0)
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_x_scroll" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_x_scroll.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_scroll(), y=overflow_visible()))
    .with_scrollbar_width(15.0)
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 45.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 35.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_y_hidden" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_y_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_visible(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_y_scroll" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_y_scroll.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point::new(x=overflow_visible(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 35.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 35.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_padding_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_padding_bottom.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    )
    .with_padding(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(1.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 31.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 21.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_negative_equal" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_negative_equal.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 0.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_negative_parent_larger" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_negative_parent_larger.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-5.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 0.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_negative_parent_smaller" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_negative_parent_smaller.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-5.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 0.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_not_blocked_by_border_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_not_blocked_by_border_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_not_blocked_by_padding_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_not_blocked_by_padding_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    )
    .with_padding(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(1.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 21.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 11.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 1.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_positive_and_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_positive_and_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-10.0),
      ),
    ),
    [node00],
  )
  let node100 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node10 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(5.0),
      ),
    ),
    [node100],
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-10.0),
      ),
    ),
    [node10],
  )
  let node200 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node20 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node200],
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-5.0),
      ),
    ),
    [node20],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 10.0)
  let l_node10 = taffy.layout(node10)
  assert_eq(l_node10.size.width, 50.0)
  assert_eq(l_node10.size.height, 10.0)
  assert_eq(l_node10.location.x, 0.0)
  assert_eq(l_node10.location.y, 0.0)
  let l_node100 = taffy.layout(node100)
  assert_eq(l_node100.size.width, 50.0)
  assert_eq(l_node100.size.height, 10.0)
  assert_eq(l_node100.location.x, 0.0)
  assert_eq(l_node100.location.y, 0.0)
  let l_node2 = taffy.layout(node2)
  assert_eq(l_node2.size.width, 50.0)
  assert_eq(l_node2.size.height, 10.0)
  assert_eq(l_node2.location.x, 0.0)
  assert_eq(l_node2.location.y, 15.0)
  let l_node20 = taffy.layout(node20)
  assert_eq(l_node20.size.width, 50.0)
  assert_eq(l_node20.size.height, 10.0)
  assert_eq(l_node20.location.x, 0.0)
  assert_eq(l_node20.location.y, 0.0)
  let l_node200 = taffy.layout(node200)
  assert_eq(l_node200.size.width, 50.0)
  assert_eq(l_node200.size.height, 10.0)
  assert_eq(l_node200.location.x, 0.0)
  assert_eq(l_node200.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_positive_equal" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_positive_equal.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_positive_parent_larger" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_positive_parent_larger.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(5.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_child_collapse_positive_parent_smaller" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_positive_parent_smaller.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(5.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_last_granchild_collapse_positive_equal" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_granchild_collapse_positive_equal.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node000 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node0000],
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node000 = taffy.layout(node000)
  assert_eq(l_node000.size.width, 50.0)
  assert_eq(l_node000.size.height, 10.0)
  assert_eq(l_node000.location.x, 0.0)
  assert_eq(l_node000.location.y, 0.0)
  let l_node0000 = taffy.layout(node0000)
  assert_eq(l_node0000.size.width, 50.0)
  assert_eq(l_node0000.size.height, 10.0)
  assert_eq(l_node0000.location.x, 0.0)
  assert_eq(l_node0000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_sibling_collapse_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-5.0),
        bottom=length(-5.0),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 0.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, -10.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, -10.0)
  let l_node2 = taffy.layout(node2)
  assert_eq(l_node2.size.width, 50.0)
  assert_eq(l_node2.size.height, 10.0)
  assert_eq(l_node2.location.x, 0.0)
  assert_eq(l_node2.location.y, -10.0)
  let l_node3 = taffy.layout(node3)
  assert_eq(l_node3.size.width, 50.0)
  assert_eq(l_node3.size.height, 10.0)
  assert_eq(l_node3.location.x, 0.0)
  assert_eq(l_node3.location.y, -10.0)
}

///|
test "upstream/generated/block/block_margin_y_sibling_collapse_negative_percentage" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_negative_percentage.rs
  ()
}

///|
test "upstream/generated/block/block_margin_y_sibling_collapse_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 90.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 30.0)
  let l_node2 = taffy.layout(node2)
  assert_eq(l_node2.size.width, 50.0)
  assert_eq(l_node2.size.height, 10.0)
  assert_eq(l_node2.location.x, 0.0)
  assert_eq(l_node2.location.y, 50.0)
  let l_node3 = taffy.layout(node3)
  assert_eq(l_node3.size.width, 50.0)
  assert_eq(l_node3.size.height, 10.0)
  assert_eq(l_node3.location.x, 0.0)
  assert_eq(l_node3.location.y, 70.0)
}

///|
test "upstream/generated/block/block_margin_y_sibling_collapse_positive_and_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive_and_negative.rs
  ()
}

///|
test "upstream/generated/block/block_margin_y_sibling_collapse_positive_and_negative_percentage" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive_and_negative_percentage.rs
  ()
}

///|
test "upstream/generated/block/block_margin_y_sibling_collapse_positive_percentage" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive_percentage.rs
  ()
}

///|
test "upstream/generated/block/block_margin_y_simple_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_simple_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 0.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, -10.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, -10.0)
}

///|
test "upstream/generated/block/block_margin_y_simple_negative_percentage_other" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_simple_negative_percentage_other.rs
  ()
}

///|
test "upstream/generated/block/block_margin_y_simple_negative_percentage_self" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_simple_negative_percentage_self.rs
  ()
}

///|
test "upstream/generated/block/block_margin_y_simple_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_simple_positive.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 40.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 30.0)
}

///|
test "upstream/generated/block/block_margin_y_simple_positive_percentage_other" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_simple_positive_percentage_other.rs
  ()
}

///|
test "upstream/generated/block/block_margin_y_simple_positive_percentage_self" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_simple_positive_percentage_self.rs
  ()
}

///|
test "upstream/generated/block/block_margin_y_total_collapse" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_total_collapse.rs
  ()
}

///|
test "upstream/generated/block/block_margin_y_total_collapse_complex" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_total_collapse_complex.rs
  ()
}

///|
test "upstream/generated/block/block_overflow_scrollbars_overridden_by_available_space" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_overridden_by_available_space.rs
  ()
}

///|
test "upstream/generated/block/block_overflow_scrollbars_overridden_by_max_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_overridden_by_max_size.rs
  ()
}

///|
test "upstream/generated/block/block_overflow_scrollbars_overridden_by_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_overridden_by_size.rs
  ()
}

///|
test "upstream/generated/block/block_overflow_scrollbars_take_up_space_both_axis" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_take_up_space_both_axis.rs
  ()
}

///|
test "upstream/generated/block/block_overflow_scrollbars_take_up_space_cross_axis" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_take_up_space_cross_axis.rs
  ()
}

///|
test "upstream/generated/block/block_overflow_scrollbars_take_up_space_main_axis" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_take_up_space_main_axis.rs
  ()
}

///|
test "upstream/generated/block/block_padding_border_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_fixed_size.rs
  ()
}

///|
test "upstream/generated/block/block_padding_border_intrinsic_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_intrinsic_size.rs
  ()
}

///|
test "upstream/generated/block/block_padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_overrides_max_size.rs
  ()
}

///|
test "upstream/generated/block/block_padding_border_overrides_min_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_overrides_min_size.rs
  ()
}

///|
test "upstream/generated/block/block_padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_overrides_size.rs
  ()
}

///|
test "upstream/generated/block/block_padding_border_percentage_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_percentage_fixed_size.rs
  ()
}

///|
test "upstream/generated/block/block_padding_border_percentage_intrinsic_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_percentage_intrinsic_size.rs
  ()
}

///|
test "upstream/generated/block/block_padding_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_fixed_size.rs
  ()
}

///|
test "upstream/generated/block/block_padding_intrinsic_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_intrinsic_size.rs
  ()
}

///|
test "upstream/generated/block/block_padding_percentage_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_percentage_fixed_size.rs
  ()
}

///|
test "upstream/generated/block/block_padding_percentage_intrinsic_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_percentage_intrinsic_size.rs
  ()
}

///|
test "upstream/generated/block/mod" {
  // TODO: port from taffy-reference/tests/generated/block/mod.rs
  ()
}

///|
test "upstream/generated/blockflex/blockflex_block_in_flex_column" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_block_in_flex_column.rs
  ()
}

///|
test "upstream/generated/blockflex/blockflex_block_in_flex_row" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_block_in_flex_row.rs
  ()
}

///|
test "upstream/generated/blockflex/blockflex_flex_in_block" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_flex_in_block.rs
  ()
}

///|
test "upstream/generated/blockflex/blockflex_margin_y_collapse_through_blocked_by_flex" {
  // Ported from taffy-reference/tests/generated/blockflex/blockflex_margin_y_collapse_through_blocked_by_flex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_flex())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 40.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 30.0)
}

///|
test "upstream/generated/blockflex/blockflex_margin_y_first_child_collapse_blocked_by_flex" {
  // Ported from taffy-reference/tests/generated/blockflex/blockflex_margin_y_first_child_collapse_blocked_by_flex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 10.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 0.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 10.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 0.0)
  assert_eq(l000.size.height, 10.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/blockflex/blockflex_margin_y_last_child_collapse_blocked_by_flex" {
  // Ported from taffy-reference/tests/generated/blockflex/blockflex_margin_y_last_child_collapse_blocked_by_flex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 0.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 0.0)
  assert_eq(l000.size.height, 10.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/blockflex/blockflex_overflow_hidden" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_overflow_hidden.rs
  ()
}

///|
test "upstream/generated/blockflex/mod" {
  // TODO: port from taffy-reference/tests/generated/blockflex/mod.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_auto" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_auto.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_larger" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_larger.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_middle" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_middle.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_smaller" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_smaller.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_larger" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_larger.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_middle" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_middle.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_smaller" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_smaller.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fr" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fr.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_max_content" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_max_content.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_min_content" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_min_content.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_grid_in_block" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_grid_in_block.rs
  ()
}

///|
test "upstream/generated/blockgrid/blockgrid_margin_y_collapse_through_blocked_by_grid" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_margin_y_collapse_through_blocked_by_grid.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 40.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 30.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_margin_y_first_child_collapse_blocked_by_grid" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_margin_y_first_child_collapse_blocked_by_grid.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 10.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 10.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 50.0)
  assert_eq(l000.size.height, 10.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_margin_y_last_child_collapse_blocked_by_grid" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_margin_y_last_child_collapse_blocked_by_grid.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 50.0)
  assert_eq(l000.size.height, 10.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/blockgrid/mod" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/mod.rs
  ()
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_aspect_ratio_overrides_height_of_full_inset" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_aspect_ratio_overrides_height_of_full_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 360.0)
  assert_eq(l0.size.height, 120.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 15.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_height" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=percent(0.5), height=auto()))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=percent(0.05),
        right=auto(),
        top=percent(0.05),
        bottom=auto(),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 67.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 15.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_height_from_inset" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_height_from_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
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
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 320.0)
  assert_eq(l0.size.height, 107.0)
  assert_eq(l0.location.x, 40.0)
  assert_eq(l0.location.y, 15.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_max_height" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_position(position_absolute())
    .with_max_size(Size::new(width=length(50.0), height=auto()))
    .with_aspect_ratio(3.0),
    TextMeasure::{
      text_content: "HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 17.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_max_width" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_position(position_absolute())
    .with_max_size(Size::new(width=auto(), height=length(50.0)))
    .with_aspect_ratio(0.5),
    TextMeasure::{
      text_content: "HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 25.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_min_height" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_min_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_min_size(Size::new(width=length(50.0), height=auto()))
    .with_aspect_ratio(3.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 17.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_min_width" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_min_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_min_size(Size::new(width=auto(), height=length(50.0)))
    .with_aspect_ratio(0.5),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 25.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_width" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=auto(), height=percent(0.2)))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=percent(0.05),
        right=auto(),
        top=percent(0.05),
        bottom=auto(),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 180.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 15.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_width_from_inset" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_width_from_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=auto(),
        right=auto(),
        top=percent(0.3),
        bottom=percent(0.5),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 180.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 90.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_height_overrides_inset" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_height_overrides_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=auto(), height=percent(0.1)))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=auto(),
        right=auto(),
        top=percent(0.3),
        bottom=percent(0.5),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 90.0)
  assert_eq(l0.size.height, 30.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 90.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_width_overrides_inset" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_width_overrides_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=percent(0.4), height=auto()))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
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
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
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
  // TODO: port from taffy-reference/tests/generated/flex/absolute_child_with_cross_margin.rs
  ()
}

///|
test "upstream/generated/flex/absolute_child_with_main_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_child_with_main_margin.rs
  ()
}

///|
test "upstream/generated/flex/absolute_child_with_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_child_with_max_height.rs
  ()
}

///|
test "upstream/generated/flex/absolute_child_with_max_height_larger_shrinkable_grandchild" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_child_with_max_height_larger_shrinkable_grandchild.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_bottom_position" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_bottom_position.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_left_position" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_left_position.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_right_position" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_right_position.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_top_position" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_top_position.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_align_items_center" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_center.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_align_items_center_on_child_only" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_center_on_child_only.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_child_order" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_child_order.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_column_container" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_column_container.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_column_container_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_column_container_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_row_container" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_row_container.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_row_container_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_row_container_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_justify_content_center" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_justify_content_center.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_no_size" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_no_size.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_percentage_bottom_based_on_parent_height" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_percentage_bottom_based_on_parent_height.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_percentage_height" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_percentage_height.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_row_width_height_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_row_width_height_end_bottom.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_start_top_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_start_top_end_bottom.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_width_height_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_width_height_end_bottom.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_width_height_start_top" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_width_height_start_top.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_width_height_start_top_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_width_height_start_top_end_bottom.rs
  ()
}

///|
test "upstream/generated/flex/absolute_layout_within_border" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_within_border.rs
  ()
}

///|
test "upstream/generated/flex/absolute_margin_bottom_left" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_margin_bottom_left.rs
  ()
}

///|
test "upstream/generated/flex/absolute_minmax_bottom_right_max" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_minmax_bottom_right_max.rs
  ()
}

///|
test "upstream/generated/flex/absolute_minmax_bottom_right_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_minmax_bottom_right_min_max.rs
  ()
}

///|
test "upstream/generated/flex/absolute_minmax_bottom_right_min_max_preferred" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_minmax_bottom_right_min_max_preferred.rs
  ()
}

///|
test "upstream/generated/flex/absolute_minmax_top_left_bottom_right_max" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_minmax_top_left_bottom_right_max.rs
  ()
}

///|
test "upstream/generated/flex/absolute_minmax_top_left_bottom_right_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_minmax_top_left_bottom_right_min_max.rs
  ()
}

///|
test "upstream/generated/flex/absolute_padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_padding_border_overrides_max_size.rs
  ()
}

///|
test "upstream/generated/flex/absolute_padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_padding_border_overrides_size.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_child" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_child_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_margin.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_child_margin_percent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_margin_percent.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_child_multiline" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_multiline.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_child_multiline_no_override_on_secondline" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_multiline_no_override_on_secondline.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_child_multiline_override" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_multiline_override.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_child_padding" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_padding.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_child_top" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_top.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_child_top2" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_top2.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_column" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_column.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_double_nested_child" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_double_nested_child.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_multiline" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_multiline.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_multiline_column" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_multiline_column.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_multiline_column2" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_multiline_column2.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_multiline_row_and_column" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_multiline_row_and_column.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_nested_child" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_nested_child.rs
  ()
}

///|
test "upstream/generated/flex/align_baseline_nested_column" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_nested_column.rs
  ()
}

///|
test "upstream/generated/flex/align_center_should_size_based_on_content" {
  // TODO: port from taffy-reference/tests/generated/flex/align_center_should_size_based_on_content.rs
  ()
}

///|
test "upstream/generated/flex/align_content_center_single_line" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_single_line.rs
  ()
}

///|
test "upstream/generated/flex/align_content_center_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_single_line_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_center_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_single_line_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_center_wrapped" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_wrapped.rs
  ()
}

///|
test "upstream/generated/flex/align_content_center_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_wrapped_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_center_wrapped_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_wrapped_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_end" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_end.rs
  ()
}

///|
test "upstream/generated/flex/align_content_end_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_end_single_line_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_end_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_end_single_line_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_end_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_end_wrapped_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_end_wrapped_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_end_wrapped_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/align_content_flex_start_with_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_flex_start_with_flex.rs
  ()
}

///|
test "upstream/generated/flex/align_content_flex_start_without_height_on_children" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_flex_start_without_height_on_children.rs
  ()
}

///|
test "upstream/generated/flex/align_content_not_stretch_with_align_items_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_not_stretch_with_align_items_stretch.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_around_single_line" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_single_line.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_around_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_single_line_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_around_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_single_line_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_around_wrapped" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_wrapped.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_around_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_wrapped_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_around_wrapped_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_wrapped_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_between_single_line" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_single_line.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_between_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_single_line_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_between_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_single_line_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_between_wrapped" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_wrapped.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_between_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_wrapped_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_between_wrapped_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_wrapped_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_evenly_single_line" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_single_line.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_evenly_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_single_line_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_evenly_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_single_line_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_evenly_wrapped" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_wrapped.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_evenly_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_wrapped_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_space_evenly_wrapped_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_wrapped_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_spacearound" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_spacearound.rs
  ()
}

///|
test "upstream/generated/flex/align_content_spacebetween" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_spacebetween.rs
  ()
}

///|
test "upstream/generated/flex/align_content_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_start.rs
  ()
}

///|
test "upstream/generated/flex/align_content_start_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_start_single_line_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_start_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_start_single_line_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/align_content_start_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_start_wrapped_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_column" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_column.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_is_not_overriding_align_items" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_is_not_overriding_align_items.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_row" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_children" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_children.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_fixed_height" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_fixed_height.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_flex.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_flex_no_shrink" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_flex_no_shrink.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_margin.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_max_height.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_min_height.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_padding" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_padding.rs
  ()
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_single_row" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_single_row.rs
  ()
}

///|
test "upstream/generated/flex/align_flex_start_with_shrinking_children" {
  // TODO: port from taffy-reference/tests/generated/flex/align_flex_start_with_shrinking_children.rs
  ()
}

///|
test "upstream/generated/flex/align_flex_start_with_shrinking_children_with_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/align_flex_start_with_shrinking_children_with_stretch.rs
  ()
}

///|
test "upstream/generated/flex/align_flex_start_with_stretching_children" {
  // TODO: port from taffy-reference/tests/generated/flex/align_flex_start_with_stretching_children.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_child_with_margin_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_child_with_margin_bigger_than_parent.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_child_without_margin_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_child_without_margin_bigger_than_parent.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_justify_content_center" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_justify_content_center.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_min_max_with_padding" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_min_max_with_padding.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_with_child_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_child_margin.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_with_child_top" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_child_top.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_with_height_with_padding_border_with_wrap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_height_with_padding_border_with_wrap.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_with_max_height_percentage_with_align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_max_height_percentage_with_align_content_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_with_max_height_with_align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_max_height_with_align_content_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_with_max_height_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_max_height_with_padding_border.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_with_min_height_percentage_with_align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_min_height_percentage_with_align_content_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_with_min_height_with_align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_min_height_with_align_content_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_with_min_height_with_align_content_flex_start_with_wrap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_min_height_with_align_content_flex_start_with_wrap.rs
  ()
}

///|
test "upstream/generated/flex/align_items_center_with_min_height_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_min_height_with_padding_border.rs
  ()
}

///|
test "upstream/generated/flex/align_items_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/align_items_flex_end_child_with_margin_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_flex_end_child_with_margin_bigger_than_parent.rs
  ()
}

///|
test "upstream/generated/flex/align_items_flex_end_child_without_margin_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_flex_end_child_without_margin_bigger_than_parent.rs
  ()
}

///|
test "upstream/generated/flex/align_items_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/align_items_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_min_max.rs
  ()
}

///|
test "upstream/generated/flex/align_items_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_stretch.rs
  ()
}

///|
test "upstream/generated/flex/align_items_stretch_min_cross" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_stretch_min_cross.rs
  ()
}

///|
test "upstream/generated/flex/align_self_baseline" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_baseline.rs
  ()
}

///|
test "upstream/generated/flex/align_self_center" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_center.rs
  ()
}

///|
test "upstream/generated/flex/align_self_center_undefined_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_center_undefined_max_height.rs
  ()
}

///|
test "upstream/generated/flex/align_self_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/align_self_flex_end_override_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_flex_end_override_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/align_self_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/align_stretch_should_size_based_on_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_stretch_should_size_based_on_parent.rs
  ()
}

///|
test "upstream/generated/flex/android_news_feed" {
  // TODO: port from taffy-reference/tests/generated/flex/android_news_feed.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_height.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_max_height.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_max_width.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_min_height.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_min_width.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_width.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_width_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_width_flex.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_height.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_max_height.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_max_width.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_width.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_fill_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_height.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_max_height.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_max_width.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_fill_min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_min_height.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_fill_min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_min_width.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_fill_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_width.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_fill_width_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_width_flex.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_height.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_max_height.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_max_width.rs
  ()
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_width.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_10343_block" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_10343_block.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_10343_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_10343_flex.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_10343_grid" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_10343_grid.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_7976_3_level" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_7976_3_level.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_7976_4_level" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_7976_4_level.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_7976_reduced" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_7976_reduced.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_8017" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_8017.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_8017_reduced" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_8017_reduced.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_8082" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_8082.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_8082_percent" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_8082_percent.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_9530" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_9530.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_9530_reduced" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_9530_reduced.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_9530_reduced2" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_9530_reduced2.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_9530_reduced3" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_9530_reduced3.rs
  ()
}

///|
test "upstream/generated/flex/bevy_issue_9530_reduced4" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_9530_reduced4.rs
  ()
}

///|
test "upstream/generated/flex/blitz_issue_88" {
  // TODO: port from taffy-reference/tests/generated/flex/blitz_issue_88.rs
  ()
}

///|
test "upstream/generated/flex/border_center_child" {
  // TODO: port from taffy-reference/tests/generated/flex/border_center_child.rs
  ()
}

///|
test "upstream/generated/flex/border_container_match_child" {
  // TODO: port from taffy-reference/tests/generated/flex/border_container_match_child.rs
  ()
}

///|
test "upstream/generated/flex/border_flex_child" {
  // TODO: port from taffy-reference/tests/generated/flex/border_flex_child.rs
  ()
}

///|
test "upstream/generated/flex/border_no_child" {
  // TODO: port from taffy-reference/tests/generated/flex/border_no_child.rs
  ()
}

///|
test "upstream/generated/flex/border_no_size" {
  // TODO: port from taffy-reference/tests/generated/flex/border_no_size.rs
  ()
}

///|
test "upstream/generated/flex/border_stretch_child" {
  // TODO: port from taffy-reference/tests/generated/flex/border_stretch_child.rs
  ()
}

///|
test "upstream/generated/flex/child_min_max_width_flexing" {
  // TODO: port from taffy-reference/tests/generated/flex/child_min_max_width_flexing.rs
  ()
}

///|
test "upstream/generated/flex/child_with_padding_align_end" {
  // TODO: port from taffy-reference/tests/generated/flex/child_with_padding_align_end.rs
  ()
}

///|
test "upstream/generated/flex/container_with_unsized_child" {
  // TODO: port from taffy-reference/tests/generated/flex/container_with_unsized_child.rs
  ()
}

///|
test "upstream/generated/flex/content_size" {
  // TODO: port from taffy-reference/tests/generated/flex/content_size.rs
  ()
}

///|
test "upstream/generated/flex/display_none" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none.rs
  ()
}

///|
test "upstream/generated/flex/display_none_absolute_child" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_absolute_child.rs
  ()
}

///|
test "upstream/generated/flex/display_none_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_fixed_size.rs
  ()
}

///|
test "upstream/generated/flex/display_none_only_node" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_only_node.rs
  ()
}

///|
test "upstream/generated/flex/display_none_with_child" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_with_child.rs
  ()
}

///|
test "upstream/generated/flex/display_none_with_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_with_margin.rs
  ()
}

///|
test "upstream/generated/flex/display_none_with_position" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_with_position.rs
  ()
}

///|
test "upstream/generated/flex/display_none_with_position_absolute" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_with_position_absolute.rs
  ()
}

///|
test "upstream/generated/flex/do_not_clamp_height_of_absolute_node_to_height_of_its_overflow_hidden_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/do_not_clamp_height_of_absolute_node_to_height_of_its_overflow_hidden_parent.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_and_main_dimen_set_when_flexing" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_and_main_dimen_set_when_flexing.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_flex_grow_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_flex_grow_column.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_flex_grow_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_flex_grow_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_flex_shrink_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_flex_shrink_column.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_flex_shrink_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_flex_shrink_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_larger_than_content_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_larger_than_content_column.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_larger_than_content_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_larger_than_content_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_overrides_main_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_overrides_main_size.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_slightly_smaller_then_content_with_flex_grow_large_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_slightly_smaller_then_content_with_flex_grow_large_size.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_smaller_than_content_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_than_content_column.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_smaller_than_content_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_than_content_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_smaller_than_main_dimen_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_than_main_dimen_column.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_smaller_than_main_dimen_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_than_main_dimen_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_smaller_then_content_with_flex_grow_large_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_then_content_with_flex_grow_large_size.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_smaller_then_content_with_flex_grow_small_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_then_content_with_flex_grow_small_size.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_smaller_then_content_with_flex_grow_unconstraint_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_then_content_with_flex_grow_unconstraint_size.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_smaller_then_content_with_flex_grow_very_large_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_then_content_with_flex_grow_very_large_size.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_unconstraint_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_unconstraint_column.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_unconstraint_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_unconstraint_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_basis_zero_undefined_main_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_zero_undefined_main_size.rs
  ()
}

///|
test "upstream/generated/flex/flex_column_relative_all_sides" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_column_relative_all_sides.rs
  ()
}

///|
test "upstream/generated/flex/flex_direction_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_column.rs
  ()
}

///|
test "upstream/generated/flex/flex_direction_column_no_height" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_column_no_height.rs
  ()
}

///|
test "upstream/generated/flex/flex_direction_column_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_column_reverse.rs
  ()
}

///|
test "upstream/generated/flex/flex_direction_column_reverse_no_height" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_column_reverse_no_height.rs
  ()
}

///|
test "upstream/generated/flex/flex_direction_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_direction_row_no_width" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_row_no_width.rs
  ()
}

///|
test "upstream/generated/flex/flex_direction_row_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_row_reverse.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_child" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_child.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_flex_basis_percent_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_flex_basis_percent_min_max.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_height_maximized" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_height_maximized.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_in_at_most_container" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_in_at_most_container.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_less_than_factor_one" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_less_than_factor_one.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_root_minimized" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_root_minimized.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_shrink_at_most" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_shrink_at_most.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_to_min" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_to_min.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_max_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_max_column.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_max_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_max_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_max_width.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_min_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_min_column.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_min_max_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_min_max_column.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_within_constrained_min_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_min_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_grow_within_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_max_width.rs
  ()
}

///|
test "upstream/generated/flex/flex_row_relative_all_sides" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_row_relative_all_sides.rs
  ()
}

///|
test "upstream/generated/flex/flex_shrink_by_outer_margin_with_max_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_shrink_by_outer_margin_with_max_size.rs
  ()
}

///|
test "upstream/generated/flex/flex_shrink_flex_grow_child_flex_shrink_other_child" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_shrink_flex_grow_child_flex_shrink_other_child.rs
  ()
}

///|
test "upstream/generated/flex/flex_shrink_flex_grow_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_shrink_flex_grow_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_shrink_to_zero" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_shrink_to_zero.rs
  ()
}

///|
test "upstream/generated/flex/flex_wrap_align_stretch_fits_one_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_wrap_align_stretch_fits_one_row.rs
  ()
}

///|
test "upstream/generated/flex/flex_wrap_children_with_min_main_overriding_flex_basis" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_wrap_children_with_min_main_overriding_flex_basis.rs
  ()
}

///|
test "upstream/generated/flex/flex_wrap_wrap_to_child_height" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_wrap_wrap_to_child_height.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_child_margins" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_child_margins.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_determines_parent_width" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_determines_parent_width.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_flexible" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_flexible.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_flexible_undefined_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_flexible_undefined_parent.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_inflexible" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_inflexible.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_inflexible_undefined_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_inflexible_undefined_parent.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_justify_center" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_center.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_justify_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_justify_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_justify_space_around" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_space_around.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_justify_space_between" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_space_between.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_justify_space_evenly" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_space_evenly.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_mixed_flexible" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_mixed_flexible.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_cyclic_partially_shrinkable" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_cyclic_partially_shrinkable.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_cyclic_shrinkable" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_cyclic_shrinkable.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_cyclic_unshrinkable" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_cyclic_unshrinkable.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_flexible" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_flexible.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_flexible_with_padding" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_flexible_with_padding.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_percentage_inflexible" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_inflexible.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_row_gap_wrapping" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_row_gap_wrapping.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_start_index" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_start_index.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_center" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_center.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_space_around" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_space_around.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_space_between" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_space_between.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_gap_wrap_align_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_stretch.rs
  ()
}

///|
test "upstream/generated/flex/gap_column_row_gap_wrapping" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_row_gap_wrapping.rs
  ()
}

///|
test "upstream/generated/flex/gap_row_gap_align_items_end" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_align_items_end.rs
  ()
}

///|
test "upstream/generated/flex/gap_row_gap_align_items_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_align_items_stretch.rs
  ()
}

///|
test "upstream/generated/flex/gap_row_gap_column_child_margins" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_column_child_margins.rs
  ()
}

///|
test "upstream/generated/flex/gap_row_gap_determines_parent_height" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_determines_parent_height.rs
  ()
}

///|
test "upstream/generated/flex/gap_row_gap_percentage_wrapping" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_percentage_wrapping.rs
  ()
}

///|
test "upstream/generated/flex/gap_row_gap_row_wrap_child_margins" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_row_wrap_child_margins.rs
  ()
}

///|
test "upstream/generated/flex/intrinsic_sizing_cross_size_column" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_cross_size_column.rs
  ()
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_column" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_column.rs
  ()
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_column_nested" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_column_nested.rs
  ()
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_column_wrap" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_column_wrap.rs
  ()
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_row" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_row.rs
  ()
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_row_nested" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_row_nested.rs
  ()
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_row_wrap" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_row_wrap.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_center" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_center.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_center_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_center_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_center_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_center_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_end" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_end.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_end_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_end_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_end_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_end_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_end_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_end_reverse.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_flex_end_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_flex_end_reverse.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_flex_start_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_flex_start_reverse.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_max_height_and_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_max_height_and_margin.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_min_height_and_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_min_height_and_margin.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_min_height_and_margin_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_min_height_and_margin_bottom.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_min_height_and_margin_top" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_min_height_and_margin_top.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_space_around" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_around.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_space_around_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_around_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_space_around_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_around_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_space_between" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_between.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_space_between_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_between_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_space_between_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_between_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_space_evenly" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_evenly.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_space_evenly_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_evenly_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_space_evenly_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_evenly_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_start" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_start.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_start_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_start_negative_space.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_start_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_start_negative_space_gap.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_column_start_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_start_reverse.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_min_max.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_min_width_with_padding_child_width_greater_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_min_width_with_padding_child_width_greater_than_parent.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_min_width_with_padding_child_width_lower_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_min_width_with_padding_child_width_lower_than_parent.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_overflow_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_overflow_min_max.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_row_center" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_center.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_row_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_row_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_row_max_width_and_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_max_width_and_margin.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_row_min_width_and_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_min_width_and_margin.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_row_space_around" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_space_around.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_row_space_between" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_space_between.rs
  ()
}

///|
test "upstream/generated/flex/justify_content_row_space_evenly" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_space_evenly.rs
  ()
}

///|
test "upstream/generated/flex/margin_and_flex_column" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_and_flex_column.rs
  ()
}

///|
test "upstream/generated/flex/margin_and_flex_row" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_and_flex_row.rs
  ()
}

///|
test "upstream/generated/flex/margin_and_stretch_column" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_and_stretch_column.rs
  ()
}

///|
test "upstream/generated/flex/margin_and_stretch_row" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_and_stretch_row.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_bottom.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_bottom_and_top" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_bottom_and_top.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_bottom_and_top_justify_center" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_bottom_and_top_justify_center.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_left" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_left_and_right" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_and_right.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_left_and_right_column" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_and_right_column.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_left_and_right_column_and_center" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_and_right_column_and_center.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_left_and_right_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_and_right_stretch.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_left_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_child_bigger_than_parent.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_left_fix_right_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_fix_right_child_bigger_than_parent.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_left_right_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_right_child_bigger_than_parent.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_left_stretching_child" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_stretching_child.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_multiple_children_column" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_multiple_children_column.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_multiple_children_row" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_multiple_children_row.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_right" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_right.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_top" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_top.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_top_and_bottom_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_top_and_bottom_stretch.rs
  ()
}

///|
test "upstream/generated/flex/margin_auto_top_stretching_child" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_top_stretching_child.rs
  ()
}

///|
test "upstream/generated/flex/margin_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_bottom.rs
  ()
}

///|
test "upstream/generated/flex/margin_fix_left_auto_right_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_fix_left_auto_right_child_bigger_than_parent.rs
  ()
}

///|
test "upstream/generated/flex/margin_left" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_left.rs
  ()
}

///|
test "upstream/generated/flex/margin_right" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_right.rs
  ()
}

///|
test "upstream/generated/flex/margin_should_not_be_part_of_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_should_not_be_part_of_max_height.rs
  ()
}

///|
test "upstream/generated/flex/margin_should_not_be_part_of_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_should_not_be_part_of_max_width.rs
  ()
}

///|
test "upstream/generated/flex/margin_top" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_top.rs
  ()
}

///|
test "upstream/generated/flex/margin_with_sibling_column" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_with_sibling_column.rs
  ()
}

///|
test "upstream/generated/flex/margin_with_sibling_row" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_with_sibling_row.rs
  ()
}

///|
test "upstream/generated/flex/max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/max_height.rs
  ()
}

///|
test "upstream/generated/flex/max_height_overrides_height" {
  // TODO: port from taffy-reference/tests/generated/flex/max_height_overrides_height.rs
  ()
}

///|
test "upstream/generated/flex/max_height_overrides_height_on_root" {
  // TODO: port from taffy-reference/tests/generated/flex/max_height_overrides_height_on_root.rs
  ()
}

///|
test "upstream/generated/flex/max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/max_width.rs
  ()
}

///|
test "upstream/generated/flex/max_width_overrides_width" {
  // TODO: port from taffy-reference/tests/generated/flex/max_width_overrides_width.rs
  ()
}

///|
test "upstream/generated/flex/max_width_overrides_width_on_root" {
  // TODO: port from taffy-reference/tests/generated/flex/max_width_overrides_width_on_root.rs
  ()
}

///|
test "upstream/generated/flex/measure_child" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child.rs
  ()
}

///|
test "upstream/generated/flex/measure_child_absolute" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_absolute.rs
  ()
}

///|
test "upstream/generated/flex/measure_child_constraint" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_constraint.rs
  ()
}

///|
test "upstream/generated/flex/measure_child_constraint_padding_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_constraint_padding_parent.rs
  ()
}

///|
test "upstream/generated/flex/measure_child_with_flex_grow" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_with_flex_grow.rs
  ()
}

///|
test "upstream/generated/flex/measure_child_with_flex_shrink" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_with_flex_shrink.rs
  ()
}

///|
test "upstream/generated/flex/measure_child_with_flex_shrink_hidden" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_with_flex_shrink_hidden.rs
  ()
}

///|
test "upstream/generated/flex/measure_child_with_min_size_greater_than_available_space" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_with_min_size_greater_than_available_space.rs
  ()
}

///|
test "upstream/generated/flex/measure_flex_basis_overrides_measure" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_flex_basis_overrides_measure.rs
  ()
}

///|
test "upstream/generated/flex/measure_height_overrides_measure" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_height_overrides_measure.rs
  ()
}

///|
test "upstream/generated/flex/measure_remeasure_child_after_growing" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_remeasure_child_after_growing.rs
  ()
}

///|
test "upstream/generated/flex/measure_remeasure_child_after_shrinking" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_remeasure_child_after_shrinking.rs
  ()
}

///|
test "upstream/generated/flex/measure_remeasure_child_after_stretching" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_remeasure_child_after_stretching.rs
  ()
}

///|
test "upstream/generated/flex/measure_root" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_root.rs
  ()
}

///|
test "upstream/generated/flex/measure_stretch_overrides_measure" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_stretch_overrides_measure.rs
  ()
}

///|
test "upstream/generated/flex/measure_width_overrides_measure" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_width_overrides_measure.rs
  ()
}

///|
test "upstream/generated/flex/min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height.rs
  ()
}

///|
test "upstream/generated/flex/min_height_larger_than_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height_larger_than_height.rs
  ()
}

///|
test "upstream/generated/flex/min_height_overrides_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height_overrides_height.rs
  ()
}

///|
test "upstream/generated/flex/min_height_overrides_height_on_root" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height_overrides_height_on_root.rs
  ()
}

///|
test "upstream/generated/flex/min_height_overrides_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height_overrides_max_height.rs
  ()
}

///|
test "upstream/generated/flex/min_height_with_nested_fixed_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height_with_nested_fixed_height.rs
  ()
}

///|
test "upstream/generated/flex/min_max_percent_different_width_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_max_percent_different_width_height.rs
  ()
}

///|
test "upstream/generated/flex/min_max_percent_no_width_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_max_percent_no_width_height.rs
  ()
}

///|
test "upstream/generated/flex/min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/min_width.rs
  ()
}

///|
test "upstream/generated/flex/min_width_larger_than_width" {
  // TODO: port from taffy-reference/tests/generated/flex/min_width_larger_than_width.rs
  ()
}

///|
test "upstream/generated/flex/min_width_overrides_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/min_width_overrides_max_width.rs
  ()
}

///|
test "upstream/generated/flex/min_width_overrides_width" {
  // TODO: port from taffy-reference/tests/generated/flex/min_width_overrides_width.rs
  ()
}

///|
test "upstream/generated/flex/min_width_overrides_width_on_root" {
  // TODO: port from taffy-reference/tests/generated/flex/min_width_overrides_width_on_root.rs
  ()
}

///|
test "upstream/generated/flex/mod" {
  // TODO: port from taffy-reference/tests/generated/flex/mod.rs
  ()
}

///|
test "upstream/generated/flex/nested_overflowing_child" {
  // TODO: port from taffy-reference/tests/generated/flex/nested_overflowing_child.rs
  ()
}

///|
test "upstream/generated/flex/nested_overflowing_child_in_constraint_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/nested_overflowing_child_in_constraint_parent.rs
  ()
}

///|
test "upstream/generated/flex/only_shrinkable_item_with_flex_basis_zero" {
  // TODO: port from taffy-reference/tests/generated/flex/only_shrinkable_item_with_flex_basis_zero.rs
  ()
}

///|
test "upstream/generated/flex/overflow_cross_axis" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_cross_axis.rs
  ()
}

///|
test "upstream/generated/flex/overflow_main_axis" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_main_axis.rs
  ()
}

///|
test "upstream/generated/flex/overflow_main_axis_shrink_hidden" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_main_axis_shrink_hidden.rs
  ()
}

///|
test "upstream/generated/flex/overflow_main_axis_shrink_scroll" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_main_axis_shrink_scroll.rs
  ()
}

///|
test "upstream/generated/flex/overflow_main_axis_shrink_visible" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_main_axis_shrink_visible.rs
  ()
}

///|
test "upstream/generated/flex/overflow_scroll_main_axis_justify_content_end" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scroll_main_axis_justify_content_end.rs
  ()
}

///|
test "upstream/generated/flex/overflow_scrollbars_overridden_by_available_space" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_overridden_by_available_space.rs
  ()
}

///|
test "upstream/generated/flex/overflow_scrollbars_overridden_by_max_size" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_overridden_by_max_size.rs
  ()
}

///|
test "upstream/generated/flex/overflow_scrollbars_overridden_by_size" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_overridden_by_size.rs
  ()
}

///|
test "upstream/generated/flex/overflow_scrollbars_take_up_space_both_axis" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_take_up_space_both_axis.rs
  ()
}

///|
test "upstream/generated/flex/overflow_scrollbars_take_up_space_cross_axis" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_take_up_space_cross_axis.rs
  ()
}

///|
test "upstream/generated/flex/overflow_scrollbars_take_up_space_main_axis" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_take_up_space_main_axis.rs
  ()
}

///|
test "upstream/generated/flex/padding_align_end_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_align_end_child.rs
  ()
}

///|
test "upstream/generated/flex/padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_max_size.rs
  ()
}

///|
test "upstream/generated/flex/padding_border_overrides_min_size" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_min_size.rs
  ()
}

///|
test "upstream/generated/flex/padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_size.rs
  ()
}

///|
test "upstream/generated/flex/padding_border_overrides_size_flex_basis_0" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_size_flex_basis_0.rs
  ()
}

///|
test "upstream/generated/flex/padding_border_overrides_size_flex_basis_0_growable" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_size_flex_basis_0_growable.rs
  ()
}

///|
test "upstream/generated/flex/padding_border_overrides_size_root" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_size_root.rs
  ()
}

///|
test "upstream/generated/flex/padding_center_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_center_child.rs
  ()
}

///|
test "upstream/generated/flex/padding_container_match_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_container_match_child.rs
  ()
}

///|
test "upstream/generated/flex/padding_flex_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_flex_child.rs
  ()
}

///|
test "upstream/generated/flex/padding_no_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_no_child.rs
  ()
}

///|
test "upstream/generated/flex/padding_no_size" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_no_size.rs
  ()
}

///|
test "upstream/generated/flex/padding_stretch_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_stretch_child.rs
  ()
}

///|
test "upstream/generated/flex/parent_wrap_child_size_overflowing_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/parent_wrap_child_size_overflowing_parent.rs
  ()
}

///|
test "upstream/generated/flex/percent_absolute_position" {
  // TODO: port from taffy-reference/tests/generated/flex/percent_absolute_position.rs
  ()
}

///|
test "upstream/generated/flex/percent_within_flex_grow" {
  // TODO: port from taffy-reference/tests/generated/flex/percent_within_flex_grow.rs
  ()
}

///|
test "upstream/generated/flex/percentage_absolute_position" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_absolute_position.rs
  ()
}

///|
test "upstream/generated/flex/percentage_container_in_wrapping_container" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_container_in_wrapping_container.rs
  ()
}

///|
test "upstream/generated/flex/percentage_different_width_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_different_width_height.rs
  ()
}

///|
test "upstream/generated/flex/percentage_different_width_height_column" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_different_width_height_column.rs
  ()
}

///|
test "upstream/generated/flex/percentage_flex_basis" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis.rs
  ()
}

///|
test "upstream/generated/flex/percentage_flex_basis_cross" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_cross.rs
  ()
}

///|
test "upstream/generated/flex/percentage_flex_basis_cross_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_max_height.rs
  ()
}

///|
test "upstream/generated/flex/percentage_flex_basis_cross_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_max_width.rs
  ()
}

///|
test "upstream/generated/flex/percentage_flex_basis_cross_min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_min_height.rs
  ()
}

///|
test "upstream/generated/flex/percentage_flex_basis_cross_min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_min_width.rs
  ()
}

///|
test "upstream/generated/flex/percentage_flex_basis_main_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_main_max_height.rs
  ()
}

///|
test "upstream/generated/flex/percentage_flex_basis_main_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_main_max_width.rs
  ()
}

///|
test "upstream/generated/flex/percentage_flex_basis_main_min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_main_min_width.rs
  ()
}

///|
test "upstream/generated/flex/percentage_main_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_main_max_height.rs
  ()
}

///|
test "upstream/generated/flex/percentage_margin_should_calculate_based_only_on_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_margin_should_calculate_based_only_on_width.rs
  ()
}

///|
test "upstream/generated/flex/percentage_moderate_complexity" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_moderate_complexity.rs
  ()
}

///|
test "upstream/generated/flex/percentage_moderate_complexity2" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_moderate_complexity2.rs
  ()
}

///|
test "upstream/generated/flex/percentage_multiple_nested_with_padding_margin_and_percentage_values" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_multiple_nested_with_padding_margin_and_percentage_values.rs
  ()
}

///|
test "upstream/generated/flex/percentage_padding_should_calculate_based_only_on_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_padding_should_calculate_based_only_on_width.rs
  ()
}

///|
test "upstream/generated/flex/percentage_position_bottom_right" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_position_bottom_right.rs
  ()
}

///|
test "upstream/generated/flex/percentage_position_left_top" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_position_left_top.rs
  ()
}

///|
test "upstream/generated/flex/percentage_size_based_on_parent_inner_size" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_size_based_on_parent_inner_size.rs
  ()
}

///|
test "upstream/generated/flex/percentage_size_of_flex_basis" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_size_of_flex_basis.rs
  ()
}

///|
test "upstream/generated/flex/percentage_sizes_should_not_prevent_flex_shrinking" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_sizes_should_not_prevent_flex_shrinking.rs
  ()
}

///|
test "upstream/generated/flex/percentage_width_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_width_height.rs
  ()
}

///|
test "upstream/generated/flex/percentage_width_height_undefined_parent_size" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_width_height_undefined_parent_size.rs
  ()
}

///|
test "upstream/generated/flex/position_root_with_rtl_should_position_withoutdirection" {
  // TODO: port from taffy-reference/tests/generated/flex/position_root_with_rtl_should_position_withoutdirection.rs
  ()
}

///|
test "upstream/generated/flex/relative_position_should_not_nudge_siblings" {
  // TODO: port from taffy-reference/tests/generated/flex/relative_position_should_not_nudge_siblings.rs
  ()
}

///|
test "upstream/generated/flex/rounding_flex_basis_flex_grow_row_prime_number_width" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_flex_basis_flex_grow_row_prime_number_width.rs
  ()
}

///|
test "upstream/generated/flex/rounding_flex_basis_flex_grow_row_width_of_100" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_flex_basis_flex_grow_row_width_of_100.rs
  ()
}

///|
test "upstream/generated/flex/rounding_flex_basis_flex_shrink_row" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_flex_basis_flex_shrink_row.rs
  ()
}

///|
test "upstream/generated/flex/rounding_flex_basis_overrides_main_size" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_flex_basis_overrides_main_size.rs
  ()
}

///|
test "upstream/generated/flex/rounding_fractial_input_1" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_1.rs
  ()
}

///|
test "upstream/generated/flex/rounding_fractial_input_2" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_2.rs
  ()
}

///|
test "upstream/generated/flex/rounding_fractial_input_3" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_3.rs
  ()
}

///|
test "upstream/generated/flex/rounding_fractial_input_4" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_4.rs
  ()
}

///|
test "upstream/generated/flex/rounding_fractial_input_5" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_5.rs
  ()
}

///|
test "upstream/generated/flex/rounding_fractial_input_6" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_6.rs
  ()
}

///|
test "upstream/generated/flex/rounding_fractial_input_7" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_7.rs
  ()
}

///|
test "upstream/generated/flex/rounding_inner_node_controversy_combined" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_inner_node_controversy_combined.rs
  ()
}

///|
test "upstream/generated/flex/rounding_inner_node_controversy_horizontal" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_inner_node_controversy_horizontal.rs
  ()
}

///|
test "upstream/generated/flex/rounding_inner_node_controversy_vertical" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_inner_node_controversy_vertical.rs
  ()
}

///|
test "upstream/generated/flex/rounding_total_fractial" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_total_fractial.rs
  ()
}

///|
test "upstream/generated/flex/rounding_total_fractial_nested" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_total_fractial_nested.rs
  ()
}

///|
test "upstream/generated/flex/scroll_size" {
  // TODO: port from taffy-reference/tests/generated/flex/scroll_size.rs
  ()
}

///|
test "upstream/generated/flex/simple_child" {
  // TODO: port from taffy-reference/tests/generated/flex/simple_child.rs
  ()
}

///|
test "upstream/generated/flex/single_flex_child_after_absolute_child" {
  // TODO: port from taffy-reference/tests/generated/flex/single_flex_child_after_absolute_child.rs
  ()
}

///|
test "upstream/generated/flex/size_defined_by_child" {
  // TODO: port from taffy-reference/tests/generated/flex/size_defined_by_child.rs
  ()
}

///|
test "upstream/generated/flex/size_defined_by_child_with_border" {
  // TODO: port from taffy-reference/tests/generated/flex/size_defined_by_child_with_border.rs
  ()
}

///|
test "upstream/generated/flex/size_defined_by_child_with_padding" {
  // TODO: port from taffy-reference/tests/generated/flex/size_defined_by_child_with_padding.rs
  ()
}

///|
test "upstream/generated/flex/size_defined_by_grand_child" {
  // TODO: port from taffy-reference/tests/generated/flex/size_defined_by_grand_child.rs
  ()
}

///|
test "upstream/generated/flex/undefined_height_with_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/undefined_height_with_min_max.rs
  ()
}

///|
test "upstream/generated/flex/undefined_width_with_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/undefined_width_with_min_max.rs
  ()
}

///|
test "upstream/generated/flex/undefined_width_with_min_max_row" {
  // TODO: port from taffy-reference/tests/generated/flex/undefined_width_with_min_max_row.rs
  ()
}

///|
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_large_size" {
  // TODO: port from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_large_size.rs
  ()
}

///|
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_small_size" {
  // TODO: port from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_small_size.rs
  ()
}

///|
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_unconstraint_size" {
  // TODO: port from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_unconstraint_size.rs
  ()
}

///|
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_very_large_size" {
  // TODO: port from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_very_large_size.rs
  ()
}

///|
test "upstream/generated/flex/wrap_child" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_child.rs
  ()
}

///|
test "upstream/generated/flex/wrap_column" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_column.rs
  ()
}

///|
test "upstream/generated/flex/wrap_grandchild" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_grandchild.rs
  ()
}

///|
test "upstream/generated/flex/wrap_nodes_with_content_sizing_margin_cross" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_nodes_with_content_sizing_margin_cross.rs
  ()
}

///|
test "upstream/generated/flex/wrap_nodes_with_content_sizing_overflowing_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_nodes_with_content_sizing_overflowing_margin.rs
  ()
}

///|
test "upstream/generated/flex/wrap_reverse_column" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_column.rs
  ()
}

///|
test "upstream/generated/flex/wrap_reverse_column_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_column_fixed_size.rs
  ()
}

///|
test "upstream/generated/flex/wrap_reverse_row" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row.rs
  ()
}

///|
test "upstream/generated/flex/wrap_reverse_row_align_content_center" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_center.rs
  ()
}

///|
test "upstream/generated/flex/wrap_reverse_row_align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_flex_start.rs
  ()
}

///|
test "upstream/generated/flex/wrap_reverse_row_align_content_space_around" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_space_around.rs
  ()
}

///|
test "upstream/generated/flex/wrap_reverse_row_align_content_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_stretch.rs
  ()
}

///|
test "upstream/generated/flex/wrap_reverse_row_single_line_different_size" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row_single_line_different_size.rs
  ()
}

///|
test "upstream/generated/flex/wrap_row" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_row.rs
  ()
}

///|
test "upstream/generated/flex/wrap_row_align_items_center" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_row_align_items_center.rs
  ()
}

///|
test "upstream/generated/flex/wrap_row_align_items_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_row_align_items_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/wrapped_column_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/wrapped_column_max_height.rs
  ()
}

///|
test "upstream/generated/flex/wrapped_column_max_height_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/wrapped_column_max_height_flex.rs
  ()
}

///|
test "upstream/generated/flex/wrapped_row_within_align_items_center" {
  // TODO: port from taffy-reference/tests/generated/flex/wrapped_row_within_align_items_center.rs
  ()
}

///|
test "upstream/generated/flex/wrapped_row_within_align_items_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/wrapped_row_within_align_items_flex_end.rs
  ()
}

///|
test "upstream/generated/flex/wrapped_row_within_align_items_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/wrapped_row_within_align_items_flex_start.rs
  ()
}

///|
test "upstream/generated/grid/chrome_issue_325928327" {
  // TODO: port from taffy-reference/tests/generated/grid/chrome_issue_325928327.rs
  ()
}

///|
test "upstream/generated/grid/grid_absolute_align_self_sized_all" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_align_self_sized_all.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_start())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_start())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_end())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_end())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_center())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_center())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_stretch())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_stretch())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let expected_w = [20.0, 60.0, 20.0, 60.0, 20.0, 60.0, 20.0, 60.0]
  let expected_h = [20.0, 60.0, 20.0, 60.0, 20.0, 60.0, 20.0, 60.0]
  let expected_x = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  let expected_y = [0.0, 0.0, 100.0, 60.0, 50.0, 30.0, 0.0, 0.0]
  for i in 0..<8 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_column_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_column_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_grid_column(Line::new(start=place_auto(), end=line(1)))
    .with_inset(
      Rect::new(
        left=length(4.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(2.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let n = taffy.layout(node0)
  assert_eq(n.size.width, 33.0)
  assert_eq(n.size.height, 157.0)
  assert_eq(n.location.x, 4.0)
  assert_eq(n.location.y, 1.0)
}

///|
test "upstream/generated/grid/grid_absolute_column_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_column_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_grid_column(Line::new(start=line(1), end=place_auto()))
    .with_inset(
      Rect::new(
        left=length(4.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(2.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let n = taffy.layout(node0)
  assert_eq(n.size.width, 133.0)
  assert_eq(n.size.height, 157.0)
  assert_eq(n.location.x, 44.0)
  assert_eq(n.location.y, 1.0)
}

///|
test "upstream/generated/grid/grid_absolute_container_bottom_left" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_bottom_left.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect::new(left=length(0.0), right=auto(), top=auto(), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [160.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_bottom_left_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_bottom_left_margin.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect::new(left=length(0.0), right=auto(), top=auto(), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [10.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [10.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [4.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [147.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_left_overrides_right" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_left_overrides_right.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=auto()))
    .with_inset(
      Rect::new(left=length(5.0), right=length(2.0), top=auto(), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [10.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [5.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [0.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_left_right" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_left_right.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect::new(left=length(5.0), right=length(2.0), top=auto(), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [173.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [5.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [0.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_left_right_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_left_right_margin.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect::new(left=length(5.0), right=length(2.0), top=auto(), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [167.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [9.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [1.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_negative_position" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_negative_position.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect::new(
        left=auto(),
        right=length(-15.0),
        top=length(-5.0),
        bottom=auto(),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect::new(
        left=length(-35.0),
        right=auto(),
        top=auto(),
        bottom=length(-25.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [195.0, -35.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0]
  let expected_y = [-5.0, 185.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_negative_position_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_negative_position_margin.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=auto(),
        right=length(-15.0),
        top=length(-5.0),
        bottom=auto(),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=length(-35.0),
        right=auto(),
        top=auto(),
        bottom=length(-25.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [193.0, -31.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0]
  let expected_y = [-4.0, 182.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_top_bottom" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_top_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=length(2.0), bottom=length(5.0)),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [153.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [2.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_top_bottom_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_top_bottom_margin.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=length(2.0), bottom=length(5.0)),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [149.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [4.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [3.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_top_right" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_top_right.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect::new(left=auto(), right=length(0.0), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [180.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [0.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_top_right_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_top_right_margin.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect::new(left=auto(), right=length(0.0), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [178.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [1.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_justify_self_sized_all" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_justify_self_sized_all.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_start())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_start())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_end())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_end())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_center())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_center())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_stretch())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_stretch())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let expected_w = [20.0, 60.0, 20.0, 60.0, 20.0, 60.0, 20.0, 60.0]
  let expected_h = [20.0, 60.0, 20.0, 60.0, 20.0, 60.0, 20.0, 60.0]
  let expected_x = [0.0, 0.0, 100.0, 60.0, 50.0, 30.0, 0.0, 0.0]
  let expected_y = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  for i in 0..<8 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_layout_within_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_layout_within_border.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect::new(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect::new(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect::new(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect::new(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_border(
      Rect::new(
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
  let nodes = [node0, node1, node2, node3]
  let expected_w = [50.0, 50.0, 50.0, 50.0]
  let expected_h = [50.0, 50.0, 50.0, 50.0]
  let expected_x = [10.0, 40.0, 20.0, 30.0]
  let expected_y = [10.0, 40.0, 20.0, 30.0]
  for i in 0..<4 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_layout_within_border_static" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_layout_within_border_static.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_end())
    .with_justify_self(align_items_end())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_end())
    .with_justify_self(align_items_end())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_border(
      Rect::new(
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
  let nodes = [node0, node1, node2, node3]
  let expected_w = [50.0, 50.0, 50.0, 50.0]
  let expected_h = [50.0, 50.0, 50.0, 50.0]
  let expected_x = [10.0, 40.0, 20.0, 30.0]
  let expected_y = [10.0, 40.0, 20.0, 30.0]
  for i in 0..<4 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_row_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_row_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_grid_row(Line::new(start=place_auto(), end=line(1)))
    .with_inset(
      Rect::new(
        left=length(4.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(2.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let n = taffy.layout(node0)
  assert_eq(n.size.width, 173.0)
  assert_eq(n.size.height, 7.0)
  assert_eq(n.location.x, 4.0)
  assert_eq(n.location.y, 1.0)
}

///|
test "upstream/generated/grid/grid_absolute_row_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_row_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_grid_row(Line::new(start=line(1), end=place_auto()))
    .with_inset(
      Rect::new(
        left=length(4.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(2.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let n = taffy.layout(node0)
  assert_eq(n.size.width, 173.0)
  assert_eq(n.size.height, 147.0)
  assert_eq(n.location.x, 4.0)
  assert_eq(n.location.y, 11.0)
}

///|
test "upstream/generated/grid/grid_absolute_top_overrides_bottom" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_top_overrides_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=length(2.0), bottom=length(5.0)),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [10.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [2.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_with_padding" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_with_padding.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect::new(left=auto(), right=length(0.0), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=auto(),
        top=auto(),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [180.0, 10.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0]
  let expected_y = [0.0, 150.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_with_padding_and_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_with_padding_and_margin.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect::new(left=auto(), right=length(0.0), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=auto(),
        top=auto(),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [178.0, 14.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0]
  let expected_y = [1.0, 147.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_align_content_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_center.rs
  run_grid_align_content_test(align_content_center(), [40.0, 80.0, 120.0])
}

///|
test "upstream/generated/grid/grid_align_content_center_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_center_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(align_content_center(), [
    -10.0, 40.0, 90.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_end.rs
  run_grid_align_content_test(align_content_end(), [80.0, 120.0, 160.0])
}

///|
test "upstream/generated/grid/grid_align_content_end_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_end_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(align_content_end(), [
    -20.0, 30.0, 80.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_end_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_end_with_padding_border.rs
  run_grid_align_content_with_padding_border_test(align_content_end(), [
    44.0, 84.0, 124.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_space_around" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_around.rs
  run_grid_align_content_test(align_content_space_around(), [13.0, 80.0, 147.0])
}

///|
test "upstream/generated/grid/grid_align_content_space_around_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_around_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(align_content_space_around(), [
    0.0, 50.0, 100.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_space_around_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_around_with_padding_border.rs
  run_grid_align_content_with_padding_border_test(
    align_content_space_around(),
    [17.0, 68.0, 119.0],
  )
}

///|
test "upstream/generated/grid/grid_align_content_space_between" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_between.rs
  run_grid_align_content_test(align_content_space_between(), [0.0, 80.0, 160.0])
}

///|
test "upstream/generated/grid/grid_align_content_space_between_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_between_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(
    align_content_space_between(),
    [0.0, 50.0, 100.0],
  )
}

///|
test "upstream/generated/grid/grid_align_content_space_between_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_between_with_padding_border.rs
  run_grid_align_content_with_padding_border_test(
    align_content_space_between(),
    [12.0, 68.0, 124.0],
  )
}

///|
test "upstream/generated/grid/grid_align_content_space_evenly" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_evenly.rs
  run_grid_align_content_test(align_content_space_evenly(), [20.0, 80.0, 140.0])
}

///|
test "upstream/generated/grid/grid_align_content_space_evenly_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_evenly_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(align_content_space_evenly(), [
    0.0, 50.0, 100.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_space_evenly_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_evenly_with_padding_border.rs
  run_grid_align_content_with_padding_border_test(
    align_content_space_evenly(),
    [20.0, 68.0, 116.0],
  )
}

///|
test "upstream/generated/grid/grid_align_content_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_start.rs
  run_grid_align_content_test(align_content_start(), [0.0, 40.0, 80.0])
}

///|
test "upstream/generated/grid/grid_align_content_start_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_start_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(align_content_start(), [
    0.0, 50.0, 100.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_start_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_start_with_padding_border.rs
  run_grid_align_content_with_padding_border_test(align_content_start(), [
    12.0, 52.0, 92.0,
  ])
}

///|
fn[C] assert_layout_xywh(
  taffy : TaffyTree[C],
  node : NodeId,
  width : Double,
  height : Double,
  x : Double,
  y : Double,
) -> Unit raise Error {
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, width)
  assert_eq(layout.size.height, height)
  assert_eq(layout.location.x, x)
  assert_eq(layout.location.y, y)
}

///|
fn[C] assert_nodes_layout_xywh(
  taffy : TaffyTree[C],
  nodes : Array[NodeId],
  expected_w : Array[Double],
  expected_h : Array[Double],
  expected_x : Array[Double],
  expected_y : Array[Double],
) -> Unit raise Error {
  for i in 0..<nodes.length() {
    assert_layout_xywh(
      taffy,
      nodes[i],
      expected_w[i],
      expected_h[i],
      expected_x[i],
      expected_y[i],
    )
  }
}

///|
test "upstream/generated/grid/grid_align_items_baseline" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 65.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 65.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 5.0, 5.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 70.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 5.0, 5.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_margin_percent" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_margin_percent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(10.0)))
    .with_margin(
      Rect::new(
        left=percent(0.01),
        right=percent(0.01),
        top=percent(0.01),
        bottom=percent(0.01),
      ),
    ),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 5.0, 5.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 70.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 1.0, 1.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_multiline" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_multiline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(60.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(25.0), height=length(20.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(25.0), height=length(10.0))),
  )
  let node12 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(25.0), height=length(20.0))),
  )
  let node13 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(25.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_flex_wrap(flex_wrap_wrap())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node10, node11, node12, node13],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 40.0, 0.0, 60.0)
  assert_layout_xywh(taffy, node10, 25.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node11, 25.0, 10.0, 25.0, 0.0)
  assert_layout_xywh(taffy, node12, 25.0, 20.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node13, 25.0, 10.0, 25.0, 20.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_multiline_no_override_on_secondline" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_multiline_no_override_on_secondline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(60.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(25.0), height=length(20.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(25.0), height=length(10.0))),
  )
  let node12 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(25.0), height=length(20.0))),
  )
  let node13 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_align_self(align_items_baseline())
    .with_size(Size::new(width=length(25.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size::new(width=length(50.0), height=length(25.0))),
    [node10, node11, node12, node13],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 25.0, 0.0, 68.0)
  assert_layout_xywh(taffy, node10, 25.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node11, 25.0, 10.0, 25.0, 0.0)
  assert_layout_xywh(taffy, node12, 25.0, 20.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node13, 25.0, 10.0, 25.0, 20.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_multiline_override" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_multiline_override.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(60.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(25.0), height=length(20.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_align_self(align_items_baseline())
    .with_size(Size::new(width=length(25.0), height=length(10.0))),
  )
  let node12 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(25.0), height=length(20.0))),
  )
  let node13 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_align_self(align_items_baseline())
    .with_size(Size::new(width=length(25.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size::new(width=length(50.0), height=length(25.0))),
    [node10, node11, node12, node13],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 25.0, 0.0, 68.0)
  assert_layout_xywh(taffy, node10, 25.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node11, 25.0, 10.0, 25.0, 0.0)
  assert_layout_xywh(taffy, node12, 25.0, 20.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node13, 25.0, 10.0, 25.0, 20.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_padding" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_padding.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0)))
    .with_padding(
      Rect::new(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect::new(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 5.0, 5.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 5.0, 65.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 5.0, 5.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_top" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=length(10.0), bottom=auto()),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 10.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 65.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_top2" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_top2.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0)))
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=length(5.0), bottom=auto()),
    ),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 70.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_complex" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_complex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
  )
  let node60 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(10.0))),
  )
  let node6 = taffy.new_with_children(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
    [node60],
  )
  let node70 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(5.0))),
  )
  let node7 = taffy.new_with_children(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
    [node70],
  )
  let node8 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 20.0, 40.0, 10.0)
  assert_layout_xywh(taffy, node10, 0.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 20.0, 20.0, 80.0, 10.0)
  assert_layout_xywh(taffy, node20, 0.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node3, 20.0, 20.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node4, 20.0, 20.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node5, 20.0, 20.0, 80.0, 40.0)
  assert_layout_xywh(taffy, node6, 20.0, 20.0, 0.0, 90.0)
  assert_layout_xywh(taffy, node60, 0.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node7, 20.0, 20.0, 40.0, 95.0)
  assert_layout_xywh(taffy, node70, 0.0, 5.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node8, 20.0, 20.0, 80.0, 80.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_double_nested_child" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_double_nested_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
    [node00],
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(15.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 50.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 65.0)
  assert_layout_xywh(taffy, node10, 50.0, 15.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_multiline" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_multiline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 50.0, 40.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 50.0, 20.0, 0.0, 100.0)
  assert_layout_xywh(taffy, node20, 50.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node3, 50.0, 50.0, 50.0, 60.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_multiline_column" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_multiline_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(30.0), height=length(50.0))),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(10.0), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(40.0), height=length(70.0))),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 30.0, 50.0, 50.0, 30.0)
  assert_layout_xywh(taffy, node10, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 40.0, 70.0, 0.0, 90.0)
  assert_layout_xywh(taffy, node20, 10.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node3, 50.0, 20.0, 50.0, 80.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_multiline_row_and_column" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_multiline_row_and_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 50.0, 50.0, 40.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 50.0, 20.0, 0.0, 100.0)
  assert_layout_xywh(taffy, node20, 50.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node3, 50.0, 20.0, 50.0, 90.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_nested_column" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_nested_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(60.0))),
  )
  let node100 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(30.0))),
  )
  let node101 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(40.0))),
  )
  let node10 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(50.0), height=length(80.0))),
    [node100, node101],
  )
  let node1 = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 100.0, 80.0, 0.0, 60.0)
  assert_layout_xywh(taffy, node10, 50.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node100, 50.0, 30.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node101, 50.0, 40.0, 0.0, 35.0)
}

///|
test "upstream/generated/grid/grid_align_items_sized_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_sized_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_center())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 10.0)
  assert_layout_xywh(taffy, node1, 60.0, 60.0, 80.0, 70.0)
}

///|
test "upstream/generated/grid/grid_align_items_sized_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_sized_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_end())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node1, 60.0, 60.0, 80.0, 60.0)
}

///|
test "upstream/generated/grid/grid_align_items_sized_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_sized_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_start())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 60.0, 80.0, 80.0)
}

///|
test "upstream/generated/grid/grid_align_items_sized_stretch" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_sized_stretch.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_stretch())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 60.0, 80.0, 80.0)
}

///|
test "upstream/generated/grid/grid_align_self_sized_all" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_self_sized_all.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_end())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_end())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_stretch())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_stretch())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 60.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 20.0, 20.0, 80.0, 20.0)
  assert_layout_xywh(taffy, node3, 60.0, 60.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node4, 20.0, 20.0, 40.0, 50.0)
  assert_layout_xywh(taffy, node5, 60.0, 60.0, 80.0, 30.0)
  assert_layout_xywh(taffy, node6, 20.0, 20.0, 0.0, 80.0)
  assert_layout_xywh(taffy, node7, 60.0, 60.0, 40.0, 80.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_absolute_aspect_ratio_overrides_height_of_full_inset" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_aspect_ratio_overrides_height_of_full_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 400.0, 300.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 360.0, 120.0, 20.0, 15.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_absolute_fill_height_from_inset" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_fill_height_from_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=percent(0.1),
        right=percent(0.1),
        top=percent(0.05),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 400.0, 300.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 320.0, 107.0, 40.0, 15.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_absolute_fill_width_from_inset" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_fill_width_from_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=auto(),
        right=auto(),
        top=percent(0.3),
        bottom=percent(0.5),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 400.0, 300.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 180.0, 60.0, 0.0, 90.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_absolute_height_overrides_inset" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_height_overrides_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=auto(), height=percent(0.1)))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=auto(),
        right=auto(),
        top=percent(0.3),
        bottom=percent(0.5),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 400.0, 300.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 90.0, 30.0, 0.0, 90.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_absolute_width_overrides_inset" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_width_overrides_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=percent(0.4), height=auto()))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect::new(
        left=percent(0.1),
        right=percent(0.1),
        top=percent(0.05),
        bottom=auto(),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 400.0, 300.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 160.0, 53.0, 40.0, 15.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_child_fill_content_height" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_child_fill_content_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_aspect_ratio(0.5),
    TextMeasure::{ text_content: "HHHH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 20.0, 0.0, 80.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_child_fill_content_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_child_fill_content_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_aspect_ratio(2.0),
    TextMeasure::{ text_content: "HHHH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 20.0, 0.0, 20.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_fill_child_height" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 25.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_fill_child_max_height" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size::new(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
    TextMeasure::{
      text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH",
      writing_mode: Vertical,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 20.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_fill_child_max_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size::new(width=auto(), height=length(20.0)))
    .with_aspect_ratio(2.0),
    TextMeasure::{
      text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 20.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_fill_child_min_height" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_min_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size::new(width=length(50.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_fill_child_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_width.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=auto(), height=length(50.0)))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes_flex" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes_flex.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_auto_columns" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_columns.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default().with_grid_column(
      Line::new(start=line(-3), end=place_auto()),
    ),
  )
  let nodes : Array[NodeId] = [node0]
  for _i in 0..<7 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(100.0)])
    .with_grid_template_columns([length(40.0)])
    .with_grid_auto_columns([length(10.0), length(20.0), length(30.0)])
    .with_grid_auto_flow(grid_auto_flow_column()),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 190.0)
  assert_eq(root_layout.size.height, 100.0)
  let l0 = taffy.layout(nodes[0])
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(nodes[1])
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(nodes[2])
  assert_eq(l2.location.x, 70.0)
  assert_eq(l2.location.y, 0.0)
  let l7 = taffy.layout(nodes[7])
  assert_eq(l7.location.x, 160.0)
  assert_eq(l7.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_auto_columns_fixed_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_columns_fixed_width.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let children : Array[NodeId] = []
  for _ in 0..<16 {
    children.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), auto(), length(40.0), auto()])
    .with_grid_template_columns([length(40.0), auto(), length(40.0), auto()])
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    children,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 200.0, 200.0, 0.0, 0.0)
  let col_w = [40.0, 60.0, 40.0, 60.0]
  let row_h = [40.0, 60.0, 40.0, 60.0]
  let col_x = [0.0, 40.0, 100.0, 140.0]
  let row_y = [0.0, 40.0, 100.0, 140.0]
  for i in 0..<16 {
    let row = i / 4
    let col = i % 4
    assert_layout_xywh(
      taffy,
      children[i],
      col_w[col],
      row_h[row],
      col_x[col],
      row_y[row],
    )
  }
}

///|
test "upstream/generated/grid/grid_auto_fill_fixed_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_fill_fixed_size.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      repeat(repeat_auto_fill(), [length(40.0)]),
    ])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  let l0 = taffy.layout(nodes[0])
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(nodes[1])
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(nodes[2])
  assert_eq(l2.location.x, 80.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_auto_fill_with_empty_auto_track" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_fill_with_empty_auto_track.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_content(justify_content_space_evenly())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([repeat(repeat_auto_fill(), [length(40.0)])])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let l0 = taffy.layout(node0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_auto_fit_with_empty_auto_track" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_fit_with_empty_auto_track.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_content(justify_content_space_evenly())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([repeat(repeat_auto_fit(), [length(40.0)])])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let l0 = taffy.layout(node0)
  assert_eq(l0.location.x, 13.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 67.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_auto_rows" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_rows.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default().with_grid_row(Line::new(start=line(-4), end=place_auto())),
  )
  let nodes : Array[NodeId] = [node0]
  for _i in 0..<7 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([length(100.0)])
    .with_grid_auto_rows([length(10.0), length(20.0), length(30.0)]),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 180.0)
  let l0 = taffy.layout(nodes[0])
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(nodes[1])
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(nodes[2])
  assert_eq(l2.location.y, 50.0)
  let l7 = taffy.layout(nodes[7])
  assert_eq(l7.location.y, 160.0)
}

///|
test "upstream/generated/grid/grid_auto_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_single_item.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=length(100.0), height=auto())),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), auto(), length(40.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 120.0)
  let col_w = [40.0, 100.0, 40.0]
  let row_h = [40.0, 40.0, 40.0]
  let col_x = [0.0, 40.0, 140.0]
  let row_y = [0.0, 40.0, 80.0]
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, col_w[col])
    assert_eq(layout.size.height, row_h[row])
    assert_eq(layout.location.x, col_x[col])
    assert_eq(layout.location.y, row_y[row])
  }
}

///|
test "upstream/generated/grid/grid_auto_single_item_fixed_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_single_item_fixed_width.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default().with_min_size(
      Size::new(width=length(100.0), height=auto()),
    ),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), auto(), auto()])
    .with_size(Size::new(width=length(200.0), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 120.0)
  let col_w = [40.0, 130.0, 30.0]
  let row_h = [40.0, 40.0, 40.0]
  let col_x = [0.0, 40.0, 170.0]
  let row_y = [0.0, 40.0, 80.0]
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, col_w[col])
    assert_eq(layout.size.height, row_h[row])
    assert_eq(layout.location.x, col_x[col])
    assert_eq(layout.location.y, row_y[row])
  }
}

///|
test "upstream/generated/grid/grid_auto_single_item_fixed_width_with_definite_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_single_item_fixed_width_with_definite_width.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=length(100.0), height=auto())),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), auto(), auto()])
    .with_size(Size::new(width=length(200.0), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 120.0)
  let col_x = [0.0, 40.0, 170.0]
  let row_y = [0.0, 40.0, 80.0]
  let expected_w = [40.0, 100.0, 30.0, 40.0, 130.0, 30.0, 40.0, 130.0, 30.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, col_x[col])
    assert_eq(layout.location.y, row_y[row])
  }
}

///|
test "upstream/generated/grid/grid_auto_takes_precedence_over_fr" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_takes_precedence_over_fr.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([auto(), fr(1.0)])
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_available_space_greater_than_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_available_space_greater_than_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(
    root,
    Size::new(width=available_space_definite(400.0), height=max_content()),
    measure_text,
  )
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 160.0)
  assert_eq(root_layout.size.height, 10.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 80.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 80.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_available_space_smaller_than_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_available_space_smaller_than_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(
    root,
    Size::new(width=available_space_definite(80.0), height=max_content()),
    measure_text,
  )
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 80.0)
  assert_eq(root_layout.size.height, 20.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_available_space_smaller_than_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_available_space_smaller_than_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHH\u{200B}HHHH",
    writing_mode: Horizontal,
  })
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHH\u{200B}HHHH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(
    root,
    Size::new(width=available_space_definite(60.0), height=max_content()),
    measure_text,
  )
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 80.0)
  assert_eq(root_layout.size.height, 20.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_basic" {
  // Ported from taffy-reference/tests/generated/grid/grid_basic.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let children : Array[NodeId] = []
  for _ in 0..<9 {
    children.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    children,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    assert_layout_xywh(
      taffy,
      children[i],
      40.0,
      40.0,
      (col * 40).to_double(),
      (row * 40).to_double(),
    )
  }
}

///|
test "upstream/generated/grid/grid_basic_implicit_tracks" {
  // Ported from taffy-reference/tests/generated/grid/grid_basic_implicit_tracks.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(35.0), height=length(35.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([length(40.0)]),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 40.0)
  assert_eq(root_layout.size.height, 75.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 35.0)
  assert_eq(l1.size.height, 35.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 40.0)
}

///|
test "upstream/generated/grid/grid_basic_with_overflow" {
  // Ported from taffy-reference/tests/generated/grid/grid_basic_with_overflow.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let children : Array[NodeId] = []
  for _ in 0..<10 {
    children.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    children,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    assert_layout_xywh(
      taffy,
      children[i],
      40.0,
      40.0,
      (col * 40).to_double(),
      (row * 40).to_double(),
    )
  }
  assert_layout_xywh(taffy, children[9], 40.0, 0.0, 0.0, 120.0)
}

///|
test "upstream/generated/grid/grid_basic_with_padding" {
  // Ported from taffy-reference/tests/generated/grid/grid_basic_with_padding.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let children : Array[NodeId] = []
  for _ in 0..<9 {
    children.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    children,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 180.0, 160.0, 0.0, 0.0)
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    assert_layout_xywh(
      taffy,
      children[i],
      40.0,
      40.0,
      40.0 + (col * 40).to_double(),
      10.0 + (row * 40).to_double(),
    )
  }
}

///|
test "upstream/generated/grid/grid_display_none_fixed_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_display_none_fixed_size.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_none())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_definite_argument" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_definite_argument.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))])
    .with_size(Size::new(width=length(60.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 40.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_definite_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_definite_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))])
    .with_size(Size::new(width=length(60.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_definite_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_definite_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))])
    .with_size(Size::new(width=length(60.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_indefinite_argument" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_argument.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 40.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_indefinite_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 20.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_indefinite_max_content_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_max_content_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point::new(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0),
    TextMeasure::{ text_content: "HH", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 10.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_indefinite_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_indefinite_min_content_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_min_content_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point::new(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0),
    TextMeasure::{ text_content: "HHHH\u{200B}HH", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 30.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_fit_content_points_argument" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_points_argument.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(length(30.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 30.0)
  assert_eq(root_layout.size.height, 40.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 40.0)
}

///|
test "upstream/generated/grid/grid_fit_content_points_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_points_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(length(30.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 20.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
}

///|
test "upstream/generated/grid/grid_fit_content_points_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_points_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(length(30.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 40.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
}

///|
test "upstream/generated/grid/grid_fit_content_points_min_content_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_points_min_content_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point::new(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0),
    TextMeasure::{ text_content: "HHHH\u{200B}HH", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(length(30.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 30.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 30.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_fr_fixed_size_no_content_proportions" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_fixed_size_no_content_proportions.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fr(1.0), fr(2.0), fr(3.0)])
    .with_size(Size::new(width=length(200.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 40.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 33.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 67.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 33.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_fr_fixed_size_no_content_proportions_sub_1_sum" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_fixed_size_no_content_proportions_sub_1_sum.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fr(0.3), fr(0.2)])
    .with_size(Size::new(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 40.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_fr_fixed_size_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_fixed_size_single_item.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=length(100.0), height=auto())),
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), fr(1.0), fr(1.0)])
    .with_grid_template_columns([length(40.0), fr(1.0), fr(1.0)])
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 200.0, 200.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 100.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 60.0, 40.0, 140.0, 0.0)
  assert_layout_xywh(taffy, node3, 40.0, 80.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node4, 100.0, 80.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node5, 60.0, 80.0, 140.0, 40.0)
  assert_layout_xywh(taffy, node6, 40.0, 80.0, 0.0, 120.0)
  assert_layout_xywh(taffy, node7, 100.0, 80.0, 40.0, 120.0)
  assert_layout_xywh(taffy, node8, 60.0, 80.0, 140.0, 120.0)
}

///|
test "upstream/generated/grid/grid_fr_no_sized_items_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_no_sized_items_indefinite.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), fr(1.0), fr(1.0)])
    .with_grid_template_columns([length(40.0), fr(1.0), fr(1.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 0.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node3, 40.0, 0.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node4, 0.0, 0.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node5, 0.0, 0.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node6, 40.0, 0.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node7, 0.0, 0.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node8, 0.0, 0.0, 40.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_single_item_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_single_item_indefinite.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=length(100.0), height=auto())),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), fr(1.0), fr(1.0)])
    .with_grid_template_columns([length(40.0), fr(1.0), fr(1.0)])
    .with_size(Size::new(width=auto(), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 240.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 100.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 100.0, 40.0, 140.0, 0.0)
  assert_layout_xywh(taffy, node3, 40.0, 0.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node4, 100.0, 0.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node5, 100.0, 0.0, 140.0, 40.0)
  assert_layout_xywh(taffy, node6, 40.0, 0.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node7, 100.0, 0.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node8, 100.0, 0.0, 140.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_span_2_proportion" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line::new(start=span(2), end=place_auto()))
    .with_size(Size::new(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([fr(1.0), fr(2.0)]),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 40.0, 40.0, 20.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_span_2_proportion_sub_1_sum" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_sub_1_sum.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line::new(start=span(2), end=place_auto()))
    .with_size(Size::new(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([fr(0.2), fr(0.3)]),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 24.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 36.0, 40.0, 24.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_span_2_proportion_with_non_spanned_track" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_with_non_spanned_track.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line::new(start=span(2), end=place_auto()))
    .with_size(Size::new(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([fr(1.0), fr(2.0), fr(3.0)]),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 40.0, 60.0, 0.0)
  assert_layout_xywh(taffy, node2, 20.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node3, 40.0, 40.0, 20.0, 40.0)
  assert_layout_xywh(taffy, node4, 60.0, 40.0, 60.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_span_2_proportion_zero_sum" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_zero_sum.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line::new(start=span(2), end=place_auto()))
    .with_size(Size::new(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([fr(0.0), fr(0.0)]),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 30.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 30.0, 40.0, 30.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_span_2_proportion_zero_sum_with_non_spanned_track" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_zero_sum_with_non_spanned_track.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line::new(start=span(2), end=place_auto()))
    .with_size(Size::new(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([fr(0.0), fr(0.0), fr(0.0)]),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 40.0, 60.0, 0.0)
  assert_layout_xywh(taffy, node2, 30.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node3, 30.0, 40.0, 30.0, 40.0)
  assert_layout_xywh(taffy, node4, 0.0, 40.0, 60.0, 40.0)
}

///|
test "upstream/generated/grid/grid_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_gap.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes = make_nine_default_grid_children(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_gap(Size::new(width=length(40.0), height=length(40.0)))
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  assert_grid_positions(
    taffy,
    nodes,
    [0.0, 80.0, 160.0],
    [0.0, 80.0, 160.0],
    40.0,
    40.0,
  )
}

///|
test "upstream/generated/grid/grid_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_hidden.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default().with_display(display_none()))
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default().with_display(display_none()))
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default().with_display(display_none()))
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 0.0, 40.0, 40.0, 0.0, 40.0, 0.0, 40.0, 40.0]
  let expected_h = [40.0, 0.0, 40.0, 40.0, 0.0, 40.0, 0.0, 40.0, 40.0]
  let expected_x = [0.0, 0.0, 40.0, 80.0, 0.0, 0.0, 0.0, 40.0, 80.0]
  let expected_y = [0.0, 0.0, 0.0, 0.0, 0.0, 40.0, 0.0, 40.0, 40.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
fn make_nine_default_grid_children(taffy : TaffyTree[Unit]) -> Array[NodeId] {
  [
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
  ]
}

///|
fn assert_grid_positions(
  taffy : TaffyTree[Unit],
  nodes : Array[NodeId],
  expected_x : Array[Double],
  expected_y : Array[Double],
  item_width : Double,
  item_height : Double,
) -> Unit raise Error {
  for row in 0..<3 {
    for col in 0..<3 {
      let idx = row * 3 + col
      let layout = taffy.layout(nodes[idx])
      assert_eq(layout.size.width, item_width)
      assert_eq(layout.size.height, item_height)
      assert_eq(layout.location.x, expected_x[col])
      assert_eq(layout.location.y, expected_y[row])
    }
  }
}

///|
fn run_grid_align_content_test(
  align_content : AlignContent,
  expected_y : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes = make_nine_default_grid_children(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content)
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  assert_grid_positions(taffy, nodes, [0.0, 40.0, 80.0], expected_y, 40.0, 40.0)
}

///|
fn run_grid_align_content_with_padding_border_test(
  align_content : AlignContent,
  expected_y : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes = make_nine_default_grid_children(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content)
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(200.0), height=length(200.0)))
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    )
    .with_border(
      Rect::new(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    ),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  assert_grid_positions(
    taffy,
    nodes,
    [48.0, 88.0, 128.0],
    expected_y,
    40.0,
    40.0,
  )
}

///|
fn run_grid_align_content_negative_space_gap_test(
  align_content : AlignContent,
  expected_y : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes = make_nine_default_grid_children(taffy)
  let inner = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content)
    .with_justify_content(justify_content_center())
    .with_gap(Size::new(width=length(10.0), height=length(10.0)))
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    nodes,
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(240.0), height=length(240.0)))
    .with_border(
      Rect::new(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [inner],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 240.0)
  assert_eq(root_layout.size.height, 240.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let inner_layout = taffy.layout(inner)
  assert_eq(inner_layout.size.width, 120.0)
  assert_eq(inner_layout.size.height, 120.0)
  assert_eq(inner_layout.location.x, 60.0)
  assert_eq(inner_layout.location.y, 60.0)
  assert_grid_positions(
    taffy,
    nodes,
    [20.0, 50.0, 80.0],
    expected_y,
    20.0,
    40.0,
  )
}

///|
fn run_grid_justify_content_test(
  justify_content : JustifyContent,
  expected_x : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes = make_nine_default_grid_children(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_content(justify_content)
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  assert_grid_positions(taffy, nodes, expected_x, [0.0, 40.0, 80.0], 40.0, 40.0)
}

///|
fn run_grid_justify_content_with_padding_border_test(
  justify_content : JustifyContent,
  expected_x : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes = make_nine_default_grid_children(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_content(justify_content)
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(200.0), height=length(200.0)))
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    )
    .with_border(
      Rect::new(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    ),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  assert_grid_positions(
    taffy,
    nodes,
    expected_x,
    [12.0, 52.0, 92.0],
    40.0,
    40.0,
  )
}

///|
fn run_grid_justify_content_negative_space_gap_test(
  justify_content : JustifyContent,
  expected_x : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes = make_nine_default_grid_children(taffy)
  let inner = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content)
    .with_gap(Size::new(width=length(10.0), height=length(10.0)))
    .with_grid_template_rows([length(20.0), length(20.0), length(20.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    nodes,
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size::new(width=length(240.0), height=length(240.0)))
    .with_border(
      Rect::new(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [inner],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 240.0)
  assert_eq(root_layout.size.height, 240.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let inner_layout = taffy.layout(inner)
  assert_eq(inner_layout.size.width, 120.0)
  assert_eq(inner_layout.size.height, 120.0)
  assert_eq(inner_layout.location.x, 60.0)
  assert_eq(inner_layout.location.y, 60.0)
  assert_grid_positions(
    taffy,
    nodes,
    expected_x,
    [20.0, 50.0, 80.0],
    40.0,
    20.0,
  )
}

///|
test "upstream/generated/grid/grid_justify_content_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_center.rs
  run_grid_justify_content_test(justify_content_center(), [40.0, 80.0, 120.0])
}

///|
test "upstream/generated/grid/grid_justify_content_center_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_center_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(justify_content_center(), [
    -10.0, 40.0, 90.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_center_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_center_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(justify_content_center(), [
    52.0, 92.0, 132.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_end.rs
  run_grid_justify_content_test(justify_content_end(), [80.0, 120.0, 160.0])
}

///|
test "upstream/generated/grid/grid_justify_content_end_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_end_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(justify_content_end(), [
    -20.0, 30.0, 80.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_end_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_end_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(justify_content_end(), [
    56.0, 96.0, 136.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_space_around" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_around.rs
  run_grid_justify_content_test(justify_content_space_around(), [
    13.0, 80.0, 147.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_space_around_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_around_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(
    justify_content_space_around(),
    [0.0, 50.0, 100.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_space_around_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_around_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(
    justify_content_space_around(),
    [49.0, 92.0, 135.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_space_between" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_between.rs
  run_grid_justify_content_test(justify_content_space_between(), [
    0.0, 80.0, 160.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_space_between_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_between_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(
    justify_content_space_between(),
    [0.0, 50.0, 100.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_space_between_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_between_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(
    justify_content_space_between(),
    [48.0, 92.0, 136.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_space_evenly" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_evenly.rs
  run_grid_justify_content_test(justify_content_space_evenly(), [
    20.0, 80.0, 140.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_space_evenly_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_evenly_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(
    justify_content_space_evenly(),
    [0.0, 50.0, 100.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_space_evenly_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_evenly_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(
    justify_content_space_evenly(),
    [50.0, 92.0, 134.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_start.rs
  run_grid_justify_content_test(justify_content_start(), [0.0, 40.0, 80.0])
}

///|
test "upstream/generated/grid/grid_justify_content_start_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_start_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(justify_content_start(), [
    0.0, 50.0, 100.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_start_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_start_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(justify_content_start(), [
    48.0, 88.0, 128.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_items_sized_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_items_sized_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_center())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 70.0)
  assert_eq(l1.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_justify_items_sized_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_items_sized_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_end())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 60.0)
  assert_eq(l1.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_justify_items_sized_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_items_sized_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_start())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_justify_items_sized_stretch" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_items_sized_stretch.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_stretch())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_justify_self_sized_all" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_self_sized_all.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_start())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_start())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_end())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_end())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_center())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_center())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_stretch())
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_stretch())
    .with_size(Size::new(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 60.0)
  assert_eq(l3.size.height, 60.0)
  assert_eq(l3.location.x, -20.0)
  assert_eq(l3.location.y, 40.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 40.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 60.0)
  assert_eq(l5.size.height, 60.0)
  assert_eq(l5.location.x, 70.0)
  assert_eq(l5.location.y, 40.0)
  let l6 = taffy.layout(node6)
  assert_eq(l6.size.width, 20.0)
  assert_eq(l6.size.height, 20.0)
  assert_eq(l6.location.x, 0.0)
  assert_eq(l6.location.y, 80.0)
  let l7 = taffy.layout(node7)
  assert_eq(l7.size.width, 60.0)
  assert_eq(l7.size.height, 60.0)
  assert_eq(l7.location.x, 40.0)
  assert_eq(l7.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_margins_auto_margins" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_auto_margins.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_start())
    .with_size(Size::new(width=length(20.0), height=auto()))
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_size(Size::new(width=auto(), height=length(20.0)))
    .with_margin(
      Rect::new(left=length(0.0), right=length(0.0), top=auto(), bottom=auto()),
    ),
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size::new(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=auto(), bottom=auto()),
    ),
  )
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 20.0, 40.0, 40.0, 40.0, 20.0, 40.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 20.0, 40.0, 20.0, 40.0, 40.0]
  let expected_x = [40.0, 80.0, 130.0, 40.0, 80.0, 120.0, 50.0, 80.0, 120.0]
  let expected_y = [10.0, 10.0, 10.0, 50.0, 60.0, 50.0, 100.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_auto_margins_override_stretch" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_auto_margins_override_stretch.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf_with_context(
    Style::default()
    .with_align_self(align_items_stretch())
    .with_justify_self(align_items_stretch())
    .with_margin(
      Rect::new(left=auto(), right=auto(), top=auto(), bottom=auto()),
    ),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 10.0, 40.0, 40.0]
  let expected_x = [40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0]
  let expected_y = [10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 105.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_fixed_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_fixed_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_justify_self(align_items_center())
    .with_size(Size::new(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect::new(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [52.0, 80.0, 120.0, 40.0, 80.0, 120.0]
  let expected_y = [18.0, 10.0, 10.0, 50.0, 50.0, 50.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_fixed_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_fixed_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_end())
    .with_justify_self(align_items_end())
    .with_size(Size::new(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [58.0, 80.0, 120.0, 40.0, 80.0, 120.0]
  let expected_y = [27.0, 10.0, 10.0, 50.0, 50.0, 50.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_fixed_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_fixed_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size::new(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [44.0, 80.0, 120.0, 40.0, 80.0, 120.0]
  let expected_y = [11.0, 10.0, 10.0, 50.0, 50.0, 50.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_fixed_stretch" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_fixed_stretch.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_stretch())
    .with_justify_self(align_items_stretch())
    .with_size(Size::new(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect::new(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect::new(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [44.0, 80.0, 120.0, 40.0, 80.0, 120.0]
  let expected_y = [11.0, 10.0, 10.0, 50.0, 50.0, 50.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_percent_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_percent_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_justify_self(align_items_center())
    .with_size(Size::new(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect::new(
        left=percent(0.2),
        right=percent(0.1),
        top=percent(0.05),
        bottom=percent(0.15),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)]),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [1.0, 20.0, 40.0, 0.0, 20.0, 40.0]
  let expected_y = [9.0, 0.0, 0.0, 40.0, 40.0, 40.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_percent_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_percent_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_end())
    .with_justify_self(align_items_end())
    .with_size(Size::new(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect::new(
        left=percent(0.2),
        right=percent(0.1),
        top=percent(0.05),
        bottom=percent(0.15),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)]),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [-2.0, 20.0, 40.0, 0.0, 20.0, 40.0]
  let expected_y = [17.0, 0.0, 0.0, 40.0, 40.0, 40.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_percent_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_percent_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size::new(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect::new(
        left=percent(0.2),
        right=percent(0.1),
        top=percent(0.05),
        bottom=percent(0.15),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)]),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [4.0, 20.0, 40.0, 0.0, 20.0, 40.0]
  let expected_y = [1.0, 0.0, 0.0, 40.0, 40.0, 40.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_percent_stretch" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_percent_stretch.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_stretch())
    .with_justify_self(align_items_stretch())
    .with_size(Size::new(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect::new(
        left=percent(0.2),
        right=percent(0.1),
        top=percent(0.05),
        bottom=percent(0.15),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)]),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [4.0, 20.0, 40.0, 0.0, 20.0, 40.0]
  let expected_y = [1.0, 0.0, 0.0, 40.0, 40.0, 40.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_maximum_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_maximum_single_item.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(0.0), grid_max_content()),
      length(40.0),
    ]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0]
  let expected_y = [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_max_content(), length(40.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0]
  let expected_y = [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_margin_auto" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_margin_auto.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_margin(
      Rect::new(left=auto(), right=auto(), top=auto(), bottom=auto()),
    ),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_max_content(), length(40.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [40.0, 10.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0]
  let expected_y = [0.0, 15.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_margin_fixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_margin_fixed.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_margin(
      Rect::new(
        left=length(20.0),
        right=length(10.0),
        top=length(5.0),
        bottom=length(15.0),
      ),
    ),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_max_content(), length(40.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 150.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 40.0, 70.0, 40.0, 40.0, 70.0, 40.0]
  let expected_h = [40.0, 20.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 60.0, 110.0, 0.0, 40.0, 110.0, 0.0, 40.0, 110.0]
  let expected_y = [0.0, 5.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_margin_percent" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_margin_percent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_margin(
      Rect::new(
        left=percent(0.2),
        right=percent(0.1),
        top=percent(0.05),
        bottom=percent(0.15),
      ),
    ),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_max_content(), length(40.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 28.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [40.0, 32.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 48.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0]
  let expected_y = [0.0, 2.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_span_2" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_span_2.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(
      Line::new(start=span(2), end=place_auto()),
    ),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      grid_max_content(),
      grid_max_content(),
    ]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 80.0)
  assert_eq(root_layout.size.height, 120.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 20.0, 20.0, 40.0, 20.0, 20.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 0.0]
  let expected_x = [0.0, 40.0, 0.0, 40.0, 60.0, 0.0, 40.0, 60.0, 0.0]
  let expected_y = [0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0, 120.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_span_2_gap_fixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_span_2_gap_fixed.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(
      Line::new(start=span(2), end=place_auto()),
    ),
    TextMeasure::{
      text_content: "HH\u{200B}HH\u{200B}HH",
      writing_mode: Horizontal,
    },
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_gap(Size::new(width=length(20.0), height=length(0.0)))
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      grid_max_content(),
      grid_max_content(),
    ]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 60.0, 40.0, 20.0, 20.0, 40.0, 20.0, 20.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 0.0]
  let expected_x = [0.0, 60.0, 0.0, 60.0, 100.0, 0.0, 60.0, 100.0, 0.0]
  let expected_y = [0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0, 120.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_span_2_gap_percent_definite" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_span_2_gap_percent_definite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(
      Line::new(start=span(2), end=place_auto()),
    ),
    TextMeasure::{
      text_content: "HH\u{200B}HH\u{200B}HH",
      writing_mode: Horizontal,
    },
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_gap(Size::new(width=percent(0.2), height=length(0.0)))
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      grid_max_content(),
      grid_max_content(),
    ])
    .with_size(Size::new(width=length(100.0), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 120.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 60.0, 40.0, 20.0, 20.0, 40.0, 20.0, 20.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 0.0]
  let expected_x = [0.0, 60.0, 0.0, 60.0, 100.0, 0.0, 60.0, 100.0, 0.0]
  let expected_y = [0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0, 120.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_span_2_gap_percent_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_span_2_gap_percent_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(
      Line::new(start=span(2), end=place_auto()),
    ),
    TextMeasure::{
      text_content: "HH\u{200B}HH\u{200B}HH",
      writing_mode: Horizontal,
    },
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_gap(Size::new(width=percent(0.2), height=length(0.0)))
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      grid_max_content(),
      grid_max_content(),
    ]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 120.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 60.0, 40.0, 20.0, 20.0, 40.0, 20.0, 20.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 0.0]
  let expected_x = [0.0, 60.0, 0.0, 60.0, 100.0, 0.0, 60.0, 100.0, 0.0]
  let expected_y = [0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0, 120.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_width_greater_than_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_width_greater_than_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_max_size(Size::new(width=length(400.0), height=auto())),
    [node00, node01],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([grid_max_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 160.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 160.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 80.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 80.0, 10.0, 80.0, 0.0)
}

///|
test "upstream/generated/grid/grid_max_width_less_than_max_content_with_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_width_less_than_max_content_with_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_max_size(Size::new(width=length(80.0), height=auto())),
    [node00, node01],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([grid_min_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 20.0, 40.0, 20.0, 0.0)
}

///|
test "upstream/generated/grid/grid_max_width_smaller_than_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_width_smaller_than_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_max_size(Size::new(width=length(80.0), height=auto())),
    [node00, node01],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([grid_max_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 80.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 80.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 40.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 40.0, 20.0, 40.0, 0.0)
}

///|
test "upstream/generated/grid/grid_max_width_smaller_than_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_width_smaller_than_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHH\u{200B}HHHH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHH\u{200B}HHHH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_max_size(Size::new(width=length(60.0), height=auto())),
    [node00, node01],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([grid_max_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 60.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 40.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 40.0, 20.0, 40.0, 0.0)
}

///|
test "upstream/generated/grid/grid_min_content_flex_column" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node02 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column()),
    [node00, node01, node02],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 20.0, 20.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node02, 20.0, 20.0, 0.0, 40.0)
}

///|
test "upstream/generated/grid/grid_min_content_flex_row" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node02 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_flex()),
    [node00, node01, node02],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 20.0, 40.0, 20.0, 0.0)
  assert_layout_xywh(taffy, node02, 20.0, 40.0, 40.0, 0.0)
}

///|
test "upstream/generated/grid/grid_min_content_flex_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default().with_min_size(Size::new(width=length(10.0), height=auto())),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(
      Line::new(start=span(2), end=place_auto()),
    ),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_min_content(), fr(1.0)]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 80.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 10.0, 30.0, 40.0, 40.0, 40.0, 10.0, 30.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 50.0, 0.0, 40.0, 0.0, 40.0, 50.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_min_content_flex_single_item_margin_auto" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item_margin_auto.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let all_auto_margin = Rect::new(
    left=auto(),
    right=auto(),
    top=auto(),
    bottom=auto(),
  )
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size::new(width=length(10.0), height=auto()))
    .with_margin(all_auto_margin),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_column(Line::new(start=span(2), end=place_auto()))
    .with_margin(all_auto_margin),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_min_content(), fr(1.0)]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 80.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 10.0, 30.0, 40.0, 40.0, 40.0, 10.0, 30.0],
    [40.0, 0.0, 40.0, 40.0, 10.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 50.0, 0.0, 40.0, 0.0, 40.0, 50.0],
    [0.0, 20.0, 0.0, 40.0, 55.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_min_content_flex_single_item_margin_fixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item_margin_fixed.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let fixed_margin = Rect::new(
    left=length(20.0),
    right=length(10.0),
    top=length(5.0),
    bottom=length(15.0),
  )
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size::new(width=length(10.0), height=auto()))
    .with_margin(fixed_margin),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_column(Line::new(start=span(2), end=place_auto()))
    .with_margin(fixed_margin),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_min_content(), fr(1.0)]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 110.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 10.0, 30.0, 40.0, 40.0, 40.0, 40.0, 30.0],
    [40.0, 20.0, 40.0, 40.0, 20.0, 40.0, 40.0, 40.0],
    [0.0, 60.0, 80.0, 0.0, 60.0, 0.0, 40.0, 80.0],
    [0.0, 5.0, 0.0, 40.0, 45.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_min_content_flex_single_item_margin_percent" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item_margin_percent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let percent_margin = Rect::new(
    left=percent(0.2),
    right=percent(0.1),
    top=percent(0.05),
    bottom=percent(0.15),
  )
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size::new(width=length(10.0), height=auto()))
    .with_margin(percent_margin),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_column(Line::new(start=span(2), end=place_auto()))
    .with_margin(percent_margin),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_min_content(), fr(1.0)]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 80.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 10.0, 30.0, 40.0, 28.0, 40.0, 10.0, 30.0],
    [40.0, 38.0, 40.0, 40.0, 32.0, 40.0, 40.0, 40.0],
    [0.0, 42.0, 50.0, 0.0, 48.0, 0.0, 40.0, 50.0],
    [0.0, 1.0, 0.0, 40.0, 42.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_min_content_maximum_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_maximum_single_item.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(0.0), grid_min_content()),
      length(40.0),
    ]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 20.0, 40.0, 40.0, 20.0, 40.0, 40.0, 20.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 60.0, 0.0, 40.0, 60.0, 0.0, 40.0, 60.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_min_content_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_single_item.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_min_content(), length(40.0)]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 20.0, 40.0, 40.0, 20.0, 40.0, 40.0, 20.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 60.0, 0.0, 40.0, 60.0, 0.0, 40.0, 60.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_minmax_auto_fixed_10px" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_auto_fixed_10px.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(auto(), length(10.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 10.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 10.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_auto_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_auto_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(auto(), grid_max_content())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_auto_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_auto_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(auto(), grid_min_content())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_auto_percent_definite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_auto_percent_definite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(auto(), percent(0.2))])
    .with_size(Size::new(width=length(100.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_auto_percent_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_auto_percent_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(auto(), percent(0.2))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 8.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_column_fixed_width_above_range" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_fixed_width_above_range.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(20.0), length(40.0)),
      length(40.0),
    ])
    .with_size(Size::new(width=length(140.0), height=auto())),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 140.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_minmax_column_fixed_width_below_range" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_fixed_width_below_range.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(20.0), length(40.0)),
      length(40.0),
    ])
    .with_size(Size::new(width=length(90.0), height=auto())),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 90.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 20.0, 40.0, 40.0, 20.0, 40.0, 40.0, 20.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 60.0, 0.0, 40.0, 60.0, 0.0, 40.0, 60.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_minmax_column_fixed_width_within_range" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_fixed_width_within_range.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(20.0), length(40.0)),
      length(40.0),
    ])
    .with_size(Size::new(width=length(110.0), height=auto())),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 110.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  // Spot-check a representative item in the second column (should be 30px wide).
  let item = nodes[1]
  let l = taffy.layout(item)
  assert_eq(l.size.width, 30.0)
  assert_eq(l.size.height, 40.0)
  assert_eq(l.location.x, 40.0)
  assert_eq(l.location.y, 0.0)
  // Spot-check a representative item in the third column (fixed 40px).
  let item2 = nodes[2]
  let l2 = taffy.layout(item2)
  assert_eq(l2.size.width, 40.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 70.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_column_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_indefinite.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(20.0), length(40.0)),
      length(40.0),
    ]),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_minmax_column_with_auto_fixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_with_auto_fixed.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(length(20.0), length(40.0)), auto()])
    .with_size(Size::new(width=length(60.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 40.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_column_with_fr_fixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_with_fr_fixed.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(length(20.0), length(40.0)), fr(1.0)])
    .with_size(Size::new(width=length(60.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 40.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_1fr" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_1fr.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), fr(1.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_auto" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_auto.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), auto())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_fixed_10px" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_fixed_10px.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), length(10.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), grid_min_content())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_percent_definite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_percent_definite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), percent(0.2))])
    .with_size(Size::new(width=length(100.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_percent_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_percent_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), percent(0.2))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_1fr" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_1fr.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), fr(1.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_auto" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_auto.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), auto())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_fixed_10px" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_fixed_10px.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), length(10.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), grid_max_content())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_percent_definite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_percent_definite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), percent(0.2))])
    .with_size(Size::new(width=length(100.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_percent_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_percent_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), percent(0.2))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_out_of_order_items" {
  // Ported from taffy-reference/tests/generated/grid/grid_out_of_order_items.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line::new(start=line(1), end=place_auto()))
    .with_size(Size::new(width=length(35.0), height=length(35.0))),
  )
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line::new(start=line(1), end=place_auto()))
    .with_grid_column(Line::new(start=line(1), end=place_auto()))
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line::new(start=line(1), end=place_auto()))
    .with_size(Size::new(width=length(10.0), height=length(10.0))),
  )
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_grid_auto_flow(grid_auto_flow_row_dense())
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 80.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 40.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 35.0)
  assert_eq(l2.size.height, 35.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 80.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 40.0)
  assert_eq(l3.size.height, 40.0)
  assert_eq(l3.location.x, 40.0)
  assert_eq(l3.location.y, 40.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 40.0)
  assert_eq(l4.size.height, 40.0)
  assert_eq(l4.location.x, 80.0)
  assert_eq(l4.location.y, 40.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 0.0)
  assert_eq(l5.location.y, 0.0)
  let l6 = taffy.layout(node6)
  assert_eq(l6.size.width, 40.0)
  assert_eq(l6.size.height, 40.0)
  assert_eq(l6.location.x, 40.0)
  assert_eq(l6.location.y, 80.0)
  let l7 = taffy.layout(node7)
  assert_eq(l7.size.width, 10.0)
  assert_eq(l7.size.height, 10.0)
  assert_eq(l7.location.x, 40.0)
  assert_eq(l7.location.y, 0.0)
  let l8 = taffy.layout(node8)
  assert_eq(l8.size.width, 40.0)
  assert_eq(l8.size.height, 40.0)
  assert_eq(l8.location.x, 80.0)
  assert_eq(l8.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_overflow_inline_axis_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_inline_axis_hidden.rs
  ()
}

///|
test "upstream/generated/grid/grid_overflow_inline_axis_scroll" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_inline_axis_scroll.rs
  ()
}

///|
test "upstream/generated/grid/grid_overflow_inline_axis_visible" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_inline_axis_visible.rs
  ()
}

///|
test "upstream/generated/grid/grid_overflow_rows" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_rows.rs
  ()
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_overridden_by_available_space" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_overridden_by_available_space.rs
  ()
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_overridden_by_max_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_overridden_by_max_size.rs
  ()
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_overridden_by_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_overridden_by_size.rs
  ()
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_take_up_space_both_axis" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_take_up_space_both_axis.rs
  ()
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_take_up_space_x_axis" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_take_up_space_x_axis.rs
  ()
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_take_up_space_y_axis" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_take_up_space_y_axis.rs
  ()
}

///|
test "upstream/generated/grid/grid_padding_border_overrides_container_max_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_padding_border_overrides_container_max_size.rs
  ()
}

///|
test "upstream/generated/grid/grid_padding_border_overrides_container_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_padding_border_overrides_container_size.rs
  ()
}

///|
test "upstream/generated/grid/grid_padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_padding_border_overrides_max_size.rs
  ()
}

///|
test "upstream/generated/grid/grid_padding_border_overrides_min_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_padding_border_overrides_min_size.rs
  ()
}

///|
test "upstream/generated/grid/grid_padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_padding_border_overrides_size.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_item_inside_stretch_item" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_item_inside_stretch_item.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_items_nested_inside_stretch_alignment" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_nested_inside_stretch_alignment.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_items_nested_moderate" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_nested_moderate.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_items_nested_with_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_nested_with_margin.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_items_nested_with_padding_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_nested_with_padding_margin.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_items_width_and_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_width_and_margin.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_items_width_and_padding" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_width_and_padding.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_tracks_definite_overflow" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_tracks_definite_overflow.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_tracks_definite_underflow" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_tracks_definite_underflow.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_tracks_indefinite_only" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_tracks_indefinite_only.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_tracks_indefinite_with_content_overflow" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_tracks_indefinite_with_content_overflow.rs
  ()
}

///|
test "upstream/generated/grid/grid_percent_tracks_indefinite_with_content_underflow" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_tracks_indefinite_with_content_underflow.rs
  ()
}

///|
test "upstream/generated/grid/grid_placement_auto_negative" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_placement_auto_negative.rs
  ()
}

///|
test "upstream/generated/grid/grid_placement_definite_in_secondary_axis_with_fully_definite_negative" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_placement_definite_in_secondary_axis_with_fully_definite_negative.rs
  ()
}

///|
test "upstream/generated/grid/grid_relative_all_sides" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_relative_all_sides.rs
  ()
}

///|
test "upstream/generated/grid/grid_relayout_vertical_text" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_relayout_vertical_text.rs
  ()
}

///|
test "upstream/generated/grid/grid_repeat_integer" {
  // Ported from taffy-reference/tests/generated/grid/grid_repeat_integer.rs
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([repeat(repeat_count(3), [length(40.0)])])
    .with_grid_template_columns([repeat(repeat_count(3), [length(40.0)])])
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  let l8 = taffy.layout(nodes[8])
  assert_eq(l8.location.x, 80.0)
  assert_eq(l8.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_repeat_mixed" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_repeat_mixed.rs
  ()
}

///|
test "upstream/generated/grid/grid_size_child_fixed_tracks" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_size_child_fixed_tracks.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite_hidden.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_max_content_auto_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_auto_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_max_content_auto_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_auto_indefinite_hidden.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite_hidden.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite_hidden.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_max_content_max_content_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_max_content_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_min_content_auto_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_auto_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_min_content_auto_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_auto_indefinite_hidden.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite_hidden.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite_hidden.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite_hidden.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_min_content_max_content_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_max_content_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_2_min_content_min_content_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_min_content_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_6_all_non_flex_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_6_all_non_flex_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_6_all_non_flex_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_6_all_non_flex_indefinite_hidden.rs
  ()
}

///|
test "upstream/generated/grid/grid_span_8_all_track_types_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_8_all_track_types_indefinite.rs
  ()
}

///|
test "upstream/generated/grid/grid_taffy_issue_624" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_taffy_issue_624.rs
  ()
}

///|
test "upstream/generated/grid/mod" {
  // TODO: port from taffy-reference/tests/generated/grid/mod.rs
  ()
}

///|
test "upstream/generated/gridflex/gridflex_column_integration" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_column_integration.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node02 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node03 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([fr(1.0), fr(1.0)])
    .with_grid_template_columns([fr(1.0), fr(1.0)]),
    [node00, node01, node02, node03],
  )
  let node = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 40.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 20.0)
  assert_eq(l01.size.height, 10.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 0.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 20.0)
  assert_eq(l02.size.height, 10.0)
  assert_eq(l02.location.x, 0.0)
  assert_eq(l02.location.y, 10.0)
  let l03 = taffy.layout(node03)
  assert_eq(l03.size.width, 20.0)
  assert_eq(l03.size.height, 10.0)
  assert_eq(l03.location.x, 20.0)
  assert_eq(l03.location.y, 10.0)
}

///|
test "upstream/generated/gridflex/gridflex_kitchen_sink" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=length(20.0), height=auto())),
  )
  let node00100 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=length(20.0), height=auto())),
  )
  let node00101 = taffy.new_leaf(Style::default())
  let node00102 = taffy.new_leaf(Style::default())
  let node00103 = taffy.new_leaf(Style::default())
  let node0010 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([percent(0.3), percent(0.1)])
    .with_grid_template_columns([auto(), percent(0.1)]),
    [node00100, node00101, node00102, node00103],
  )
  let node001 = taffy.new_with_children(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0010],
  )
  let node00 = taffy.new_with_children(Style::default(), [node000, node001])
  let node01 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node02 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node03 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([fr(1.0), fr(1.0)])
    .with_grid_template_columns([fr(1.0), fr(1.0)]),
    [node00, node01, node02, node03],
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 140.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 140.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 70.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 20.0)
  assert_eq(l000.size.height, 10.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
  let l001 = taffy.layout(node001)
  assert_eq(l001.size.width, 50.0)
  assert_eq(l001.size.height, 10.0)
  assert_eq(l001.location.x, 20.0)
  assert_eq(l001.location.y, 0.0)
  let l0010 = taffy.layout(node0010)
  assert_eq(l0010.size.width, 20.0)
  assert_eq(l0010.size.height, 10.0)
  assert_eq(l0010.location.x, 0.0)
  assert_eq(l0010.location.y, 0.0)
  let l00100 = taffy.layout(node00100)
  assert_eq(l00100.size.width, 20.0)
  assert_eq(l00100.size.height, 3.0)
  assert_eq(l00100.location.x, 0.0)
  assert_eq(l00100.location.y, 0.0)
  let l00101 = taffy.layout(node00101)
  assert_eq(l00101.size.width, 2.0)
  assert_eq(l00101.size.height, 3.0)
  assert_eq(l00101.location.x, 20.0)
  assert_eq(l00101.location.y, 0.0)
  let l00102 = taffy.layout(node00102)
  assert_eq(l00102.size.width, 20.0)
  assert_eq(l00102.size.height, 1.0)
  assert_eq(l00102.location.x, 0.0)
  assert_eq(l00102.location.y, 3.0)
  let l00103 = taffy.layout(node00103)
  assert_eq(l00103.size.width, 2.0)
  assert_eq(l00103.size.height, 1.0)
  assert_eq(l00103.location.x, 20.0)
  assert_eq(l00103.location.y, 3.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 70.0)
  assert_eq(l01.size.height, 10.0)
  assert_eq(l01.location.x, 70.0)
  assert_eq(l01.location.y, 0.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 70.0)
  assert_eq(l02.size.height, 10.0)
  assert_eq(l02.location.x, 0.0)
  assert_eq(l02.location.y, 10.0)
  let l03 = taffy.layout(node03)
  assert_eq(l03.size.width, 70.0)
  assert_eq(l03.size.height, 10.0)
  assert_eq(l03.location.x, 70.0)
  assert_eq(l03.location.y, 10.0)
}

///|
test "upstream/generated/gridflex/gridflex_kitchen_sink_minimise" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink_minimise.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=length(50.0), height=auto())),
  )
  let node01 = taffy.new_leaf(Style::default())
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(20.0)])
    .with_grid_template_columns([fr(1.0), fr(1.0)]),
    [node00, node01],
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 50.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 50.0)
  assert_eq(l01.location.y, 0.0)
}

///|
test "upstream/generated/gridflex/gridflex_kitchen_sink_minimise2" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink_minimise2.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([auto()])
    .with_grid_template_columns([auto()]),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/gridflex/gridflex_kitchen_sink_minimise3" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink_minimise3.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(20.0)),
    ),
  )
  let node01 = taffy.new_leaf(Style::default())
  let node02 = taffy.new_leaf(Style::default())
  let node03 = taffy.new_leaf(Style::default())
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([percent(0.3), percent(0.1)])
    .with_grid_template_columns([auto(), percent(0.1)]),
    [node00, node01, node02, node03],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size::new(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 2.0)
  assert_eq(l01.size.height, 6.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 0.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 20.0)
  assert_eq(l02.size.height, 2.0)
  assert_eq(l02.location.x, 0.0)
  assert_eq(l02.location.y, 6.0)
  let l03 = taffy.layout(node03)
  assert_eq(l03.size.width, 2.0)
  assert_eq(l03.size.height, 2.0)
  assert_eq(l03.location.x, 20.0)
  assert_eq(l03.location.y, 6.0)
}

///|
test "upstream/generated/gridflex/gridflex_row_integration" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_row_integration.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node00 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node02 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node03 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([fr(1.0), fr(1.0)])
    .with_grid_template_columns([fr(1.0), fr(1.0)]),
    [node00, node01, node02, node03],
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 40.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 20.0)
  assert_eq(l01.size.height, 10.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 0.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 20.0)
  assert_eq(l02.size.height, 10.0)
  assert_eq(l02.location.x, 0.0)
  assert_eq(l02.location.y, 10.0)
  let l03 = taffy.layout(node03)
  assert_eq(l03.size.width, 20.0)
  assert_eq(l03.size.height, 10.0)
  assert_eq(l03.location.x, 20.0)
  assert_eq(l03.location.y, 10.0)
}

///|
test "upstream/generated/gridflex/mod" {
  // TODO: port from taffy-reference/tests/generated/gridflex/mod.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_affect_available_space_x_axis" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_affect_available_space_x_axis.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_affect_available_space_y_axis" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_affect_available_space_y_axis.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_overridden_by_available_space" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_overridden_by_available_space.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_overridden_by_max_size" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_overridden_by_max_size.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_overridden_by_size" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_overridden_by_size.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_take_up_space_both_axis" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_take_up_space_both_axis.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_take_up_space_x_axis" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_take_up_space_x_axis.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_take_up_space_y_axis" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_take_up_space_y_axis.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_padding_border_overrides_max_size.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_padding_border_overrides_min_size" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_padding_border_overrides_min_size.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_padding_border_overrides_size.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_with_content_and_border" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_with_content_and_border.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_with_content_and_padding" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_with_content_and_padding.rs
  ()
}

///|
test "upstream/generated/leaf/leaf_with_content_and_padding_border" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_with_content_and_padding_border.rs
  ()
}

///|
test "upstream/generated/leaf/mod" {
  // TODO: port from taffy-reference/tests/generated/leaf/mod.rs
  ()
}

///|
test "upstream/generated/./mod" {
  // TODO: port from taffy-reference/tests/generated/mod.rs
  ()
}
