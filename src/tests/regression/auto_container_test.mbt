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
test "auto_container_sizes_to_children_row" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let child_a = chicle.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(5.0))),
  )
  let child_b = chicle.new_leaf(
    Style::default().with_size(Size(width=length(7.0), height=length(20.0))),
  )
  let root = chicle.new_with_children(Style::default(), [child_a, child_b])
  chicle.compute_layout(root, Size::max_content())
  let root_layout = chicle.layout(root)
  assert_eq(root_layout.size.width, 17.0)
  assert_eq(root_layout.size.height, 20.0)
}
