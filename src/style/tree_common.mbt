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

///|
fn resolve_track_dimension(d : Dimension, available : Double) -> Double {
  match d {
    DimAuto => 0.0
    DimLength(v) => v
    DimPercent(p) => available * p
    DimFr(_) => 0.0
    DimMinMax(_, max) => resolve_track_dimension(max, available)
    DimMinContent => 0.0
    DimMaxContent => 0.0
    DimFitContent(limit) => resolve_track_dimension(limit, available)
    DimRepeat(_, _) => 0.0
  }
}

///|
fn is_near_int(v : Double) -> Bool {
  abs_double(v - v.floor()) < 0.000001
}

///|

///|
fn compute_grid_track_sizes_with_contributions(
  tracks : Array[Dimension],
  available : Double,
  gap : Double,
  min_contrib : Array[Double],
  max_contrib : Array[Double],
  expand_to_fill : Bool,
) -> Array[Double] {
  let count = tracks.length()
  let sizes : Array[Double] = Array::make(count, 0.0)
  let min_sizes : Array[Double] = Array::make(count, 0.0)
  let fr_weights : Array[Double] = Array::make(count, 0.0)
  let is_auto : Array[Bool] = Array::make(count, false)
  let max_limits : Array[Double] = Array::make(count, 0.0)
  let inf = 1.0e30
  fn clamp_minmax(v : Double, lo : Double, hi : Double) -> Double {
    let v = if v < lo { lo } else { v }
    if v > hi {
      hi
    } else {
      v
    }
  }

  fn min_function_value(
    d : Dimension,
    available : Double,
    min_c : Double,
    max_c : Double,
  ) -> Double {
    match d {
      DimAuto => 0.0
      DimMinContent => min_c
      DimMaxContent => max_c
      DimFitContent(limit) => {
        let lim = resolve_track_dimension(limit, available)
        let max_limited = if max_c < lim { max_c } else { lim }
        if max_limited < min_c {
          min_c
        } else {
          max_limited
        }
      }
      DimFr(_) => 0.0
      DimRepeat(_, _) => 0.0
      _ => {
        let v = resolve_track_dimension(d, available)
        if v > 0.0 {
          v
        } else {
          0.0
        }
      }
    }
  }

  fn max_function_value_and_limit(
    d : Dimension,
    available : Double,
    min_c : Double,
    max_c : Double,
    inf : Double,
  ) -> (Double, Double, Double) {
    match d {
      DimAuto => (max_c, inf, 0.0)
      DimMinContent => (min_c, inf, 0.0)
      DimMaxContent => (max_c, inf, 0.0)
      DimFitContent(limit) => {
        let lim = resolve_track_dimension(limit, available)
        let preferred = if max_c < lim { max_c } else { lim }
        let preferred = if preferred < min_c { min_c } else { preferred }
        (preferred, preferred, 0.0)
      }
      DimFr(w) => (0.0, inf, if w > 0.0 { w } else { 0.0 })
      DimRepeat(_, _) => (0.0, inf, 0.0)
      _ => {
        let v = resolve_track_dimension(d, available)
        let v = if v > 0.0 { v } else { 0.0 }
        (v, v, 0.0)
      }
    }
  }

  for i in 0..<count {
    let min_c = if i < min_contrib.length() { min_contrib[i] } else { 0.0 }
    let max_c = if i < max_contrib.length() { max_contrib[i] } else { 0.0 }
    match tracks[i] {
      DimAuto => {
        min_sizes[i] = min_c
        sizes[i] = max_c
        max_limits[i] = inf
        is_auto[i] = true
      }
      DimMinContent => {
        min_sizes[i] = min_c
        sizes[i] = min_c
        max_limits[i] = inf
        is_auto[i] = true
      }
      DimMaxContent => {
        min_sizes[i] = max_c
        sizes[i] = max_c
        max_limits[i] = inf
        is_auto[i] = true
      }
      DimFitContent(limit) => {
        let lim = resolve_track_dimension(limit, available)
        let preferred = if max_c < lim { max_c } else { lim }
        let preferred = if preferred < min_c { min_c } else { preferred }
        min_sizes[i] = min_c
        sizes[i] = preferred
        max_limits[i] = preferred
        is_auto[i] = true
      }
      DimLength(v) => {
        sizes[i] = v
        min_sizes[i] = v
        max_limits[i] = v
      }
      DimPercent(p) => {
        let v = available * p
        sizes[i] = v
        min_sizes[i] = v
        max_limits[i] = v
      }
      DimFr(w) => {
        fr_weights[i] = if w > 0.0 { w } else { 0.0 }
        let base = if w > 0.0 { min_c } else { max_c }
        sizes[i] = base
        min_sizes[i] = base
        max_limits[i] = inf
      }
      DimMinMax(min_d, max_d) => {
        let min_v = min_function_value(min_d, available, min_c, max_c)
        let max_r = max_function_value_and_limit(
          max_d, available, min_c, max_c, inf,
        )
        let max_v = max_r.0
        let max_lim = max_r.1
        let fr_w = max_r.2
        min_sizes[i] = min_v
        if fr_w > 0.0 {
          fr_weights[i] = fr_w
          sizes[i] = min_v
          max_limits[i] = inf
        } else {
          let preferred = if max_v < min_v { min_v } else { max_v }
          sizes[i] = preferred
          max_limits[i] = if max_lim < min_v { min_v } else { max_lim }
          is_auto[i] = match max_d {
            DimAuto | DimMinContent | DimMaxContent | DimFitContent(_) => true
            _ => false
          }
        }
      }
      DimRepeat(_, _) => {
        // Expanded earlier; treat as auto when encountered.
        min_sizes[i] = min_c
        sizes[i] = max_c
        max_limits[i] = inf
        is_auto[i] = true
      }
    }
  }

  // Intrinsic sizing for flexible tracks: derive a flex fraction from content contributions.
  // This matches taffy 0.5 behavior for `fr` tracks under indefinite available space.
  if not(expand_to_fill) {
    let mut flex_fraction = 0.0
    for i in 0..<count {
      let w = fr_weights[i]
      if w > 0.0 {
        let max_c = if i < max_contrib.length() { max_contrib[i] } else { 0.0 }
        let ratio = max_c / w
        if ratio > flex_fraction {
          flex_fraction = ratio
        }
      }
    }
    if flex_fraction > 0.0 {
      for i in 0..<count {
        let w = fr_weights[i]
        if w > 0.0 {
          let flex_size = flex_fraction * w
          sizes[i] = if flex_size < min_sizes[i] {
            min_sizes[i]
          } else {
            flex_size
          }
          min_sizes[i] = if i < min_contrib.length() {
            min_contrib[i]
          } else {
            0.0
          }
          max_limits[i] = inf
          is_auto[i] = true
        }
      }
    }
  }

  // Shrink tracks down to their min-content contributions if the sum of preferred sizes overflows.
  let mut used = 0.0
  for s in sizes {
    used = used + s
  }
  if count > 1 {
    used = used + gap * (count - 1).to_double()
  }
  if used > available {
    let eps = 0.000001
    let mut over = used - available
    let mut shrinkable : Array[Int] = []
    for i in 0..<count {
      if sizes[i] > min_sizes[i] + eps {
        shrinkable.push(i)
      }
    }
    while over > eps && shrinkable.length() > 0 {
      let per = over / shrinkable.length().to_double()
      let mut shrunk = 0.0
      let next : Array[Int] = []
      for idx in shrinkable {
        let can = sizes[idx] - min_sizes[idx]
        let s = if can < per { can } else { per }
        if s > 0.0 {
          sizes[idx] = sizes[idx] - s
          shrunk = shrunk + s
        }
        if sizes[idx] > min_sizes[idx] + eps {
          next.push(idx)
        }
      }
      if shrunk <= 0.0 {
        break
      }
      over = over - shrunk
      shrinkable = next
    }
  }

  // Distribute any remaining free space (only when the grid container has a definite size).
  used = 0.0
  for s in sizes {
    used = used + s
  }
  if count > 1 {
    used = used + gap * (count - 1).to_double()
  }
  let free = available - used
  if expand_to_fill && free > 0.0 {
    let mut sum_fr = 0.0
    for w in fr_weights {
      sum_fr = sum_fr + w
    }
    if sum_fr > 0.0 {
      let mut fixed_used = 0.0
      for i in 0..<count {
        if fr_weights[i] <= 0.0 {
          fixed_used = fixed_used + sizes[i]
        }
      }
      let mut remaining_for_fr = max_double(available - fixed_used, 0.0)
      let mut unresolved : Array[Int] = []
      for i in 0..<count {
        if fr_weights[i] > 0.0 {
          unresolved.push(i)
          sizes[i] = min_sizes[i]
        }
      }
      while unresolved.length() > 0 {
        let mut unresolved_sum = 0.0
        for idx in unresolved {
          unresolved_sum = unresolved_sum + fr_weights[idx]
        }
        let denom = if unresolved_sum < 1.0 { 1.0 } else { unresolved_sum }
        let flex_fraction = remaining_for_fr / denom
        let mut froze_any = false
        let next_unresolved : Array[Int] = []
        for idx in unresolved {
          let proposed = flex_fraction * fr_weights[idx]
          if proposed + 0.000001 < min_sizes[idx] {
            sizes[idx] = min_sizes[idx]
            remaining_for_fr = max_double(
              remaining_for_fr - min_sizes[idx],
              0.0,
            )
            froze_any = true
          } else {
            next_unresolved.push(idx)
          }
        }
        if not(froze_any) {
          let total_fr_space = if unresolved_sum < 1.0 {
            remaining_for_fr * unresolved_sum
          } else {
            remaining_for_fr
          }
          if is_near_int(total_fr_space) {
            let total_int = total_fr_space.floor().to_int()
            let raw_bases : Array[Int] = []
            let raw_fracs : Array[Double] = []
            let mut sum_bases = 0
            for idx in unresolved {
              let raw = flex_fraction * fr_weights[idx]
              let base = raw.floor().to_int()
              raw_bases.push(base)
              raw_fracs.push(raw - base.to_double())
              sum_bases = sum_bases + base
            }
            let mut remainder = total_int - sum_bases
            while remainder > 0 {
              let mut best_j = 0
              let mut best_frac = -1.0
              for j in 0..<raw_fracs.length() {
                if raw_fracs[j] > best_frac {
                  best_frac = raw_fracs[j]
                  best_j = j
                }
              }
              raw_bases[best_j] = raw_bases[best_j] + 1
              raw_fracs[best_j] = -1.0
              remainder = remainder - 1
            }
            for j in 0..<unresolved.length() {
              sizes[unresolved[j]] = raw_bases[j].to_double()
            }
          } else {
            for idx in unresolved {
              sizes[idx] = flex_fraction * fr_weights[idx]
            }
          }
          break
        }
        unresolved = next_unresolved
      }
    } else {
      // Distribute remaining free space evenly to auto-like tracks, respecting fit-content/minmax caps.
      let mut remaining = free
      let mut growable : Array[Int] = []
      for i in 0..<count {
        if is_auto[i] && sizes[i] + 0.000001 < max_limits[i] {
          growable.push(i)
        }
      }
      while remaining > 0.000001 && growable.length() > 0 {
        let extra = remaining / growable.length().to_double()
        let mut used_extra = 0.0
        let next : Array[Int] = []
        for idx in growable {
          let cap = max_limits[idx] - sizes[idx]
          let inc = if cap < extra { cap } else { extra }
          if inc > 0.0 {
            sizes[idx] = sizes[idx] + inc
            used_extra = used_extra + inc
          }
          if sizes[idx] + 0.000001 < max_limits[idx] {
            next.push(idx)
          }
        }
        if used_extra <= 0.0 {
          break
        }
        remaining = remaining - used_extra
        growable = next
      }
    }
  }

  // Ensure no track is below its min size.
  for i in 0..<count {
    sizes[i] = clamp_minmax(sizes[i], min_sizes[i], inf)
  }
  sizes
}

///|
