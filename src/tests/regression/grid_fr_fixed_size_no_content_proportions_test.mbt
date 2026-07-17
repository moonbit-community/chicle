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
test "grid_fr_fixed_size_no_content_proportions" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(Style::default())
  let node1 = chicle.new_leaf(Style::default())
  let node2 = chicle.new_leaf(Style::default())
  let root_style = Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fr(1.0), fr(2.0), fr(3.0)])
    .with_size(Size(width=length(200.0), height=auto()))
  let root = chicle.new_with_children(root_style, [node0, node1, node2])
  chicle.compute_layout(root, Size::max_content())
  let root_layout = chicle.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 40.0)
  let l0 = chicle.layout(node0)
  assert_eq(l0.size.width, 33.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.size.width, 67.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 33.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = chicle.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "grid_fr_tracks_subtract_column_gaps" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(Style::default())
  let node1 = chicle.new_leaf(Style::default())
  let node2 = chicle.new_leaf(Style::default())
  let root_style = Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([length(180.0), fr(1.0), fr(1.0)])
    .with_gap(Size(width=length(14.0), height=length(0.0)))
    .with_padding(
      Rect(
        left=length(22.0),
        right=length(22.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    )
    .with_size(Size(width=length(760.0), height=length(40.0)))
  let root = chicle.new_with_children(root_style, [node0, node1, node2])
  chicle.compute_layout(root, Size::max_content())
  let l0 = chicle.layout(node0)
  assert_eq(l0.location.x, 22.0)
  assert_eq(l0.size.width, 180.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.location.x, 216.0)
  assert_eq(l1.size.width, 254.0)
  let l2 = chicle.layout(node2)
  assert_eq(l2.location.x, 484.0)
  assert_eq(l2.size.width, 254.0)
}

///|
test "grid_fr_tracks_subtract_row_gaps" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(Style::default())
  let node1 = chicle.new_leaf(Style::default())
  let node2 = chicle.new_leaf(Style::default())
  let root_style = Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(70.0), fr(1.0), length(92.0)])
    .with_grid_template_columns([length(40.0)])
    .with_gap(Size(width=length(0.0), height=length(14.0)))
    .with_padding(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(22.0),
        bottom=length(22.0),
      ),
    )
    .with_size(Size(width=length(40.0), height=length(480.0)))
  let root = chicle.new_with_children(root_style, [node0, node1, node2])
  chicle.compute_layout(root, Size::max_content())
  let l0 = chicle.layout(node0)
  assert_eq(l0.location.y, 22.0)
  assert_eq(l0.size.height, 70.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.location.y, 106.0)
  assert_eq(l1.size.height, 246.0)
  let l2 = chicle.layout(node2)
  assert_eq(l2.location.y, 366.0)
  assert_eq(l2.size.height, 92.0)
}
