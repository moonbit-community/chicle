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
fn border_padding_single_axis_rect(
  axis : Int,
  value : Dimension,
) -> Rect[Dimension] {
  match axis {
    0 =>
      Rect(left=value, right=length(0.0), top=length(0.0), bottom=length(0.0))
    1 =>
      Rect(left=length(0.0), right=value, top=length(0.0), bottom=length(0.0))
    2 =>
      Rect(left=length(0.0), right=length(0.0), top=value, bottom=length(0.0))
    3 =>
      Rect(left=length(0.0), right=length(0.0), top=length(0.0), bottom=value)
    _ =>
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      )
  }
}

///|
test "border_on_a_single_axis_doesnt_increase_size" {
  for axis in 0..<4 {
    let chicle : ChicleTree[Unit] = ChicleTree()
    let node = chicle.new_leaf(
      Style::default().with_border(
        border_padding_single_axis_rect(axis, length(10.0)),
      ),
    )
    chicle.compute_layout(
      node,
      Size(
        width=available_space_definite(100.0),
        height=available_space_definite(100.0),
      ),
    )
    let layout = chicle.layout(node)
    assert_eq(layout.size.width * layout.size.height, 0.0)
  }
}

///|
test "padding_on_a_single_axis_doesnt_increase_size" {
  for axis in 0..<4 {
    let chicle : ChicleTree[Unit] = ChicleTree()
    let node = chicle.new_leaf(
      Style::default().with_padding(
        border_padding_single_axis_rect(axis, length(10.0)),
      ),
    )
    chicle.compute_layout(
      node,
      Size(
        width=available_space_definite(100.0),
        height=available_space_definite(100.0),
      ),
    )
    let layout = chicle.layout(node)
    assert_eq(layout.size.width * layout.size.height, 0.0)
  }
}

///|
test "border_and_padding_on_a_single_axis_doesnt_increase_size" {
  for axis in 0..<4 {
    let chicle : ChicleTree[Unit] = ChicleTree()
    let rect = border_padding_single_axis_rect(axis, length(10.0))
    let node = chicle.new_leaf(
      Style::default().with_border(rect).with_padding(rect),
    )
    chicle.compute_layout(
      node,
      Size(
        width=available_space_definite(100.0),
        height=available_space_definite(100.0),
      ),
    )
    let layout = chicle.layout(node)
    assert_eq(layout.size.width * layout.size.height, 0.0)
  }
}

///|
test "vertical_padding_percentage_uses_width_as_basis" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node = chicle.new_leaf(
    Style::default().with_padding(
      Rect(
        left=percent(1.0),
        right=length(0.0),
        top=percent(1.0),
        bottom=length(0.0),
      ),
    ),
  )
  chicle.compute_layout(
    node,
    Size(
      width=available_space_definite(200.0),
      height=available_space_definite(100.0),
    ),
  )
  let layout = chicle.layout(node)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 200.0)
}

///|
test "vertical_border_and_padding_percentage_values_use_available_space_correctly" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let node = chicle.new_leaf(
    Style::default().with_padding(
      Rect(
        left=percent(1.0),
        right=length(0.0),
        top=percent(1.0),
        bottom=length(0.0),
      ),
    ),
  )
  chicle.compute_layout(
    node,
    Size(
      width=available_space_definite(200.0),
      height=available_space_definite(100.0),
    ),
  )
  let layout = chicle.layout(node)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 200.0)
}
