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
