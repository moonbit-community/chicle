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
test "upstream/generated/block/block_margin_y_last_child_collapse_negative_equal" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_negative_equal.rs
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
        bottom=length(-10.0),
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
        bottom=length(-10.0),
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
        bottom=length(-5.0),
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
        bottom=length(-10.0),
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
        bottom=length(-10.0),
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
        bottom=length(-5.0),
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
test "upstream/generated/block/block_margin_y_last_child_collapse_not_blocked_by_padding_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_not_blocked_by_padding_top.rs
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
        bottom=length(-10.0),
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
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(-10.0),
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
      Rect(
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
test "upstream/generated/block/block_margin_y_last_child_collapse_positive_parent_larger" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_positive_parent_larger.rs
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
        bottom=length(5.0),
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
test "upstream/generated/block/block_margin_y_last_child_collapse_positive_parent_smaller" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_child_collapse_positive_parent_smaller.rs
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
        bottom=length(5.0),
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
test "upstream/generated/block/block_margin_y_last_granchild_collapse_positive_equal" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_last_granchild_collapse_positive_equal.rs
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
  let l_node0000 = taffy.layout(node0000)
  assert_eq(l_node0000.size.width, 50.0)
  assert_eq(l_node0000.size.height, 10.0)
  assert_eq(l_node0000.location.x, 0.0)
  assert_eq(l_node0000.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_sibling_collapse_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-5.0),
        bottom=length(-5.0),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
  // Ported from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_negative_percentage.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(-0.1),
        bottom=percent(-0.1),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(-0.1),
        bottom=percent(-0.1),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(-0.05),
        bottom=percent(-0.05),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(-0.1),
        bottom=percent(-0.1),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 15.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, -5.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 0.0)
  let l_node2 = taffy.layout(node2)
  assert_eq(l_node2.size.width, 50.0)
  assert_eq(l_node2.size.height, 10.0)
  assert_eq(l_node2.location.x, 0.0)
  assert_eq(l_node2.location.y, 5.0)
  let l_node3 = taffy.layout(node3)
  assert_eq(l_node3.size.width, 50.0)
  assert_eq(l_node3.size.height, 10.0)
  assert_eq(l_node3.location.x, 0.0)
  assert_eq(l_node3.location.y, 10.0)
}

///|
test "upstream/generated/block/block_margin_y_sibling_collapse_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
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
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
  // Ported from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive_and_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node5 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(5.0),
        bottom=length(-5.0),
      ),
    ),
  )
  let node6 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6],
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
  assert_eq(l_node1.location.y, 20.0)
  let l_node2 = taffy.layout(node2)
  assert_eq(l_node2.size.width, 50.0)
  assert_eq(l_node2.size.height, 10.0)
  assert_eq(l_node2.location.x, 0.0)
  assert_eq(l_node2.location.y, 35.0)
  let l_node3 = taffy.layout(node3)
  assert_eq(l_node3.size.width, 50.0)
  assert_eq(l_node3.size.height, 10.0)
  assert_eq(l_node3.location.x, 0.0)
  assert_eq(l_node3.location.y, 40.0)
  let l_node4 = taffy.layout(node4)
  assert_eq(l_node4.size.width, 50.0)
  assert_eq(l_node4.size.height, 10.0)
  assert_eq(l_node4.location.x, 0.0)
  assert_eq(l_node4.location.y, 50.0)
  let l_node5 = taffy.layout(node5)
  assert_eq(l_node5.size.width, 50.0)
  assert_eq(l_node5.size.height, 10.0)
  assert_eq(l_node5.location.x, 0.0)
  assert_eq(l_node5.location.y, 55.0)
  let l_node6 = taffy.layout(node6)
  assert_eq(l_node6.size.width, 50.0)
  assert_eq(l_node6.size.height, 10.0)
  assert_eq(l_node6.location.x, 0.0)
  assert_eq(l_node6.location.y, 70.0)
}

///|
test "upstream/generated/block/block_margin_y_sibling_collapse_positive_and_negative_percentage" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive_and_negative_percentage.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(-0.1),
        bottom=percent(0.1),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(-0.05),
        bottom=percent(0.05),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(-0.1),
        bottom=percent(-0.1),
      ),
    ),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.1),
        bottom=percent(-0.1),
      ),
    ),
  )
  let node5 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.05),
        bottom=percent(-0.05),
      ),
    ),
  )
  let node6 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 80.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 5.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 15.0)
  let l_node2 = taffy.layout(node2)
  assert_eq(l_node2.size.width, 50.0)
  assert_eq(l_node2.size.height, 10.0)
  assert_eq(l_node2.location.x, 0.0)
  assert_eq(l_node2.location.y, 28.0)
  let l_node3 = taffy.layout(node3)
  assert_eq(l_node3.size.width, 50.0)
  assert_eq(l_node3.size.height, 10.0)
  assert_eq(l_node3.location.x, 0.0)
  assert_eq(l_node3.location.y, 35.0)
  let l_node4 = taffy.layout(node4)
  assert_eq(l_node4.size.width, 50.0)
  assert_eq(l_node4.size.height, 10.0)
  assert_eq(l_node4.location.x, 0.0)
  assert_eq(l_node4.location.y, 45.0)
  let l_node5 = taffy.layout(node5)
  assert_eq(l_node5.size.width, 50.0)
  assert_eq(l_node5.size.height, 10.0)
  assert_eq(l_node5.location.x, 0.0)
  assert_eq(l_node5.location.y, 53.0)
  let l_node6 = taffy.layout(node6)
  assert_eq(l_node6.size.width, 50.0)
  assert_eq(l_node6.size.height, 10.0)
  assert_eq(l_node6.location.x, 0.0)
  assert_eq(l_node6.location.y, 65.0)
}

///|
test "upstream/generated/block/block_margin_y_sibling_collapse_positive_percentage" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_sibling_collapse_positive_percentage.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 65.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 5.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 20.0)
  let l_node2 = taffy.layout(node2)
  assert_eq(l_node2.size.width, 50.0)
  assert_eq(l_node2.size.height, 10.0)
  assert_eq(l_node2.location.x, 0.0)
  assert_eq(l_node2.location.y, 35.0)
  let l_node3 = taffy.layout(node3)
  assert_eq(l_node3.size.width, 50.0)
  assert_eq(l_node3.size.height, 10.0)
  assert_eq(l_node3.location.x, 0.0)
  assert_eq(l_node3.location.y, 50.0)
}

///|
test "upstream/generated/block/block_margin_y_simple_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_simple_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  // Ported from taffy-reference/tests/generated/block/block_margin_y_simple_negative_percentage_other.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(-0.1),
        bottom=percent(-0.1),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 10.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, -5.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_simple_negative_percentage_self" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_simple_negative_percentage_self.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(-0.1),
        bottom=percent(-0.1),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 10.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, -5.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 0.0)
}

///|
test "upstream/generated/block/block_margin_y_simple_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_simple_positive.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  // Ported from taffy-reference/tests/generated/block/block_margin_y_simple_positive_percentage_other.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0, node1],
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
  assert_eq(l_node0.location.y, 5.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 20.0)
}

///|
test "upstream/generated/block/block_margin_y_simple_positive_percentage_self" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_simple_positive_percentage_self.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.1),
        bottom=percent(0.1),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0, node1],
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
  assert_eq(l_node0.location.y, 5.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 10.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 20.0)
}

///|
test "upstream/generated/block/block_margin_y_total_collapse" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_total_collapse.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
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
  let node01 = taffy.new_leaf(
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
  )
  let node02 = taffy.new_leaf(
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
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [node00, node01, node02],
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
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 10.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 50.0)
  assert_eq(l_node00.size.height, 10.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
  let l_node01 = taffy.layout(node01)
  assert_eq(l_node01.size.width, 50.0)
  assert_eq(l_node01.size.height, 0.0)
  assert_eq(l_node01.location.x, 0.0)
  assert_eq(l_node01.location.y, 20.0)
  let l_node02 = taffy.layout(node02)
  assert_eq(l_node02.size.width, 50.0)
  assert_eq(l_node02.size.height, 10.0)
  assert_eq(l_node02.location.x, 0.0)
  assert_eq(l_node02.location.y, 20.0)
}

///|
test "upstream/generated/block/block_margin_y_total_collapse_complex" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_total_collapse_complex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(-10.0),
      ),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-5.0),
        bottom=length(-5.0),
      ),
    ),
  )
  let node11 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(7.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node12 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-6.0),
        bottom=length(9.0),
      ),
    ),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
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
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-5.0),
        bottom=length(-5.0),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
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
    .with_size(Size(width=length(50.0), height=auto())),
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
  let l_node10 = taffy.layout(node10)
  assert_eq(l_node10.size.width, 0.0)
  assert_eq(l_node10.size.height, 10.0)
  assert_eq(l_node10.location.x, 0.0)
  assert_eq(l_node10.location.y, -5.0)
  let l_node11 = taffy.layout(node11)
  assert_eq(l_node11.size.width, 0.0)
  assert_eq(l_node11.size.height, 10.0)
  assert_eq(l_node11.location.x, 0.0)
  assert_eq(l_node11.location.y, 7.0)
  let l_node12 = taffy.layout(node12)
  assert_eq(l_node12.size.width, 0.0)
  assert_eq(l_node12.size.height, 10.0)
  assert_eq(l_node12.location.x, 0.0)
  assert_eq(l_node12.location.y, -6.0)
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
test "upstream/generated/block/block_overflow_scrollbars_overridden_by_available_space" {
  // Ported from taffy-reference/tests/generated/block/block_overflow_scrollbars_overridden_by_available_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
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
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
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
  assert_eq(l_node0.size.width, 2.0)
  assert_eq(l_node0.size.height, 15.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node00 = taffy.layout(node00)
  assert_eq(l_node00.size.width, 0.0)
  assert_eq(l_node00.size.height, 0.0)
  assert_eq(l_node00.location.x, 0.0)
  assert_eq(l_node00.location.y, 0.0)
}
