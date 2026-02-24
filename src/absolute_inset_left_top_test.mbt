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
test "absolute_inset_left_top (github:issue#1 repro)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let root_style = Style::default()
    .with_display(display_flex())
    .with_position(position_relative())
    .with_size(Size::new(width=length(800.0), height=length(600.0)))
  let child_style = Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect::new(
        left=length(40.0),
        right=auto(),
        top=length(50.0),
        bottom=auto(),
      ),
    )
    .with_size(Size::new(width=length(200.0), height=length(60.0)))
  let child = taffy.new_leaf(child_style)
  let root = taffy.new_with_children(root_style, [child])
  taffy.compute_layout(
    root,
    Size::new(
      width=available_space_definite(800.0),
      height=available_space_definite(600.0),
    ),
  )
  let layout = taffy.layout(child)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 60.0)
  assert_eq(layout.location.x, 40.0)
  assert_eq(layout.location.y, 50.0)
}
