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
test "upstream/generated/flex/align_baseline_multiline_column2" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_multiline_column2.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(30.0), height=length(50.0))),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(40.0), height=length(70.0))),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(20.0))),
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

///|
test "upstream/generated/flex/align_baseline_multiline_row_and_column" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_multiline_row_and_column.rs
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
    .with_size(Size(width=length(50.0), height=length(50.0))),
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
    Style::default().with_size(Size(width=length(50.0), height=length(20.0))),
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
  assert_eq(l1.size.height, 50.0)
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
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 90.0)
}

///|
test "upstream/generated/flex/align_baseline_nested_child" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_nested_child.rs
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
test "upstream/generated/flex/align_baseline_nested_column" {
  // Ported from taffy-reference/tests/generated/flex/align_baseline_nested_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(60.0))),
  )
  let node100 = taffy.new_leaf(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(30.0))),
  )
  let node101 = taffy.new_leaf(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(40.0))),
  )
  let node10 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=length(80.0))),
    [node100, node101],
  )
  let node1 = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
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
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 80.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 30.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 80.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l100 = taffy.layout(node100)
  assert_eq(l100.size.width, 50.0)
  assert_eq(l100.size.height, 30.0)
  assert_eq(l100.location.x, 0.0)
  assert_eq(l100.location.y, 0.0)
  let l101 = taffy.layout(node101)
  assert_eq(l101.size.width, 50.0)
  assert_eq(l101.size.height, 40.0)
  assert_eq(l101.location.x, 0.0)
  assert_eq(l101.location.y, 30.0)
}

///|
test "upstream/generated/flex/align_center_should_size_based_on_content" {
  // Ported from taffy-reference/tests/generated/flex/align_center_should_size_based_on_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_center())
    .with_flex_grow(0.0)
    .with_flex_shrink(1.0),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 40.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 20.0)
  assert_eq(l000.size.height, 20.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_center_single_line" {
  // Ported from taffy-reference/tests/generated/flex/align_content_center_single_line.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_center())
    .with_size(Size(width=length(120.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 120.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 20.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 40.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 20.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 60.0)
  assert_eq(l3.location.y, 0.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 10.0)
  assert_eq(l4.location.x, 80.0)
  assert_eq(l4.location.y, 0.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 10.0)
  assert_eq(l5.location.x, 100.0)
  assert_eq(l5.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_center_single_line_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_center_single_line_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00],
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
  assert_eq(l00.size.height, 60.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_center_single_line_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_center_single_line_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_center())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00],
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
  assert_eq(l00.size.height, 60.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_center_wrapped" {
  // Ported from taffy-reference/tests/generated/flex/align_content_center_wrapped.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let mk = fn() {
    taffy.new_leaf(
      Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
    )
  }
  let node0 = mk()
  let node1 = mk()
  let node2 = mk()
  let node3 = mk()
  let node4 = mk()
  let node5 = mk()
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_center())
    .with_size(Size(width=length(120.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(node, Size::max_content())
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 120.0)
  assert_eq(l_node.size.height, 100.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 35.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 35.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 45.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 45.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 55.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.location.x, 50.0)
  assert_eq(l5.location.y, 55.0)
}

///|
test "upstream/generated/flex/align_content_center_wrapped_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_center_wrapped_negative_space.rs
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
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_center())
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
test "upstream/generated/flex/align_content_center_wrapped_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_center_wrapped_negative_space_gap.rs
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
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_center())
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
test "upstream/generated/flex/align_content_end" {
  // Ported from taffy-reference/tests/generated/flex/align_content_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_end())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 50.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 50.0)
  assert_eq(l2.location.y, 20.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 30.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 10.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 40.0)
}

///|
test "upstream/generated/flex/align_content_end_single_line_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_end_single_line_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_end())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00],
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
  assert_eq(l00.size.height, 60.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_end_single_line_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_end_single_line_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_end())
    .with_justify_content(justify_content_center())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00],
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
  assert_eq(l00.size.height, 60.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_end_wrapped_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_end_wrapped_negative_space.rs
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
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_end())
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
test "upstream/generated/flex/align_content_end_wrapped_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_end_wrapped_negative_space_gap.rs
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
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_end())
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
test "upstream/generated/flex/align_content_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/align_content_flex_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_flex_end())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 50.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 50.0)
  assert_eq(l2.location.y, 20.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 30.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 10.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 40.0)
}

///|
test "upstream/generated/flex/align_content_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/align_content_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(130.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 130.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 10.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 10.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 10.0)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 20.0)
}

///|
test "upstream/generated/flex/align_content_flex_start_with_flex" {
  // Ported from taffy-reference/tests/generated/flex/align_content_flex_start_with_flex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(0.0)
    .with_flex_basis(percent(0.0))
    .with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(0.0)
    .with_flex_basis(percent(0.0))
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_size(Size(width=length(50.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=length(120.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 120.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 40.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 0.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 80.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 40.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 80.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 0.0)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 120.0)
}

///|
test "upstream/generated/flex/align_content_flex_start_without_height_on_children" {
  // Ported from taffy-reference/tests/generated/flex/align_content_flex_start_without_height_on_children.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 0.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 10.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 10.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 0.0)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 20.0)
}

///|
test "upstream/generated/flex/align_content_not_stretch_with_align_items_stretch" {
  // Ported from taffy-reference/tests/generated/flex/align_content_not_stretch_with_align_items_stretch.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(272.0), height=length(44.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
    [node00],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(56.0), height=length(44.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(328.0), height=length(52.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 328.0)
  assert_eq(lnode.size.height, 52.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 272.0)
  assert_eq(l0.size.height, 44.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 272.0)
  assert_eq(l00.size.height, 44.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 56.0)
  assert_eq(l1.size.height, 44.0)
  assert_eq(l1.location.x, 272.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 56.0)
  assert_eq(l10.size.height, 44.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_space_around_single_line" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_around_single_line.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_space_around())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 17.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 16.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 17.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 17.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 33.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 17.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 0.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 16.0)
  assert_eq(l4.size.height, 10.0)
  assert_eq(l4.location.x, 67.0)
  assert_eq(l4.location.y, 0.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 17.0)
  assert_eq(l5.size.height, 10.0)
  assert_eq(l5.location.x, 83.0)
  assert_eq(l5.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_space_around_single_line_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_around_single_line_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_space_around())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00],
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
  assert_eq(l00.size.height, 60.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_space_around_single_line_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_around_single_line_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_space_around())
    .with_justify_content(justify_content_center())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00],
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
  assert_eq(l00.size.height, 60.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_space_around_wrapped" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_around_wrapped.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_space_around())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 12.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 12.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 45.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 45.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 10.0)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 78.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 50.0)
  assert_eq(l5.size.height, 10.0)
  assert_eq(l5.location.x, 50.0)
  assert_eq(l5.location.y, 78.0)
}
