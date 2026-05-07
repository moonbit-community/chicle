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
test "upstream/generated/block/block_display_none_with_margin" {
  // Ported from taffy-reference/tests/generated/block/block_display_none_with_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_none())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_none())
    .with_position(position_absolute())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
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
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 0.0)
  assert_eq(c0.size.height, 0.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_inset_fixed" {
  // Ported from taffy-reference/tests/generated/block/block_inset_fixed.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(left=length(2.0), right=auto(), top=length(4.0), bottom=auto()),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=length(6.0), top=auto(), bottom=length(8.0)),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(left=percent(0.02), right=auto(), top=percent(0.04), bottom=auto()),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=percent(0.06), top=auto(), bottom=percent(0.08)),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size(width=auto(), height=length(50.0)))
    .with_max_size(Size(width=length(100.0), height=auto())),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size(width=auto(), height=length(50.0)))
    .with_max_size(Size(width=length(300.0), height=auto())),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(200.0), height=length(200.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size(width=auto(), height=length(50.0)))
    .with_min_size(Size(width=length(200.0), height=auto()))
    .with_max_size(Size(width=length(50.0), height=auto())),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
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
  let c0 = taffy.layout(node0)
  assert_eq(c0.size.width, 200.0)
  assert_eq(c0.size.height, 50.0)
  assert_eq(c0.location.x, 0.0)
  assert_eq(c0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_auto_bottom" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=auto(), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=auto(), right=length(0.0), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_size(Size(width=auto(), height=length(50.0)))
    .with_max_size(Size(width=length(100.0), height=auto()))
    .with_margin(
      Rect(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(200.0), height=length(200.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
test "upstream/generated/block/block_margin_auto_left_fix_right_child_bigger_than_parent" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_left_fix_right_child_bigger_than_parent.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
test "upstream/generated/block/block_margin_auto_left_right_child_bigger_than_parent" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_left_right_child_bigger_than_parent.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
test "upstream/generated/block/block_margin_auto_multiple_children" {
  // Ported from taffy-reference/tests/generated/block/block_margin_auto_multiple_children.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(100.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_align_items(align_items_center())
    .with_size(Size(width=length(200.0), height=length(200.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(20.0), height=length(10.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(20.0), height=length(10.0)))
    .with_margin(
      Rect(left=auto(), right=length(0.0), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(20.0), height=length(10.0)))
    .with_margin(
      Rect(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(20.0), height=length(10.0)))
    .with_margin(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(20.0), height=length(10.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(-10.0),
        right=length(-5.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(5.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
