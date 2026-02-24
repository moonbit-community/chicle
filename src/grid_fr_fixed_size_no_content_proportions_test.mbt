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
test "upstream/generated/grid/grid_fr_fixed_size_no_content_proportions" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let root_style = Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([fr(1.0), fr(2.0), fr(3.0)])
    .with_size(Size::new(width=length(200.0), height=auto()))
  let root = taffy.new_with_children(root_style, [node0, node1, node2])
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 200.0)
  assert_eq(root_layout.size.height, 40.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 33.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 67.0)
  assert_eq(l1.size.height, 40.0)
  assert_eq(l1.location.x, 33.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
}
