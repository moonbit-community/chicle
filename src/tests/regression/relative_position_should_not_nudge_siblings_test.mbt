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
test "relative_position_should_not_nudge_siblings (upstream: generated/flex/relative_position_should_not_nudge_siblings.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let child_style = Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(15.0), bottom=auto()),
    )
  let node0 = taffy.new_leaf(child_style)
  let node1 = taffy.new_leaf(child_style)
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout(node, Size::max_content())
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 15.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 25.0)
}
