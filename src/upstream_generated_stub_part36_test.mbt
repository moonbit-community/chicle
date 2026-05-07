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
test "upstream/generated/grid/grid_justify_content_start_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_start_negative_space_gap.rs
  run_grid_justify_content_negative_space_gap_test(justify_content_start(), [
    0.0, 50.0, 100.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_content_start_with_padding_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_content_start_with_padding_border.rs
  run_grid_justify_content_with_padding_border_test(justify_content_start(), [
    48.0, 88.0, 128.0,
  ])
}

///|
test "upstream/generated/grid/grid_justify_items_sized_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_items_sized_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_center())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 70.0)
  assert_eq(l1.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_justify_items_sized_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_items_sized_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_end())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 60.0)
  assert_eq(l1.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_justify_items_sized_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_items_sized_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_start())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_justify_items_sized_stretch" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_items_sized_stretch.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_stretch())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_justify_self_sized_all" {
  // Ported from taffy-reference/tests/generated/grid/grid_justify_self_sized_all.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_end())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_end())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_center())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_center())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_stretch())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_stretch())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 20.0)
  assert_eq(l2.size.height, 20.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 60.0)
  assert_eq(l3.size.height, 60.0)
  assert_eq(l3.location.x, -20.0)
  assert_eq(l3.location.y, 40.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 20.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 40.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 60.0)
  assert_eq(l5.size.height, 60.0)
  assert_eq(l5.location.x, 70.0)
  assert_eq(l5.location.y, 40.0)
  let l6 = taffy.layout(node6)
  assert_eq(l6.size.width, 20.0)
  assert_eq(l6.size.height, 20.0)
  assert_eq(l6.location.x, 0.0)
  assert_eq(l6.location.y, 80.0)
  let l7 = taffy.layout(node7)
  assert_eq(l7.size.width, 60.0)
  assert_eq(l7.size.height, 60.0)
  assert_eq(l7.location.x, 40.0)
  assert_eq(l7.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_margins_auto_margins" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_auto_margins.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(
    Style::default()
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(20.0), height=auto()))
    .with_margin(
      Rect(left=auto(), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_size(Size(width=auto(), height=length(20.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=auto(), bottom=auto()),
    ),
  )
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(Rect(left=auto(), right=auto(), top=auto(), bottom=auto())),
  )
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
  let expected_w = [40.0, 40.0, 20.0, 40.0, 40.0, 40.0, 20.0, 40.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 20.0, 40.0, 20.0, 40.0, 40.0]
  let expected_x = [40.0, 80.0, 130.0, 40.0, 80.0, 120.0, 50.0, 80.0, 120.0]
  let expected_y = [10.0, 10.0, 10.0, 50.0, 60.0, 50.0, 100.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_auto_margins_override_stretch" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_auto_margins_override_stretch.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf_with_context(
    Style::default()
    .with_align_self(align_items_stretch())
    .with_justify_self(align_items_stretch())
    .with_margin(Rect(left=auto(), right=auto(), top=auto(), bottom=auto())),
    { text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
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
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 10.0, 40.0, 40.0]
  let expected_x = [40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0]
  let expected_y = [10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 105.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_fixed_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_fixed_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_justify_self(align_items_center())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
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
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [52.0, 80.0, 120.0, 40.0, 80.0, 120.0]
  let expected_y = [18.0, 10.0, 10.0, 50.0, 50.0, 50.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_fixed_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_fixed_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_end())
    .with_justify_self(align_items_end())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
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
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [58.0, 80.0, 120.0, 40.0, 80.0, 120.0]
  let expected_y = [27.0, 10.0, 10.0, 50.0, 50.0, 50.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_fixed_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_fixed_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
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
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [44.0, 80.0, 120.0, 40.0, 80.0, 120.0]
  let expected_y = [11.0, 10.0, 10.0, 50.0, 50.0, 50.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_fixed_stretch" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_fixed_stretch.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_stretch())
    .with_justify_self(align_items_stretch())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
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
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 180.0)
  assert_eq(root_layout.size.height, 160.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [44.0, 80.0, 120.0, 40.0, 80.0, 120.0]
  let expected_y = [11.0, 10.0, 10.0, 50.0, 50.0, 50.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_percent_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_percent_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_justify_self(align_items_center())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect(
        left=percent(0.2),
        right=percent(0.1),
        top=percent(0.05),
        bottom=percent(0.15),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)]),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [1.0, 20.0, 40.0, 0.0, 20.0, 40.0]
  let expected_y = [9.0, 0.0, 0.0, 40.0, 40.0, 40.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_percent_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_percent_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_end())
    .with_justify_self(align_items_end())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect(
        left=percent(0.2),
        right=percent(0.1),
        top=percent(0.05),
        bottom=percent(0.15),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)]),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [-2.0, 20.0, 40.0, 0.0, 20.0, 40.0]
  let expected_y = [17.0, 0.0, 0.0, 40.0, 40.0, 40.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_percent_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_percent_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect(
        left=percent(0.2),
        right=percent(0.1),
        top=percent(0.05),
        bottom=percent(0.15),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)]),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [4.0, 20.0, 40.0, 0.0, 20.0, 40.0]
  let expected_y = [1.0, 0.0, 0.0, 40.0, 40.0, 40.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_margins_percent_stretch" {
  // Ported from taffy-reference/tests/generated/grid/grid_margins_percent_stretch.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_stretch())
    .with_justify_self(align_items_stretch())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_margin(
      Rect(
        left=percent(0.2),
        right=percent(0.1),
        top=percent(0.05),
        bottom=percent(0.15),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)]),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5]
  let expected_w = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0]
  let expected_h = [20.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [4.0, 20.0, 40.0, 0.0, 20.0, 40.0]
  let expected_y = [1.0, 0.0, 0.0, 40.0, 40.0, 40.0]
  for i in 0..<6 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_maximum_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_maximum_single_item.rs
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([
      length(40.0),
      minmax(length(0.0), grid_max_content()),
      length(40.0),
    ]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0]
  let expected_y = [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item.rs
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), grid_max_content(), length(40.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0]
  let expected_y = [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_margin_auto" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_margin_auto.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_margin(
      Rect(left=auto(), right=auto(), top=auto(), bottom=auto()),
    ),
    { text_content: "HH\u{200B}HH", writing_mode: Horizontal },
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
    .with_grid_template_columns([length(40.0), grid_max_content(), length(40.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [40.0, 10.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0]
  let expected_y = [0.0, 15.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_margin_fixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_margin_fixed.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_margin(
      Rect(
        left=length(20.0),
        right=length(10.0),
        top=length(5.0),
        bottom=length(15.0),
      ),
    ),
    { text_content: "HH\u{200B}HH", writing_mode: Horizontal },
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
    .with_grid_template_columns([length(40.0), grid_max_content(), length(40.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 150.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 40.0, 70.0, 40.0, 40.0, 70.0, 40.0]
  let expected_h = [40.0, 20.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 60.0, 110.0, 0.0, 40.0, 110.0, 0.0, 40.0, 110.0]
  let expected_y = [0.0, 5.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_margin_percent" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_margin_percent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_margin(
      Rect(
        left=percent(0.2),
        right=percent(0.1),
        top=percent(0.05),
        bottom=percent(0.15),
      ),
    ),
    { text_content: "HH\u{200B}HH", writing_mode: Horizontal },
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
    .with_grid_template_columns([length(40.0), grid_max_content(), length(40.0)]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 28.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [40.0, 32.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 48.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0]
  let expected_y = [0.0, 2.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_max_content_single_item_span_2" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_span_2.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(Line(start=span(2), end=place_auto())),
    { text_content: "HH\u{200B}HH", writing_mode: Horizontal },
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
    .with_grid_template_columns([
      length(40.0),
      grid_max_content(),
      grid_max_content(),
    ]),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 80.0)
  assert_eq(root_layout.size.height, 120.0)
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7, node8]
  let expected_w = [40.0, 40.0, 40.0, 20.0, 20.0, 40.0, 20.0, 20.0, 40.0]
  let expected_h = [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 0.0]
  let expected_x = [0.0, 40.0, 0.0, 40.0, 60.0, 0.0, 40.0, 60.0, 0.0]
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
test "upstream/generated/grid/grid_max_content_single_item_span_2_gap_fixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_span_2_gap_fixed.rs
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
    .with_gap(Size(width=length(20.0), height=length(0.0)))
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
  assert_eq(root_layout.size.width, 120.0)
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
test "upstream/generated/grid/grid_max_content_single_item_span_2_gap_percent_definite" {
  // Ported from taffy-reference/tests/generated/grid/grid_max_content_single_item_span_2_gap_percent_definite.rs
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
    ])
    .with_size(Size(width=length(100.0), height=auto())),
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
