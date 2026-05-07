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
test "upstream/generated/block/block_absolute_margin_auto_bottom_and_top_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_and_top_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=auto(), bottom=auto()),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_bottom_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=length(0.0), bottom=auto()),
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
  assert_eq(c.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_bottom_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=length(0.0), bottom=auto()),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_and_right_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_and_right_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    )
    .with_inset(
      Rect(left=length(10.0), right=length(20.0), top=auto(), bottom=auto()),
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
  assert_eq(c.location.x, 70.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_and_right_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_and_right_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_child_bigger_than_parent_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_child_bigger_than_parent_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect(left=auto(), right=length(0.0), top=length(0.0), bottom=length(0.0)),
    )
    .with_inset(
      Rect(left=length(10.0), right=length(20.0), top=auto(), bottom=auto()),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(52.0), height=length(52.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect(left=auto(), right=length(0.0), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(52.0), height=length(52.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect(left=auto(), right=length(10.0), top=length(0.0), bottom=length(0.0)),
    )
    .with_inset(
      Rect(left=length(10.0), right=length(20.0), top=auto(), bottom=auto()),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(52.0), height=length(52.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect(left=auto(), right=length(10.0), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(52.0), height=length(52.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    )
    .with_inset(
      Rect(left=length(10.0), right=length(20.0), top=auto(), bottom=auto()),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(52.0), height=length(52.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(52.0), height=length(52.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=auto(), right=length(0.0), top=length(0.0), bottom=length(0.0)),
    )
    .with_inset(
      Rect(left=length(10.0), right=length(20.0), top=auto(), bottom=auto()),
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
  assert_eq(c.location.x, 130.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_left_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=auto(), right=length(0.0), top=length(0.0), bottom=length(0.0)),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_multiple_children_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_multiple_children_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(100.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=length(0.0)),
    )
    .with_inset(
      Rect(left=length(10.0), right=length(20.0), top=auto(), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=length(0.0)),
    )
    .with_inset(
      Rect(left=length(20.0), right=length(10.0), top=auto(), bottom=auto()),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_align_items(align_items_center())
    .with_size(Size(width=length(200.0), height=length(200.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(100.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_align_items(align_items_center())
    .with_size(Size(width=length(200.0), height=length(200.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=length(0.0)),
    )
    .with_inset(
      Rect(left=length(10.0), right=length(20.0), top=auto(), bottom=auto()),
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
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_right_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_right_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=length(0.0)),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_top_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_top_with_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=auto(), bottom=length(0.0)),
    )
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(20.0), bottom=length(10.0)),
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
  assert_eq(c.location.y, 140.0)
}

///|
test "upstream/generated/block/block_absolute_margin_auto_top_without_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_auto_top_without_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=auto(), bottom=length(0.0)),
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
  assert_eq(c.location.y, 0.0)
}

///|
test "upstream/generated/block/block_absolute_margin_bottom_left_with_inset" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_margin_bottom_left_with_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect(
        left=length(20.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(20.0),
      ),
    ),
    { text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    { text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_max_size(Size(width=length(40.0), height=length(30.0)))
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
  assert_eq(c.size.width, 40.0)
  assert_eq(c.size.height, 30.0)
  assert_eq(c.location.x, 50.0)
  assert_eq(c.location.y, 60.0)
}

///|
test "upstream/generated/block/block_absolute_minmax_bottom_right_min_max" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_minmax_bottom_right_min_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_min_size(Size(width=length(50.0), height=length(60.0)))
    .with_max_size(Size(width=length(40.0), height=length(30.0)))
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
  assert_eq(c.size.width, 50.0)
  assert_eq(c.size.height, 60.0)
  assert_eq(c.location.x, 40.0)
  assert_eq(c.location.y, 30.0)
}

///|
test "upstream/generated/block/block_absolute_minmax_bottom_right_min_max_preferred" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_minmax_bottom_right_min_max_preferred.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(200.0), height=length(200.0)))
    .with_min_size(Size(width=length(50.0), height=length(60.0)))
    .with_max_size(Size(width=length(40.0), height=length(30.0)))
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
  assert_eq(c.size.width, 50.0)
  assert_eq(c.size.height, 60.0)
  assert_eq(c.location.x, 40.0)
  assert_eq(c.location.y, 30.0)
}

///|
test "upstream/generated/block/block_absolute_minmax_top_left_bottom_right_max" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_minmax_top_left_bottom_right_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_max_size(Size(width=length(40.0), height=length(30.0)))
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
  assert_eq(c.size.width, 40.0)
  assert_eq(c.size.height, 30.0)
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 10.0)
}
