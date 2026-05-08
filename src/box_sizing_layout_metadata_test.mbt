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
test "box_sizing_content_box_expands_to_border_box" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node = taffy.new_leaf(
    Style::default()
    .with_box_sizing(box_sizing_content_box())
    .with_size(Size(width=length(100.0), height=length(50.0)))
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    )
    .with_border(
      Rect(
        left=length(2.0),
        right=length(2.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
  )
  taffy.compute_layout(node, Size::max_content())
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 124.0)
  assert_eq(layout.size.height, 66.0)
  assert_eq(layout.padding.left, 10.0)
  assert_eq(layout.border.top, 3.0)
}

///|
test "layout_exposes_bevy_metadata_fields" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=length(100.0), height=length(80.0)))
    .with_overflow(Point(x=overflow_scroll(), y=overflow_scroll()))
    .with_scrollbar_width(7.0)
    .with_padding(
      Rect(
        left=length(5.0),
        right=length(6.0),
        top=length(3.0),
        bottom=length(4.0),
      ),
    )
    .with_border(
      Rect(
        left=length(1.0),
        right=length(2.0),
        top=length(8.0),
        bottom=length(9.0),
      ),
    ),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.content_size.width, 79.0)
  assert_eq(layout.content_size.height, 49.0)
  assert_eq(layout.scrollbar_size.width, 7.0)
  assert_eq(layout.scrollbar_size.height, 7.0)
  assert_eq(layout.border.right, 2.0)
  assert_eq(layout.padding.bottom, 4.0)
}
