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
test "container content size includes overflowing children" {
  let block : ChicleTree[Unit] = ChicleTree()
  let block_child = block.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(200.0), height=length(20.0))),
  )
  let block_root = block.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(50.0))),
    [block_child],
  )
  block.compute_layout(block_root, Size::max_content())
  let block_child_layout = block.layout(block_child)
  let block_layout = block.layout(block_root)
  debug_inspect(
    [
      block_child_layout.size.width,
      block_layout.content_size.width,
      block_layout.scroll_width(),
    ],
    content="[200, 200, 100]",
  )

  let flexbox : ChicleTree[Unit] = ChicleTree()
  let flex_child = flexbox.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(200.0), height=length(20.0))),
  )
  let flex_root = flexbox.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(50.0))),
    [flex_child],
  )
  flexbox.compute_layout(flex_root, Size::max_content())
  debug_inspect(
    [
      flexbox.layout(flex_child).size.width,
      flexbox.layout(flex_root).content_size.width,
    ],
    content="[200, 200]",
  )

  let grid : ChicleTree[Unit] = ChicleTree()
  let grid_child = grid.new_leaf(
    Style::default().with_size(Size(width=length(200.0), height=length(20.0))),
  )
  let grid_root = grid.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(50.0))),
    [grid_child],
  )
  grid.compute_layout(grid_root, Size::max_content())
  debug_inspect(
    [
      grid.layout(grid_child).size.width,
      grid.layout(grid_root).content_size.width,
    ],
    content="[200, 200]",
  )

  let absolute : ChicleTree[Unit] = ChicleTree()
  let absolute_child = absolute.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(200.0), height=length(20.0))),
  )
  let absolute_root = absolute.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(50.0))),
    [absolute_child],
  )
  absolute.compute_layout(absolute_root, Size::max_content())
  debug_inspect(
    [
      absolute.layout(absolute_child).size.width,
      absolute.layout(absolute_root).content_size.width,
    ],
    content="[200, 200]",
  )
}

///|
test "clipped descendant overflow does not propagate to its parent" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let grandchild = chicle.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(200.0), height=length(20.0))),
  )
  let clipped_child = chicle.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_size(Size(width=length(50.0), height=length(30.0))),
    [grandchild],
  )
  let root = chicle.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(50.0))),
    [clipped_child],
  )
  chicle.compute_layout(root, Size::max_content())
  debug_inspect(
    [
      chicle.layout(clipped_child).content_size.width,
      chicle.layout(root).content_size.width,
      chicle.layout(root).scroll_width(),
    ],
    content="[200, 100, 0]",
  )
}

///|
test "content size uses the positive overflow edge" {
  let positive : ChicleTree[Unit] = ChicleTree()
  let positive_child = positive.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_inset(
      Rect(left=length(40.0), right=auto(), top=auto(), bottom=auto()),
    )
    .with_size(Size(width=length(100.0), height=length(20.0))),
  )
  let positive_root = positive.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(50.0))),
    [positive_child],
  )
  positive.compute_layout(positive_root, Size::max_content())
  debug_inspect(
    [
      positive.layout(positive_child).location.x,
      positive.layout(positive_root).content_size.width,
    ],
    content="[40, 140]",
  )

  let negative : ChicleTree[Unit] = ChicleTree()
  let negative_child = negative.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_inset(
      Rect(left=length(-40.0), right=auto(), top=auto(), bottom=auto()),
    )
    .with_size(Size(width=length(100.0), height=length(20.0))),
  )
  let negative_root = negative.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(100.0), height=length(50.0))),
    [negative_child],
  )
  negative.compute_layout(negative_root, Size::max_content())
  debug_inspect(
    [
      negative.layout(negative_child).location.x,
      negative.layout(negative_root).content_size.width,
    ],
    content="[-40, 100]",
  )
}
