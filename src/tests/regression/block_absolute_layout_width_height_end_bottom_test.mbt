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
test "block_absolute_layout_width_height_end_bottom" {
  let chicle : @regression.ChicleTree[Unit] = ChicleTree()
  let child_style = @regression.Style::default()
    .with_display(@regression.display_block())
    .with_position(@regression.position_absolute())
    .with_size(
      Size(width=@regression.length(10.0), height=@regression.length(10.0)),
    )
    .with_inset(
      Rect(
        left=@regression.auto(),
        right=@regression.length(10.0),
        top=@regression.auto(),
        bottom=@regression.length(10.0),
      ),
    )
  let child = chicle.new_leaf(child_style)
  let root_style = @regression.Style::default()
    .with_display(@regression.display_block())
    .with_size(
      Size(width=@regression.length(100.0), height=@regression.length(100.0)),
    )
  let root = chicle.new_with_children(root_style, [child])
  chicle.compute_layout(root, @regression.Size::max_content())
  let layout = chicle.layout(child)
  assert_eq(layout.size.width, 10.0)
  assert_eq(layout.size.height, 10.0)
  assert_eq(layout.location.x, 80.0)
  assert_eq(layout.location.y, 80.0)
}
