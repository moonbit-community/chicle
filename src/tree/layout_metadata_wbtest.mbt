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
test "offset_subtree only changes location" {
  let tree : ChicleTree[Unit] = ChicleTree()
  let node = tree.new_leaf(Style::default())
  tree.set_unrounded_layout(node, {
    order: 7,
    location: Point(x=10.0, y=20.0),
    size: Size(width=30.0, height=40.0),
    content_size: Size(width=50.0, height=60.0),
    scrollbar_size: Size(width=3.0, height=4.0),
    border: Rect(left=1.0, right=2.0, top=3.0, bottom=4.0),
    padding: Rect(left=5.0, right=6.0, top=7.0, bottom=8.0),
  })
  offset_subtree(tree, node, 11.0, -9.0)
  let layout = tree.nodes[node].unrounded_layout
  debug_inspect(layout.order, content="7")
  debug_inspect(
    [
      layout.location.x,
      layout.location.y,
      layout.size.width,
      layout.size.height,
      layout.content_size.width,
      layout.content_size.height,
      layout.scrollbar_size.width,
      layout.scrollbar_size.height,
      layout.border.left,
      layout.border.right,
      layout.border.top,
      layout.border.bottom,
      layout.padding.left,
      layout.padding.right,
      layout.padding.top,
      layout.padding.bottom,
    ],
    content="[21, 11, 30, 40, 50, 60, 3, 4, 1, 2, 3, 4, 5, 6, 7, 8]",
  )
}
