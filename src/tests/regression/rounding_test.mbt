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
test "rounding_doesnt_leave_gaps" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let w_square : Size[Dimension] = Size(
    width=length(100.3),
    height=length(100.3),
  )
  let child_a = chicle.new_leaf(Style::default().with_size(w_square))
  let child_b = chicle.new_leaf(Style::default().with_size(w_square))
  let root_style = Style::default()
    .with_size(Size(width=length(963.3333), height=length(1000.0)))
    .with_justify_content(justify_content_center())
  let root = chicle.new_with_children(root_style, [child_a, child_b])
  chicle.compute_layout(root, Size::max_content())
  let layout_a = chicle.layout(child_a)
  let layout_b = chicle.layout(child_b)
  assert_eq(layout_a.location.x + layout_a.size.width, layout_b.location.x)
}
