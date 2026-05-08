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
test "upstream/generated/block/block_margin_x_intrinsic_size_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_intrinsic_size_negative.rs
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=percent(-0.2),
        right=percent(-0.1),
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
test "upstream/generated/block/block_margin_x_percentage_fixed_size_positive" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_percentage_fixed_size_positive.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=percent(0.2),
        right=percent(0.1),
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

///|
test "upstream/generated/block/block_margin_x_percentage_intrinsic_size_other_negative" {
  // Ported from taffy-reference/tests/generated/block/block_margin_x_percentage_intrinsic_size_other_negative.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=percent(-0.2),
        right=percent(-0.1),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(10.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=percent(0.2),
        right=percent(0.1),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(10.0))),
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(100.0), height=length(10.0)))
    .with_margin(
      Rect(
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(100.0), height=length(10.0)))
    .with_margin(
      Rect(
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
    .with_display(display_block())
    .with_aspect_ratio(2.0)
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 20.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_border_top" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_border_top.rs
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
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 20.0)
}

///|
test "upstream/generated/block/block_margin_y_collapse_through_blocked_by_height" {
  // Ported from taffy-reference/tests/generated/block/block_margin_y_collapse_through_blocked_by_height.rs
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
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(1.0)))
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
  let node1 = taffy.new_leaf_with_context(
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
    { text_content: "HH", writing_mode: Horizontal },
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
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(0.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    { text_content: "HH", writing_mode: Horizontal },
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
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_display(display_block())
    .with_max_size(Size(width=auto(), height=length(0.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    { text_content: "HH", writing_mode: Horizontal },
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
    .with_display(display_block())
    .with_min_size(Size(width=auto(), height=length(1.0)))
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_hidden(), y=overflow_visible()))
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_visible()))
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_visible(), y=overflow_hidden()))
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
    .with_display(display_block())
    .with_overflow(Point(x=overflow_visible(), y=overflow_scroll()))
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
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
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
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
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
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
        bottom=length(-5.0),
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
        top=length(-7.0),
        bottom=length(-3.0),
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
        top=length(-2.0),
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
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 20.0)
}
