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
test "upstream/generated/flex/absolute_layout_width_height_start_top" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_width_height_start_top.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=length(10.0), right=auto(), top=length(10.0), bottom=auto()),
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
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/absolute_layout_width_height_start_top_end_bottom" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_width_height_start_top_end_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/absolute_layout_within_border" {
  // Ported from taffy-reference/tests/generated/flex/absolute_layout_within_border.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
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
  let node = taffy.new_with_children(
    Style::default()
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
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
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
test "upstream/generated/flex/absolute_margin_bottom_left" {
  // Ported from taffy-reference/tests/generated/flex/absolute_margin_bottom_left.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_flex_end())
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
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 80.0)
}

///|
test "upstream/generated/flex/absolute_minmax_bottom_right_max" {
  // Ported from taffy-reference/tests/generated/flex/absolute_minmax_bottom_right_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_max_size(Size(width=length(40.0), height=length(30.0)))
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 30.0)
  assert_eq(l0.location.x, 50.0)
  assert_eq(l0.location.y, 60.0)
}

///|
test "upstream/generated/flex/absolute_minmax_bottom_right_min_max" {
  // Ported from taffy-reference/tests/generated/flex/absolute_minmax_bottom_right_min_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_min_size(Size(width=length(50.0), height=length(60.0)))
    .with_max_size(Size(width=length(40.0), height=length(30.0)))
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
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 40.0)
  assert_eq(l0.location.y, 30.0)
}

///|
test "upstream/generated/flex/absolute_minmax_bottom_right_min_max_preferred" {
  // Ported from taffy-reference/tests/generated/flex/absolute_minmax_bottom_right_min_max_preferred.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(200.0), height=length(200.0)))
    .with_min_size(Size(width=length(50.0), height=length(60.0)))
    .with_max_size(Size(width=length(40.0), height=length(30.0)))
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
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 40.0)
  assert_eq(l0.location.y, 30.0)
}

///|
test "upstream/generated/flex/absolute_minmax_top_left_bottom_right_max" {
  // Ported from taffy-reference/tests/generated/flex/absolute_minmax_top_left_bottom_right_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 30.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/absolute_minmax_top_left_bottom_right_min_max" {
  // Ported from taffy-reference/tests/generated/flex/absolute_minmax_top_left_bottom_right_min_max.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/absolute_padding_border_overrides_max_size" {
  // Ported from taffy-reference/tests/generated/flex/absolute_padding_border_overrides_max_size.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 0.0)
  assert_eq(l_node.size.height, 0.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 22.0)
  assert_eq(l0.size.height, 14.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_padding_border_overrides_size" {
  // Ported from taffy-reference/tests/generated/flex/absolute_padding_border_overrides_size.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 0.0)
  assert_eq(l_node.size.height, 0.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 22.0)
  assert_eq(l0.size.height, 14.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_baseline" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 30.0)
}

///|
test "upstream/generated/flex/align_baseline_child" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
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
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 40.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_baseline_child_margin" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_child_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 5.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 40.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 5.0)
  assert_eq(l10.location.y, 5.0)
}

///|
test "upstream/generated/flex/align_baseline_child_margin_percent" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_child_margin_percent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 5.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 45.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 1.0)
  assert_eq(l10.location.y, 1.0)
}

///|
test "upstream/generated/flex/align_baseline_child_multiline" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_child_multiline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(60.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node12 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node13 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(50.0), height=auto())),
    [node10, node11, node12, node13],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 80.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 40.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 25.0)
  assert_eq(l10.size.height, 20.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 25.0)
  assert_eq(l11.size.height, 10.0)
  assert_eq(l11.location.x, 25.0)
  assert_eq(l11.location.y, 0.0)
  let l12 = taffy.layout(node12)
  assert_eq(l12.size.width, 25.0)
  assert_eq(l12.size.height, 20.0)
  assert_eq(l12.location.x, 0.0)
  assert_eq(l12.location.y, 20.0)
  let l13 = taffy.layout(node13)
  assert_eq(l13.size.width, 25.0)
  assert_eq(l13.size.height, 10.0)
  assert_eq(l13.location.x, 25.0)
  assert_eq(l13.location.y, 20.0)
}

///|
test "upstream/generated/flex/align_baseline_child_multiline_no_override_on_secondline" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_child_multiline_no_override_on_secondline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(60.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node12 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node13 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_baseline())
    .with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(50.0), height=length(25.0))),
    [node10, node11, node12, node13],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
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
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 25.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 40.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 25.0)
  assert_eq(l10.size.height, 20.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 25.0)
  assert_eq(l11.size.height, 10.0)
  assert_eq(l11.location.x, 25.0)
  assert_eq(l11.location.y, 0.0)
  let l12 = taffy.layout(node12)
  assert_eq(l12.size.width, 25.0)
  assert_eq(l12.size.height, 20.0)
  assert_eq(l12.location.x, 0.0)
  assert_eq(l12.location.y, 20.0)
  let l13 = taffy.layout(node13)
  assert_eq(l13.size.width, 25.0)
  assert_eq(l13.size.height, 10.0)
  assert_eq(l13.location.x, 25.0)
  assert_eq(l13.location.y, 20.0)
}

///|
test "upstream/generated/flex/align_baseline_child_multiline_override" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_child_multiline_override.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(60.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_baseline())
    .with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node12 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node13 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_baseline())
    .with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(50.0), height=length(25.0))),
    [node10, node11, node12, node13],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
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
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 25.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 50.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 25.0)
  assert_eq(l10.size.height, 20.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 25.0)
  assert_eq(l11.size.height, 10.0)
  assert_eq(l11.location.x, 25.0)
  assert_eq(l11.location.y, 0.0)
  let l12 = taffy.layout(node12)
  assert_eq(l12.size.width, 25.0)
  assert_eq(l12.size.height, 20.0)
  assert_eq(l12.location.x, 0.0)
  assert_eq(l12.location.y, 20.0)
  let l13 = taffy.layout(node13)
  assert_eq(l13.size.width, 25.0)
  assert_eq(l13.size.height, 10.0)
  assert_eq(l13.location.x, 25.0)
  assert_eq(l13.location.y, 20.0)
}

///|
test "upstream/generated/flex/align_baseline_child_padding" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_child_padding.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
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
  let node = taffy.new_with_children(
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
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 5.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 45.0)
  assert_eq(l1.location.y, 40.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 5.0)
  assert_eq(l10.location.y, 5.0)
}

///|
test "upstream/generated/flex/align_baseline_child_top" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_child_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(10.0), bottom=auto()),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
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
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 40.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_baseline_child_top2" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_child_top2.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(20.0)))
    .with_inset(Rect(left=auto(), right=auto(), top=length(5.0), bottom=auto())),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
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
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 45.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_baseline_column" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_baseline())
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
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/flex/align_baseline_double_nested_child" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_double_nested_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
    [node00],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(15.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default().with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
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
  assert_eq(l1.location.y, 5.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 15.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_baseline_multiline" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_multiline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 40.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 100.0)
  let l20 = taffy.layout(node20)
  assert_eq(l20.size.width, 50.0)
  assert_eq(l20.size.height, 10.0)
  assert_eq(l20.location.x, 0.0)
  assert_eq(l20.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 50.0)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 60.0)
}

///|
test "upstream/generated/flex/align_baseline_multiline_column" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_multiline_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(30.0), height=length(50.0))),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(40.0), height=length(70.0))),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 20.0)
  assert_eq(l10.size.height, 20.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 40.0)
  assert_eq(l2.size.height, 70.0)
  assert_eq(l2.location.x, 50.0)
  assert_eq(l2.location.y, 0.0)
  let l20 = taffy.layout(node20)
  assert_eq(l20.size.width, 10.0)
  assert_eq(l20.size.height, 10.0)
  assert_eq(l20.location.x, 0.0)
  assert_eq(l20.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 70.0)
}
