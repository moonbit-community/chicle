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
test "block_absolute_layout_within_border" {
  let chicle : @regression.ChicleTree[Unit] = ChicleTree()
  let node0 = chicle.new_leaf(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_position(@regression.position_absolute())
    .with_size(
      Size(width=@regression.length(50.0), height=@regression.length(50.0)),
    )
    .with_inset(
      Rect(
        left=@regression.length(0.0),
        right=@regression.auto(),
        top=@regression.length(0.0),
        bottom=@regression.auto(),
      ),
    ),
  )
  let node1 = chicle.new_leaf(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_position(@regression.position_absolute())
    .with_size(
      Size(width=@regression.length(50.0), height=@regression.length(50.0)),
    )
    .with_inset(
      Rect(
        left=@regression.auto(),
        right=@regression.length(0.0),
        top=@regression.auto(),
        bottom=@regression.length(0.0),
      ),
    ),
  )
  let node2 = chicle.new_leaf(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_position(@regression.position_absolute())
    .with_size(
      Size(width=@regression.length(50.0), height=@regression.length(50.0)),
    )
    .with_margin(
      Rect(
        left=@regression.length(10.0),
        right=@regression.length(10.0),
        top=@regression.length(10.0),
        bottom=@regression.length(10.0),
      ),
    )
    .with_inset(
      Rect(
        left=@regression.length(0.0),
        right=@regression.auto(),
        top=@regression.length(0.0),
        bottom=@regression.auto(),
      ),
    ),
  )
  let node3 = chicle.new_leaf(
    @regression.Style::default()
    .with_display(@regression.display_block())
    .with_position(@regression.position_absolute())
    .with_size(
      Size(width=@regression.length(50.0), height=@regression.length(50.0)),
    )
    .with_margin(
      Rect(
        left=@regression.length(10.0),
        right=@regression.length(10.0),
        top=@regression.length(10.0),
        bottom=@regression.length(10.0),
      ),
    )
    .with_inset(
      Rect(
        left=@regression.auto(),
        right=@regression.length(0.0),
        top=@regression.auto(),
        bottom=@regression.length(0.0),
      ),
    ),
  )
  let root_style = @regression.Style::default()
    .with_display(@regression.display_block())
    .with_size(
      Size(width=@regression.length(100.0), height=@regression.length(100.0)),
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
  let root = chicle.new_with_children(root_style, [node0, node1, node2, node3])
  chicle.compute_layout(root, @regression.Size::max_content())
  let l0 = chicle.layout(node0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
  let l1 = chicle.layout(node1)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 40.0)
  let l2 = chicle.layout(node2)
  assert_eq(l2.location.x, 20.0)
  assert_eq(l2.location.y, 20.0)
  let l3 = chicle.layout(node3)
  assert_eq(l3.location.x, 30.0)
  assert_eq(l3.location.y, 30.0)
}
