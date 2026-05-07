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
test "upstream/generated/flex/gap_column_gap_wrap_align_stretch" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_gap_wrap_align_stretch.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_min_size(Size(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_min_size(Size(width=length(60.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_min_size(Size(width=length(60.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_min_size(Size(width=length(60.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_min_size(Size(width=length(60.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_gap(Size(width=length(5.0), height=length(0.0)))
    .with_size(Size(width=length(300.0), height=length(300.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 300.0)
  assert_eq(lnode.size.height, 300.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 71.0)
  assert_eq(l0.size.height, 150.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 72.0)
  assert_eq(l1.size.height, 150.0)
  assert_eq(l1.location.x, 76.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 71.0)
  assert_eq(l2.size.height, 150.0)
  assert_eq(l2.location.x, 153.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 71.0)
  assert_eq(l3.size.height, 150.0)
  assert_eq(l3.location.x, 229.0)
  assert_eq(l3.location.y, 0.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 300.0)
  assert_eq(l4.size.height, 150.0)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 150.0)
}

///|
test "upstream/generated/flex/gap_column_row_gap_wrapping" {
  // Ported from taffy-reference/tests/generated/flex/gap_column_row_gap_wrapping.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node8 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(80.0), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 80.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 40.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 40.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 60.0)
  assert_eq(l5.location.y, 40.0)
  let l6 = taffy.layout(node6)
  assert_eq(l6.size.width, 20.0)
  assert_eq(l6.size.height, 20.0)
  assert_eq(l6.location.x, 0.0)
  assert_eq(l6.location.y, 80.0)
  let l7 = taffy.layout(node7)
  assert_eq(l7.size.width, 20.0)
  assert_eq(l7.size.height, 20.0)
  assert_eq(l7.location.x, 30.0)
  assert_eq(l7.location.y, 80.0)
  let l8 = taffy.layout(node8)
  assert_eq(l8.size.width, 20.0)
  assert_eq(l8.size.height, 20.0)
  assert_eq(l8.location.x, 60.0)
  assert_eq(l8.location.y, 80.0)
}

///|
test "upstream/generated/flex/gap_row_gap_align_items_end" {
  // Ported from taffy-reference/tests/generated/flex/gap_row_gap_align_items_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_flex_end())
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(100.0), height=length(200.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 90.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 90.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 0.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 90.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 0.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 200.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 0.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 200.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 0.0)
  assert_eq(l5.location.x, 60.0)
  assert_eq(l5.location.y, 200.0)
}

///|
test "upstream/generated/flex/gap_row_gap_align_items_stretch" {
  // Ported from taffy-reference/tests/generated/flex/gap_row_gap_align_items_stretch.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_stretch())
    .with_align_content(align_content_stretch())
    .with_gap(Size(width=length(10.0), height=length(20.0)))
    .with_size(Size(width=length(100.0), height=length(200.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 90.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 90.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 90.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 90.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 110.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 90.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 110.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 90.0)
  assert_eq(l5.location.x, 60.0)
  assert_eq(l5.location.y, 110.0)
}

///|
test "upstream/generated/flex/gap_row_gap_column_child_margins" {
  // Ported from taffy-reference/tests/generated/flex/gap_row_gap_column_child_margins.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(2.0),
        bottom=length(2.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
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
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(15.0),
        bottom=length(15.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_gap(Size(width=length(0.0), height=length(10.0)))
    .with_size(Size(width=length(100.0), height=length(200.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 42.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 2.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 42.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 66.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 42.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 143.0)
}

///|
test "upstream/generated/flex/gap_row_gap_determines_parent_height" {
  // Ported from taffy-reference/tests/generated/flex/gap_row_gap_determines_parent_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(30.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_stretch())
    .with_gap(Size(width=length(0.0), height=length(10.0)))
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 80.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 50.0)
}

///|
test "upstream/generated/flex/gap_row_gap_percentage_wrapping" {
  // Ported from taffy-reference/tests/generated/flex/gap_row_gap_percentage_wrapping.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node8 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_gap(Size(width=length(10.0), height=percent(0.1)))
    .with_size(Size(width=length(80.0), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 80.0)
  assert_eq(lnode.size.height, 60.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 20.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 20.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 60.0)
  assert_eq(l5.location.y, 20.0)
  let l6 = taffy.layout(node6)
  assert_eq(l6.size.width, 20.0)
  assert_eq(l6.size.height, 20.0)
  assert_eq(l6.location.x, 0.0)
  assert_eq(l6.location.y, 40.0)
  let l7 = taffy.layout(node7)
  assert_eq(l7.size.width, 20.0)
  assert_eq(l7.size.height, 20.0)
  assert_eq(l7.location.x, 30.0)
  assert_eq(l7.location.y, 40.0)
  let l8 = taffy.layout(node8)
  assert_eq(l8.size.width, 20.0)
  assert_eq(l8.size.height, 20.0)
  assert_eq(l8.location.x, 60.0)
  assert_eq(l8.location.y, 40.0)
}

///|
test "upstream/generated/flex/gap_row_gap_row_wrap_child_margins" {
  // Ported from taffy-reference/tests/generated/flex/gap_row_gap_row_wrap_child_margins.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(60.0), height=auto()))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(2.0),
        bottom=length(2.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(60.0), height=auto()))
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
    .with_size(Size(width=length(60.0), height=auto()))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(15.0),
        bottom=length(15.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_gap(Size(width=length(0.0), height=length(10.0)))
    .with_size(Size(width=length(100.0), height=length(200.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 42.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 2.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 42.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 66.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 60.0)
  assert_eq(l2.size.height, 42.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 143.0)
}

///|
test "upstream/generated/flex/intrinsic_sizing_cross_size_column" {
  // Ported from taffy-reference/tests/generated/flex/intrinsic_sizing_cross_size_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(
    Style::default().with_flex_direction(flex_direction_column()),
    TextMeasure::{ text_content: "HH\u{200b}HH", writing_mode: Horizontal },
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 40.0)
  assert_eq(lnode.size.height, 10.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_column" {
  // Ported from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(
    Style::default().with_flex_direction(flex_direction_column()),
    TextMeasure::{ text_content: "HH\u{200b}HH", writing_mode: Vertical },
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 10.0)
  assert_eq(lnode.size.height, 40.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_column_nested" {
  // Ported from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_column_nested.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_flex_direction(flex_direction_column()),
    TextMeasure::{ text_content: "HH\u{200b}HH", writing_mode: Vertical },
  )
  let node = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 10.0)
  assert_eq(lnode.size.height, 40.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_column_wrap" {
  // Ported from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_column_wrap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_flex_direction(flex_direction_column()),
    TextMeasure::{ text_content: "HH\u{200b}HH", writing_mode: Vertical },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_flex_direction(flex_direction_column()),
    TextMeasure::{ text_content: "HH\u{200b}HH", writing_mode: Vertical },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap()),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 10.0)
  assert_eq(lnode.size.height, 80.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 40.0)
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_row" {
  // Ported from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200b}HH",
    writing_mode: Horizontal,
  })
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 40.0)
  assert_eq(lnode.size.height, 10.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_row_nested" {
  // Ported from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_row_nested.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200b}HH",
    writing_mode: Horizontal,
  })
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 40.0)
  assert_eq(lnode.size.height, 10.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/intrinsic_sizing_main_size_row_wrap" {
  // Ported from taffy-reference/tests/generated/flex/intrinsic_sizing_main_size_row_wrap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200b}HH",
    writing_mode: Horizontal,
  })
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200b}HH",
    writing_mode: Horizontal,
  })
  let node = taffy.new_with_children(
    Style::default().with_flex_wrap(flex_wrap_wrap()),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 80.0)
  assert_eq(lnode.size.height, 10.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/justify_content_column_center" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_center.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 35.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 45.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 55.0)
}

///|
test "upstream/generated/flex/justify_content_column_center_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_center_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, -25.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, -5.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 15.0)
}

///|
test "upstream/generated/flex/justify_content_column_center_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_center_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, -35.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, -5.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 25.0)
}

///|
test "upstream/generated/flex/justify_content_column_end" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_flex_end())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 70.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 80.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 90.0)
}

///|
test "upstream/generated/flex/justify_content_column_end_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_end_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_end())
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, -50.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, -30.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, -10.0)
}

///|
test "upstream/generated/flex/justify_content_column_end_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_end_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_end())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, -70.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, -40.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, -10.0)
}

///|
test "upstream/generated/flex/justify_content_column_end_reverse" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_end_reverse.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_flex_end())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 70.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 80.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 90.0)
}

///|
test "upstream/generated/flex/justify_content_column_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_flex_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_flex_end())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 70.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 80.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 90.0)
}

///|
test "upstream/generated/flex/justify_content_column_flex_end_reverse" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_flex_end_reverse.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column_reverse())
    .with_justify_content(justify_content_flex_end())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 20.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/justify_content_column_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_flex_start())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 20.0)
}
