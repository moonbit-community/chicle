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
fn measured_scroll_extent_leaf(
  _known_dimensions : @regression.Size[Double?],
  _available_space : @regression.Size[@regression.AvailableSpace],
  _node_id : @regression.NodeId,
  _node_context : Unit?,
  _style : @regression.Style,
) -> @regression.Size[Double] {
  Size(width=140.0, height=120.0)
}

///|
test "layout_scroll_extent_accessors_match_chicle" {
  let chicle : @regression.ChicleTree[Unit] = ChicleTree()
  let node = chicle.new_leaf(
    @regression.Style::default()
    .with_size(
      Size(width=@regression.length(100.0), height=@regression.length(80.0)),
    )
    .with_overflow(
      Point(x=@regression.overflow_scroll(), y=@regression.overflow_scroll()),
    )
    .with_scrollbar_width(7.0)
    .with_border(
      Rect(
        left=@regression.zero(),
        right=@regression.length(2.0),
        top=@regression.zero(),
        bottom=@regression.length(6.0),
      ),
    ),
  )
  chicle.compute_layout_with_measure(
    node,
    @regression.Size::max_content(),
    measured_scroll_extent_leaf,
  )
  let layout = chicle.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 80.0)
  assert_eq(layout.scroll_width(), 49.0)
  assert_eq(layout.scroll_height(), 53.0)
}
