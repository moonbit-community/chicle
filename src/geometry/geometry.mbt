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
pub(all) enum AbsoluteAxis {
  Horizontal
  Vertical
}

///|
pub(all) enum AbstractAxis {
  Inline
  Block
}

///|
pub(all) enum AvailableSpace {
  AvailDefinite(Double)
  AvailMinContent
  AvailMaxContent
}

///|
pub fn AvailableSpace::is_definite(self : AvailableSpace) -> Bool {
  self is AvailDefinite(_)
}

///|
pub fn AvailableSpace::into_option(self : AvailableSpace) -> Double? {
  match self {
    AvailDefinite(value) => Some(value)
    _ => None
  }
}

///|
pub fn AvailableSpace::unwrap_or(
  self : AvailableSpace,
  default : Double,
) -> Double {
  match self {
    AvailDefinite(value) => value
    _ => default
  }
}

///|
pub fn AvailableSpace::or(
  self : AvailableSpace,
  default : AvailableSpace,
) -> AvailableSpace {
  match self {
    AvailDefinite(_) => self
    _ => default
  }
}

///|
pub fn AvailableSpace::maybe_set(
  self : AvailableSpace,
  value : Double?,
) -> AvailableSpace {
  match value {
    Some(value) => AvailDefinite(value)
    None => self
  }
}

///|
pub fn abstract_axis_inline() -> AbstractAxis {
  Inline
}

///|
pub fn abstract_axis_block() -> AbstractAxis {
  Block
}

///|
pub(all) struct Point[T] {
  x : T
  y : T
}

///|
pub fn[T] Point::Point(x~ : T, y~ : T) -> Point[T] {
  { x, y }
}

///|
pub fn Point::zero() -> Point[Double] {
  Point(x=0.0, y=0.0)
}

///|
pub(all) struct Size[T] {
  width : T
  height : T
}

///|
pub fn[T] Size::Size(width~ : T, height~ : T) -> Size[T] {
  { width, height }
}

///|
pub fn Size::zero() -> Size[Double] {
  Size(width=0.0, height=0.0)
}

///|
pub fn Size::max_content() -> Size[AvailableSpace] {
  Size(width=AvailMaxContent, height=AvailMaxContent)
}

///|
pub(all) struct Rect[T] {
  left : T
  right : T
  top : T
  bottom : T
}

///|
pub fn[T] Rect::Rect(left~ : T, right~ : T, top~ : T, bottom~ : T) -> Rect[T] {
  { left, right, top, bottom }
}

///|
pub(all) struct Line[T] {
  start : T
  end : T
}

///|
pub fn[T] Line::Line(start~ : T, end~ : T) -> Line[T] {
  { start, end }
}
