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
test "upstream/generated/grid/grid_basic_with_padding" {
  // Ported from taffy-reference/tests/generated/grid/grid_basic_with_padding.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let children : Array[NodeId] = []
  for _ in 0..<9 {
    children.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    children,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 180.0, 160.0, 0.0, 0.0)
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    assert_layout_xywh(
      taffy,
      children[i],
      40.0,
      40.0,
      40.0 + (col * 40).to_double(),
      10.0 + (row * 40).to_double(),
    )
  }
}

///|
test "upstream/generated/grid/grid_display_none_fixed_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_display_none_fixed_size.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_none())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_definite_argument" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_definite_argument.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))])
    .with_size(Size(width=length(60.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 40.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_definite_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_definite_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))])
    .with_size(Size(width=length(60.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_definite_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_definite_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))])
    .with_size(Size(width=length(60.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_indefinite_argument" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_argument.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 40.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_indefinite_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 20.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_indefinite_max_content_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_max_content_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0),
    TextMeasure::{ text_content: "HH", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 10.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_indefinite_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
}

///|
test "upstream/generated/grid/grid_fit_content_percent_indefinite_min_content_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_percent_indefinite_min_content_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0),
    TextMeasure::{ text_content: "HHHH\u{200B}HH", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(percent(0.5))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 30.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_fit_content_points_argument" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_points_argument.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(length(30.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 30.0)
  assert_eq(root_layout.size.height, 40.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 40.0)
}

///|
test "upstream/generated/grid/grid_fit_content_points_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_points_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(length(30.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 20.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
}

///|
test "upstream/generated/grid/grid_fit_content_points_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_points_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(length(30.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 40.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
}

///|
test "upstream/generated/grid/grid_fit_content_points_min_content_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_fit_content_points_min_content_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0),
    TextMeasure::{ text_content: "HHHH\u{200B}HH", writing_mode: Horizontal },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fit_content(length(30.0))]),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 30.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 30.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_fr_fixed_size_no_content_proportions" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_fixed_size_no_content_proportions.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fr(1.0), fr(2.0), fr(3.0)])
    .with_size(Size(width=length(200.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 40.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 33.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 67.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 33.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_fr_fixed_size_no_content_proportions_sub_1_sum" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_fixed_size_no_content_proportions_sub_1_sum.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fr(0.3), fr(0.2)])
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 40.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_fr_fixed_size_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_fixed_size_single_item.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), fr(1.0), fr(1.0)])
    .with_grid_template_columns([length(40.0), fr(1.0), fr(1.0)])
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 200.0, 200.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 100.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 60.0, 40.0, 140.0, 0.0)
  assert_layout_xywh(taffy, node3, 40.0, 80.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node4, 100.0, 80.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node5, 60.0, 80.0, 140.0, 40.0)
  assert_layout_xywh(taffy, node6, 40.0, 80.0, 0.0, 120.0)
  assert_layout_xywh(taffy, node7, 100.0, 80.0, 40.0, 120.0)
  assert_layout_xywh(taffy, node8, 60.0, 80.0, 140.0, 120.0)
}

///|
test "upstream/generated/grid/grid_fr_no_sized_items_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_no_sized_items_indefinite.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
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
    .with_grid_template_rows([length(40.0), fr(1.0), fr(1.0)])
    .with_grid_template_columns([length(40.0), fr(1.0), fr(1.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 0.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node3, 40.0, 0.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node4, 0.0, 0.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node5, 0.0, 0.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node6, 40.0, 0.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node7, 0.0, 0.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node8, 0.0, 0.0, 40.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_single_item_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_single_item_indefinite.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
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
    .with_grid_template_rows([length(40.0), fr(1.0), fr(1.0)])
    .with_grid_template_columns([length(40.0), fr(1.0), fr(1.0)])
    .with_size(Size(width=auto(), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 240.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 100.0, 40.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 100.0, 40.0, 140.0, 0.0)
  assert_layout_xywh(taffy, node3, 40.0, 0.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node4, 100.0, 0.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node5, 100.0, 0.0, 140.0, 40.0)
  assert_layout_xywh(taffy, node6, 40.0, 0.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node7, 100.0, 0.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node8, 100.0, 0.0, 140.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_span_2_proportion" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line(start=span(2), end=place_auto()))
    .with_size(Size(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([fr(1.0), fr(2.0)]),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 40.0, 40.0, 20.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_span_2_proportion_sub_1_sum" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_sub_1_sum.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line(start=span(2), end=place_auto()))
    .with_size(Size(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([fr(0.2), fr(0.3)]),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 24.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 36.0, 40.0, 24.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_span_2_proportion_with_non_spanned_track" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_with_non_spanned_track.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line(start=span(2), end=place_auto()))
    .with_size(Size(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([fr(1.0), fr(2.0), fr(3.0)]),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 40.0, 60.0, 0.0)
  assert_layout_xywh(taffy, node2, 20.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node3, 40.0, 40.0, 20.0, 40.0)
  assert_layout_xywh(taffy, node4, 60.0, 40.0, 60.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_span_2_proportion_zero_sum" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_zero_sum.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line(start=span(2), end=place_auto()))
    .with_size(Size(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([fr(0.0), fr(0.0)]),
    [node0, node1, node2],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 30.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 30.0, 40.0, 30.0, 40.0)
}

///|
test "upstream/generated/grid/grid_fr_span_2_proportion_zero_sum_with_non_spanned_track" {
  // Ported from taffy-reference/tests/generated/grid/grid_fr_span_2_proportion_zero_sum_with_non_spanned_track.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line(start=span(2), end=place_auto()))
    .with_size(Size(width=length(60.0), height=auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([fr(0.0), fr(0.0), fr(0.0)]),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 60.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 40.0, 60.0, 0.0)
  assert_layout_xywh(taffy, node2, 30.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node3, 30.0, 40.0, 30.0, 40.0)
  assert_layout_xywh(taffy, node4, 0.0, 40.0, 60.0, 40.0)
}

///|
test "upstream/generated/grid/grid_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_gap.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = make_nine_default_grid_children(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_gap(Size(width=length(40.0), height=length(40.0)))
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(200.0), height=length(200.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  assert_grid_positions(
    taffy,
    nodes,
    [0.0, 80.0, 160.0],
    [0.0, 80.0, 160.0],
    40.0,
    40.0,
  )
}
