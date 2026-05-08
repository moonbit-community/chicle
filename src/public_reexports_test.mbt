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
test "root type reexports include constructors" {
  let point = @moon_taffy.Point(x=0, y=0)
  let size = @moon_taffy.Size(width=1, height=2)
  let rect = @moon_taffy.Rect(left=0, right=0, top=0, bottom=0)
  let line = @moon_taffy.Line(start=0, end=1)
  let _ : @moon_taffy.Point[Int] = point
  let _ : @moon_taffy.Size[Int] = size
  let _ : @moon_taffy.Rect[Int] = rect
  let _ : @moon_taffy.Line[Int] = line
  let _ : JustifyContent = justify_content_stretch()
}
