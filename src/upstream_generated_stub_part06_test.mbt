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
test "upstream/generated/block/block_margin_y_collapse_through_positive_and_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_positive_and_negative.rs
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
        bottom=length(-10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
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
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
      Rect(
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
    .with_display(display_block())
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
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    )
    .with_overflow(Point(x=overflow_hidden(), y=overflow_visible())),
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_visible()))
    .with_scrollbar_width(15.0)
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_visible(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_visible(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
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
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    )
    .with_padding(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
    .with_display(display_block())
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
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    )
    .with_padding(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node100 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node10 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
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
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node10],
  )
  let node200 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node20 = taffy.new_with_children(
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
    [node200],
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
    .with_display(display_block())
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
    .with_display(display_block())
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0000 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node000 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
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
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node1000 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node100 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
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
      Rect(
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
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [node10],
  )
  let node2000 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node200 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
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
      Rect(
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
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0000 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node000 = taffy.new_with_children(
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
    [node0000],
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
    .with_display(display_block())
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
    .with_display(display_block())
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_hidden(), y=overflow_visible()))
    .with_scrollbar_width(15.0)
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_visible()))
    .with_scrollbar_width(15.0)
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_visible(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_visible(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
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
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    )
    .with_padding(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
