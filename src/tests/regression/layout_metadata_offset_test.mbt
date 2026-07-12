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
fn measured_offset_leaf(
  _known_dimensions : Size[Double?],
  _available_space : Size[AvailableSpace],
  _node_id : NodeId,
  _node_context : Unit?,
  _style : Style,
) -> Size[Double] {
  Size(width=12.0, height=13.0)
}

///|
test "relative subtree offset preserves descendant layout metadata" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let grandchild = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(7.0)
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(4.0),
        top=length(5.0),
        bottom=length(6.0),
      ),
    )
    .with_border(
      Rect(
        left=length(1.0),
        right=length(2.0),
        top=length(3.0),
        bottom=length(4.0),
      ),
    ),
  )
  let sibling = taffy.new_leaf(Style::default())
  let container = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect(left=length(10.0), right=auto(), top=auto(), bottom=auto()),
    ),
    [sibling, grandchild],
  )
  let root = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [container],
  )
  taffy.compute_layout_with_measure(
    root,
    Size::max_content(),
    measured_offset_leaf,
  )
  let layout = taffy.layout(grandchild)
  debug_inspect(
    [
      layout.padding.left,
      layout.padding.right,
      layout.padding.top,
      layout.padding.bottom,
      layout.border.left,
      layout.border.right,
      layout.border.top,
      layout.border.bottom,
      layout.scrollbar_size.width,
      layout.scrollbar_size.height,
      layout.content_size.width,
      layout.content_size.height,
    ],
    content="[3, 4, 5, 6, 1, 2, 3, 4, 7, 7, 12, 13]",
  )
  debug_inspect(layout.order, content="1")
}

///|
test "block margin collapse offset preserves descendant metadata" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let first_flow_leaf = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let metadata_leaf = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size(width=length(20.0), height=length(20.0)))
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(4.0),
        top=length(5.0),
        bottom=length(6.0),
      ),
    ),
  )
  let first_inner = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [first_flow_leaf],
  )
  let first_middle = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [first_inner],
  )
  let first_child = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [first_middle, metadata_leaf],
  )
  let second_flow_leaf = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0))),
  )
  let second_inner = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-2.0),
        bottom=length(0.0),
      ),
    ),
    [second_flow_leaf],
  )
  let second_middle = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(5.0),
        bottom=length(0.0),
      ),
    ),
    [second_inner],
  )
  let second_child = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(-10.0),
        bottom=length(0.0),
      ),
    ),
    [second_middle],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
    [first_child, second_child],
  )
  taffy.compute_layout_with_measure(
    root,
    Size::max_content(),
    measured_offset_leaf,
  )
  let layout = taffy.layout(metadata_leaf)
  debug_inspect(
    [
      layout.padding.left,
      layout.padding.right,
      layout.padding.top,
      layout.padding.bottom,
      layout.content_size.width,
      layout.content_size.height,
    ],
    content="[3, 4, 5, 6, 12, 13]",
  )
}
