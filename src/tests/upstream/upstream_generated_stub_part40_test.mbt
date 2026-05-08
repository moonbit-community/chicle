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
test "upstream/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_max_content(), fit_content(length(10.0))]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 60.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_10px_indefinite_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_max_content(), fit_content(length(10.0))]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 40.0, 80.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_max_content(), fit_content(length(80.0))]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 60.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_max_content_fit_content_80px_indefinite_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_max_content(), fit_content(length(80.0))]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 40.0, 80.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_max_content_max_content_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_max_content_max_content_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_max_content(), grid_max_content()]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_min_content_auto_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_min_content_auto_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content(), auto()]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 40.0, 20.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 10.0, 0.0, 40.0)
}

///|
test "upstream/generated/grid/grid_span_2_min_content_auto_indefinite_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_min_content_auto_indefinite_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content(), auto()]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 10.0, 0.0, 40.0)
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content(), fit_content(length(10.0))]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 20.0, 0.0)
  assert_layout_xywh(taffy, node2, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_10px_indefinite_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content(), fit_content(length(10.0))]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 50.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 10.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 50.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content(), fit_content(length(30.0))]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 50.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 30.0, 40.0, 20.0, 0.0)
  assert_layout_xywh(taffy, node2, 50.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_30px_indefinite_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content(), fit_content(length(30.0))]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 70.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 30.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 70.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content(), fit_content(length(80.0))]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 40.0, 20.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_min_content_fit_content_80px_indefinite_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content(), fit_content(length(80.0))]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_min_content_max_content_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_min_content_max_content_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content(), grid_max_content()]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 40.0, 20.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_min_content_min_content_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_min_content_min_content_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    { text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content(), grid_min_content()]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 20.0, 0.0)
  assert_layout_xywh(taffy, node2, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_6_all_non_flex_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_6_all_non_flex_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(Line(start=line(1), end=span(6))),
    { text_content: "HHHHHHHH\u{200b}HHHHHHHH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([
      grid_min_content(),
      grid_max_content(),
      fit_content(length(20.0)),
      auto(),
      length(10.0),
      percent(0.2),
    ]),
    [node0, node1, node2, node3, node4, node5, node6],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 160.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 160.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 10.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 89.0, 40.0, 10.0, 40.0)
  assert_layout_xywh(taffy, node3, 10.0, 40.0, 99.0, 40.0)
  assert_layout_xywh(taffy, node4, 9.0, 40.0, 109.0, 40.0)
  assert_layout_xywh(taffy, node5, 10.0, 40.0, 118.0, 40.0)
  assert_layout_xywh(taffy, node6, 32.0, 40.0, 128.0, 40.0)
}

///|
test "upstream/generated/grid/grid_span_6_all_non_flex_indefinite_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_6_all_non_flex_indefinite_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_grid_column(Line(start=line(1), end=span(6))),
    { text_content: "HHHHHHHH\u{200b}HHHHHHHH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([
      grid_min_content(),
      grid_max_content(),
      fit_content(length(20.0)),
      auto(),
      length(10.0),
      percent(0.2),
    ]),
    [node0, node1, node2, node3, node4, node5, node6],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 160.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 160.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 19.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 99.0, 40.0, 19.0, 40.0)
  assert_layout_xywh(taffy, node3, 0.0, 40.0, 118.0, 40.0)
  assert_layout_xywh(taffy, node4, 0.0, 40.0, 118.0, 40.0)
  assert_layout_xywh(taffy, node5, 10.0, 40.0, 118.0, 40.0)
  assert_layout_xywh(taffy, node6, 32.0, 40.0, 128.0, 40.0)
}

///|
test "upstream/generated/grid/grid_span_8_all_track_types_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_8_all_track_types_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(Line(start=line(1), end=span(8))),
    { text_content: "HHHHHHHH\u{200b}HHHHHHHH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([
      grid_min_content(),
      grid_max_content(),
      fit_content(length(20.0)),
      auto(),
      length(10.0),
      percent(0.2),
      fr(1.0),
      fr(2.0),
    ]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 160.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 160.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 0.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node3, 0.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node4, 0.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node5, 10.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node6, 32.0, 40.0, 10.0, 40.0)
  assert_layout_xywh(taffy, node7, 39.0, 40.0, 42.0, 40.0)
  assert_layout_xywh(taffy, node8, 79.0, 40.0, 81.0, 40.0)
}

///|
test "upstream/generated/grid/grid_taffy_issue_624" {
  // Ported from taffy-reference/tests/generated/grid/grid_taffy_issue_624.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=span(2)))
    .with_grid_column(Line(start=line(1), end=place_auto()))
    .with_size(Size(width=length(100.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=span(2)))
    .with_grid_column(Line(start=line(2), end=span(2)))
    .with_size(Size(width=length(40.0), height=length(30.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(3), end=span(1)))
    .with_grid_column(Line(start=line(1), end=span(2)))
    .with_size(Size(width=length(120.0), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_start())
    .with_justify_content(justify_content_start())
    .with_grid_template_rows([auto(), auto(), auto(), fr(1.0)])
    .with_grid_template_columns([auto(), auto(), fr(1.0)])
    .with_size(Size(width=length(320.0), height=length(640.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 320.0, 640.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 30.0, 100.0, 0.0)
  assert_layout_xywh(taffy, node2, 120.0, 20.0, 0.0, 50.0)
}

///|
test "upstream/generated/grid/mod" {
  // Ported from taffy-reference/tests/generated/grid/mod.rs
  ()
}

///|
test "upstream/generated/gridflex/gridflex_column_integration" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_column_integration.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node02 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node03 = taffy.new_leaf_with_context(Style::default(), {
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
  let node = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
    [node0],
  )
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
test "upstream/generated/gridflex/gridflex_kitchen_sink" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node00100 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=auto())),
  )
  let node00101 = taffy.new_leaf(Style::default())
  let node00102 = taffy.new_leaf(Style::default())
  let node00103 = taffy.new_leaf(Style::default())
  let node0010 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([percent(0.3), percent(0.1)])
    .with_grid_template_columns([auto(), percent(0.1)]),
    [node00100, node00101, node00102, node00103],
  )
  let node001 = taffy.new_with_children(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=length(50.0), height=auto())),
    [node0010],
  )
  let node00 = taffy.new_with_children(Style::default(), [node000, node001])
  let node01 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node02 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let node03 = taffy.new_leaf_with_context(Style::default(), {
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
  assert_eq(l_node.size.width, 140.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 140.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 70.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  let l001 = taffy.layout(node001)
  assert_eq(l000.size.width, 20.0)
  assert_eq(l000.size.height, 10.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
  assert_eq(l001.size.width, 50.0)
  assert_eq(l001.size.height, 10.0)
  assert_eq(l001.location.x, 20.0)
  assert_eq(l001.location.y, 0.0)
  let l0010 = taffy.layout(node0010)
  assert_eq(l0010.size.width, 20.0)
  assert_eq(l0010.size.height, 10.0)
  assert_eq(l0010.location.x, 0.0)
  assert_eq(l0010.location.y, 0.0)
  let l00100 = taffy.layout(node00100)
  assert_eq(l00100.size.width, 20.0)
  assert_eq(l00100.size.height, 3.0)
  assert_eq(l00100.location.x, 0.0)
  assert_eq(l00100.location.y, 0.0)
  let l00101 = taffy.layout(node00101)
  assert_eq(l00101.size.width, 2.0)
  assert_eq(l00101.size.height, 3.0)
  assert_eq(l00101.location.x, 20.0)
  assert_eq(l00101.location.y, 0.0)
  let l00102 = taffy.layout(node00102)
  assert_eq(l00102.size.width, 20.0)
  assert_eq(l00102.size.height, 1.0)
  assert_eq(l00102.location.x, 0.0)
  assert_eq(l00102.location.y, 3.0)
  let l00103 = taffy.layout(node00103)
  assert_eq(l00103.size.width, 2.0)
  assert_eq(l00103.size.height, 1.0)
  assert_eq(l00103.location.x, 20.0)
  assert_eq(l00103.location.y, 3.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 70.0)
  assert_eq(l01.size.height, 10.0)
  assert_eq(l01.location.x, 70.0)
  assert_eq(l01.location.y, 0.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 70.0)
  assert_eq(l02.size.height, 10.0)
  assert_eq(l02.location.x, 0.0)
  assert_eq(l02.location.y, 10.0)
  let l03 = taffy.layout(node03)
  assert_eq(l03.size.width, 70.0)
  assert_eq(l03.size.height, 10.0)
  assert_eq(l03.location.x, 70.0)
  assert_eq(l03.location.y, 10.0)
}

///|
test "upstream/generated/gridflex/gridflex_kitchen_sink_minimise" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink_minimise.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node01 = taffy.new_leaf(Style::default())
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(20.0)])
    .with_grid_template_columns([fr(1.0), fr(1.0)]),
    [node00, node01],
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 100.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 50.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 50.0)
  assert_eq(l01.location.y, 0.0)
}

///|
test "upstream/generated/gridflex/gridflex_kitchen_sink_minimise2" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink_minimise2.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([auto()])
    .with_grid_template_columns([auto()]),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_grow(1.0)
    .with_size(Size(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/gridflex/gridflex_kitchen_sink_minimise3" {
  // Ported from taffy-reference/tests/generated/gridflex/gridflex_kitchen_sink_minimise3.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(Style::default())
  let node02 = taffy.new_leaf(Style::default())
  let node03 = taffy.new_leaf(Style::default())
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([percent(0.3), percent(0.1)])
    .with_grid_template_columns([auto(), percent(0.1)]),
    [node00, node01, node02, node03],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 2.0)
  assert_eq(l01.size.height, 6.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 0.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 20.0)
  assert_eq(l02.size.height, 2.0)
  assert_eq(l02.location.x, 0.0)
  assert_eq(l02.location.y, 6.0)
  let l03 = taffy.layout(node03)
  assert_eq(l03.size.width, 2.0)
  assert_eq(l03.size.height, 2.0)
  assert_eq(l03.location.x, 20.0)
  assert_eq(l03.location.y, 6.0)
}
