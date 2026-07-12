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
test "layout order matches upstream placement order" {
  let flex : TaffyTree[Unit] = TaffyTree()
  let flex_a = flex.new_leaf(Style::default())
  let flex_hidden = flex.new_leaf(Style::default().with_display(display_none()))
  let flex_b = flex.new_leaf(Style::default())
  let flex_absolute = flex.new_leaf(
    Style::default().with_position(position_absolute()),
  )
  let flex_root = flex.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [flex_a, flex_hidden, flex_b, flex_absolute],
  )
  flex.compute_layout(flex_root, Size::max_content())
  debug_inspect(
    [
      flex.layout(flex_root).order,
      flex.layout(flex_a).order,
      flex.layout(flex_hidden).order,
      flex.layout(flex_b).order,
      flex.layout(flex_absolute).order,
    ],
    content="[0, 0, 0, 2, 3]",
  )

  let block : TaffyTree[Unit] = TaffyTree()
  let block_a = block.new_leaf(Style::default())
  let block_hidden = block.new_leaf(
    Style::default().with_display(display_none()),
  )
  let block_b = block.new_leaf(Style::default())
  let block_absolute = block.new_leaf(
    Style::default().with_position(position_absolute()),
  )
  let block_root = block.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [block_a, block_hidden, block_b, block_absolute],
  )
  block.compute_layout(block_root, Size::max_content())
  debug_inspect(
    [
      block.layout(block_a).order,
      block.layout(block_hidden).order,
      block.layout(block_b).order,
      block.layout(block_absolute).order,
    ],
    content="[0, 0, 1, 2]",
  )

  let grid : TaffyTree[Unit] = TaffyTree()
  let grid_a = grid.new_leaf(Style::default())
  let grid_hidden = grid.new_leaf(Style::default().with_display(display_none()))
  let grid_b = grid.new_leaf(Style::default())
  let grid_absolute = grid.new_leaf(
    Style::default().with_position(position_absolute()),
  )
  let grid_root = grid.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [grid_a, grid_hidden, grid_b, grid_absolute],
  )
  grid.compute_layout(grid_root, Size::max_content())
  debug_inspect(
    [
      grid.layout(grid_a).order,
      grid.layout(grid_b).order,
      grid.layout(grid_hidden).order,
      grid.layout(grid_absolute).order,
    ],
    content="[0, 1, 0, 3]",
  )
}

///|
test "layout order survives cached root layout" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let first = taffy.new_leaf(Style::default())
  let second = taffy.new_leaf(Style::default())
  let container = taffy.new_with_children(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
    [first, second],
  )
  let root = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [container],
  )
  taffy.compute_layout(root, Size::max_content())
  let first_order = taffy.layout(second).order
  taffy.compute_layout(root, Size::max_content())
  debug_inspect([first_order, taffy.layout(second).order], content="[1, 1]")
}
