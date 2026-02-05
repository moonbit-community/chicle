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
#skip
test "upstream/generated/block/block_absolute_aspect_ratio_aspect_ratio_overrides_height_of_full_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_aspect_ratio_overrides_height_of_full_inset.rs
  ()
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
#skip
test "upstream/generated/block/block_absolute_aspect_ratio_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_aspect_ratio_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_aspect_ratio_fill_min_height" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_min_height.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_aspect_ratio_fill_min_width" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_fill_min_width.rs
  ()
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
#skip
test "upstream/generated/block/block_absolute_aspect_ratio_height_overrides_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_height_overrides_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_aspect_ratio_width_overrides_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_aspect_ratio_width_overrides_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_child_with_margin_x" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_child_with_margin_x.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_child_with_margin_y" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_child_with_margin_y.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_child_with_max_height" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_child_with_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_layout_child_order" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_layout_child_order.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_layout_no_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_layout_no_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_layout_percentage_bottom_based_on_parent_height" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_layout_percentage_bottom_based_on_parent_height.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_layout_percentage_height" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_layout_percentage_height.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_layout_row_width_height_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_layout_row_width_height_end_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_layout_start_top_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_layout_start_top_end_bottom.rs
  ()
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
#skip
test "upstream/generated/block/block_absolute_layout_width_height_start_top_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_layout_width_height_start_top_end_bottom.rs
  ()
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
#skip
test "upstream/generated/block/block_absolute_margin_auto_bottom_and_top_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_and_top_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_bottom_and_top_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_and_top_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_bottom_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_bottom_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_bottom_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_left_and_right_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_and_right_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_left_and_right_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_and_right_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_left_child_bigger_than_parent_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_child_bigger_than_parent_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_left_child_bigger_than_parent_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_child_bigger_than_parent_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_left_fix_right_child_bigger_than_parent_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_fix_right_child_bigger_than_parent_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_left_fix_right_child_bigger_than_parent_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_fix_right_child_bigger_than_parent_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_left_right_child_bigger_than_parent_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_right_child_bigger_than_parent_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_left_right_child_bigger_than_parent_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_right_child_bigger_than_parent_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_left_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_left_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_left_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_multiple_children_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_multiple_children_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_multiple_children_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_multiple_children_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_right_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_right_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_right_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_right_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_top_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_top_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_auto_top_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_auto_top_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_bottom_left_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_bottom_left_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_margin_bottom_left_without_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_margin_bottom_left_without_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_minmax_bottom_right_max" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_minmax_bottom_right_max.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_minmax_bottom_right_min_max" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_minmax_bottom_right_min_max.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_minmax_bottom_right_min_max_preferred" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_minmax_bottom_right_min_max_preferred.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_minmax_top_left_bottom_right_max" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_minmax_top_left_bottom_right_max.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_minmax_top_left_bottom_right_min_max" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_minmax_top_left_bottom_right_min_max.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_no_styles" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_no_styles.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_padding_border_overrides_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_absolute_padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_absolute_padding_border_overrides_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_align_baseline_child" {
  // TODO: port from taffy-reference/tests/generated/block/block_align_baseline_child.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_align_baseline_child_margin" {
  // TODO: port from taffy-reference/tests/generated/block/block_align_baseline_child_margin.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_align_baseline_child_margin_percent" {
  // TODO: port from taffy-reference/tests/generated/block/block_align_baseline_child_margin_percent.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_align_baseline_child_padding" {
  // TODO: port from taffy-reference/tests/generated/block/block_align_baseline_child_padding.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_align_baseline_child_top" {
  // TODO: port from taffy-reference/tests/generated/block/block_align_baseline_child_top.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_align_baseline_child_top2" {
  // TODO: port from taffy-reference/tests/generated/block/block_align_baseline_child_top2.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_align_baseline_double_nested_child" {
  // TODO: port from taffy-reference/tests/generated/block/block_align_baseline_double_nested_child.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_aspect_ratio_fill_height" {
  // TODO: port from taffy-reference/tests/generated/block/block_aspect_ratio_fill_height.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_aspect_ratio_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/block/block_aspect_ratio_fill_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_aspect_ratio_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/block/block_aspect_ratio_fill_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_aspect_ratio_fill_min_height" {
  // TODO: port from taffy-reference/tests/generated/block/block_aspect_ratio_fill_min_height.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_aspect_ratio_fill_min_width" {
  // TODO: port from taffy-reference/tests/generated/block/block_aspect_ratio_fill_min_width.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_aspect_ratio_fill_width" {
  // TODO: port from taffy-reference/tests/generated/block/block_aspect_ratio_fill_width.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_basic" {
  // TODO: port from taffy-reference/tests/generated/block/block_basic.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_border_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_border_fixed_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_border_intrinsic_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_border_intrinsic_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_border_percentage_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_border_percentage_fixed_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_border_percentage_intrinsic_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_border_percentage_intrinsic_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_display_none" {
  // TODO: port from taffy-reference/tests/generated/block/block_display_none.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_display_none_with_child" {
  // TODO: port from taffy-reference/tests/generated/block/block_display_none_with_child.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_display_none_with_inset" {
  // TODO: port from taffy-reference/tests/generated/block/block_display_none_with_inset.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_display_none_with_margin" {
  // TODO: port from taffy-reference/tests/generated/block/block_display_none_with_margin.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_display_none_with_position_absolute" {
  // TODO: port from taffy-reference/tests/generated/block/block_display_none_with_position_absolute.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_inset_fixed" {
  // TODO: port from taffy-reference/tests/generated/block/block_inset_fixed.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_inset_percentage" {
  // TODO: port from taffy-reference/tests/generated/block/block_inset_percentage.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_intrinsic_width" {
  // TODO: port from taffy-reference/tests/generated/block/block_intrinsic_width.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_item_max_width" {
  // TODO: port from taffy-reference/tests/generated/block/block_item_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_item_min_width_overrides_max_width" {
  // TODO: port from taffy-reference/tests/generated/block/block_item_min_width_overrides_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_bottom_and_top" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_bottom_and_top.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_left" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_left.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_left_and_right" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_left_and_right.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_left_and_right_with_auto_width" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_left_and_right_with_auto_width.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_left_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_left_child_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_left_fix_right_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_left_fix_right_child_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_left_right_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_left_right_child_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_multiple_children" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_multiple_children.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_right" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_right.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_auto_top" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_auto_top.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_fixed_auto_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_fixed_auto_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_fixed_auto_left" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_fixed_auto_left.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_fixed_auto_left_and_right" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_fixed_auto_left_and_right.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_fixed_auto_right" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_fixed_auto_right.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_fixed_auto_top" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_fixed_auto_top.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_fixed_size_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_fixed_size_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_fixed_size_positive" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_fixed_size_positive.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_intrinsic_size_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_intrinsic_size_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_intrinsic_size_positive" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_intrinsic_size_positive.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_percentage_fixed_size_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_percentage_fixed_size_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_percentage_fixed_size_positive" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_percentage_fixed_size_positive.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_percentage_intrinsic_size_other_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_percentage_intrinsic_size_other_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_percentage_intrinsic_size_other_positive" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_percentage_intrinsic_size_other_positive.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_percentage_intrinsic_size_self_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_percentage_intrinsic_size_self_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_x_percentage_intrinsic_size_self_positive" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_x_percentage_intrinsic_size_self_positive.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_complex" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_complex.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_aspect_ratio" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_aspect_ratio.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_border_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_border_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_border_top" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_border_top.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_height" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_height.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_line_box" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_line_box.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_line_box_with_height_zero" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_line_box_with_height_zero.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_line_box_with_max_height_zero" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_line_box_with_max_height_zero.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_min_height" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_min_height.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_overflow_x_hidden" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_overflow_x_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_overflow_x_scroll" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_overflow_x_scroll.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_overflow_y_hidden" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_overflow_y_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_overflow_y_scroll" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_overflow_y_scroll.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_padding_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_padding_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_padding_top" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_padding_top.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_positive" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_positive.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_positive_and_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_positive_and_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_collapse_through_with_absolute_child" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_collapse_through_with_absolute_child.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_border_top" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_border_top.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_x_hidden" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_x_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_x_scroll" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_x_scroll.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_y_hidden" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_y_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_y_scroll" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_overflow_y_scroll.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_blocked_by_padding_top" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_blocked_by_padding_top.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_negative_equal" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_negative_equal.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_negative_parent_larger" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_negative_parent_larger.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_negative_parent_smaller" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_negative_parent_smaller.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_not_blocked_by_border_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_not_blocked_by_border_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_not_blocked_by_padding_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_not_blocked_by_padding_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_positive_and_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_positive_and_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_positive_equal" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_positive_equal.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_positive_parent_larger" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_positive_parent_larger.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_child_collapse_positive_parent_smaller" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_child_collapse_positive_parent_smaller.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_granchild_collapse_positive_and_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_granchild_collapse_positive_and_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_first_granchild_collapse_positive_equal" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_first_granchild_collapse_positive_equal.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_border_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_border_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_x_hidden" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_x_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_x_scroll" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_x_scroll.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_y_hidden" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_y_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_y_scroll" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_overflow_y_scroll.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_blocked_by_padding_bottom" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_blocked_by_padding_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_negative_equal" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_negative_equal.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_negative_parent_larger" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_negative_parent_larger.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_negative_parent_smaller" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_negative_parent_smaller.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_not_blocked_by_border_top" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_not_blocked_by_border_top.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_not_blocked_by_padding_top" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_not_blocked_by_padding_top.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_positive_and_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_positive_and_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_positive_equal" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_positive_equal.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_positive_parent_larger" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_positive_parent_larger.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_child_collapse_positive_parent_smaller" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_positive_parent_smaller.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_last_granchild_collapse_positive_equal" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_last_granchild_collapse_positive_equal.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_sibling_collapse_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_sibling_collapse_negative_percentage" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_negative_percentage.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_sibling_collapse_positive" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_sibling_collapse_positive_and_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive_and_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_sibling_collapse_positive_and_negative_percentage" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive_and_negative_percentage.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_sibling_collapse_positive_percentage" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive_percentage.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_simple_negative" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_simple_negative.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_simple_negative_percentage_other" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_simple_negative_percentage_other.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_simple_negative_percentage_self" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_simple_negative_percentage_self.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_simple_positive" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_simple_positive.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_simple_positive_percentage_other" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_simple_positive_percentage_other.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_simple_positive_percentage_self" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_simple_positive_percentage_self.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_total_collapse" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_total_collapse.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_margin_y_total_collapse_complex" {
  // TODO: port from taffy-reference/tests/generated/block/block_margin_y_total_collapse_complex.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_overflow_scrollbars_overridden_by_available_space" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_overridden_by_available_space.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_overflow_scrollbars_overridden_by_max_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_overridden_by_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_overflow_scrollbars_overridden_by_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_overridden_by_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_overflow_scrollbars_take_up_space_both_axis" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_take_up_space_both_axis.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_overflow_scrollbars_take_up_space_cross_axis" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_take_up_space_cross_axis.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_overflow_scrollbars_take_up_space_main_axis" {
  // TODO: port from taffy-reference/tests/generated/block/block_overflow_scrollbars_take_up_space_main_axis.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_border_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_fixed_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_border_intrinsic_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_intrinsic_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_overrides_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_border_overrides_min_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_overrides_min_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_overrides_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_border_percentage_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_percentage_fixed_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_border_percentage_intrinsic_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_border_percentage_intrinsic_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_fixed_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_intrinsic_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_intrinsic_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_percentage_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_percentage_fixed_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/block_padding_percentage_intrinsic_size" {
  // TODO: port from taffy-reference/tests/generated/block/block_padding_percentage_intrinsic_size.rs
  ()
}

///|
#skip
test "upstream/generated/block/mod" {
  // TODO: port from taffy-reference/tests/generated/block/mod.rs
  ()
}

///|
#skip
test "upstream/generated/blockflex/blockflex_block_in_flex_column" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_block_in_flex_column.rs
  ()
}

///|
#skip
test "upstream/generated/blockflex/blockflex_block_in_flex_row" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_block_in_flex_row.rs
  ()
}

///|
#skip
test "upstream/generated/blockflex/blockflex_flex_in_block" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_flex_in_block.rs
  ()
}

///|
#skip
test "upstream/generated/blockflex/blockflex_margin_y_collapse_through_blocked_by_flex" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_margin_y_collapse_through_blocked_by_flex.rs
  ()
}

///|
#skip
test "upstream/generated/blockflex/blockflex_margin_y_first_child_collapse_blocked_by_flex" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_margin_y_first_child_collapse_blocked_by_flex.rs
  ()
}

///|
#skip
test "upstream/generated/blockflex/blockflex_margin_y_last_child_collapse_blocked_by_flex" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_margin_y_last_child_collapse_blocked_by_flex.rs
  ()
}

///|
#skip
test "upstream/generated/blockflex/blockflex_overflow_hidden" {
  // TODO: port from taffy-reference/tests/generated/blockflex/blockflex_overflow_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/blockflex/mod" {
  // TODO: port from taffy-reference/tests/generated/blockflex/mod.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_block_in_grid_auto" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_auto.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_larger" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_larger.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_middle" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_middle.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_smaller" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_smaller.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_larger" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_larger.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_middle" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_middle.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_smaller" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_smaller.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fr" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fr.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_block_in_grid_max_content" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_max_content.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_block_in_grid_min_content" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_min_content.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_grid_in_block" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_grid_in_block.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_margin_y_collapse_through_blocked_by_grid" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_margin_y_collapse_through_blocked_by_grid.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_margin_y_first_child_collapse_blocked_by_grid" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_margin_y_first_child_collapse_blocked_by_grid.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/blockgrid_margin_y_last_child_collapse_blocked_by_grid" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/blockgrid_margin_y_last_child_collapse_blocked_by_grid.rs
  ()
}

///|
#skip
test "upstream/generated/blockgrid/mod" {
  // TODO: port from taffy-reference/tests/generated/blockgrid/mod.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_aspect_ratio_overrides_height_of_full_inset" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_aspect_ratio_overrides_height_of_full_inset.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_fill_height" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_fill_height_from_inset" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_height_from_inset.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_fill_min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_min_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_fill_min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_min_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_fill_width" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_fill_width_from_inset" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_width_from_inset.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_height_overrides_inset" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_height_overrides_inset.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_aspect_ratio_width_overrides_inset" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_aspect_ratio_width_overrides_inset.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_child_with_cross_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_child_with_cross_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_child_with_main_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_child_with_main_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_child_with_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_child_with_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_child_with_max_height_larger_shrinkable_grandchild" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_child_with_max_height_larger_shrinkable_grandchild.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_bottom_position" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_bottom_position.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_left_position" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_left_position.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_right_position" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_right_position.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_center_and_top_position" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_center_and_top_position.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_align_items_and_justify_content_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_and_justify_content_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_align_items_center" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_align_items_center_on_child_only" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_align_items_center_on_child_only.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_child_order" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_child_order.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_column_container" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_column_container.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_column_container_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_column_container_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_row_container" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_row_container.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_in_wrap_reverse_row_container_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_in_wrap_reverse_row_container_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_justify_content_center" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_justify_content_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_no_size" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_no_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_percentage_bottom_based_on_parent_height" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_percentage_bottom_based_on_parent_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_percentage_height" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_percentage_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_row_width_height_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_row_width_height_end_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_start_top_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_start_top_end_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_width_height_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_width_height_end_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_width_height_start_top" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_width_height_start_top.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_width_height_start_top_end_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_width_height_start_top_end_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_layout_within_border" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_layout_within_border.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_margin_bottom_left" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_margin_bottom_left.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_minmax_bottom_right_max" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_minmax_bottom_right_max.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_minmax_bottom_right_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_minmax_bottom_right_min_max.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_minmax_bottom_right_min_max_preferred" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_minmax_bottom_right_min_max_preferred.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_minmax_top_left_bottom_right_max" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_minmax_top_left_bottom_right_max.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_minmax_top_left_bottom_right_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_minmax_top_left_bottom_right_min_max.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_padding_border_overrides_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/absolute_padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/flex/absolute_padding_border_overrides_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_child" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_child_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_child_margin_percent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_margin_percent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_child_multiline" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_multiline.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_child_multiline_no_override_on_secondline" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_multiline_no_override_on_secondline.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_child_multiline_override" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_multiline_override.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_child_padding" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_padding.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_child_top" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_top.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_child_top2" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_child_top2.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_column" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_double_nested_child" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_double_nested_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_multiline" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_multiline.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_multiline_column" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_multiline_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_multiline_column2" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_multiline_column2.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_multiline_row_and_column" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_multiline_row_and_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_nested_child" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_nested_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_baseline_nested_column" {
  // TODO: port from taffy-reference/tests/generated/flex/align_baseline_nested_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_center_should_size_based_on_content" {
  // TODO: port from taffy-reference/tests/generated/flex/align_center_should_size_based_on_content.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_center_single_line" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_single_line.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_center_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_single_line_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_center_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_single_line_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_center_wrapped" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_wrapped.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_center_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_wrapped_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_center_wrapped_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_center_wrapped_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_end" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_end_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_end_single_line_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_end_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_end_single_line_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_end_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_end_wrapped_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_end_wrapped_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_end_wrapped_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_flex_start_with_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_flex_start_with_flex.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_flex_start_without_height_on_children" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_flex_start_without_height_on_children.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_not_stretch_with_align_items_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_not_stretch_with_align_items_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_around_single_line" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_single_line.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_around_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_single_line_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_around_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_single_line_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_around_wrapped" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_wrapped.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_around_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_wrapped_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_around_wrapped_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_around_wrapped_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_between_single_line" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_single_line.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_between_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_single_line_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_between_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_single_line_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_between_wrapped" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_wrapped.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_between_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_wrapped_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_between_wrapped_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_between_wrapped_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_evenly_single_line" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_single_line.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_evenly_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_single_line_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_evenly_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_single_line_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_evenly_wrapped" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_wrapped.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_evenly_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_wrapped_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_space_evenly_wrapped_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_space_evenly_wrapped_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_spacearound" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_spacearound.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_spacebetween" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_spacebetween.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_start_single_line_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_start_single_line_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_start_single_line_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_start_single_line_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_start_wrapped_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_start_wrapped_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_column" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_is_not_overriding_align_items" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_is_not_overriding_align_items.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_row" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_row_with_children" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_children.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_row_with_fixed_height" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_fixed_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_row_with_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_flex.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_row_with_flex_no_shrink" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_flex_no_shrink.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_row_with_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_row_with_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_row_with_min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_min_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_row_with_padding" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_padding.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_content_stretch_row_with_single_row" {
  // TODO: port from taffy-reference/tests/generated/flex/align_content_stretch_row_with_single_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_flex_start_with_shrinking_children" {
  // TODO: port from taffy-reference/tests/generated/flex/align_flex_start_with_shrinking_children.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_flex_start_with_shrinking_children_with_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/align_flex_start_with_shrinking_children_with_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_flex_start_with_stretching_children" {
  // TODO: port from taffy-reference/tests/generated/flex/align_flex_start_with_stretching_children.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_child_with_margin_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_child_with_margin_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_child_without_margin_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_child_without_margin_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_justify_content_center" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_justify_content_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_min_max_with_padding" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_min_max_with_padding.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_with_child_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_child_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_with_child_top" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_child_top.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_with_height_with_padding_border_with_wrap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_height_with_padding_border_with_wrap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_with_max_height_percentage_with_align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_max_height_percentage_with_align_content_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_with_max_height_with_align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_max_height_with_align_content_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_with_max_height_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_max_height_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_with_min_height_percentage_with_align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_min_height_percentage_with_align_content_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_with_min_height_with_align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_min_height_with_align_content_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_with_min_height_with_align_content_flex_start_with_wrap" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_min_height_with_align_content_flex_start_with_wrap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_center_with_min_height_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_center_with_min_height_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_flex_end_child_with_margin_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_flex_end_child_with_margin_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_flex_end_child_without_margin_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_flex_end_child_without_margin_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_min_max.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_items_stretch_min_cross" {
  // TODO: port from taffy-reference/tests/generated/flex/align_items_stretch_min_cross.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_self_baseline" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_baseline.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_self_center" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_self_center_undefined_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_center_undefined_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_self_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_self_flex_end_override_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_flex_end_override_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_self_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/align_self_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/align_stretch_should_size_based_on_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/align_stretch_should_size_based_on_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/android_news_feed" {
  // TODO: port from taffy-reference/tests/generated/flex/android_news_feed.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_fill_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_fill_min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_min_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_fill_min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_min_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_fill_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_fill_width_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_width_flex.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_fill_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_fill_min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_min_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_fill_min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_min_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_fill_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_fill_width_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_width_flex.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_width" {
  // TODO: port from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_10343_block" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_10343_block.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_10343_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_10343_flex.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_10343_grid" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_10343_grid.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_7976_3_level" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_7976_3_level.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_7976_4_level" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_7976_4_level.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_7976_reduced" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_7976_reduced.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_8017" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_8017.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_8017_reduced" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_8017_reduced.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_8082" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_8082.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_8082_percent" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_8082_percent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_9530" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_9530.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_9530_reduced" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_9530_reduced.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_9530_reduced2" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_9530_reduced2.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_9530_reduced3" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_9530_reduced3.rs
  ()
}

///|
#skip
test "upstream/generated/flex/bevy_issue_9530_reduced4" {
  // TODO: port from taffy-reference/tests/generated/flex/bevy_issue_9530_reduced4.rs
  ()
}

///|
#skip
test "upstream/generated/flex/blitz_issue_88" {
  // TODO: port from taffy-reference/tests/generated/flex/blitz_issue_88.rs
  ()
}

///|
#skip
test "upstream/generated/flex/border_center_child" {
  // TODO: port from taffy-reference/tests/generated/flex/border_center_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/border_container_match_child" {
  // TODO: port from taffy-reference/tests/generated/flex/border_container_match_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/border_flex_child" {
  // TODO: port from taffy-reference/tests/generated/flex/border_flex_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/border_no_child" {
  // TODO: port from taffy-reference/tests/generated/flex/border_no_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/border_no_size" {
  // TODO: port from taffy-reference/tests/generated/flex/border_no_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/border_stretch_child" {
  // TODO: port from taffy-reference/tests/generated/flex/border_stretch_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/child_min_max_width_flexing" {
  // TODO: port from taffy-reference/tests/generated/flex/child_min_max_width_flexing.rs
  ()
}

///|
#skip
test "upstream/generated/flex/child_with_padding_align_end" {
  // TODO: port from taffy-reference/tests/generated/flex/child_with_padding_align_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/container_with_unsized_child" {
  // TODO: port from taffy-reference/tests/generated/flex/container_with_unsized_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/content_size" {
  // TODO: port from taffy-reference/tests/generated/flex/content_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/display_none" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none.rs
  ()
}

///|
#skip
test "upstream/generated/flex/display_none_absolute_child" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_absolute_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/display_none_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_fixed_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/display_none_only_node" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_only_node.rs
  ()
}

///|
#skip
test "upstream/generated/flex/display_none_with_child" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_with_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/display_none_with_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_with_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/display_none_with_position" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_with_position.rs
  ()
}

///|
#skip
test "upstream/generated/flex/display_none_with_position_absolute" {
  // TODO: port from taffy-reference/tests/generated/flex/display_none_with_position_absolute.rs
  ()
}

///|
#skip
test "upstream/generated/flex/do_not_clamp_height_of_absolute_node_to_height_of_its_overflow_hidden_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/do_not_clamp_height_of_absolute_node_to_height_of_its_overflow_hidden_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_and_main_dimen_set_when_flexing" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_and_main_dimen_set_when_flexing.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_flex_grow_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_flex_grow_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_flex_grow_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_flex_grow_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_flex_shrink_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_flex_shrink_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_flex_shrink_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_flex_shrink_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_larger_than_content_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_larger_than_content_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_larger_than_content_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_larger_than_content_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_overrides_main_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_overrides_main_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_slightly_smaller_then_content_with_flex_grow_large_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_slightly_smaller_then_content_with_flex_grow_large_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_smaller_than_content_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_than_content_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_smaller_than_content_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_than_content_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_smaller_than_main_dimen_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_than_main_dimen_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_smaller_than_main_dimen_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_than_main_dimen_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_smaller_then_content_with_flex_grow_large_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_then_content_with_flex_grow_large_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_smaller_then_content_with_flex_grow_small_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_then_content_with_flex_grow_small_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_smaller_then_content_with_flex_grow_unconstraint_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_then_content_with_flex_grow_unconstraint_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_smaller_then_content_with_flex_grow_very_large_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_smaller_then_content_with_flex_grow_very_large_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_unconstraint_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_unconstraint_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_unconstraint_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_unconstraint_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_basis_zero_undefined_main_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_basis_zero_undefined_main_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_column_relative_all_sides" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_column_relative_all_sides.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_direction_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_direction_column_no_height" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_column_no_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_direction_column_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_column_reverse.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_direction_column_reverse_no_height" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_column_reverse_no_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_direction_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_direction_row_no_width" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_row_no_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_direction_row_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_direction_row_reverse.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_child" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_flex_basis_percent_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_flex_basis_percent_min_max.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_height_maximized" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_height_maximized.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_in_at_most_container" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_in_at_most_container.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_less_than_factor_one" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_less_than_factor_one.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_root_minimized" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_root_minimized.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_shrink_at_most" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_shrink_at_most.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_to_min" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_to_min.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_within_constrained_max_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_max_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_within_constrained_max_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_max_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_within_constrained_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_within_constrained_min_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_min_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_within_constrained_min_max_column" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_min_max_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_within_constrained_min_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_constrained_min_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_grow_within_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_grow_within_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_row_relative_all_sides" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_row_relative_all_sides.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_shrink_by_outer_margin_with_max_size" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_shrink_by_outer_margin_with_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_shrink_flex_grow_child_flex_shrink_other_child" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_shrink_flex_grow_child_flex_shrink_other_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_shrink_flex_grow_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_shrink_flex_grow_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_shrink_to_zero" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_shrink_to_zero.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_wrap_align_stretch_fits_one_row" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_wrap_align_stretch_fits_one_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_wrap_children_with_min_main_overriding_flex_basis" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_wrap_children_with_min_main_overriding_flex_basis.rs
  ()
}

///|
#skip
test "upstream/generated/flex/flex_wrap_wrap_to_child_height" {
  // TODO: port from taffy-reference/tests/generated/flex/flex_wrap_wrap_to_child_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_child_margins" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_child_margins.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_determines_parent_width" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_determines_parent_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_flexible" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_flexible.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_flexible_undefined_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_flexible_undefined_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_inflexible" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_inflexible.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_inflexible_undefined_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_inflexible_undefined_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_justify_center" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_justify_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_justify_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_justify_space_around" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_space_around.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_justify_space_between" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_space_between.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_justify_space_evenly" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_justify_space_evenly.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_mixed_flexible" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_mixed_flexible.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_percentage_cyclic_partially_shrinkable" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_cyclic_partially_shrinkable.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_percentage_cyclic_shrinkable" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_cyclic_shrinkable.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_percentage_cyclic_unshrinkable" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_cyclic_unshrinkable.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_percentage_flexible" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_flexible.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_percentage_flexible_with_padding" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_flexible_with_padding.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_percentage_inflexible" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_percentage_inflexible.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_row_gap_wrapping" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_row_gap_wrapping.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_start_index" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_start_index.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_wrap_align_center" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_wrap_align_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_wrap_align_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_wrap_align_space_around" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_space_around.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_wrap_align_space_between" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_space_between.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_gap_wrap_align_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_column_row_gap_wrapping" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_column_row_gap_wrapping.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_row_gap_align_items_end" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_align_items_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_row_gap_align_items_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_align_items_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_row_gap_column_child_margins" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_column_child_margins.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_row_gap_determines_parent_height" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_determines_parent_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_row_gap_percentage_wrapping" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_percentage_wrapping.rs
  ()
}

///|
#skip
test "upstream/generated/flex/gap_row_gap_row_wrap_child_margins" {
  // TODO: port from taffy-reference/tests/generated/flex/gap_row_gap_row_wrap_child_margins.rs
  ()
}

///|
#skip
test "upstream/generated/flex/intrinsic_sizing_cross_size_column" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_cross_size_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/intrinsic_sizing_main_size_column" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/intrinsic_sizing_main_size_column_nested" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_column_nested.rs
  ()
}

///|
#skip
test "upstream/generated/flex/intrinsic_sizing_main_size_column_wrap" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_column_wrap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/intrinsic_sizing_main_size_row" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/intrinsic_sizing_main_size_row_nested" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_row_nested.rs
  ()
}

///|
#skip
test "upstream/generated/flex/intrinsic_sizing_main_size_row_wrap" {
  // TODO: port from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_row_wrap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_center" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_center_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_center_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_center_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_center_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_end" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_end_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_end_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_end_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_end_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_end_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_end_reverse.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_flex_end_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_flex_end_reverse.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_flex_start_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_flex_start_reverse.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_max_height_and_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_max_height_and_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_min_height_and_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_min_height_and_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_min_height_and_margin_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_min_height_and_margin_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_min_height_and_margin_top" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_min_height_and_margin_top.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_space_around" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_around.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_space_around_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_around_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_space_around_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_around_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_space_between" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_between.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_space_between_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_between_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_space_between_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_between_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_space_evenly" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_evenly.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_space_evenly_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_evenly_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_space_evenly_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_space_evenly_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_start" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_start_negative_space" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_start_negative_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_start_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_start_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_column_start_reverse" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_column_start_reverse.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_min_max.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_min_width_with_padding_child_width_greater_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_min_width_with_padding_child_width_greater_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_min_width_with_padding_child_width_lower_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_min_width_with_padding_child_width_lower_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_overflow_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_overflow_min_max.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_row_center" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_row_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_row_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_row_max_width_and_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_max_width_and_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_row_min_width_and_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_min_width_and_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_row_space_around" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_space_around.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_row_space_between" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_space_between.rs
  ()
}

///|
#skip
test "upstream/generated/flex/justify_content_row_space_evenly" {
  // TODO: port from taffy-reference/tests/generated/flex/justify_content_row_space_evenly.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_and_flex_column" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_and_flex_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_and_flex_row" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_and_flex_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_and_stretch_column" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_and_stretch_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_and_stretch_row" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_and_stretch_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_bottom_and_top" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_bottom_and_top.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_bottom_and_top_justify_center" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_bottom_and_top_justify_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_left" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_left_and_right" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_and_right.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_left_and_right_column" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_and_right_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_left_and_right_column_and_center" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_and_right_column_and_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_left_and_right_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_and_right_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_left_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_child_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_left_fix_right_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_fix_right_child_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_left_right_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_right_child_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_left_stretching_child" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_left_stretching_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_multiple_children_column" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_multiple_children_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_multiple_children_row" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_multiple_children_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_right" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_right.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_top" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_top.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_top_and_bottom_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_top_and_bottom_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_auto_top_stretching_child" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_auto_top_stretching_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_bottom" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_fix_left_auto_right_child_bigger_than_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_fix_left_auto_right_child_bigger_than_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_left" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_left.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_right" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_right.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_should_not_be_part_of_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_should_not_be_part_of_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_should_not_be_part_of_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_should_not_be_part_of_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_top" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_top.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_with_sibling_column" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_with_sibling_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/margin_with_sibling_row" {
  // TODO: port from taffy-reference/tests/generated/flex/margin_with_sibling_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/max_height_overrides_height" {
  // TODO: port from taffy-reference/tests/generated/flex/max_height_overrides_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/max_height_overrides_height_on_root" {
  // TODO: port from taffy-reference/tests/generated/flex/max_height_overrides_height_on_root.rs
  ()
}

///|
#skip
test "upstream/generated/flex/max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/max_width_overrides_width" {
  // TODO: port from taffy-reference/tests/generated/flex/max_width_overrides_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/max_width_overrides_width_on_root" {
  // TODO: port from taffy-reference/tests/generated/flex/max_width_overrides_width_on_root.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_child" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_child_absolute" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_absolute.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_child_constraint" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_constraint.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_child_constraint_padding_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_constraint_padding_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_child_with_flex_grow" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_with_flex_grow.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_child_with_flex_shrink" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_with_flex_shrink.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_child_with_flex_shrink_hidden" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_with_flex_shrink_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_child_with_min_size_greater_than_available_space" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_child_with_min_size_greater_than_available_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_flex_basis_overrides_measure" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_flex_basis_overrides_measure.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_height_overrides_measure" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_height_overrides_measure.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_remeasure_child_after_growing" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_remeasure_child_after_growing.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_remeasure_child_after_shrinking" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_remeasure_child_after_shrinking.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_remeasure_child_after_stretching" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_remeasure_child_after_stretching.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_root" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_root.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_stretch_overrides_measure" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_stretch_overrides_measure.rs
  ()
}

///|
#skip
test "upstream/generated/flex/measure_width_overrides_measure" {
  // TODO: port from taffy-reference/tests/generated/flex/measure_width_overrides_measure.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_height_larger_than_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height_larger_than_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_height_overrides_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height_overrides_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_height_overrides_height_on_root" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height_overrides_height_on_root.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_height_overrides_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height_overrides_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_height_with_nested_fixed_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_height_with_nested_fixed_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_max_percent_different_width_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_max_percent_different_width_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_max_percent_no_width_height" {
  // TODO: port from taffy-reference/tests/generated/flex/min_max_percent_no_width_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/min_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_width_larger_than_width" {
  // TODO: port from taffy-reference/tests/generated/flex/min_width_larger_than_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_width_overrides_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/min_width_overrides_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_width_overrides_width" {
  // TODO: port from taffy-reference/tests/generated/flex/min_width_overrides_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/min_width_overrides_width_on_root" {
  // TODO: port from taffy-reference/tests/generated/flex/min_width_overrides_width_on_root.rs
  ()
}

///|
#skip
test "upstream/generated/flex/mod" {
  // TODO: port from taffy-reference/tests/generated/flex/mod.rs
  ()
}

///|
#skip
test "upstream/generated/flex/nested_overflowing_child" {
  // TODO: port from taffy-reference/tests/generated/flex/nested_overflowing_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/nested_overflowing_child_in_constraint_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/nested_overflowing_child_in_constraint_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/only_shrinkable_item_with_flex_basis_zero" {
  // TODO: port from taffy-reference/tests/generated/flex/only_shrinkable_item_with_flex_basis_zero.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_cross_axis" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_cross_axis.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_main_axis" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_main_axis.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_main_axis_shrink_hidden" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_main_axis_shrink_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_main_axis_shrink_scroll" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_main_axis_shrink_scroll.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_main_axis_shrink_visible" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_main_axis_shrink_visible.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_scroll_main_axis_justify_content_end" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scroll_main_axis_justify_content_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_scrollbars_overridden_by_available_space" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_overridden_by_available_space.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_scrollbars_overridden_by_max_size" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_overridden_by_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_scrollbars_overridden_by_size" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_overridden_by_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_scrollbars_take_up_space_both_axis" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_take_up_space_both_axis.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_scrollbars_take_up_space_cross_axis" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_take_up_space_cross_axis.rs
  ()
}

///|
#skip
test "upstream/generated/flex/overflow_scrollbars_take_up_space_main_axis" {
  // TODO: port from taffy-reference/tests/generated/flex/overflow_scrollbars_take_up_space_main_axis.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_align_end_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_align_end_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_border_overrides_min_size" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_min_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_border_overrides_size_flex_basis_0" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_size_flex_basis_0.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_border_overrides_size_flex_basis_0_growable" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_size_flex_basis_0_growable.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_border_overrides_size_root" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_border_overrides_size_root.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_center_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_center_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_container_match_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_container_match_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_flex_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_flex_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_no_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_no_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_no_size" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_no_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/padding_stretch_child" {
  // TODO: port from taffy-reference/tests/generated/flex/padding_stretch_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/parent_wrap_child_size_overflowing_parent" {
  // TODO: port from taffy-reference/tests/generated/flex/parent_wrap_child_size_overflowing_parent.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percent_absolute_position" {
  // TODO: port from taffy-reference/tests/generated/flex/percent_absolute_position.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percent_within_flex_grow" {
  // TODO: port from taffy-reference/tests/generated/flex/percent_within_flex_grow.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_absolute_position" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_absolute_position.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_container_in_wrapping_container" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_container_in_wrapping_container.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_different_width_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_different_width_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_different_width_height_column" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_different_width_height_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_flex_basis" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_flex_basis_cross" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_cross.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_flex_basis_cross_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_flex_basis_cross_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_flex_basis_cross_min_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_min_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_flex_basis_cross_min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_cross_min_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_flex_basis_main_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_main_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_flex_basis_main_max_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_main_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_flex_basis_main_min_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_flex_basis_main_min_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_main_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_main_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_margin_should_calculate_based_only_on_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_margin_should_calculate_based_only_on_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_moderate_complexity" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_moderate_complexity.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_moderate_complexity2" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_moderate_complexity2.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_multiple_nested_with_padding_margin_and_percentage_values" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_multiple_nested_with_padding_margin_and_percentage_values.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_padding_should_calculate_based_only_on_width" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_padding_should_calculate_based_only_on_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_position_bottom_right" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_position_bottom_right.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_position_left_top" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_position_left_top.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_size_based_on_parent_inner_size" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_size_based_on_parent_inner_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_size_of_flex_basis" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_size_of_flex_basis.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_sizes_should_not_prevent_flex_shrinking" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_sizes_should_not_prevent_flex_shrinking.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_width_height" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_width_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/percentage_width_height_undefined_parent_size" {
  // TODO: port from taffy-reference/tests/generated/flex/percentage_width_height_undefined_parent_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/position_root_with_rtl_should_position_withoutdirection" {
  // TODO: port from taffy-reference/tests/generated/flex/position_root_with_rtl_should_position_withoutdirection.rs
  ()
}

///|
#skip
test "upstream/generated/flex/relative_position_should_not_nudge_siblings" {
  // TODO: port from taffy-reference/tests/generated/flex/relative_position_should_not_nudge_siblings.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_flex_basis_flex_grow_row_prime_number_width" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_flex_basis_flex_grow_row_prime_number_width.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_flex_basis_flex_grow_row_width_of_100" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_flex_basis_flex_grow_row_width_of_100.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_flex_basis_flex_shrink_row" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_flex_basis_flex_shrink_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_flex_basis_overrides_main_size" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_flex_basis_overrides_main_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_fractial_input_1" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_1.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_fractial_input_2" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_2.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_fractial_input_3" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_3.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_fractial_input_4" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_4.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_fractial_input_5" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_5.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_fractial_input_6" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_6.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_fractial_input_7" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_fractial_input_7.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_inner_node_controversy_combined" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_inner_node_controversy_combined.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_inner_node_controversy_horizontal" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_inner_node_controversy_horizontal.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_inner_node_controversy_vertical" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_inner_node_controversy_vertical.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_total_fractial" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_total_fractial.rs
  ()
}

///|
#skip
test "upstream/generated/flex/rounding_total_fractial_nested" {
  // TODO: port from taffy-reference/tests/generated/flex/rounding_total_fractial_nested.rs
  ()
}

///|
#skip
test "upstream/generated/flex/scroll_size" {
  // TODO: port from taffy-reference/tests/generated/flex/scroll_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/simple_child" {
  // TODO: port from taffy-reference/tests/generated/flex/simple_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/single_flex_child_after_absolute_child" {
  // TODO: port from taffy-reference/tests/generated/flex/single_flex_child_after_absolute_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/size_defined_by_child" {
  // TODO: port from taffy-reference/tests/generated/flex/size_defined_by_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/size_defined_by_child_with_border" {
  // TODO: port from taffy-reference/tests/generated/flex/size_defined_by_child_with_border.rs
  ()
}

///|
#skip
test "upstream/generated/flex/size_defined_by_child_with_padding" {
  // TODO: port from taffy-reference/tests/generated/flex/size_defined_by_child_with_padding.rs
  ()
}

///|
#skip
test "upstream/generated/flex/size_defined_by_grand_child" {
  // TODO: port from taffy-reference/tests/generated/flex/size_defined_by_grand_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/undefined_height_with_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/undefined_height_with_min_max.rs
  ()
}

///|
#skip
test "upstream/generated/flex/undefined_width_with_min_max" {
  // TODO: port from taffy-reference/tests/generated/flex/undefined_width_with_min_max.rs
  ()
}

///|
#skip
test "upstream/generated/flex/undefined_width_with_min_max_row" {
  // TODO: port from taffy-reference/tests/generated/flex/undefined_width_with_min_max_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_large_size" {
  // TODO: port from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_large_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_small_size" {
  // TODO: port from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_small_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_unconstraint_size" {
  // TODO: port from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_unconstraint_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_very_large_size" {
  // TODO: port from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_very_large_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_child" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_child.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_column" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_grandchild" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_grandchild.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_nodes_with_content_sizing_margin_cross" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_nodes_with_content_sizing_margin_cross.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_nodes_with_content_sizing_overflowing_margin" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_nodes_with_content_sizing_overflowing_margin.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_reverse_column" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_column.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_reverse_column_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_column_fixed_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_reverse_row" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_reverse_row_align_content_center" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_reverse_row_align_content_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_reverse_row_align_content_space_around" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_space_around.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_reverse_row_align_content_stretch" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_reverse_row_single_line_different_size" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_reverse_row_single_line_different_size.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_row" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_row.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_row_align_items_center" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_row_align_items_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrap_row_align_items_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/wrap_row_align_items_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrapped_column_max_height" {
  // TODO: port from taffy-reference/tests/generated/flex/wrapped_column_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrapped_column_max_height_flex" {
  // TODO: port from taffy-reference/tests/generated/flex/wrapped_column_max_height_flex.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrapped_row_within_align_items_center" {
  // TODO: port from taffy-reference/tests/generated/flex/wrapped_row_within_align_items_center.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrapped_row_within_align_items_flex_end" {
  // TODO: port from taffy-reference/tests/generated/flex/wrapped_row_within_align_items_flex_end.rs
  ()
}

///|
#skip
test "upstream/generated/flex/wrapped_row_within_align_items_flex_start" {
  // TODO: port from taffy-reference/tests/generated/flex/wrapped_row_within_align_items_flex_start.rs
  ()
}

///|
#skip
test "upstream/generated/grid/chrome_issue_325928327" {
  // TODO: port from taffy-reference/tests/generated/grid/chrome_issue_325928327.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_align_self_sized_all" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_align_self_sized_all.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_column_end" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_column_end.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_column_start" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_column_start.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_bottom_left" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_bottom_left.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_bottom_left_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_bottom_left_margin.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_left_overrides_right" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_left_overrides_right.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_left_right" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_left_right.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_left_right_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_left_right_margin.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_negative_position" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_negative_position.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_negative_position_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_negative_position_margin.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_top_bottom" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_top_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_top_bottom_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_top_bottom_margin.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_top_right" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_top_right.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_container_top_right_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_container_top_right_margin.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_justify_self_sized_all" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_justify_self_sized_all.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_layout_within_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_layout_within_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_layout_within_border_static" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_layout_within_border_static.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_row_end" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_row_end.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_row_start" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_row_start.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_top_overrides_bottom" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_top_overrides_bottom.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_with_padding" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_with_padding.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_absolute_with_padding_and_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_absolute_with_padding_and_margin.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_center" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_center.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_center_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_center_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_end" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_end.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_end_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_end_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_end_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_end_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_space_around" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_space_around.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_space_around_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_space_around_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_space_around_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_space_around_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_space_between" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_space_between.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_space_between_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_space_between_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_space_between_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_space_between_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_space_evenly" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_space_evenly.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_space_evenly_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_space_evenly_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_space_evenly_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_space_evenly_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_start" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_start.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_start_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_start_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_content_start_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_content_start_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_child" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_child.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_child_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_margin.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_child_margin_percent" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_margin_percent.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_child_multiline" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_multiline.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_child_multiline_no_override_on_secondline" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_multiline_no_override_on_secondline.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_child_multiline_override" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_multiline_override.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_child_padding" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_padding.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_child_top" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_top.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_child_top2" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_top2.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_complex" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_complex.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_double_nested_child" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_double_nested_child.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_multiline" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_multiline.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_multiline_column" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_multiline_column.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_multiline_row_and_column" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_multiline_row_and_column.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_baseline_nested_column" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_baseline_nested_column.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_sized_center" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_sized_center.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_sized_end" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_sized_end.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_sized_start" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_sized_start.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_items_sized_stretch" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_items_sized_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_align_self_sized_all" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_align_self_sized_all.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_absolute_aspect_ratio_overrides_height_of_full_inset" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_aspect_ratio_overrides_height_of_full_inset.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_absolute_fill_height_from_inset" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_fill_height_from_inset.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_absolute_fill_width_from_inset" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_fill_width_from_inset.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_absolute_height_overrides_inset" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_height_overrides_inset.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_absolute_width_overrides_inset" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_width_overrides_inset.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_child_fill_content_height" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_child_fill_content_height.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_child_fill_content_width" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_child_fill_content_width.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_fill_child_height" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_height.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_fill_child_max_height" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_max_height.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_fill_child_max_width" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_max_width.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_fill_child_min_height" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_min_height.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_fill_child_width" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_width.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes_flex" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes_flex.rs
  ()
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
#skip
test "upstream/generated/grid/grid_auto_columns_fixed_width" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_auto_columns_fixed_width.rs
  ()
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
#skip
test "upstream/generated/grid/grid_basic" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_basic.rs
  ()
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
#skip
test "upstream/generated/grid/grid_basic_with_overflow" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_basic_with_overflow.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_basic_with_padding" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_basic_with_padding.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_display_none_fixed_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_display_none_fixed_size.rs
  ()
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
#skip
test "upstream/generated/grid/grid_fit_content_percent_indefinite_max_content_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_max_content_hidden.rs
  ()
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
#skip
test "upstream/generated/grid/grid_fit_content_percent_indefinite_min_content_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_min_content_hidden.rs
  ()
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
#skip
test "upstream/generated/grid/grid_fit_content_points_min_content_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fit_content_points_min_content_hidden.rs
  ()
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
#skip
test "upstream/generated/grid/grid_fr_fixed_size_single_item" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fr_fixed_size_single_item.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_fr_no_sized_items_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fr_no_sized_items_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_fr_single_item_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fr_single_item_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_fr_span_2_proportion" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_fr_span_2_proportion_sub_1_sum" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_sub_1_sum.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_fr_span_2_proportion_with_non_spanned_track" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_with_non_spanned_track.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_fr_span_2_proportion_zero_sum" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_zero_sum.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_fr_span_2_proportion_zero_sum_with_non_spanned_track" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_zero_sum_with_non_spanned_track.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_center" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_center.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_center_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_center_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_center_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_center_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_end" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_end.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_end_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_end_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_end_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_end_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_space_around" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_space_around.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_space_around_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_space_around_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_space_around_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_space_around_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_space_between" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_space_between.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_space_between_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_space_between_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_space_between_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_space_between_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_space_evenly" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_space_evenly.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_space_evenly_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_space_evenly_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_space_evenly_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_space_evenly_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_start" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_start.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_start_negative_space_gap" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_start_negative_space_gap.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_content_start_with_padding_border" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_content_start_with_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_items_sized_center" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_items_sized_center.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_items_sized_end" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_items_sized_end.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_items_sized_start" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_items_sized_start.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_items_sized_stretch" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_items_sized_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_justify_self_sized_all" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_justify_self_sized_all.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_margins_auto_margins" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_margins_auto_margins.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_margins_auto_margins_override_stretch" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_margins_auto_margins_override_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_margins_fixed_center" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_margins_fixed_center.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_margins_fixed_end" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_margins_fixed_end.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_margins_fixed_start" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_margins_fixed_start.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_margins_fixed_stretch" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_margins_fixed_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_margins_percent_center" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_margins_percent_center.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_margins_percent_end" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_margins_percent_end.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_margins_percent_start" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_margins_percent_start.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_margins_percent_stretch" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_margins_percent_stretch.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_max_content_maximum_single_item" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_max_content_maximum_single_item.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_max_content_single_item" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_max_content_single_item.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_max_content_single_item_margin_auto" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_max_content_single_item_margin_auto.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_max_content_single_item_margin_fixed" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_max_content_single_item_margin_fixed.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_max_content_single_item_margin_percent" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_max_content_single_item_margin_percent.rs
  ()
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
#skip
test "upstream/generated/grid/grid_max_width_greater_than_max_content" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_max_width_greater_than_max_content.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_max_width_less_than_max_content_with_min_content" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_max_width_less_than_max_content_with_min_content.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_max_width_smaller_than_max_content" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_max_width_smaller_than_max_content.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_max_width_smaller_than_min_content" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_max_width_smaller_than_min_content.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_min_content_flex_column" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_min_content_flex_column.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_min_content_flex_row" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_min_content_flex_row.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_min_content_flex_single_item" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_min_content_flex_single_item_margin_auto" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item_margin_auto.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_min_content_flex_single_item_margin_fixed" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item_margin_fixed.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_min_content_flex_single_item_margin_percent" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item_margin_percent.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_min_content_maximum_single_item" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_min_content_maximum_single_item.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_min_content_single_item" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_min_content_single_item.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_auto_fixed_10px" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_auto_fixed_10px.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_auto_max_content" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_auto_max_content.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_auto_min_content" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_auto_min_content.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_auto_percent_definite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_auto_percent_definite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_auto_percent_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_auto_percent_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_column_fixed_width_above_range" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_column_fixed_width_above_range.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_column_fixed_width_below_range" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_column_fixed_width_below_range.rs
  ()
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
#skip
test "upstream/generated/grid/grid_minmax_column_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_column_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_column_with_auto_fixed" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_column_with_auto_fixed.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_column_with_fr_fixed" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_column_with_fr_fixed.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_max_content_1fr" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_max_content_1fr.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_max_content_auto" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_max_content_auto.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_max_content_fixed_10px" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_max_content_fixed_10px.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_max_content_min_content" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_max_content_min_content.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_max_content_percent_definite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_max_content_percent_definite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_max_content_percent_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_max_content_percent_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_min_content_1fr" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_min_content_1fr.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_min_content_auto" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_min_content_auto.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_min_content_fixed_10px" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_min_content_fixed_10px.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_min_content_max_content" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_min_content_max_content.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_min_content_percent_definite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_min_content_percent_definite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_minmax_min_content_percent_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_minmax_min_content_percent_indefinite.rs
  ()
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
#skip
test "upstream/generated/grid/grid_overflow_inline_axis_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_inline_axis_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_overflow_inline_axis_scroll" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_inline_axis_scroll.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_overflow_inline_axis_visible" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_inline_axis_visible.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_overflow_rows" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_rows.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_overflow_scrollbars_overridden_by_available_space" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_overridden_by_available_space.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_overflow_scrollbars_overridden_by_max_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_overridden_by_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_overflow_scrollbars_overridden_by_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_overridden_by_size.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_overflow_scrollbars_take_up_space_both_axis" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_take_up_space_both_axis.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_overflow_scrollbars_take_up_space_x_axis" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_take_up_space_x_axis.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_overflow_scrollbars_take_up_space_y_axis" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_take_up_space_y_axis.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_padding_border_overrides_container_max_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_padding_border_overrides_container_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_padding_border_overrides_container_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_padding_border_overrides_container_size.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_padding_border_overrides_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_padding_border_overrides_min_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_padding_border_overrides_min_size.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_padding_border_overrides_size.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_item_inside_stretch_item" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_item_inside_stretch_item.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_items_nested_inside_stretch_alignment" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_nested_inside_stretch_alignment.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_items_nested_moderate" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_nested_moderate.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_items_nested_with_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_nested_with_margin.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_items_nested_with_padding_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_nested_with_padding_margin.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_items_width_and_margin" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_width_and_margin.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_items_width_and_padding" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_items_width_and_padding.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_tracks_definite_overflow" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_tracks_definite_overflow.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_tracks_definite_underflow" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_tracks_definite_underflow.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_tracks_indefinite_only" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_tracks_indefinite_only.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_tracks_indefinite_with_content_overflow" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_tracks_indefinite_with_content_overflow.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_percent_tracks_indefinite_with_content_underflow" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_percent_tracks_indefinite_with_content_underflow.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_placement_auto_negative" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_placement_auto_negative.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_placement_definite_in_secondary_axis_with_fully_definite_negative" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_placement_definite_in_secondary_axis_with_fully_definite_negative.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_relative_all_sides" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_relative_all_sides.rs
  ()
}

///|
#skip
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
#skip
test "upstream/generated/grid/grid_repeat_mixed" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_repeat_mixed.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_size_child_fixed_tracks" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_size_child_fixed_tracks.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_max_content_auto_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_auto_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_max_content_auto_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_auto_indefinite_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_max_content_max_content_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_max_content_max_content_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_min_content_auto_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_auto_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_min_content_auto_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_auto_indefinite_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_min_content_max_content_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_max_content_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_2_min_content_min_content_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_2_min_content_min_content_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_6_all_non_flex_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_6_all_non_flex_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_6_all_non_flex_indefinite_hidden" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_6_all_non_flex_indefinite_hidden.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_span_8_all_track_types_indefinite" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_span_8_all_track_types_indefinite.rs
  ()
}

///|
#skip
test "upstream/generated/grid/grid_taffy_issue_624" {
  // TODO: port from taffy-reference/tests/generated/grid/grid_taffy_issue_624.rs
  ()
}

///|
#skip
test "upstream/generated/grid/mod" {
  // TODO: port from taffy-reference/tests/generated/grid/mod.rs
  ()
}

///|
#skip
test "upstream/generated/gridflex/gridflex_column_integration" {
  // TODO: port from taffy-reference/tests/generated/gridflex/gridflex_column_integration.rs
  ()
}

///|
#skip
test "upstream/generated/gridflex/gridflex_kitchen_sink" {
  // TODO: port from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink.rs
  ()
}

///|
#skip
test "upstream/generated/gridflex/gridflex_kitchen_sink_minimise" {
  // TODO: port from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink_minimise.rs
  ()
}

///|
#skip
test "upstream/generated/gridflex/gridflex_kitchen_sink_minimise2" {
  // TODO: port from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink_minimise2.rs
  ()
}

///|
#skip
test "upstream/generated/gridflex/gridflex_kitchen_sink_minimise3" {
  // TODO: port from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink_minimise3.rs
  ()
}

///|
#skip
test "upstream/generated/gridflex/gridflex_row_integration" {
  // TODO: port from taffy-reference/tests/generated/gridflex/gridflex_row_integration.rs
  ()
}

///|
#skip
test "upstream/generated/gridflex/mod" {
  // TODO: port from taffy-reference/tests/generated/gridflex/mod.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_overflow_scrollbars_affect_available_space_x_axis" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_affect_available_space_x_axis.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_overflow_scrollbars_affect_available_space_y_axis" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_affect_available_space_y_axis.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_overflow_scrollbars_overridden_by_available_space" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_overridden_by_available_space.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_overflow_scrollbars_overridden_by_max_size" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_overridden_by_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_overflow_scrollbars_overridden_by_size" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_overridden_by_size.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_overflow_scrollbars_take_up_space_both_axis" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_take_up_space_both_axis.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_overflow_scrollbars_take_up_space_x_axis" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_take_up_space_x_axis.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_overflow_scrollbars_take_up_space_y_axis" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_take_up_space_y_axis.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_padding_border_overrides_max_size" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_padding_border_overrides_max_size.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_padding_border_overrides_min_size" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_padding_border_overrides_min_size.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_padding_border_overrides_size" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_padding_border_overrides_size.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_with_content_and_border" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_with_content_and_border.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_with_content_and_padding" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_with_content_and_padding.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/leaf_with_content_and_padding_border" {
  // TODO: port from taffy-reference/tests/generated/leaf/leaf_with_content_and_padding_border.rs
  ()
}

///|
#skip
test "upstream/generated/leaf/mod" {
  // TODO: port from taffy-reference/tests/generated/leaf/mod.rs
  ()
}

///|
#skip
test "upstream/generated/./mod" {
  // TODO: port from taffy-reference/tests/generated/mod.rs
  ()
}
