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
test "upstream/generated/grid/grid_aspect_ratio_child_fill_content_height" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_child_fill_content_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_aspect_ratio(0.5),
    { text_content: "HHHH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 20.0, 0.0, 80.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_child_fill_content_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_child_fill_content_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_aspect_ratio(2.0),
    { text_content: "HHHH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 20.0, 0.0, 20.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_fill_child_height" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 25.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_fill_child_max_height" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
    {
      text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH",
      writing_mode: Vertical,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 20.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_fill_child_max_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size(width=auto(), height=length(20.0)))
    .with_aspect_ratio(2.0),
    {
      text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 20.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_fill_child_min_height" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_min_height.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size(width=length(50.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_fill_child_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_fill_child_width.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(50.0)))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes_flex" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_overridden_by_explicit_sizes_flex.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_aspect_ratio(2.0),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_auto_columns" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_columns.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_grid_column(Line(start=line(-3), end=place_auto())),
  )
  let nodes : Array[NodeId] = [node0]
  for _i in 0..<7 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(100.0)])
    .with_grid_template_columns([length(40.0)])
    .with_grid_auto_columns([length(10.0), length(20.0), length(30.0)])
    .with_grid_auto_flow(grid_auto_flow_column()),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 190.0)
  assert_eq(root_layout.size.height, 100.0)
  let l0 = taffy.layout(nodes[0])
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(nodes[1])
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(nodes[2])
  assert_eq(l2.location.x, 70.0)
  assert_eq(l2.location.y, 0.0)
  let l7 = taffy.layout(nodes[7])
  assert_eq(l7.location.x, 160.0)
  assert_eq(l7.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_auto_columns_fixed_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_columns_fixed_width.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let children : Array[NodeId] = []
  for _ in 0..<16 {
    children.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), auto(), length(40.0), auto()])
    .with_grid_template_columns([length(40.0), auto(), length(40.0), auto()])
    .with_size(Size(width=length(200.0), height=length(200.0))),
    children,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 200.0, 200.0, 0.0, 0.0)
  let col_w = [40.0, 60.0, 40.0, 60.0]
  let row_h = [40.0, 60.0, 40.0, 60.0]
  let col_x = [0.0, 40.0, 100.0, 140.0]
  let row_y = [0.0, 40.0, 100.0, 140.0]
  for i in 0..<16 {
    let row = i / 4
    let col = i % 4
    assert_layout_xywh(
      taffy,
      children[i],
      col_w[col],
      row_h[row],
      col_x[col],
      row_y[row],
    )
  }
}

///|
test "upstream/generated/grid/grid_auto_fill_fixed_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_fill_fixed_size.rs
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
      repeat(repeat_auto_fill(), [length(40.0)]),
    ])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  let l0 = taffy.layout(nodes[0])
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(nodes[1])
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(nodes[2])
  assert_eq(l2.location.x, 80.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_auto_fill_with_empty_auto_track" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_fill_with_empty_auto_track.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_content(justify_content_space_evenly())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([repeat(repeat_auto_fill(), [length(40.0)])])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let l0 = taffy.layout(node0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_auto_fit_with_empty_auto_track" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_fit_with_empty_auto_track.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_content(justify_content_space_evenly())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([repeat(repeat_auto_fit(), [length(40.0)])])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let l0 = taffy.layout(node0)
  assert_eq(l0.location.x, 13.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 67.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_auto_rows" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_rows.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_grid_row(Line(start=line(-4), end=place_auto())),
  )
  let nodes : Array[NodeId] = [node0]
  for _i in 0..<7 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([length(100.0)])
    .with_grid_auto_rows([length(10.0), length(20.0), length(30.0)]),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 180.0)
  let l0 = taffy.layout(nodes[0])
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(nodes[1])
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(nodes[2])
  assert_eq(l2.location.y, 50.0)
  let l7 = taffy.layout(nodes[7])
  assert_eq(l7.location.y, 160.0)
}

///|
test "upstream/generated/grid/grid_auto_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_single_item.rs
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
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), auto(), length(40.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 120.0)
  let col_w = [40.0, 100.0, 40.0]
  let row_h = [40.0, 40.0, 40.0]
  let col_x = [0.0, 40.0, 140.0]
  let row_y = [0.0, 40.0, 80.0]
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, col_w[col])
    assert_eq(layout.size.height, row_h[row])
    assert_eq(layout.location.x, col_x[col])
    assert_eq(layout.location.y, row_y[row])
  }
}

///|
test "upstream/generated/grid/grid_auto_single_item_fixed_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_single_item_fixed_width.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default().with_min_size(Size(width=length(100.0), height=auto())),
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
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), auto(), auto()])
    .with_size(Size(width=length(200.0), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 120.0)
  let col_w = [40.0, 130.0, 30.0]
  let row_h = [40.0, 40.0, 40.0]
  let col_x = [0.0, 40.0, 170.0]
  let row_y = [0.0, 40.0, 80.0]
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, col_w[col])
    assert_eq(layout.size.height, row_h[row])
    assert_eq(layout.location.x, col_x[col])
    assert_eq(layout.location.y, row_y[row])
  }
}

///|
test "upstream/generated/grid/grid_auto_single_item_fixed_width_with_definite_width" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_single_item_fixed_width_with_definite_width.rs
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
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), auto(), auto()])
    .with_size(Size(width=length(200.0), height=auto())),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 120.0)
  let col_x = [0.0, 40.0, 170.0]
  let row_y = [0.0, 40.0, 80.0]
  let expected_w = [40.0, 100.0, 30.0, 40.0, 130.0, 30.0, 40.0, 130.0, 30.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, col_x[col])
    assert_eq(layout.location.y, row_y[row])
  }
}

///|
test "upstream/generated/grid/grid_auto_takes_precedence_over_fr" {
  // Ported from taffy-reference/tests/generated/grid/grid_auto_takes_precedence_over_fr.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([auto(), fr(1.0)])
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 200.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_available_space_greater_than_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_available_space_greater_than_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node1 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(
    root,
    Size(width=available_space_definite(400.0), height=max_content()),
    measure_text,
  )
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 160.0)
  assert_eq(root_layout.size.height, 10.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 80.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 80.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_available_space_smaller_than_max_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_available_space_smaller_than_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let node1 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(
    root,
    Size(width=available_space_definite(80.0), height=max_content()),
    measure_text,
  )
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 80.0)
  assert_eq(root_layout.size.height, 20.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_available_space_smaller_than_min_content" {
  // Ported from taffy-reference/tests/generated/grid/grid_available_space_smaller_than_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HHHH\u{200B}HHHH",
    writing_mode: Horizontal,
  })
  let node1 = taffy.new_leaf_with_context(Style::default(), {
    text_content: "HHHH\u{200B}HHHH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(
    root,
    Size(width=available_space_definite(60.0), height=max_content()),
    measure_text,
  )
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 80.0)
  assert_eq(root_layout.size.height, 20.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/grid/grid_basic" {
  // Ported from taffy-reference/tests/generated/grid/grid_basic.rs
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
    .with_size(Size(width=length(120.0), height=length(120.0))),
    children,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    assert_layout_xywh(
      taffy,
      children[i],
      40.0,
      40.0,
      (col * 40).to_double(),
      (row * 40).to_double(),
    )
  }
}

///|
test "upstream/generated/grid/grid_basic_implicit_tracks" {
  // Ported from taffy-reference/tests/generated/grid/grid_basic_implicit_tracks.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(35.0), height=length(35.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([length(40.0)]),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 40.0)
  assert_eq(root_layout.size.height, 75.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 35.0)
  assert_eq(l1.size.height, 35.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 40.0)
}

///|
test "upstream/generated/grid/grid_basic_with_overflow" {
  // Ported from taffy-reference/tests/generated/grid/grid_basic_with_overflow.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let children : Array[NodeId] = []
  for _ in 0..<10 {
    children.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    children,
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  for i in 0..<9 {
    let row = i / 3
    let col = i % 3
    assert_layout_xywh(
      taffy,
      children[i],
      40.0,
      40.0,
      (col * 40).to_double(),
      (row * 40).to_double(),
    )
  }
  assert_layout_xywh(taffy, children[9], 40.0, 0.0, 0.0, 120.0)
}
