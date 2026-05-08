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
fn resolve_dimension(d : Dimension, available : AvailableSpace) -> Double {
  match d {
    DimAuto => 0.0
    DimLength(v) => v
    DimPercent(p) =>
      match available {
        AvailDefinite(v) => v * p
        AvailMinContent => 0.0
        AvailMaxContent => 0.0
      }
    DimFr(_) => 0.0
    DimMinMax(_, max) => resolve_dimension(max, available)
    DimMinContent => 0.0
    DimMaxContent => 0.0
    DimFitContent(_) => 0.0
    DimRepeat(_, _) => 0.0
  }
}

///|
fn resolve_optional_dimension(
  d : Dimension,
  available : AvailableSpace,
) -> Double? {
  match d {
    DimAuto => None
    DimLength(v) => Some(v)
    DimPercent(p) =>
      match available {
        AvailDefinite(v) => Some(v * p)
        _ => None
      }
    DimFr(_) => None
    DimMinMax(_, max) => resolve_optional_dimension(max, available)
    DimMinContent => None
    DimMaxContent => None
    DimFitContent(_) => None
    DimRepeat(_, _) => None
  }
}

///|
fn clamp_dimension(
  value : Double,
  min_size : Dimension,
  max_size : Dimension,
  available : AvailableSpace,
) -> Double {
  let min_v = resolve_optional_dimension(min_size, available)
  let max_v0 = resolve_optional_dimension(max_size, available)
  let max_v = match (min_v, max_v0) {
    (Some(min_v), Some(max_v)) =>
      if max_v < min_v {
        Some(min_v)
      } else {
        Some(max_v)
      }
    _ => max_v0
  }
  let v0 = match min_v {
    Some(min_v) => max_double(value, min_v)
    None => value
  }
  match max_v {
    Some(max_v) => if v0 > max_v { max_v } else { v0 }
    None => v0
  }
}

///|
fn resolve_dimension_width_basis(d : Dimension, basis_width : Double) -> Double {
  match d {
    DimAuto => 0.0
    DimLength(v) => v
    DimPercent(p) => basis_width * p
    DimFr(_) => 0.0
    DimMinMax(_, max) => resolve_dimension_width_basis(max, basis_width)
    DimMinContent => 0.0
    DimMaxContent => 0.0
    DimFitContent(_) => 0.0
    DimRepeat(_, _) => 0.0
  }
}

///|
fn resolve_rect_width_basis(
  rect : Rect[Dimension],
  available : Size[AvailableSpace],
) -> Rect[Double] {
  let basis_width = match available.width {
    AvailDefinite(v) => v
    _ => 0.0
  }
  Rect(
    left=resolve_dimension_width_basis(rect.left, basis_width),
    right=resolve_dimension_width_basis(rect.right, basis_width),
    top=resolve_dimension_width_basis(rect.top, basis_width),
    bottom=resolve_dimension_width_basis(rect.bottom, basis_width),
  )
}
