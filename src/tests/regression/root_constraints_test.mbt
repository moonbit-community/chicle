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
test "root_with_percentage_size" {
  let chicle : @regression.ChicleTree[Unit] = ChicleTree()
  let node = chicle.new_leaf(
    @regression.Style::default().with_size(
      Size(width=@regression.percent(1.0), height=@regression.percent(1.0)),
    ),
  )
  chicle.compute_layout(
    node,
    Size(
      width=@regression.available_space_definite(100.0),
      height=@regression.available_space_definite(200.0),
    ),
  )
  let layout = chicle.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 200.0)
}

///|
test "root_with_no_size" {
  let chicle : @regression.ChicleTree[Unit] = ChicleTree()
  let node = chicle.new_leaf(@regression.Style::default())
  chicle.compute_layout(
    node,
    Size(
      width=@regression.available_space_definite(100.0),
      height=@regression.available_space_definite(100.0),
    ),
  )
  let layout = chicle.layout(node)
  assert_eq(layout.size.width, 0.0)
  assert_eq(layout.size.height, 0.0)
}

///|
test "root_with_larger_size" {
  let chicle : @regression.ChicleTree[Unit] = ChicleTree()
  let node = chicle.new_leaf(
    @regression.Style::default().with_size(
      Size(width=@regression.length(200.0), height=@regression.length(200.0)),
    ),
  )
  chicle.compute_layout(
    node,
    Size(
      width=@regression.available_space_definite(100.0),
      height=@regression.available_space_definite(100.0),
    ),
  )
  let layout = chicle.layout(node)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 200.0)
}

///|
test "root_padding_and_border_larger_than_definite_size" {
  let tree : @regression.ChicleTree[Unit] = @regression.ChicleTree::with_capacity(
    16,
  )
  let child = tree.new_leaf(@regression.Style::default())
  let root_style = @regression.Style::default()
    .with_size(
      Size(width=@regression.length(10.0), height=@regression.length(10.0)),
    )
    .with_padding(
      Rect(
        left=@regression.length(10.0),
        right=@regression.length(10.0),
        top=@regression.length(10.0),
        bottom=@regression.length(10.0),
      ),
    )
    .with_border(
      Rect(
        left=@regression.length(10.0),
        right=@regression.length(10.0),
        top=@regression.length(10.0),
        bottom=@regression.length(10.0),
      ),
    )
  let root = tree.new_with_children(root_style, [child])
  tree.compute_layout(root, @regression.Size::max_content())
  let layout = tree.layout(root)
  assert_eq(layout.size.width, 40.0)
  assert_eq(layout.size.height, 40.0)
}
