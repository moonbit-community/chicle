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
test "upstream/generated/block/block_overflow_scrollbars_overridden_by_max_size" {
  // Ported from taffy-reference/tests/generated/block/block_overflow_scrollbars_overridden_by_max_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_max_size(Size(width=length(2.0), height=length(4.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 2.0)
  assert_eq(l_node.size.height, 4.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 0.0)
  assert_eq(l_node0.size.height, 0.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_overflow_scrollbars_overridden_by_size" {
  // Ported from taffy-reference/tests/generated/block/block_overflow_scrollbars_overridden_by_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(2.0), height=length(4.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 2.0)
  assert_eq(l_node.size.height, 4.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 0.0)
  assert_eq(l_node0.size.height, 0.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_overflow_scrollbars_take_up_space_both_axis" {
  // Ported from taffy-reference/tests/generated/block/block_overflow_scrollbars_take_up_space_both_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 50.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 35.0)
  assert_eq(l_node0.size.height, 35.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_overflow_scrollbars_take_up_space_cross_axis" {
  // Ported from taffy-reference/tests/generated/block/block_overflow_scrollbars_take_up_space_cross_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point(x=overflow_visible(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 50.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 35.0)
  assert_eq(l_node0.size.height, 50.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_overflow_scrollbars_take_up_space_main_axis" {
  // Ported from taffy-reference/tests/generated/block/block_overflow_scrollbars_take_up_space_main_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_visible()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 50.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 35.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
}

///|
test "upstream/generated/block/block_padding_border_fixed_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_border_fixed_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_padding(
      Rect(
        left=length(7.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(5.0),
      ),
    )
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
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 50.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 28.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 15.0)
  assert_eq(l_node0.location.y, 3.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 28.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 15.0)
  assert_eq(l_node1.location.y, 13.0)
}

///|
test "upstream/generated/block/block_padding_border_intrinsic_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_border_intrinsic_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_padding(
      Rect(
        left=length(7.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(5.0),
      ),
    )
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
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 72.0)
  assert_eq(l_node.size.height, 34.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 15.0)
  assert_eq(l_node0.location.y, 3.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 15.0)
  assert_eq(l_node1.location.y, 13.0)
}

///|
test "upstream/generated/block/block_padding_border_overrides_max_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_border_overrides_max_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(Style::default())
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
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
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 22.0)
  assert_eq(l_node.size.height, 14.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 22.0)
  assert_eq(l_node0.size.height, 14.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 0.0)
  assert_eq(l_node00.size.height, 0.0)
  assert_eq(l_node00.location.x, 15.0)
  assert_eq(l_node00.location.y, 3.0)
}

///|
test "upstream/generated/block/block_padding_border_overrides_min_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_border_overrides_min_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(Style::default())
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_min_size(Size(width=length(0.0), height=length(0.0)))
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
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 22.0)
  assert_eq(l_node.size.height, 14.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 22.0)
  assert_eq(l_node0.size.height, 14.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 0.0)
  assert_eq(l_node00.size.height, 0.0)
  assert_eq(l_node00.location.x, 15.0)
  assert_eq(l_node00.location.y, 3.0)
}

///|
test "upstream/generated/block/block_padding_border_overrides_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_border_overrides_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(Style::default())
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
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
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 22.0)
  assert_eq(l_node.size.height, 14.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 22.0)
  assert_eq(l_node0.size.height, 14.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 0.0)
  assert_eq(l_node00.size.height, 0.0)
  assert_eq(l_node00.location.x, 15.0)
  assert_eq(l_node00.location.y, 3.0)
}

///|
test "upstream/generated/block/block_padding_border_percentage_fixed_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_border_percentage_fixed_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_padding(
      Rect(
        left=percent(0.04),
        right=percent(0.02),
        top=percent(0.01),
        bottom=percent(0.03),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 50.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 12.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 47.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 2.0)
  assert_eq(l_node00.location.y, 1.0)
}

///|
test "upstream/generated/block/block_padding_border_percentage_intrinsic_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_border_percentage_intrinsic_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_padding(
      Rect(
        left=percent(0.04),
        right=percent(0.02),
        top=percent(0.01),
        bottom=percent(0.03),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 0.0)
  assert_eq(l_node.size.height, 10.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 0.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 0.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
}

///|
test "upstream/generated/block/block_padding_fixed_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_fixed_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_padding(
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
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 50.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 38.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 8.0)
  assert_eq(l_node0.location.y, 2.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 38.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 8.0)
  assert_eq(l_node1.location.y, 12.0)
}

///|
test "upstream/generated/block/block_padding_intrinsic_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_intrinsic_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_padding(
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
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 62.0)
  assert_eq(l_node.size.height, 28.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 8.0)
  assert_eq(l_node0.location.y, 2.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 8.0)
  assert_eq(l_node1.location.y, 12.0)
}

///|
test "upstream/generated/block/block_padding_percentage_fixed_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_percentage_fixed_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_padding(
      Rect(
        left=percent(0.04),
        right=percent(0.02),
        top=percent(0.01),
        bottom=percent(0.03),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 50.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 12.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 47.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 2.0)
  assert_eq(l_node00.location.y, 1.0)
}

///|
test "upstream/generated/block/block_padding_percentage_intrinsic_size" {
  // Ported from taffy-reference/tests/generated/block/block_padding_percentage_intrinsic_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_padding(
      Rect(
        left=percent(0.04),
        right=percent(0.02),
        top=percent(0.01),
        bottom=percent(0.03),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 0.0)
  assert_eq(l_node.size.height, 10.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 0.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 0.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
}

///|
test "upstream/generated/block/mod" {
  // Upstream module declaration file; no runnable test vectors.
  ()
}

///|
test "upstream/generated/blockflex/blockflex_block_in_flex_column" {
  // Ported from taffy-reference/tests/generated/blockflex/blockflex_block_in_flex_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(200.0), height=length(50.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 200.0)
  assert_eq(l_node.size.height, 50.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 200.0)
  assert_eq(l_node0.size.height, 0.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 0.0)
}

///|
test "upstream/generated/blockflex/blockflex_block_in_flex_row" {
  // Ported from taffy-reference/tests/generated/blockflex/blockflex_block_in_flex_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(200.0), height=length(50.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 200.0)
  assert_eq(l_node.size.height, 50.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 0.0)
  assert_eq(l_node0.size.height, 50.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 50.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 0.0)
}

///|
test "upstream/generated/blockflex/blockflex_flex_in_block" {
  // Ported from taffy-reference/tests/generated/blockflex/blockflex_flex_in_block.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_flex()),
    [node00],
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(200.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 200.0)
  assert_eq(l_node.size.height, 70.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 200.0)
  assert_eq(l_node0.size.height, 50.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 50.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 20.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 50.0)
}

///|
test "upstream/generated/blockflex/blockflex_margin_y_collapse_through_blocked_by_flex" {
  // Ported from taffy-reference/tests/generated/blockflex/blockflex_margin_y_collapse_through_blocked_by_flex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
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
      Rect(
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
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
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
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
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
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
  // Ported from taffy-reference/tests/generated/blockflex/blockflex_overflow_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_flex_grow(1.0),
    TextMeasure::{ text_content: "HHHH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()).with_flex_grow(1.0),
    TextMeasure::{ text_content: "HHHH\u{200B}HH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(20.0), height=length(50.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 20.0)
  assert_eq(l_node.size.height, 50.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 0.0)
  assert_eq(l_node0.size.height, 50.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 40.0)
  assert_eq(l_node1.size.height, 50.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 0.0)
}

///|
test "upstream/generated/blockflex/mod" {
  // Upstream module declaration file; no runnable test vectors.
  ()
}
