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
test "grid_align_items_sized_start" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = chicle.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = chicle.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_start())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  chicle.compute_layout(root, Size::max_content())
  let l0 = chicle.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.size.width, 60.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 80.0)
}

///|
test "grid_align_items_sized_end" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = chicle.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = chicle.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_end())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  chicle.compute_layout(root, Size::max_content())
  let l0 = chicle.layout(node0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 20.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 60.0)
}

///|
test "grid_justify_items_sized_start" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = chicle.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = chicle.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_start())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  chicle.compute_layout(root, Size::max_content())
  let l0 = chicle.layout(node0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 80.0)
}

///|
test "grid_justify_items_sized_end" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = chicle.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = chicle.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_items(align_items_end())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  chicle.compute_layout(root, Size::max_content())
  let l0 = chicle.layout(node0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.location.x, 60.0)
  assert_eq(l1.location.y, 80.0)
}
