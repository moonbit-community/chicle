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
test "upstream/generated/grid/grid_max_content_single_item_span_2_gap_percent_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_span_2_gap_percent_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(Line(start=span(2), end=place_auto())),
    { text_content: "HH\u{200B}HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_gap(Size(width=percent(0.2), height=length(0.0)))
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      grid_max_content(),
      grid_max_content(),
    ]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 120.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 60.0, 40.0, 20.0, 20.0, 40.0, 20.0, 20.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 0.0]
  let expected_x = [0.0, 60.0, 0.0, 60.0, 100.0, 0.0, 60.0, 100.0, 0.0]
  let expected_y = [0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0, 120.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_width_greater_than_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_width_greater_than_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_max_size(Size(width=length(400.0), height=auto())),
    [node00, node01],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([grid_max_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 160.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 160.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 80.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 80.0, 10.0, 80.0, 0.0)
}

///|
test "upstream/generated/grid/grid_max_width_less_than_max_content_with_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_width_less_than_max_content_with_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_max_size(Size(width=length(80.0), height=auto())),
    [node00, node01],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([grid_min_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 20.0, 40.0, 20.0, 0.0)
}

///|
test "upstream/generated/grid/grid_max_width_smaller_than_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_width_smaller_than_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_max_size(Size(width=length(80.0), height=auto())),
    [node00, node01],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([grid_max_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 80.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 80.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 40.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 40.0, 20.0, 40.0, 0.0)
}

///|
test "upstream/generated/grid/grid_max_width_smaller_than_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_width_smaller_than_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HHHH\u{200B}HHHH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HHHH\u{200B}HHHH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_max_size(Size(width=length(60.0), height=auto())),
    [node00, node01],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([grid_max_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 60.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 40.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 40.0, 20.0, 40.0, 0.0)
}

///|
test "upstream/generated/grid/grid_min_content_flex_column" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node02 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column()),
    [node00, node01, node02],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 20.0, 20.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node02, 20.0, 20.0, 0.0, 40.0)
}

///|
test "upstream/generated/grid/grid_min_content_flex_row" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node01 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node02 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_flex()),
    [node00, node01, node02],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content()]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node01, 20.0, 40.0, 20.0, 0.0)
  assert_layout_xywh(taffy, node02, 20.0, 40.0, 40.0, 0.0)
}

///|
test "upstream/generated/grid/grid_min_content_flex_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default().with_min_size(Size(width=length(10.0), height=auto())),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(Line(start=span(2), end=place_auto())),
    { text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_min_content(), fr(1.0)]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 80.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 10.0, 30.0, 40.0, 40.0, 40.0, 10.0, 30.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 50.0, 0.0, 40.0, 0.0, 40.0, 50.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_min_content_flex_single_item_margin_auto" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item_margin_auto.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let all_auto_margin : Rect[Dimension] = Rect(
    left=auto(),
    right=auto(),
    top=auto(),
    bottom=auto(),
  )
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size(width=length(10.0), height=auto()))
    .with_margin(all_auto_margin),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_column(Line(start=span(2), end=place_auto()))
    .with_margin(all_auto_margin),
    { text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_min_content(), fr(1.0)]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 80.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 10.0, 30.0, 40.0, 40.0, 40.0, 10.0, 30.0],
    [40.0, 0.0, 40.0, 40.0, 10.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 50.0, 0.0, 40.0, 0.0, 40.0, 50.0],
    [0.0, 20.0, 0.0, 40.0, 55.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_min_content_flex_single_item_margin_fixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item_margin_fixed.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let fixed_margin : Rect[Dimension] = Rect(
    left=length(20.0),
    right=length(10.0),
    top=length(5.0),
    bottom=length(15.0),
  )
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size(width=length(10.0), height=auto()))
    .with_margin(fixed_margin),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_column(Line(start=span(2), end=place_auto()))
    .with_margin(fixed_margin),
    { text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_min_content(), fr(1.0)]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 110.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 10.0, 30.0, 40.0, 40.0, 40.0, 40.0, 30.0],
    [40.0, 20.0, 40.0, 40.0, 20.0, 40.0, 40.0, 40.0],
    [0.0, 60.0, 80.0, 0.0, 60.0, 0.0, 40.0, 80.0],
    [0.0, 5.0, 0.0, 40.0, 45.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_min_content_flex_single_item_margin_percent" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_flex_single_item_margin_percent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let percent_margin : Rect[Dimension] = Rect(
    left=percent(0.2),
    right=percent(0.1),
    top=percent(0.05),
    bottom=percent(0.15),
  )
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size(width=length(10.0), height=auto()))
    .with_margin(percent_margin),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_column(Line(start=span(2), end=place_auto()))
    .with_margin(percent_margin),
    { text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_min_content(), fr(1.0)]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 80.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 10.0, 30.0, 40.0, 28.0, 40.0, 10.0, 30.0],
    [40.0, 38.0, 40.0, 40.0, 32.0, 40.0, 40.0, 40.0],
    [0.0, 42.0, 50.0, 0.0, 48.0, 0.0, 40.0, 50.0],
    [0.0, 1.0, 0.0, 40.0, 42.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_min_content_maximum_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_maximum_single_item.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(0.0), grid_min_content()),
      length(40.0),
    ]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 20.0, 40.0, 40.0, 20.0, 40.0, 40.0, 20.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 60.0, 0.0, 40.0, 60.0, 0.0, 40.0, 60.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_min_content_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_min_content_single_item.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_min_content(), length(40.0)]),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 20.0, 40.0, 40.0, 20.0, 40.0, 40.0, 20.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 60.0, 0.0, 40.0, 60.0, 0.0, 40.0, 60.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_minmax_auto_fixed_10px" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_auto_fixed_10px.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(auto(), length(10.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 10.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 10.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_auto_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_auto_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(auto(), grid_max_content())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_auto_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_auto_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(auto(), grid_min_content())]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_auto_percent_definite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_auto_percent_definite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(auto(), percent(0.2))])
    .with_size(Size(width=length(100.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_auto_percent_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_auto_percent_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(auto(), percent(0.2))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 8.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_column_fixed_width_above_range" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_fixed_width_above_range.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(20.0), length(40.0)),
      length(40.0),
    ])
    .with_size(Size(width=length(140.0), height=auto())),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 140.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_minmax_column_fixed_width_below_range" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_fixed_width_below_range.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(20.0), length(40.0)),
      length(40.0),
    ])
    .with_size(Size(width=length(90.0), height=auto())),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 90.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 20.0, 40.0, 40.0, 20.0, 40.0, 40.0, 20.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 60.0, 0.0, 40.0, 60.0, 0.0, 40.0, 60.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_minmax_column_fixed_width_within_range" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_fixed_width_within_range.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(20.0), length(40.0)),
      length(40.0),
    ])
    .with_size(Size(width=length(110.0), height=auto())),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 110.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  // Spot-check a representative item in the second column (should be 30px wide).
  let item = nodes[1]
  let l = taffy.layout(item)
  assert_eq(l.size.width, 30.0)
  assert_eq(l.size.height, 40.0)
  assert_eq(l.location.x, 40.0)
  assert_eq(l.location.y, 0.0)
  // Spot-check a representative item in the third column (fixed 40px).
  let item2 = nodes[2]
  let l2 = taffy.layout(item2)
  assert_eq(l2.size.width, 40.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 70.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_column_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_indefinite.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(20.0), length(40.0)),
      length(40.0),
    ]),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_minmax_column_with_auto_fixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_with_auto_fixed.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(length(20.0), length(40.0)), auto()])
    .with_size(Size(width=length(60.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 40.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_column_with_fr_fixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_column_with_fr_fixed.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(length(20.0), length(40.0)), fr(1.0)])
    .with_size(Size(width=length(60.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 40.0, 0.0)
}

///|
test "upstream/generated/grid/grid_minmax_max_content_1fr" {
  // Ported from taffy-reference/tests/generated/grid/grid_minmax_max_content_1fr.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(grid_max_content(), fr(1.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
}
