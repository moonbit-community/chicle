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
fn max_double(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

///|
fn min_double(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
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
  Rect::new(
    left=resolve_dimension_width_basis(rect.left, basis_width),
    right=resolve_dimension_width_basis(rect.right, basis_width),
    top=resolve_dimension_width_basis(rect.top, basis_width),
    bottom=resolve_dimension_width_basis(rect.bottom, basis_width),
  )
}

///|
fn abs_double(v : Double) -> Double {
  if v < 0.0 {
    -v
  } else {
    v
  }
}

///|
fn margin_collapse_state_add_margin(
  state : (Double, Double),
  margin : Double,
) -> (Double, Double) {
  let mut max_pos = state.0
  let mut min_neg = state.1
  if margin > 0.0 {
    if margin > max_pos {
      max_pos = margin
    } else {
      ()
    }
  } else if margin < 0.0 {
    if margin < min_neg {
      min_neg = margin
    } else {
      ()
    }
  } else {
    ()
  }
  (max_pos, min_neg)
}

///|
fn margin_collapse_state_from(margin : Double) -> (Double, Double) {
  margin_collapse_state_add_margin((0.0, 0.0), margin)
}

///|
fn margin_collapse_state_value(state : (Double, Double)) -> Double {
  state.0 + state.1
}

///|
fn[C] set_effective_margin_states(
  tree : TaffyTree[C],
  node_id : NodeId,
  top_state : (Double, Double),
  bottom_state : (Double, Double),
) -> Unit {
  tree.nodes[node_id].effective_margin_top_max_pos = top_state.0
  tree.nodes[node_id].effective_margin_top_min_neg = top_state.1
  tree.nodes[node_id].effective_margin_bottom_max_pos = bottom_state.0
  tree.nodes[node_id].effective_margin_bottom_min_neg = bottom_state.1
  tree.nodes[node_id].effective_margin_top = margin_collapse_state_value(
    top_state,
  )
  tree.nodes[node_id].effective_margin_bottom = margin_collapse_state_value(
    bottom_state,
  )
}

///|
fn double_approx_equal(a : Double, b : Double) -> Bool {
  abs_double(a - b) <= 0.000001
}

///|
fn optional_double_equal(a : Double?, b : Double?) -> Bool {
  match (a, b) {
    (None, None) => true
    (Some(x), Some(y)) => double_approx_equal(x, y)
    _ => false
  }
}

///|
fn available_space_equal(a : AvailableSpace, b : AvailableSpace) -> Bool {
  match (a, b) {
    (AvailDefinite(x), AvailDefinite(y)) => double_approx_equal(x, y)
    (AvailMinContent, AvailMinContent) => true
    (AvailMaxContent, AvailMaxContent) => true
    _ => false
  }
}

///|
fn known_dimensions_equal(a : Size[Double?], b : Size[Double?]) -> Bool {
  optional_double_equal(a.width, b.width) &&
  optional_double_equal(a.height, b.height)
}

///|
fn available_size_equal(
  a : Size[AvailableSpace],
  b : Size[AvailableSpace],
) -> Bool {
  available_space_equal(a.width, b.width) &&
  available_space_equal(a.height, b.height)
}

///|
fn point_equal(a : Point[Double], b : Point[Double]) -> Bool {
  double_approx_equal(a.x, b.x) && double_approx_equal(a.y, b.y)
}

///|
fn find_leaf_measure_cache(
  cache : Array[LeafMeasureCacheEntry],
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
) -> Size[Double]? {
  for entry in cache {
    if known_dimensions_equal(entry.known_dimensions, known_dimensions) &&
      available_size_equal(entry.available_space, available_space) {
      return Some(entry.measured)
    }
  }
  None
}

///|
fn find_node_layout_cache(
  cache : Array[NodeLayoutCacheEntry],
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  is_layout_root : Bool,
) -> NodeLayoutCacheEntry? {
  for entry in cache {
    if known_dimensions_equal(entry.known_dimensions, known_dimensions) &&
      available_size_equal(entry.available_space, available_space) &&
      point_equal(entry.absolute_origin, absolute_origin) &&
      entry.is_layout_root == is_layout_root {
      return Some(entry)
    }
  }
  None
}
