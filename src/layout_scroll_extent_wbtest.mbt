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
test "layout_scroll_extent_accessors_match_taffy" {
  let layout = {
    ..Layout::zero(),
    size: Size(width=100.0, height=80.0),
    content_size: Size(width=140.0, height=120.0),
    scrollbar_size: Size(width=7.0, height=9.0),
    border: Rect(left=1.0, right=2.0, top=3.0, bottom=4.0),
  }
  assert_eq(layout.scroll_width(), 49.0)
  assert_eq(layout.scroll_height(), 53.0)
}
