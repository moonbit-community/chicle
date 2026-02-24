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
test "grid_out_of_order_items_column_dense (regression)" {
  // Mirror of upstream/generated/grid/grid_out_of_order_items.rs, but for column dense auto-placement.
  // This is a MoonBit-only regression test because upstream only ships RowDense vectors.
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line::new(start=line(1), end=place_auto()))
    .with_size(Size::new(width=length(35.0), height=length(35.0))),
  )
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line::new(start=line(1), end=place_auto()))
    .with_grid_column(Line::new(start=line(1), end=place_auto()))
    .with_size(Size::new(width=length(20.0), height=length(20.0))),
  )
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(
    Style::default()
    .with_grid_column(Line::new(start=line(1), end=place_auto()))
    .with_size(Size::new(width=length(10.0), height=length(10.0))),
  )
  let node8 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_grid_auto_flow(grid_auto_flow_column_dense())
    .with_size(Size::new(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 80.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 35.0)
  assert_eq(l2.size.height, 35.0)
  assert_eq(l2.location.x, 80.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 40.0)
  assert_eq(l3.size.height, 40.0)
  assert_eq(l3.location.x, 40.0)
  assert_eq(l3.location.y, 40.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 40.0)
  assert_eq(l4.size.height, 40.0)
  assert_eq(l4.location.x, 40.0)
  assert_eq(l4.location.y, 80.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.size.width, 20.0)
  assert_eq(l5.size.height, 20.0)
  assert_eq(l5.location.x, 0.0)
  assert_eq(l5.location.y, 0.0)
  let l6 = taffy.layout(node6)
  assert_eq(l6.size.width, 40.0)
  assert_eq(l6.size.height, 40.0)
  assert_eq(l6.location.x, 80.0)
  assert_eq(l6.location.y, 40.0)
  let l7 = taffy.layout(node7)
  assert_eq(l7.size.width, 10.0)
  assert_eq(l7.size.height, 10.0)
  assert_eq(l7.location.x, 0.0)
  assert_eq(l7.location.y, 40.0)
  let l8 = taffy.layout(node8)
  assert_eq(l8.size.width, 40.0)
  assert_eq(l8.size.height, 40.0)
  assert_eq(l8.location.x, 80.0)
  assert_eq(l8.location.y, 80.0)
}
