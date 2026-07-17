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
test "wrap_row" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(
    Style::default().with_size(Size(width=length(31.0), height=length(30.0))),
  )
  let node1 = chicle.new_leaf(
    Style::default().with_size(Size(width=length(32.0), height=length(30.0))),
  )
  let node2 = chicle.new_leaf(
    Style::default().with_size(Size(width=length(33.0), height=length(30.0))),
  )
  let node3 = chicle.new_leaf(
    Style::default().with_size(Size(width=length(34.0), height=length(30.0))),
  )
  let root = chicle.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1, node2, node3],
  )
  chicle.compute_layout(root, Size::max_content())
  let layout = chicle.layout(root)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 60.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let l0 = chicle.layout(node0)
  assert_eq(l0.size.width, 31.0)
  assert_eq(l0.size.height, 30.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.size.width, 32.0)
  assert_eq(l1.size.height, 30.0)
  assert_eq(l1.location.x, 31.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = chicle.layout(node2)
  assert_eq(l2.size.width, 33.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 63.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = chicle.layout(node3)
  assert_eq(l3.size.width, 34.0)
  assert_eq(l3.size.height, 30.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 30.0)
}
