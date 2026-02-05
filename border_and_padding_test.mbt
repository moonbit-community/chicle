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
test "vertical_padding_percentage_uses_width_as_basis" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node = taffy.new_leaf(
    Style::default().with_padding(
      Rect::new(
        left=percent(1.0),
        right=length(0.0),
        top=percent(1.0),
        bottom=length(0.0),
      ),
    ),
  )
  taffy.compute_layout(
    node,
    Size::new(
      width=available_space_definite(200.0),
      height=available_space_definite(100.0),
    ),
  )
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 200.0)
}
