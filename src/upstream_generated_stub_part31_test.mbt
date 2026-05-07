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
test "upstream/generated/grid/grid_absolute_row_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_row_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_grid_row(Line(start=place_auto(), end=line(1)))
    .with_inset(
      Rect(
        left=length(4.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(2.0),
      ),
    ),
  )
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
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let n = taffy.layout(node0)
  assert_eq(n.size.width, 173.0)
  assert_eq(n.size.height, 7.0)
  assert_eq(n.location.x, 4.0)
  assert_eq(n.location.y, 1.0)
}

///|
test "upstream/generated/grid/grid_absolute_row_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_row_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_inset(
      Rect(
        left=length(4.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(2.0),
      ),
    ),
  )
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
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let n = taffy.layout(node0)
  assert_eq(n.size.width, 173.0)
  assert_eq(n.size.height, 147.0)
  assert_eq(n.location.x, 4.0)
  assert_eq(n.location.y, 11.0)
}

///|
test "upstream/generated/grid/grid_absolute_top_overrides_bottom" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_top_overrides_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(2.0), bottom=length(5.0)),
    ),
  )
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
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [10.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [2.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_with_padding" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_with_padding.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(left=auto(), right=length(0.0), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(left=length(10.0), right=auto(), top=auto(), bottom=length(10.0)),
    ),
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
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [180.0, 10.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0]
  let expected_y = [0.0, 150.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_with_padding_and_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_with_padding_and_margin.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_margin(
      Rect(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect(left=auto(), right=length(0.0), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_margin(
      Rect(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect(left=length(10.0), right=auto(), top=auto(), bottom=length(10.0)),
    ),
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
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_padding(
      Rect(
        left=length(40.0),
        right=length(20.0),
        top=length(10.0),
        bottom=length(30.0),
      ),
    ),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [178.0, 14.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0]
  let expected_y = [1.0, 147.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_align_content_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_center.rs
  run_grid_align_content_test(align_content_center(), [40.0, 80.0, 120.0])
}

///|
test "upstream/generated/grid/grid_align_content_center_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_center_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(align_content_center(), [
    -10.0, 40.0, 90.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_end.rs
  run_grid_align_content_test(align_content_end(), [80.0, 120.0, 160.0])
}

///|
test "upstream/generated/grid/grid_align_content_end_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_end_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(align_content_end(), [
    -20.0, 30.0, 80.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_end_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_end_with_padding_border.rs
  run_grid_align_content_with_padding_border_test(align_content_end(), [
    44.0, 84.0, 124.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_space_around" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_around.rs
  run_grid_align_content_test(align_content_space_around(), [13.0, 80.0, 147.0])
}

///|
test "upstream/generated/grid/grid_align_content_space_around_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_around_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(align_content_space_around(), [
    0.0, 50.0, 100.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_space_around_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_around_with_padding_border.rs
  run_grid_align_content_with_padding_border_test(
    align_content_space_around(),
    [17.0, 68.0, 119.0],
  )
}

///|
test "upstream/generated/grid/grid_align_content_space_between" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_between.rs
  run_grid_align_content_test(align_content_space_between(), [0.0, 80.0, 160.0])
}

///|
test "upstream/generated/grid/grid_align_content_space_between_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_between_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(
    align_content_space_between(),
    [0.0, 50.0, 100.0],
  )
}

///|
test "upstream/generated/grid/grid_align_content_space_between_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_between_with_padding_border.rs
  run_grid_align_content_with_padding_border_test(
    align_content_space_between(),
    [12.0, 68.0, 124.0],
  )
}

///|
test "upstream/generated/grid/grid_align_content_space_evenly" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_evenly.rs
  run_grid_align_content_test(align_content_space_evenly(), [20.0, 80.0, 140.0])
}

///|
test "upstream/generated/grid/grid_align_content_space_evenly_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_evenly_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(align_content_space_evenly(), [
    0.0, 50.0, 100.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_space_evenly_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_space_evenly_with_padding_border.rs
  run_grid_align_content_with_padding_border_test(
    align_content_space_evenly(),
    [20.0, 68.0, 116.0],
  )
}

///|
test "upstream/generated/grid/grid_align_content_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_start.rs
  run_grid_align_content_test(align_content_start(), [0.0, 40.0, 80.0])
}

///|
test "upstream/generated/grid/grid_align_content_start_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_start_negative_space_gap.rs
  run_grid_align_content_negative_space_gap_test(align_content_start(), [
    0.0, 50.0, 100.0,
  ])
}

///|
test "upstream/generated/grid/grid_align_content_start_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_content_start_with_padding_border.rs
  run_grid_align_content_with_padding_border_test(align_content_start(), [
    12.0, 52.0, 92.0,
  ])
}

///|
fn[C] assert_layout_xywh(
  taffy : TaffyTree[C],
  node : NodeId,
  width : Double,
  height : Double,
  x : Double,
  y : Double,
) -> Unit raise Error {
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, width)
  assert_eq(layout.size.height, height)
  assert_eq(layout.location.x, x)
  assert_eq(layout.location.y, y)
}

///|
fn[C] assert_nodes_layout_xywh(
  taffy : TaffyTree[C],
  nodes : Array[NodeId],
  expected_w : Array[Double],
  expected_h : Array[Double],
  expected_x : Array[Double],
  expected_y : Array[Double],
) -> Unit raise Error {
  for i in 0..<nodes.length() {
    assert_layout_xywh(
      taffy,
      nodes[i],
      expected_w[i],
      expected_h[i],
      expected_x[i],
      expected_y[i],
    )
  }
}

///|
test "upstream/generated/grid/grid_align_items_baseline" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 65.0)
}
