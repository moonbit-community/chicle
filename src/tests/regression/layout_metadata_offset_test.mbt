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
  _known_dimensions : @regression.Size[Double?],
  _available_space : @regression.Size[@regression.AvailableSpace],
  _node_id : @regression.NodeId,
  _node_context : Unit?,
  _style : @regression.Style,
) -> @regression.Size[Double] {
  Size(width=12.0, height=13.0)
}

///|
test "relative subtree offset preserves descendant layout metadata" {
  let chicle : @regression.ChicleTree[Unit] = ChicleTree()
  let grandchild = chicle.new_leaf(
    @regression.Style::default()
    .with_size(
      Size(width=@regression.length(20.0), height=@regression.length(20.0)),
    )
    .with_overflow(
      Point(x=@regression.overflow_scroll(), y=@regression.overflow_scroll()),
    )
    .with_scrollbar_width(7.0)
    .with_padding(
      Rect(
        left=@regression.length(3.0),
        right=@regression.length(4.0),
        top=@regression.length(5.0),
        bottom=@regression.length(6.0),
      ),
    )
    .with_border(
      Rect(
        left=@regression.length(1.0),
        right=@regression.length(2.0),
        top=@regression.length(3.0),
        bottom=@regression.length(4.0),
      ),
    ),
  )
  let sibling = chicle.new_leaf(@regression.Style::default())
  let container = chicle.new_with_children(
    @regression.Style::default()
    .with_size(
      Size(width=@regression.length(50.0), height=@regression.length(50.0)),
    )
    .with_inset(
      Rect(
        left=@regression.length(10.0),
        right=@regression.auto(),
        top=@regression.auto(),
        bottom=@regression.auto(),
      ),
    ),
    [sibling, grandchild],
  )
  let root = chicle.new_with_children(
    @regression.Style::default().with_size(
      Size(width=@regression.length(100.0), height=@regression.length(100.0)),
    ),
    [container],
  )
  chicle.compute_layout_with_measure(
    root,
    @regression.Size::max_content(),
    measured_offset_leaf,
  )
  let layout = chicle.layout(grandchild)
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
  let chicle : @regression.ChicleTree[Unit] = ChicleTree()
  let first_flow_leaf = chicle.new_leaf(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_size(Size(width=@regression.auto(), height=@regression.length(10.0))),
  )
  let metadata_leaf = chicle.new_leaf(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_position(@regression.position_absolute())
    .with_size(
      Size(width=@regression.length(20.0), height=@regression.length(20.0)),
    )
    .with_padding(
      Rect(
        left=@regression.length(3.0),
        right=@regression.length(4.0),
        top=@regression.length(5.0),
        bottom=@regression.length(6.0),
      ),
    ),
  )
  let first_inner = chicle.new_with_children(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_margin(
      Rect(
        left=@regression.length(0.0),
        right=@regression.length(0.0),
        top=@regression.length(-10.0),
        bottom=@regression.length(0.0),
      ),
    ),
    [first_flow_leaf],
  )
  let first_middle = chicle.new_with_children(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_margin(
      Rect(
        left=@regression.length(0.0),
        right=@regression.length(0.0),
        top=@regression.length(10.0),
        bottom=@regression.length(0.0),
      ),
    ),
    [first_inner],
  )
  let first_child = chicle.new_with_children(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_margin(
      Rect(
        left=@regression.length(0.0),
        right=@regression.length(0.0),
        top=@regression.length(-10.0),
        bottom=@regression.length(0.0),
      ),
    ),
    [first_middle, metadata_leaf],
  )
  let second_flow_leaf = chicle.new_leaf(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_size(Size(width=@regression.auto(), height=@regression.length(10.0))),
  )
  let second_inner = chicle.new_with_children(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_margin(
      Rect(
        left=@regression.length(0.0),
        right=@regression.length(0.0),
        top=@regression.length(-2.0),
        bottom=@regression.length(0.0),
      ),
    ),
    [second_flow_leaf],
  )
  let second_middle = chicle.new_with_children(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_margin(
      Rect(
        left=@regression.length(0.0),
        right=@regression.length(0.0),
        top=@regression.length(5.0),
        bottom=@regression.length(0.0),
      ),
    ),
    [second_inner],
  )
  let second_child = chicle.new_with_children(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_margin(
      Rect(
        left=@regression.length(0.0),
        right=@regression.length(0.0),
        top=@regression.length(-10.0),
        bottom=@regression.length(0.0),
      ),
    ),
    [second_middle],
  )
  let root = chicle.new_with_children(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_size(Size(width=@regression.length(50.0), height=@regression.auto())),
    [first_child, second_child],
  )
  chicle.compute_layout_with_measure(
    root,
    @regression.Size::max_content(),
    measured_offset_leaf,
  )
  let layout = chicle.layout(metadata_leaf)
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
