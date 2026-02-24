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
fn mk_grid_root(
  taffy : TaffyTree[Unit],
  align : AlignContent,
  children : Array[NodeId],
) -> NodeId {
  taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align)
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size::new(width=length(200.0), height=length(200.0))),
    children,
  )
}

///|
fn check_grid_cell(
  taffy : TaffyTree[Unit],
  node : NodeId,
  expected_x : Double,
  expected_y : Double,
) -> Unit raise Error {
  let l = try taffy.layout(node) catch {
    _ => panic()
  } noraise {
    v => v
  }
  assert_eq(l.size.width, 40.0)
  assert_eq(l.size.height, 40.0)
  assert_eq(l.location.x, expected_x)
  assert_eq(l.location.y, expected_y)
}

///|
test "grid_align_content_start (upstream: generated/grid/grid_align_content_start.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes = Array::make(9, 0)
  for i in 0..<9 {
    nodes[i] = taffy.new_leaf(Style::default())
  }
  let root = mk_grid_root(taffy, align_content_start(), nodes)
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 200.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  check_grid_cell(taffy, nodes[0], 0.0, 0.0)
  check_grid_cell(taffy, nodes[1], 40.0, 0.0)
  check_grid_cell(taffy, nodes[2], 80.0, 0.0)
  check_grid_cell(taffy, nodes[3], 0.0, 40.0)
  check_grid_cell(taffy, nodes[4], 40.0, 40.0)
  check_grid_cell(taffy, nodes[5], 80.0, 40.0)
  check_grid_cell(taffy, nodes[6], 0.0, 80.0)
  check_grid_cell(taffy, nodes[7], 40.0, 80.0)
  check_grid_cell(taffy, nodes[8], 80.0, 80.0)
}

///|
test "grid_align_content_center (upstream: generated/grid/grid_align_content_center.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes = Array::make(9, 0)
  for i in 0..<9 {
    nodes[i] = taffy.new_leaf(Style::default())
  }
  let root = mk_grid_root(taffy, align_content_center(), nodes)
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 200.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  check_grid_cell(taffy, nodes[0], 0.0, 40.0)
  check_grid_cell(taffy, nodes[1], 40.0, 40.0)
  check_grid_cell(taffy, nodes[2], 80.0, 40.0)
  check_grid_cell(taffy, nodes[3], 0.0, 80.0)
  check_grid_cell(taffy, nodes[4], 40.0, 80.0)
  check_grid_cell(taffy, nodes[5], 80.0, 80.0)
  check_grid_cell(taffy, nodes[6], 0.0, 120.0)
  check_grid_cell(taffy, nodes[7], 40.0, 120.0)
  check_grid_cell(taffy, nodes[8], 80.0, 120.0)
}

///|
test "grid_align_content_end (upstream: generated/grid/grid_align_content_end.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let nodes = Array::make(9, 0)
  for i in 0..<9 {
    nodes[i] = taffy.new_leaf(Style::default())
  }
  let root = mk_grid_root(taffy, align_content_end(), nodes)
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 200.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  check_grid_cell(taffy, nodes[0], 0.0, 80.0)
  check_grid_cell(taffy, nodes[1], 40.0, 80.0)
  check_grid_cell(taffy, nodes[2], 80.0, 80.0)
  check_grid_cell(taffy, nodes[3], 0.0, 120.0)
  check_grid_cell(taffy, nodes[4], 40.0, 120.0)
  check_grid_cell(taffy, nodes[5], 80.0, 120.0)
  check_grid_cell(taffy, nodes[6], 0.0, 160.0)
  check_grid_cell(taffy, nodes[7], 40.0, 160.0)
  check_grid_cell(taffy, nodes[8], 80.0, 160.0)
}
