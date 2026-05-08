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
test "upstream/generated/flex/align_content_space_around_wrapped_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_around_wrapped_negative_space.rs
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
    .with_align_content(align_content_space_around())
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
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 20.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 40.0)
}

///|
test "upstream/generated/flex/align_content_space_around_wrapped_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_around_wrapped_negative_space_gap.rs
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
    .with_align_content(align_content_space_around())
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
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 30.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 60.0)
}

///|
test "upstream/generated/flex/align_content_space_between_single_line" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_between_single_line.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_space_between())
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
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 10.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 10.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 20.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 10.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 30.0)
  assert_eq(l3.location.y, 0.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 10.0)
  assert_eq(l4.size.height, 10.0)
  assert_eq(l4.location.x, 40.0)
  assert_eq(l4.location.y, 0.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 10.0)
  assert_eq(l5.size.height, 10.0)
  assert_eq(l5.location.x, 50.0)
  assert_eq(l5.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_space_between_single_line_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_between_single_line_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_space_between())
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
test "upstream/generated/flex/align_content_space_between_single_line_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_between_single_line_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_space_between())
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
test "upstream/generated/flex/align_content_space_between_wrapped" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_between_wrapped.rs
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
    .with_align_content(align_content_space_between())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
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
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 45.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 45.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 90.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.location.x, 50.0)
  assert_eq(l5.location.y, 90.0)
}

///|
test "upstream/generated/flex/align_content_space_between_wrapped_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_between_wrapped_negative_space.rs
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
    .with_align_content(align_content_space_between())
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
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 20.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 40.0)
}

///|
test "upstream/generated/flex/align_content_space_between_wrapped_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_between_wrapped_negative_space_gap.rs
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
    .with_align_content(align_content_space_between())
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
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 30.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 60.0)
}

///|
test "upstream/generated/flex/align_content_space_evenly_single_line" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_evenly_single_line.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_space_evenly())
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
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 10.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 10.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 20.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 10.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 30.0)
  assert_eq(l3.location.y, 0.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 10.0)
  assert_eq(l4.size.height, 10.0)
  assert_eq(l4.location.x, 40.0)
  assert_eq(l4.location.y, 0.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 10.0)
  assert_eq(l5.size.height, 10.0)
  assert_eq(l5.location.x, 50.0)
  assert_eq(l5.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_space_evenly_single_line_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_evenly_single_line_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_space_evenly())
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
test "upstream/generated/flex/align_content_space_evenly_single_line_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_evenly_single_line_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_space_evenly())
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
test "upstream/generated/flex/align_content_space_evenly_wrapped" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_evenly_wrapped.rs
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
    .with_align_content(align_content_space_evenly())
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
  assert_eq(l0.location.y, 18.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 18.0)
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
  assert_eq(l4.location.y, 73.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 50.0)
  assert_eq(l5.size.height, 10.0)
  assert_eq(l5.location.x, 50.0)
  assert_eq(l5.location.y, 73.0)
}

///|
test "upstream/generated/flex/align_content_space_evenly_wrapped_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_evenly_wrapped_negative_space.rs
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
    .with_align_content(align_content_space_evenly())
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
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 20.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 40.0)
}

///|
test "upstream/generated/flex/align_content_space_evenly_wrapped_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_space_evenly_wrapped_negative_space_gap.rs
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
    .with_align_content(align_content_space_evenly())
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
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 30.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 60.0)
}

///|
test "upstream/generated/flex/align_content_spacearound" {
  // Ported from taffy-reference/tests/generated/flex/align_content_spacearound.rs
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
    .with_align_content(align_content_space_around())
    .with_size(Size(width=length(140.0), height=length(120.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 140.0)
  assert_eq(lnode.size.height, 120.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 15.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 15.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 55.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 55.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 10.0)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 95.0)
}

///|
test "upstream/generated/flex/align_content_spacebetween" {
  // Ported from taffy-reference/tests/generated/flex/align_content_spacebetween.rs
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
    .with_align_content(align_content_space_between())
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
  assert_eq(l4.location.y, 90.0)
}

///|
test "upstream/generated/flex/align_content_start" {
  // Ported from taffy-reference/tests/generated/flex/align_content_start.rs
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
    .with_align_content(align_content_start())
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
test "upstream/generated/flex/align_content_start_single_line_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_start_single_line_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_start())
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
test "upstream/generated/flex/align_content_start_single_line_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/align_content_start_single_line_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(60.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_content(align_content_start())
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
test "upstream/generated/flex/align_content_start_wrapped_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/align_content_start_wrapped_negative_space.rs
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
    .with_align_content(align_content_start())
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
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 20.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 40.0)
}

///|
test "upstream/generated/flex/align_content_stretch" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
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
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 0.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 0.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 0.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 0.0)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_stretch_column" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=auto(), height=length(50.0))),
    [node00],
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_size(Size(width=auto(), height=length(50.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(50.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(50.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(100.0), height=length(150.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 150.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 50.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 50.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 50.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 50.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 100.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_stretch_is_not_overriding_align_items" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_is_not_overriding_align_items.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_align_content(align_content_stretch()),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 10.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 45.0)
}

///|
test "upstream/generated/flex/align_content_stretch_row" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
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
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 50.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 50.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 50.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 50.0)
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_children" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_row_with_children.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0)),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(50.0), height=auto())),
    [node00],
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
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
  assert_eq(l00.size.height, 50.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 50.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 50.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 50.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 50.0)
}
