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
priv struct GridTrackSizingState {
  sizes : Array[Double]
  min_sizes : Array[Double]
  fr_weights : Array[Double]
  stretch_auto : Array[Bool]
  max_limits : Array[Double]
  inf : Double
}

///|
priv struct GridTrackSizingAlgorithmInput {
  tracks : Array[Dimension]
  available : Double
  gap : Double
  min_contribution : Array[Double]
  max_content_contribution : Array[Double]
  expand_to_fill : Bool
}

///|
priv struct GridTrackSizingAlgorithmOutput {
  sizes : Array[Double]
}

///|
fn GridTrackSizingAlgorithmInput::GridTrackSizingAlgorithmInput(
  tracks~ : Array[Dimension],
  available~ : Double,
  gap~ : Double,
  min_contribution~ : Array[Double],
  max_content_contribution~ : Array[Double],
  expand_to_fill~ : Bool,
) -> GridTrackSizingAlgorithmInput {
  {
    tracks,
    available,
    gap,
    min_contribution,
    max_content_contribution,
    expand_to_fill,
  }
}

///|
fn clamp_track_size(v : Double, lo : Double, hi : Double) -> Double {
  let clamped_lo = if v < lo { lo } else { v }
  if clamped_lo > hi {
    hi
  } else {
    clamped_lo
  }
}

///|
fn grid_track_min_function_value(
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

///|
fn grid_track_max_function_value_and_limit(
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

///|
fn initialize_track_sizes(
  input : GridTrackSizingAlgorithmInput,
) -> GridTrackSizingState {
  let tracks = input.tracks
  let available = input.available
  let min_contrib = input.min_contribution
  let max_contrib = input.max_content_contribution
  let count = tracks.length()
  let sizes : Array[Double] = Array::make(count, 0.0)
  let min_sizes : Array[Double] = Array::make(count, 0.0)
  let fr_weights : Array[Double] = Array::make(count, 0.0)
  let stretch_auto : Array[Bool] = Array::make(count, false)
  let max_limits : Array[Double] = Array::make(count, 0.0)
  let inf = 1.0e30
  for i in 0..<count {
    let min_c = if i < min_contrib.length() { min_contrib[i] } else { 0.0 }
    let max_c = if i < max_contrib.length() { max_contrib[i] } else { 0.0 }
    match tracks[i] {
      DimAuto => {
        min_sizes[i] = min_c
        sizes[i] = max_c
        max_limits[i] = inf
        stretch_auto[i] = true
      }
      DimMinContent => {
        min_sizes[i] = min_c
        sizes[i] = min_c
        max_limits[i] = inf
      }
      DimMaxContent => {
        min_sizes[i] = max_c
        sizes[i] = max_c
        max_limits[i] = inf
      }
      DimFitContent(limit) => {
        let lim = resolve_track_dimension(limit, available)
        let preferred = if max_c < lim { max_c } else { lim }
        let preferred = if preferred < min_c { min_c } else { preferred }
        min_sizes[i] = min_c
        sizes[i] = preferred
        max_limits[i] = preferred
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
        let min_v = grid_track_min_function_value(
          min_d, available, min_c, max_c,
        )
        let max_r = grid_track_max_function_value_and_limit(
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
          stretch_auto[i] = match max_d {
            DimAuto => true
            _ => false
          }
        }
      }
      DimRepeat(_, _) => {
        // Expanded earlier; treat as auto when encountered.
        min_sizes[i] = min_c
        sizes[i] = max_c
        max_limits[i] = inf
        stretch_auto[i] = true
      }
    }
  }
  { sizes, min_sizes, fr_weights, stretch_auto, max_limits, inf }
}

///|
fn resolve_intrinsic_track_sizes(
  state : GridTrackSizingState,
  input : GridTrackSizingAlgorithmInput,
) -> Unit {
  let min_contrib = input.min_contribution
  let max_contrib = input.max_content_contribution
  let sizes = state.sizes
  let min_sizes = state.min_sizes
  let fr_weights = state.fr_weights
  let max_limits = state.max_limits
  let inf = state.inf
  let count = sizes.length()
  let mut flex_fraction = 0.0
  for i in 0..<count {
    let weight = fr_weights[i]
    if weight > 0.0 {
      let max_c = if i < max_contrib.length() { max_contrib[i] } else { 0.0 }
      let ratio = max_c / weight
      if ratio > flex_fraction {
        flex_fraction = ratio
      }
    }
  }
  if flex_fraction > 0.0 {
    for i in 0..<count {
      let weight = fr_weights[i]
      if weight > 0.0 {
        let flex_size = flex_fraction * weight
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
      }
    }
  }
}

///|
fn grid_track_used_size(state : GridTrackSizingState, gap : Double) -> Double {
  let sizes = state.sizes
  let mut used = 0.0
  for size in sizes {
    used = used + size
  }
  let count = sizes.length()
  if count > 1 {
    used + gap * (count - 1).to_double()
  } else {
    used
  }
}

///|
fn shrink_tracks_to_minimum(
  state : GridTrackSizingState,
  available : Double,
  gap : Double,
) -> Unit {
  let sizes = state.sizes
  let min_sizes = state.min_sizes
  let used = grid_track_used_size(state, gap)
  if used <= available {
    return
  }
  let eps = 0.000001
  let mut over = used - available
  let mut shrinkable : Array[Int] = []
  for i in 0..<sizes.length() {
    if sizes[i] > min_sizes[i] + eps {
      shrinkable.push(i)
    }
  }
  while over > eps && shrinkable.length() > 0 {
    let per_track = over / shrinkable.length().to_double()
    let mut shrunk = 0.0
    let next : Array[Int] = []
    for idx in shrinkable {
      let can_shrink = sizes[idx] - min_sizes[idx]
      let shrink = if can_shrink < per_track { can_shrink } else { per_track }
      if shrink > 0.0 {
        sizes[idx] = sizes[idx] - shrink
        shrunk = shrunk + shrink
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

///|
fn expand_flexible_tracks(
  state : GridTrackSizingState,
  available : Double,
) -> Bool {
  let sizes = state.sizes
  let min_sizes = state.min_sizes
  let fr_weights = state.fr_weights
  let mut sum_fr = 0.0
  for weight in fr_weights {
    sum_fr = sum_fr + weight
  }
  if sum_fr <= 0.0 {
    return false
  }
  let mut fixed_used = 0.0
  for i in 0..<sizes.length() {
    if fr_weights[i] <= 0.0 {
      fixed_used = fixed_used + sizes[i]
    }
  }
  let mut remaining_for_fr = max_double(available - fixed_used, 0.0)
  let mut unresolved : Array[Int] = []
  for i in 0..<sizes.length() {
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
        remaining_for_fr = max_double(remaining_for_fr - min_sizes[idx], 0.0)
        froze_any = true
      } else {
        next_unresolved.push(idx)
      }
    }
    if !froze_any {
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
  true
}

///|
fn distribute_space_up_to_growth_limits(
  state : GridTrackSizingState,
  free : Double,
) -> Unit {
  let sizes = state.sizes
  let max_limits = state.max_limits
  let mut remaining = free
  let mut growable : Array[Int] = []
  for i in 0..<sizes.length() {
    if max_limits[i] < state.inf && sizes[i] + 0.000001 < max_limits[i] {
      growable.push(i)
    }
  }
  while remaining > 0.000001 && growable.length() > 0 {
    let extra = remaining / growable.length().to_double()
    let mut used_extra = 0.0
    let next : Array[Int] = []
    for idx in growable {
      let cap = max_limits[idx] - sizes[idx]
      let increase = if cap < extra { cap } else { extra }
      if increase > 0.0 {
        sizes[idx] = sizes[idx] + increase
        used_extra = used_extra + increase
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

///|
fn maximize_tracks(
  state : GridTrackSizingState,
  available : Double,
  gap : Double,
) -> Unit {
  let used = grid_track_used_size(state, gap)
  let free = available - used
  if free <= 0.0 {
    return
  }
  distribute_space_up_to_growth_limits(state, free)
}

///|
fn stretch_auto_tracks(
  state : GridTrackSizingState,
  available : Double,
  gap : Double,
) -> Unit {
  let used = grid_track_used_size(state, gap)
  let free = available - used
  if free <= 0.0 {
    return
  }
  let sizes = state.sizes
  let stretch_auto = state.stretch_auto
  let stretchable : Array[Int] = []
  for i in 0..<sizes.length() {
    if stretch_auto[i] {
      stretchable.push(i)
    }
  }
  if stretchable.length() == 0 {
    return
  }
  let extra = free / stretchable.length().to_double()
  for idx in stretchable {
    sizes[idx] = sizes[idx] + extra
  }
}

///|
fn clamp_grid_tracks_to_minimum(state : GridTrackSizingState) -> Unit {
  let sizes = state.sizes
  let min_sizes = state.min_sizes
  for i in 0..<sizes.length() {
    sizes[i] = clamp_track_size(sizes[i], min_sizes[i], state.inf)
  }
}

///|
fn track_sizing_algorithm(
  input : GridTrackSizingAlgorithmInput,
) -> GridTrackSizingAlgorithmOutput {
  let state = initialize_track_sizes(input)
  let sizes = state.sizes

  // Intrinsic sizing for flexible tracks: derive a flex fraction from content contributions.
  // This matches taffy 0.5 behavior for `fr` tracks under indefinite available space.
  if !input.expand_to_fill {
    resolve_intrinsic_track_sizes(state, input)
  }

  // Shrink tracks down to their min-content contributions if the sum of preferred sizes overflows.
  shrink_tracks_to_minimum(state, input.available, input.gap)

  // Distribute any remaining free space (only when the grid container has a definite size).
  if input.expand_to_fill {
    maximize_tracks(state, input.available, input.gap)
    if expand_flexible_tracks(state, input.available) {
      ()
    } else {
      ()
    }
    stretch_auto_tracks(state, input.available, input.gap)
  }

  // Ensure no track is below its min size.
  clamp_grid_tracks_to_minimum(state)
  { sizes, }
}
