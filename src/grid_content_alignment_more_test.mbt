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
fn mk_9_nodes(taffy : TaffyTree[Unit]) -> Array[NodeId] {
  let nodes = Array::make(9, 0)
  for i in 0..<9 {
    nodes[i] = taffy.new_leaf(Style::default())
  }
  nodes
}

///|
fn check_cell(
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
test "grid_justify_content_space_between (upstream: generated/grid/grid_justify_content_space_between.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = mk_9_nodes(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_content(justify_content_space_between())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(200.0), height=length(200.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  check_cell(taffy, nodes[0], 0.0, 0.0)
  check_cell(taffy, nodes[1], 80.0, 0.0)
  check_cell(taffy, nodes[2], 160.0, 0.0)
  check_cell(taffy, nodes[3], 0.0, 40.0)
  check_cell(taffy, nodes[4], 80.0, 40.0)
  check_cell(taffy, nodes[5], 160.0, 40.0)
}

///|
test "grid_justify_content_space_evenly (upstream: generated/grid/grid_justify_content_space_evenly.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = mk_9_nodes(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_justify_content(justify_content_space_evenly())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(200.0), height=length(200.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  check_cell(taffy, nodes[0], 20.0, 0.0)
  check_cell(taffy, nodes[1], 80.0, 0.0)
  check_cell(taffy, nodes[2], 140.0, 0.0)
  check_cell(taffy, nodes[3], 20.0, 40.0)
  check_cell(taffy, nodes[4], 80.0, 40.0)
  check_cell(taffy, nodes[5], 140.0, 40.0)
}

///|
test "grid_align_content_space_between (upstream: generated/grid/grid_align_content_space_between.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = mk_9_nodes(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content_space_between())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(200.0), height=length(200.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  check_cell(taffy, nodes[0], 0.0, 0.0)
  check_cell(taffy, nodes[3], 0.0, 80.0)
  check_cell(taffy, nodes[6], 0.0, 160.0)
}

///|
test "grid_align_content_space_evenly (upstream: generated/grid/grid_align_content_space_evenly.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes = mk_9_nodes(taffy)
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content_space_evenly())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(200.0), height=length(200.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  check_cell(taffy, nodes[0], 0.0, 20.0)
  check_cell(taffy, nodes[3], 0.0, 80.0)
  check_cell(taffy, nodes[6], 0.0, 140.0)
}

///|
test "grid_justify_content_center_negative_space_gap (upstream: generated/grid/grid_justify_content_center_negative_space_gap.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let leafs = mk_9_nodes(taffy)
  let inner = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_center())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_grid_template_rows([length(20.0), length(20.0), length(20.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    leafs,
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
  let inner_layout = taffy.layout(inner)
  assert_eq(inner_layout.location.x, 60.0)
  assert_eq(inner_layout.location.y, 60.0)
  assert_eq(inner_layout.size.width, 120.0)
  assert_eq(inner_layout.size.height, 120.0)
  let l00 = taffy.layout(leafs[0])
  assert_eq(l00.size.width, 40.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, -10.0)
  assert_eq(l00.location.y, 20.0)
}

///|
test "grid_align_content_center_negative_space_gap (upstream: generated/grid/grid_align_content_center_negative_space_gap.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let leafs = mk_9_nodes(taffy)
  let inner = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_center())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(20.0), length(20.0), length(20.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    leafs,
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
  let inner_layout = taffy.layout(inner)
  assert_eq(inner_layout.location.x, 60.0)
  assert_eq(inner_layout.location.y, 60.0)
  assert_eq(inner_layout.size.width, 120.0)
  assert_eq(inner_layout.size.height, 120.0)
  let l00 = taffy.layout(leafs[0])
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 40.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, -10.0)
}
