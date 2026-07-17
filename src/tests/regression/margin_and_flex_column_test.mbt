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
test "margin_and_flex_column" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node = chicle.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  chicle.compute_layout(node, Size::max_content())
  let layout = chicle.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let layout0 = chicle.layout(node0)
  assert_eq(layout0.size.width, 100.0)
  assert_eq(layout0.size.height, 80.0)
  assert_eq(layout0.location.x, 0.0)
  assert_eq(layout0.location.y, 10.0)
}
