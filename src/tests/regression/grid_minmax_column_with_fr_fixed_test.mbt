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
test "grid_minmax_column_with_fr_fixed" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(Style::default())
  let node1 = chicle.new_leaf(Style::default())
  let root_style = Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([minmax(length(20.0), length(40.0)), fr(1.0)])
    .with_size(Size(width=length(60.0), height=auto()))
  let root = chicle.new_with_children(root_style, [node0, node1])
  chicle.compute_layout(root, Size::max_content())
  let root_layout = chicle.layout(root)
  assert_eq(root_layout.size.width, 60.0)
  assert_eq(root_layout.size.height, 40.0)
  let l0 = chicle.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.size.width, 20.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 0.0)
}
