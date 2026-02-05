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
pub struct Point[T] {
  x : T
  y : T
}

///|
pub fn[T] Point::new(x~ : T, y~ : T) -> Point[T] {
  Point::{ x, y }
}

///|
pub fn Point::zero() -> Point[Double] {
  Point::{ x: 0.0, y: 0.0 }
}

///|
pub struct Size[T] {
  width : T
  height : T
}

///|
pub fn[T] Size::new(width~ : T, height~ : T) -> Size[T] {
  Size::{ width, height }
}

///|
pub fn Size::zero() -> Size[Double] {
  Size::{ width: 0.0, height: 0.0 }
}

///|
pub struct Rect[T] {
  left : T
  right : T
  top : T
  bottom : T
}

///|
pub fn[T] Rect::new(left~ : T, right~ : T, top~ : T, bottom~ : T) -> Rect[T] {
  Rect::{ left, right, top, bottom }
}

///|
pub struct Line[T] {
  start : T
  end : T
}

///|
pub fn[T] Line::new(start~ : T, end~ : T) -> Line[T] {
  Line::{ start, end }
}
