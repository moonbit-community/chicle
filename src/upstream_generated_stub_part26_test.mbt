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
test "upstream/generated/flex/overflow_cross_axis" {
  // Ported from taffy-reference/tests/generated/flex/overflow_cross_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(200.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
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
  assert_eq(l0.size.height, 200.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/overflow_main_axis" {
  // Ported from taffy-reference/tests/generated/flex/overflow_main_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(200.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/overflow_main_axis_shrink_hidden" {
  // Ported from taffy-reference/tests/generated/flex/overflow_main_axis_shrink_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_flex_shrink(1.0),
    TextMeasure::{ text_content: "HHHHHHHHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/flex/overflow_main_axis_shrink_scroll" {
  // Ported from taffy-reference/tests/generated/flex/overflow_main_axis_shrink_scroll.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_flex_shrink(1.0),
    TextMeasure::{ text_content: "HHHHHHHHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/flex/overflow_main_axis_shrink_visible" {
  // Ported from taffy-reference/tests/generated/flex/overflow_main_axis_shrink_visible.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_flex_shrink(1.0),
    TextMeasure::{ text_content: "HHHHHHHHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 50.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/overflow_scroll_main_axis_justify_content_end" {
  // Ported from taffy-reference/tests/generated/flex/overflow_scroll_main_axis_justify_content_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(200.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_end())
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
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, -100.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/overflow_scrollbars_overridden_by_available_space" {
  // Ported from taffy-reference/tests/generated/flex/overflow_scrollbars_overridden_by_available_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node0 = taffy.new_with_children(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_flex_grow(1.0),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(2.0), height=length(4.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 2.0, 4.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 2.0, 4.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/generated/flex/overflow_scrollbars_overridden_by_max_size" {
  // Ported from taffy-reference/tests/generated/flex/overflow_scrollbars_overridden_by_max_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node = taffy.new_with_children(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_max_size(Size(width=length(2.0), height=length(4.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 2.0, 4.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/generated/flex/overflow_scrollbars_overridden_by_size" {
  // Ported from taffy-reference/tests/generated/flex/overflow_scrollbars_overridden_by_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node = taffy.new_with_children(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(2.0), height=length(4.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 2.0, 4.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/generated/flex/overflow_scrollbars_take_up_space_both_axis" {
  // Ported from taffy-reference/tests/generated/flex/overflow_scrollbars_take_up_space_both_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node = taffy.new_with_children(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 35.0, 35.0, 0.0, 0.0)
}

///|
test "upstream/generated/flex/overflow_scrollbars_take_up_space_cross_axis" {
  // Ported from taffy-reference/tests/generated/flex/overflow_scrollbars_take_up_space_cross_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node = taffy.new_with_children(
    Style::default()
    .with_overflow(Point(x=overflow_visible(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 35.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/flex/overflow_scrollbars_take_up_space_main_axis" {
  // Ported from taffy-reference/tests/generated/flex/overflow_scrollbars_take_up_space_main_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node = taffy.new_with_children(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_visible()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 35.0, 0.0, 0.0)
}

///|
test "upstream/generated/flex/padding_align_end_child" {
  // Ported from taffy-reference/tests/generated/flex/padding_align_end_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(20.0),
        right=length(20.0),
        top=length(20.0),
        bottom=length(20.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_flex_end())
    .with_justify_content(justify_content_flex_end())
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 100.0)
  assert_eq(l0.location.y, 100.0)
}

///|
test "upstream/generated/flex/padding_border_overrides_max_size" {
  // Ported from taffy-reference/tests/generated/flex/padding_border_overrides_max_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 22.0)
  assert_eq(lnode.size.height, 14.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 22.0)
  assert_eq(l0.size.height, 14.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/padding_border_overrides_min_size" {
  // Ported from taffy-reference/tests/generated/flex/padding_border_overrides_min_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 22.0)
  assert_eq(lnode.size.height, 14.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 22.0)
  assert_eq(l0.size.height, 14.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/padding_border_overrides_size" {
  // Ported from taffy-reference/tests/generated/flex/padding_border_overrides_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 22.0)
  assert_eq(lnode.size.height, 14.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 22.0)
  assert_eq(l0.size.height, 14.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/padding_border_overrides_size_flex_basis_0" {
  // Ported from taffy-reference/tests/generated/flex/padding_border_overrides_size_flex_basis_0.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_basis(length(0.0))
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
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_basis(length(0.0))
    .with_size(Size(width=length(12.0), height=length(12.0))),
  )
  let node = taffy.new_with_children(Style::default(), [node0, node1])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 34.0)
  assert_eq(lnode.size.height, 14.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 22.0)
  assert_eq(l0.size.height, 14.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 12.0)
  assert_eq(l1.location.x, 22.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/padding_border_overrides_size_flex_basis_0_growable" {
  // Ported from taffy-reference/tests/generated/flex/padding_border_overrides_size_flex_basis_0_growable.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(length(0.0))
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
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_basis(length(0.0))
    .with_size(Size(width=length(12.0), height=length(12.0))),
  )
  let node = taffy.new_with_children(Style::default(), [node0, node1])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 34.0)
  assert_eq(lnode.size.height, 14.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 28.0)
  assert_eq(l0.size.height, 14.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 6.0)
  assert_eq(l1.size.height, 12.0)
  assert_eq(l1.location.x, 28.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/padding_border_overrides_size_root" {
  // Ported from taffy-reference/tests/generated/flex/padding_border_overrides_size_root.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node = taffy.new_with_children(
    Style::default()
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
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 22.0)
  assert_eq(lnode.size.height, 14.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 15.0)
  assert_eq(l0.location.y, 3.0)
}

///|
test "upstream/generated/flex/padding_center_child" {
  // Ported from taffy-reference/tests/generated/flex/padding_center_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(20.0),
      ),
    ),
    [node0],
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
  assert_eq(l0.location.x, 40.0)
  assert_eq(l0.location.y, 40.0)
}

///|
test "upstream/generated/flex/padding_container_match_child" {
  // Ported from taffy-reference/tests/generated/flex/padding_container_match_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 30.0)
  assert_eq(lnode.size.height, 30.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/padding_flex_child" {
  // Ported from taffy-reference/tests/generated/flex/padding_flex_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=length(10.0), height=auto())),
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
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 80.0)
  assert_eq(l0.size.height, 80.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/padding_no_child" {
  // Ported from taffy-reference/tests/generated/flex/padding_no_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf(
    Style::default().with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 20.0)
  assert_eq(lnode.size.height, 20.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
}

///|
test "upstream/generated/flex/padding_no_size" {
  // Ported from taffy-reference/tests/generated/flex/padding_no_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf(
    Style::default().with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 20.0)
  assert_eq(lnode.size.height, 20.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
}

///|
test "upstream/generated/flex/padding_stretch_child" {
  // Ported from taffy-reference/tests/generated/flex/padding_stretch_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
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
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}
