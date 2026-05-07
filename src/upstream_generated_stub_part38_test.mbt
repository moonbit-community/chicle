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
test "upstream/generated/grid/grid_minmax_max_content_auto" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_auto.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), auto())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_fixed_10px" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_fixed_10px.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), length(10.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), grid_min_content())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_percent_definite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_percent_definite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), percent(0.2))])
    .with_size(Size(width=length(100.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_percent_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_percent_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), percent(0.2))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_1fr" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_1fr.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), fr(1.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_auto" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_auto.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), auto())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_fixed_10px" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_fixed_10px.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), length(10.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), grid_max_content())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_percent_definite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_percent_definite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), percent(0.2))])
    .with_size(Size(width=length(100.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_min_content_percent_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_min_content_percent_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_min_content(), percent(0.2))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_out_of_order_items" {
  // Ported from taffy-reference/tests/generated/grid/grid_out_of_order_items.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line(start=line(1), end=place_auto()))
    .with_size(Size(width=length(35.0), height=length(35.0))),
  )
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto()))
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_grid_auto_flow(grid_auto_flow_row_dense())
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 80.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 40.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 35.0)
  assert_eq(l2.size.height, 35.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 80.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 40.0)
  assert_eq(l3.size.height, 40.0)
  assert_eq(l3.location.x, 40.0)
  assert_eq(l3.location.y, 40.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 40.0)
  assert_eq(l4.size.height, 40.0)
  assert_eq(l4.location.x, 80.0)
  assert_eq(l4.location.y, 40.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 0.0)
  assert_eq(l5.location.y, 0.0)
  let l6 = taffy.layout(node6)
  assert_eq(l6.size.width, 40.0)
  assert_eq(l6.size.height, 40.0)
  assert_eq(l6.location.x, 40.0)
  assert_eq(l6.location.y, 80.0)
  let l7 = taffy.layout(node7)
  assert_eq(l7.size.width, 10.0)
  assert_eq(l7.size.height, 10.0)
  assert_eq(l7.location.x, 40.0)
  assert_eq(l7.location.y, 0.0)
  let l8 = taffy.layout(node8)
  assert_eq(l8.size.width, 40.0)
  assert_eq(l8.size.height, 40.0)
  assert_eq(l8.location.x, 80.0)
  assert_eq(l8.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_overflow_inline_axis_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_overflow_inline_axis_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0),
    { text_content: "HHHHHHHHHH", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_overflow_inline_axis_scroll" {
  // Ported from taffy-reference/tests/generated/grid/grid_overflow_inline_axis_scroll.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0),
    { text_content: "HHHHHHHHHH", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_overflow_inline_axis_visible" {
  // Ported from taffy-reference/tests/generated/grid/grid_overflow_inline_axis_visible.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HHHHHHHHHH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_overflow_rows" {
  // Ported from taffy-reference/tests/generated/grid/grid_overflow_rows.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(Line(start=line(1), end=span(4))),
    {
      text_content: "HHHHHHHHHHHHHHHH\u{200b}HHHHHHHHHHHHHHHH",
      writing_mode: Horizontal,
    },
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([
      grid_min_content(),
      grid_max_content(),
      length(10.0),
      percent(0.2),
    ]),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 320.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 320.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 43.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 203.0, 40.0, 43.0, 40.0)
  assert_layout_xywh(taffy, node3, 10.0, 40.0, 246.0, 40.0)
  assert_layout_xywh(taffy, node4, 64.0, 40.0, 256.0, 40.0)
  assert_layout_xywh(taffy, node5, 43.0, 0.0, 0.0, 80.0)
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_overridden_by_available_space" {
  // Ported from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_overridden_by_available_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(Style::default())
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0),
    [node00],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(2.0), height=length(4.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 2.0, 4.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 2.0, 4.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_overridden_by_max_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_overridden_by_max_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_max_size(Size(width=length(2.0), height=length(4.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 2.0, 4.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_overridden_by_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_overridden_by_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(2.0), height=length(4.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 2.0, 4.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_take_up_space_both_axis" {
  // Ported from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_take_up_space_both_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 35.0, 35.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_take_up_space_x_axis" {
  // Ported from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_take_up_space_x_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_overflow(Point(x=overflow_scroll(), y=overflow_visible()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 35.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_overflow_scrollbars_take_up_space_y_axis" {
  // Ported from taffy-reference/tests/generated/grid/grid_overflow_scrollbars_take_up_space_y_axis.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_overflow(Point(x=overflow_visible(), y=overflow_scroll()))
    .with_scrollbar_width(15.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 35.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_padding_border_overrides_container_max_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_padding_border_overrides_container_max_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
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
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 22.0, 14.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 0.0, 0.0, 15.0, 3.0)
}

///|
test "upstream/generated/grid/grid_padding_border_overrides_container_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_padding_border_overrides_container_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
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
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 22.0, 14.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 0.0, 0.0, 15.0, 3.0)
}

///|
test "upstream/generated/grid/grid_padding_border_overrides_max_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_padding_border_overrides_max_size.rs
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
  let root = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 22.0, 14.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 22.0, 14.0, 0.0, 0.0)
}
