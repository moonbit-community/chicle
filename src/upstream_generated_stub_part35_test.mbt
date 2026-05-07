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
test "upstream/generated/grid/grid_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_hidden.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default().with_display(display_none()))
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default().with_display(display_none()))
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default().with_display(display_none()))
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 0.0, 40.0, 40.0, 0.0, 40.0, 0.0, 40.0, 40.0]
  let expected_h = [40.0, 0.0, 40.0, 40.0, 0.0, 40.0, 0.0, 40.0, 40.0]
  let expected_x = [0.0, 0.0, 40.0, 80.0, 0.0, 0.0, 0.0, 40.0, 80.0]
  let expected_y = [0.0, 0.0, 0.0, 0.0, 0.0, 40.0, 0.0, 40.0, 40.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
fn make_nine_default_grid_children(taffy : TaffyTree[Unit]) -> Array[NodeId] {
  [
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
    taffy.new_leaf(Style::default()),
  ]
}

///|
fn assert_grid_positions(
  taffy : TaffyTree[Unit],
  nodes : Array[NodeId],
  expected_x : Array[Double],
  expected_y : Array[Double],
  item_width : Double,
  item_height : Double,
) -> Unit raise Error {
  for row in 0..<3 {
    for col in 0..<3 {
      let idx = row * 3 + col
      let layout = taffy.layout(nodes[idx])
      assert_eq(layout.size.width, item_width)
      assert_eq(layout.size.height, item_height)
      assert_eq(layout.location.x, expected_x[col])
      assert_eq(layout.location.y, expected_y[row])
    }
  }
}

///|
fn run_grid_align_content_test(
  align_content : AlignContent,
  expected_y : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = make_nine_default_grid_children(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content)
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
  assert_grid_positions(taffy, nodes, [0.0, 40.0, 80.0], expected_y, 40.0, 40.0)
}

///|
fn run_grid_align_content_with_padding_border_test(
  align_content : AlignContent,
  expected_y : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = make_nine_default_grid_children(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content)
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(200.0), height=length(200.0)))
    .with_padding(
      Rect(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    )
    .with_border(
      Rect(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    ),
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
    [48.0, 88.0, 128.0],
    expected_y,
    40.0,
    40.0,
  )
}

///|
fn run_grid_align_content_negative_space_gap_test(
  align_content : AlignContent,
  expected_y : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = make_nine_default_grid_children(taffy)
  let inner = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content)
    .with_justify_content(justify_content_center())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    nodes,
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(240.0), height=length(240.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [inner],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 240.0)
  assert_eq(root_layout.size.height, 240.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let inner_layout = taffy.layout(inner)
  assert_eq(inner_layout.size.width, 120.0)
  assert_eq(inner_layout.size.height, 120.0)
  assert_eq(inner_layout.location.x, 60.0)
  assert_eq(inner_layout.location.y, 60.0)
  assert_grid_positions(
    taffy,
    nodes,
    [20.0, 50.0, 80.0],
    expected_y,
    20.0,
    40.0,
  )
}

///|
fn run_grid_justify_content_test(
  justify_content : JustifyContent,
  expected_x : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = make_nine_default_grid_children(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_content(justify_content)
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
  assert_grid_positions(taffy, nodes, expected_x, [0.0, 40.0, 80.0], 40.0, 40.0)
}

///|
fn run_grid_justify_content_with_padding_border_test(
  justify_content : JustifyContent,
  expected_x : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = make_nine_default_grid_children(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_content(justify_content)
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(200.0), height=length(200.0)))
    .with_padding(
      Rect(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    )
    .with_border(
      Rect(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    ),
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
    expected_x,
    [12.0, 52.0, 92.0],
    40.0,
    40.0,
  )
}

///|
fn run_grid_justify_content_negative_space_gap_test(
  justify_content : JustifyContent,
  expected_x : Array[Double],
) -> Unit raise Error {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = make_nine_default_grid_children(taffy)
  let inner = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content)
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_grid_template_rows([length(20.0), length(20.0), length(20.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    nodes,
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(240.0), height=length(240.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [inner],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 240.0)
  assert_eq(root_layout.size.height, 240.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let inner_layout = taffy.layout(inner)
  assert_eq(inner_layout.size.width, 120.0)
  assert_eq(inner_layout.size.height, 120.0)
  assert_eq(inner_layout.location.x, 60.0)
  assert_eq(inner_layout.location.y, 60.0)
  assert_grid_positions(
    taffy,
    nodes,
    expected_x,
    [20.0, 50.0, 80.0],
    40.0,
    20.0,
  )
}

///|
test "upstream/generated/grid/grid_justify_content_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_center.rs
  run_grid_justify_content_test(justify_content_center(), [40.0, 80.0, 120.0])
}

///|
test "upstream/generated/grid/grid_justify_content_center_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_center_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(justify_content_center(), [
    -10.0, 40.0, 90.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_center_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_center_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(justify_content_center(), [
    52.0, 92.0, 132.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_end.rs
  run_grid_justify_content_test(justify_content_end(), [80.0, 120.0, 160.0])
}

///|
test "upstream/generated/grid/grid_justify_content_end_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_end_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(justify_content_end(), [
    -20.0, 30.0, 80.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_end_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_end_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(justify_content_end(), [
    56.0, 96.0, 136.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_space_around" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_around.rs
  run_grid_justify_content_test(justify_content_space_around(), [
    13.0, 80.0, 147.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_space_around_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_around_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(
    justify_content_space_around(),
    [0.0, 50.0, 100.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_space_around_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_around_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(
    justify_content_space_around(),
    [49.0, 92.0, 135.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_space_between" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_between.rs
  run_grid_justify_content_test(justify_content_space_between(), [
    0.0, 80.0, 160.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_space_between_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_between_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(
    justify_content_space_between(),
    [0.0, 50.0, 100.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_space_between_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_between_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(
    justify_content_space_between(),
    [48.0, 92.0, 136.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_space_evenly" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_evenly.rs
  run_grid_justify_content_test(justify_content_space_evenly(), [
    20.0, 80.0, 140.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_space_evenly_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_evenly_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(
    justify_content_space_evenly(),
    [0.0, 50.0, 100.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_space_evenly_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_space_evenly_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(
    justify_content_space_evenly(),
    [50.0, 92.0, 134.0],
  )
}

///|
test "upstream/generated/grid/grid_justify_content_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_start.rs
  run_grid_justify_content_test(justify_content_start(), [0.0, 40.0, 80.0])
}
