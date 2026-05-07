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
test "upstream/generated/block/block_absolute_minmax_top_left_bottom_right_min_max" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_minmax_top_left_bottom_right_min_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_min_size(Size(width=length(50.0), height=length(60.0)))
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
  assert_eq(c.size.width, 50.0)
  assert_eq(c.size.height, 60.0)
  assert_eq(c.location.x, 10.0)
  assert_eq(c.location.y, 10.0)
}

///|
test "upstream/generated/block/block_absolute_no_styles" {
  // Ported from taffy-reference/tests/generated/block/block_absolute_no_styles.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(10.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_max_size(Size(width=length(12.0), height=length(12.0)))
    .with_padding(
      Rect(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    )
    .with_border(
      Rect(
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(12.0), height=length(12.0)))
    .with_padding(
      Rect(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    )
    .with_border(
      Rect(
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(10.0)))
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=length(10.0)))
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(20.0)))
    .with_padding(
      Rect(
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
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect(
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(10.0), bottom=auto()),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(20.0)))
    .with_inset(Rect(left=auto(), right=auto(), top=length(5.0), bottom=auto())),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node00],
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(15.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_max_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
    {
      text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
test "upstream/generated/block/block_aspect_ratio_fill_max_width" {
  // Ported from taffy-reference/tests/generated/block/block_aspect_ratio_fill_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_max_size(Size(width=auto(), height=length(20.0)))
    .with_aspect_ratio(2.0),
    {
      text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_min_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_min_size(Size(width=auto(), height=length(40.0)))
    .with_aspect_ratio(2.0),
    { text_content: "", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(40.0)))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_border(
      Rect(
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_border(
      Rect(
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_none())
    .with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node10 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=length(20.0), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_with_children(
    Style::default().with_display(display_none()),
    [node10],
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
    { text_content: "", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_none())
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(10.0), bottom=auto()),
    ),
    { text_content: "", writing_mode: Horizontal },
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
