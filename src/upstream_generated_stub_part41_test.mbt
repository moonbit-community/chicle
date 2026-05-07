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
test "upstream/generated/gridflex/gridflex_row_integration" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_row_integration.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node02 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node03 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([fr(1.0), fr(1.0)])
    .with_grid_template_columns([fr(1.0), fr(1.0)]),
    [node00, node01, node02, node03],
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 40.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 20.0)
  assert_eq(l01.size.height, 10.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 0.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 20.0)
  assert_eq(l02.size.height, 10.0)
  assert_eq(l02.location.x, 0.0)
  assert_eq(l02.location.y, 10.0)
  let l03 = taffy.layout(node03)
  assert_eq(l03.size.width, 20.0)
  assert_eq(l03.size.height, 10.0)
  assert_eq(l03.location.x, 20.0)
  assert_eq(l03.location.y, 10.0)
}

///|
test "upstream/generated/gridflex/mod" {
  // Upstream mod.rs only declares submodules; no standalone runnable vector.
  ()
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_affect_available_space_x_axis" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_affect_available_space_x_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_visible()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(45.0), height=length(45.0))),
    TextMeasure::{
      text_content: "HHHHHHHHHHHHHHHHHHHHH",
      writing_mode: Horizontal,
    },
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 45.0)
  assert_eq(l_node.size.height, 45.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_affect_available_space_y_axis" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_affect_available_space_y_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_visible(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(45.0), height=length(45.0))),
    TextMeasure::{
      text_content: "HHHHHHHHHHHHHHHHHHHHH",
      writing_mode: Horizontal,
    },
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 45.0)
  assert_eq(l_node.size.height, 45.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_overridden_by_available_space" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_overridden_by_available_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_flex_grow(1.0),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(2.0), height=length(4.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 2.0)
  assert_eq(l_node.size.height, 4.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 2.0)
  assert_eq(l0.size.height, 4.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_overridden_by_max_size" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_overridden_by_max_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_max_size(Size(width=length(2.0), height=length(4.0))),
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 2.0)
  assert_eq(l_node.size.height, 4.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_overridden_by_size" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_overridden_by_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(2.0), height=length(4.0))),
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 2.0)
  assert_eq(l_node.size.height, 4.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_take_up_space_both_axis" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_take_up_space_both_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0),
    TextMeasure::{ text_content: "HH", writing_mode: Horizontal },
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 35.0)
  assert_eq(l_node.size.height, 25.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_take_up_space_x_axis" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_take_up_space_x_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_visible()))
    .with_scrollbar_width(15.0),
    TextMeasure::{ text_content: "HH", writing_mode: Horizontal },
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 20.0)
  assert_eq(l_node.size.height, 25.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_overflow_scrollbars_take_up_space_y_axis" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_overflow_scrollbars_take_up_space_y_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_visible(), y=overflow_scroll()))
    .with_scrollbar_width(15.0),
    TextMeasure::{ text_content: "HH", writing_mode: Horizontal },
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 35.0)
  assert_eq(l_node.size.height, 10.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_padding_border_overrides_max_size" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_padding_border_overrides_max_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf(
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
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 22.0)
  assert_eq(l_node.size.height, 14.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_padding_border_overrides_min_size" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_padding_border_overrides_min_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf(
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
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 22.0)
  assert_eq(l_node.size.height, 14.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_padding_border_overrides_size" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_padding_border_overrides_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf(
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
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 22.0)
  assert_eq(l_node.size.height, 14.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_with_content_and_border" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_with_content_and_border.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(
    Style::default().with_border(
      Rect(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    ),
    TextMeasure::{ text_content: "HHHH", writing_mode: Horizontal },
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 52.0)
  assert_eq(l_node.size.height, 18.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_with_content_and_padding" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_with_content_and_padding.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(
    Style::default().with_padding(
      Rect(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    ),
    TextMeasure::{ text_content: "HHHH", writing_mode: Horizontal },
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 52.0)
  assert_eq(l_node.size.height, 18.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/leaf_with_content_and_padding_border" {
  // Ported from taffy-reference/tests/generated/leaf/leaf_with_content_and_padding_border.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(
    Style::default()
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
    TextMeasure::{ text_content: "HHHH", writing_mode: Horizontal },
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 62.0)
  assert_eq(l_node.size.height, 24.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
}

///|
test "upstream/generated/leaf/mod" {
  // Upstream mod.rs only declares submodules; no standalone runnable vector.
  ()
}

///|
test "upstream/generated/./mod" {
  // Upstream mod.rs only declares submodules; no standalone runnable vector.
  ()
}
