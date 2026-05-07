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
test "upstream/generated/flex/wrap_row_align_items_center" {
  // Ported from taffy-reference/tests/generated/flex/wrap_row_align_items_center.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(30.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(30.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_center())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 60.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 5.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 30.0)
  assert_eq(l3.size.height, 30.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 30.0)
}

///|
test "upstream/generated/flex/wrap_row_align_items_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/wrap_row_align_items_flex_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(30.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(30.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_flex_end())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 60.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 20.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 30.0)
  assert_eq(l3.size.height, 30.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 30.0)
}

///|
test "upstream/generated/flex/wrapped_column_max_height" {
  // Ported from taffy-reference/tests/generated/flex/wrapped_column_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(100.0), height=length(500.0)))
    .with_max_size(Size(width=auto(), height=length(200.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(200.0), height=length(200.0)))
    .with_margin(
      Rect(
        left=length(20.0),
        right=length(20.0),
        top=length(20.0),
        bottom=length(20.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_center())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(700.0), height=length(500.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 700.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 200.0)
  assert_eq(l0.location.x, 250.0)
  assert_eq(l0.location.y, 30.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 200.0)
  assert_eq(l1.location.x, 200.0)
  assert_eq(l1.location.y, 250.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 420.0)
  assert_eq(l2.location.y, 200.0)
}

///|
test "upstream/generated/flex/wrapped_column_max_height_flex" {
  // Ported from taffy-reference/tests/generated/flex/wrapped_column_max_height_flex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_size(Size(width=length(100.0), height=length(500.0)))
    .with_max_size(Size(width=auto(), height=length(200.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_size(Size(width=length(200.0), height=length(200.0)))
    .with_margin(
      Rect(
        left=length(20.0),
        right=length(20.0),
        top=length(20.0),
        bottom=length(20.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_center())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(700.0), height=length(500.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 700.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 180.0)
  assert_eq(l0.location.x, 300.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 180.0)
  assert_eq(l1.location.x, 250.0)
  assert_eq(l1.location.y, 200.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 300.0)
  assert_eq(l2.location.y, 400.0)
}

///|
test "upstream/generated/flex/wrapped_row_within_align_items_center" {
  // Ported from taffy-reference/tests/generated/flex/wrapped_row_within_align_items_center.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(150.0), height=length(80.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(80.0), height=length(80.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_flex_wrap(flex_wrap_wrap()),
    [node00, node01],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
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
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 160.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 150.0)
  assert_eq(l00.size.height, 80.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 80.0)
  assert_eq(l01.size.height, 80.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 80.0)
}

///|
test "upstream/generated/flex/wrapped_row_within_align_items_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/wrapped_row_within_align_items_flex_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(150.0), height=length(80.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(80.0), height=length(80.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_flex_wrap(flex_wrap_wrap()),
    [node00, node01],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_flex_end())
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
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 160.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 150.0)
  assert_eq(l00.size.height, 80.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 80.0)
  assert_eq(l01.size.height, 80.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 80.0)
}

///|
test "upstream/generated/flex/wrapped_row_within_align_items_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/wrapped_row_within_align_items_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(150.0), height=length(80.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(80.0), height=length(80.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_flex_wrap(flex_wrap_wrap()),
    [node00, node01],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_flex_start())
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
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 160.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 150.0)
  assert_eq(l00.size.height, 80.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 80.0)
  assert_eq(l01.size.height, 80.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 80.0)
}

///|
test "upstream/generated/grid/chrome_issue_325928327" {
  // Ported from taffy-reference/tests/generated/grid/chrome_issue_325928327.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=percent(1.0)))
    .with_aspect_ratio(1.0),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_size(Size(width=auto(), height=percent(1.0))),
    [node00],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_center())
    .with_size(Size(width=percent(1.0), height=length(40.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_absolute_align_self_sized_all" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_align_self_sized_all.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_start())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_start())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_end())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_end())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_center())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_center())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_stretch())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_stretch())
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
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let expected_w = [20.0, 60.0, 20.0, 60.0, 20.0, 60.0, 20.0, 60.0]
  let expected_h = [20.0, 60.0, 20.0, 60.0, 20.0, 60.0, 20.0, 60.0]
  let expected_x = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  let expected_y = [0.0, 0.0, 100.0, 60.0, 50.0, 30.0, 0.0, 0.0]
  for i in 0..<8 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_column_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_column_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_grid_column(Line(start=place_auto(), end=line(1)))
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
  assert_eq(n.size.width, 33.0)
  assert_eq(n.size.height, 157.0)
  assert_eq(n.location.x, 4.0)
  assert_eq(n.location.y, 1.0)
}

///|
test "upstream/generated/grid/grid_absolute_column_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_column_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_grid_column(Line(start=line(1), end=place_auto()))
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
  assert_eq(n.size.width, 133.0)
  assert_eq(n.size.height, 157.0)
  assert_eq(n.location.x, 44.0)
  assert_eq(n.location.y, 1.0)
}

///|
test "upstream/generated/grid/grid_absolute_container_bottom_left" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_bottom_left.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(left=length(0.0), right=auto(), top=auto(), bottom=length(0.0)),
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
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [0.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [160.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_bottom_left_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_bottom_left_margin.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(4.0),
        right=length(2.0),
        top=length(1.0),
        bottom=length(3.0),
      ),
    )
    .with_inset(
      Rect(left=length(0.0), right=auto(), top=auto(), bottom=length(0.0)),
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
  let expected_w = [10.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [10.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [4.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [147.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_left_overrides_right" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_left_overrides_right.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(10.0), height=auto()))
    .with_inset(
      Rect(left=length(5.0), right=length(2.0), top=auto(), bottom=auto()),
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
  let expected_w = [10.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [5.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [0.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_left_right" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_left_right.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(left=length(5.0), right=length(2.0), top=auto(), bottom=auto()),
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
  let expected_w = [173.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [5.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [0.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_left_right_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_left_right_margin.rs
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
      Rect(left=length(5.0), right=length(2.0), top=auto(), bottom=auto()),
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
  let expected_w = [167.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [9.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [1.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_negative_position" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_negative_position.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(left=auto(), right=length(-15.0), top=length(-5.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(left=length(-35.0), right=auto(), top=auto(), bottom=length(-25.0)),
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
  let expected_x = [195.0, -35.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0]
  let expected_y = [-5.0, 185.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_negative_position_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_negative_position_margin.rs
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
      Rect(left=auto(), right=length(-15.0), top=length(-5.0), bottom=auto()),
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
      Rect(left=length(-35.0), right=auto(), top=auto(), bottom=length(-25.0)),
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
  let expected_x = [193.0, -31.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0]
  let expected_y = [-4.0, 182.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_top_bottom" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_top_bottom.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
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
  let expected_h = [153.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
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
test "upstream/generated/grid/grid_absolute_container_top_bottom_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_top_bottom_margin.rs
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
  let expected_h = [149.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [4.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [3.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_top_right" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_top_right.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect(left=auto(), right=length(0.0), top=length(0.0), bottom=auto()),
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
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [180.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [0.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_container_top_right_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_container_top_right_margin.rs
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
  let expected_h = [0.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0]
  let expected_x = [178.0, 40.0, 80.0, 120.0, 40.0, 80.0, 120.0, 40.0, 80.0]
  let expected_y = [1.0, 10.0, 10.0, 10.0, 50.0, 50.0, 50.0, 90.0, 90.0]
  for i in 0..<9 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_justify_self_sized_all" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_justify_self_sized_all.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_end())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_end())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_center())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_center())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_justify_self(align_items_stretch())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
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
  let nodes = [node0, node1, node2, node3, node4, node5, node6, node7]
  let expected_w = [20.0, 60.0, 20.0, 60.0, 20.0, 60.0, 20.0, 60.0]
  let expected_h = [20.0, 60.0, 20.0, 60.0, 20.0, 60.0, 20.0, 60.0]
  let expected_x = [0.0, 0.0, 100.0, 60.0, 50.0, 30.0, 0.0, 0.0]
  let expected_y = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  for i in 0..<8 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_layout_within_border" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_layout_within_border.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_border(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3]
  let expected_w = [50.0, 50.0, 50.0, 50.0]
  let expected_h = [50.0, 50.0, 50.0, 50.0]
  let expected_x = [10.0, 40.0, 20.0, 30.0]
  let expected_y = [10.0, 40.0, 20.0, 30.0]
  for i in 0..<4 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}

///|
test "upstream/generated/grid/grid_absolute_layout_within_border_static" {
  // Ported from taffy-reference/tests/generated/grid/grid_absolute_layout_within_border_static.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_end())
    .with_justify_self(align_items_end())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_align_self(align_items_end())
    .with_justify_self(align_items_end())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_border(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let nodes = [node0, node1, node2, node3]
  let expected_w = [50.0, 50.0, 50.0, 50.0]
  let expected_h = [50.0, 50.0, 50.0, 50.0]
  let expected_x = [10.0, 40.0, 20.0, 30.0]
  let expected_y = [10.0, 40.0, 20.0, 30.0]
  for i in 0..<4 {
    let layout = taffy.layout(nodes[i])
    assert_eq(layout.size.width, expected_w[i])
    assert_eq(layout.size.height, expected_h[i])
    assert_eq(layout.location.x, expected_x[i])
    assert_eq(layout.location.y, expected_y[i])
  }
}
