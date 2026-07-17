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
test "flex_wrap_align_stretch_fits_one_row" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = chicle.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let root = chicle.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1],
  )
  chicle.compute_layout(root, Size::max_content())
  let layout = chicle.layout(root)
  assert_eq(layout.size.width, 150.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let l0 = chicle.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
}
