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
test "toggle_root_display_none" {
  let hidden_style = Style::default()
    .with_display(display_none())
    .with_size(Size(width=length(100.0), height=length(100.0)))
  let flex_style = Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(100.0), height=length(100.0)))
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node = chicle.new_leaf(hidden_style)
  chicle.compute_layout(node, Size::max_content())
  let layout = chicle.layout(node)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  assert_eq(layout.size.width, 0.0)
  assert_eq(layout.size.height, 0.0)
  chicle.set_style(node, flex_style)
  chicle.compute_layout(node, Size::max_content())
  let layout = chicle.layout(node)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  chicle.set_style(node, hidden_style)
  chicle.compute_layout(node, Size::max_content())
  let layout = chicle.layout(node)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  assert_eq(layout.size.width, 0.0)
  assert_eq(layout.size.height, 0.0)
}

///|
test "toggle_root_display_none_with_children" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let child_style = Style::default().with_size(
    Size(width=length(800.0), height=length(100.0)),
  )
  let child = chicle.new_leaf(child_style)
  let parent_style = Style::default().with_size(
    Size(width=length(800.0), height=length(100.0)),
  )
  let parent = chicle.new_with_children(parent_style, [child])
  let root = chicle.new_with_children(Style::default(), [parent])
  chicle.compute_layout(root, Size::max_content())
  assert_eq(chicle.layout(child).size.width, 800.0)
  assert_eq(chicle.layout(child).size.height, 100.0)
  chicle.set_style(root, Style::default().with_display(display_none()))
  chicle.compute_layout(root, Size::max_content())
  assert_eq(chicle.layout(child).size.width, 0.0)
  assert_eq(chicle.layout(child).size.height, 0.0)
  chicle.set_style(root, Style::default())
  chicle.compute_layout(root, Size::max_content())
  assert_eq(chicle.layout(child).size.width, 800.0)
  assert_eq(chicle.layout(child).size.height, 100.0)
}
