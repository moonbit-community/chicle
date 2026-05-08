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
fn compute_spanned_max_track_size(
  tracks : Array[Dimension],
  snapshot : GridTrackSizingItemSnapshot,
) -> Double {
  let mut space = 0.0
  for i in 0..<snapshot.placed.length() {
    if snapshot.placed[i] && snapshot.span[i] > 1 {
      let start = snapshot.start[i]
      let end = start + snapshot.span[i]
      let mut crosses_flex = false
      for j in start..<end {
        if track_has_flexible_max(tracks[j]) {
          crosses_flex = true
          break
        }
      }
      if crosses_flex && snapshot.max_content_contribution[i] > space {
        space = snapshot.max_content_contribution[i]
      }
    }
  }
  space
}

///|
fn distribute_track_space_up_to_limits(
  states : Array[GridTrack],
  start : Int,
  span : Int,
  space : Double,
  should_affect : (GridTrack) -> Bool,
  limit_of : (GridTrack) -> Double,
  eps : Double,
  inf : Double,
) -> Double {
  let mut remaining = space
  while remaining > eps {
    let mut growable = 0
    for j in start..<(start + span) {
      if should_affect(states[j]) &&
        states[j].base_size + states[j].item_incurred_increase <
        limit_of(states[j]) - eps {
        growable = growable + 1
      }
    }
    if growable == 0 {
      return remaining
    }
    let mut min_room = inf
    for j in start..<(start + span) {
      if should_affect(states[j]) &&
        states[j].base_size + states[j].item_incurred_increase <
        limit_of(states[j]) - eps {
        let room = limit_of(states[j]) -
          states[j].base_size -
          states[j].item_incurred_increase
        if room < min_room {
          min_room = room
        }
      }
    }
    let share = @util.min_double(min_room, remaining / growable.to_double())
    if share <= 0.0 {
      return remaining
    }
    for j in start..<(start + span) {
      if should_affect(states[j]) &&
        states[j].base_size + states[j].item_incurred_increase <
        limit_of(states[j]) - eps {
        states[j].item_incurred_increase = states[j].item_incurred_increase +
          share
        remaining = remaining - share
      }
    }
  }
  remaining
}

///|
fn distribute_item_space_to_base_size(
  states : Array[GridTrack],
  start : Int,
  span : Int,
  space : Double,
  should_affect : (GridTrack) -> Bool,
  limit_of : (GridTrack) -> Double,
  contribution_type : IntrinsicContributionType,
  percent_basis : Double?,
  eps : Double,
  inf : Double,
) -> Unit {
  if space <= 0.0 || span <= 0 {
    return
  }
  let mut used = 0.0
  for j in start..<(start + span) {
    used = used + states[j].base_size
  }
  let extra = space - used
  if extra <= 0.0 {
    return
  }
  let mut has_affected = false
  for j in start..<(start + span) {
    if should_affect(states[j]) {
      has_affected = true
      break
    }
  }
  if !has_affected {
    return
  }
  for j in start..<(start + span) {
    states[j].item_incurred_increase = 0.0
  }
  let remaining = distribute_track_space_up_to_limits(
    states, start, span, extra, should_affect, limit_of, eps, inf,
  )
  if remaining > eps {
    let mut matching_affected = false
    for j in start..<(start + span) {
      let dimension = states[j].dimension
      let matches_beyond = match contribution_type {
        TrackMaximumContribution =>
          track_has_max_content_or_fit_max(dimension) ||
          track_min_sizing_kind(dimension) == 2
        TrackMinimumContribution =>
          track_has_intrinsic_max(dimension, percent_basis)
      }
      if should_affect(states[j]) && matches_beyond {
        matching_affected = true
        break
      }
    }
    let beyond_filter = fn(state : GridTrack) -> Bool {
      if matching_affected {
        match contribution_type {
          TrackMaximumContribution =>
            track_has_max_content_or_fit_max(state.dimension) ||
            track_min_sizing_kind(state.dimension) == 2
          TrackMinimumContribution =>
            track_has_intrinsic_max(state.dimension, percent_basis)
        }
      } else {
        true
      }
    }
    ignore(
      distribute_track_space_up_to_limits(
        states, start, span, remaining, beyond_filter, limit_of, eps, inf,
      ),
    )
  }
  for j in start..<(start + span) {
    if states[j].item_incurred_increase > states[j].base_size_planned_increase {
      states[j].base_size_planned_increase = states[j].item_incurred_increase
    }
    states[j].item_incurred_increase = 0.0
  }
}

///|
fn flush_track_base_size_increases(states : Array[GridTrack]) -> Unit {
  for state in states {
    state.base_size = state.base_size + state.base_size_planned_increase
    state.base_size_planned_increase = 0.0
  }
}

///|
fn apply_definite_max_floor(
  states : Array[GridTrack],
  percent_basis : Double?,
) -> Unit {
  for state in states {
    match state.dimension {
      DimMinMax(_, max_d) =>
        match max_d {
          DimLength(v) => if v > state.base_size { state.base_size = v }
          DimPercent(p) =>
            match percent_basis {
              Some(basis) => {
                let v = basis * p
                if v > state.base_size {
                  state.base_size = v
                }
              }
              None => ()
            }
          _ => ()
        }
      _ => ()
    }
  }
}

///|
fn grid_track_base_sizes(states : Array[GridTrack]) -> Array[Double] {
  let sizes : Array[Double] = []
  for state in states {
    sizes.push(state.base_size)
  }
  sizes
}

///|
fn compute_intrinsic_base_sizes_max_content(
  tracks : Array[Dimension],
  snapshot : GridTrackSizingItemSnapshot,
  percent_basis : Double?,
) -> Array[Double] {
  let count = tracks.length()
  let inf = 1.0e30
  let eps = 0.000001
  let states : Array[GridTrack] = []
  for i in 0..<count {
    states.push(grid_track_base_state(tracks[i], percent_basis))
  }

  let mut max_span = 1
  for i in 0..<snapshot.placed.length() {
    if snapshot.placed[i] && snapshot.span[i] > max_span {
      max_span = snapshot.span[i]
    }
  }

  for span in 1..<(max_span + 1) {
    for i in 0..<snapshot.placed.length() {
      if !snapshot.placed[i] || snapshot.span[i] != span {
        continue
      }
      let s = snapshot.start[i]
      let sp = snapshot.span[i]
      let scroll_container = snapshot.minimum_contribution[i] + eps <
        snapshot.min_content_contribution[i]
      let min_space = if scroll_container {
        snapshot.minimum_contribution[i]
      } else {
        @util.max_double(
          snapshot.minimum_contribution[i],
          snapshot.min_content_contribution[i],
        )
      }
      let limit_of = if scroll_container {
        fn(state : GridTrack) -> Double {
          track_fit_content_limit(state.dimension, percent_basis, inf)
        }
      } else {
        fn(_state : GridTrack) -> Double { inf }
      }
      distribute_item_space_to_base_size(
        states,
        s,
        sp,
        min_space,
        fn(state : GridTrack) -> Bool {
          track_has_intrinsic_min(state.dimension, percent_basis)
        },
        limit_of,
        TrackMinimumContribution,
        percent_basis,
        eps,
        inf,
      )
    }
  }
  flush_track_base_size_increases(states)

  for span in 1..<(max_span + 1) {
    for i in 0..<snapshot.placed.length() {
      if !snapshot.placed[i] || snapshot.span[i] != span {
        continue
      }
      let s = snapshot.start[i]
      let sp = snapshot.span[i]
      let scroll_container = snapshot.minimum_contribution[i] + eps <
        snapshot.min_content_contribution[i]
      let limit_of = if scroll_container {
        fn(state : GridTrack) -> Double {
          track_fit_content_limit(state.dimension, percent_basis, inf)
        }
      } else {
        fn(_state : GridTrack) -> Double { inf }
      }
      distribute_item_space_to_base_size(
        states,
        s,
        sp,
        snapshot.min_content_contribution[i],
        fn(state : GridTrack) -> Bool {
          let kind = track_min_sizing_kind(state.dimension)
          kind == 1 || kind == 2
        },
        limit_of,
        TrackMinimumContribution,
        percent_basis,
        eps,
        inf,
      )
    }
  }
  flush_track_base_size_increases(states)

  for span in 1..<(max_span + 1) {
    for i in 0..<snapshot.placed.length() {
      if !snapshot.placed[i] || snapshot.span[i] != span {
        continue
      }
      let s = snapshot.start[i]
      let sp = snapshot.span[i]
      let max_space = snapshot.max_content_contribution[i]
      let mut has_max_content = false
      for j in s..<(s + sp) {
        if track_min_sizing_kind(states[j].dimension) == 2 {
          has_max_content = true
          break
        }
      }
      let affect_kind = if has_max_content { 2 } else { 3 }
      let limit_of = if has_max_content {
        fn(_state : GridTrack) -> Double { inf }
      } else {
        fn(state : GridTrack) -> Double {
          track_fit_content_limit(state.dimension, percent_basis, inf)
        }
      }
      distribute_item_space_to_base_size(
        states,
        s,
        sp,
        max_space,
        fn(state : GridTrack) -> Bool {
          track_min_sizing_kind(state.dimension) == affect_kind &&
          !track_max_is_min_content(state.dimension)
        },
        limit_of,
        TrackMaximumContribution,
        percent_basis,
        eps,
        inf,
      )
    }
  }
  flush_track_base_size_increases(states)

  for span in 1..<(max_span + 1) {
    for i in 0..<snapshot.placed.length() {
      if !snapshot.placed[i] || snapshot.span[i] != span {
        continue
      }
      let s = snapshot.start[i]
      let sp = snapshot.span[i]
      distribute_item_space_to_base_size(
        states,
        s,
        sp,
        snapshot.max_content_contribution[i],
        fn(state : GridTrack) -> Bool {
          track_min_sizing_kind(state.dimension) == 2
        },
        fn(_state : GridTrack) -> Double { inf },
        TrackMaximumContribution,
        percent_basis,
        eps,
        inf,
      )
    }
  }
  flush_track_base_size_increases(states)

  apply_definite_max_floor(states, percent_basis)
  grid_track_base_sizes(states)
}

///|
fn compute_flexible_percent_max_content_track_sizes(
  tracks : Array[Dimension],
  snapshot : GridTrackSizingItemSnapshot,
) -> (Array[Double], Double)? {
  let flex_space = compute_spanned_max_track_size(tracks, snapshot)
  if flex_space <= 0.0 {
    return None
  }
  let states : Array[GridTrack] = []
  let mut fixed_used = 0.0
  let mut flex_sum = 0.0
  for track in tracks {
    let state = grid_track_base_state(track, Some(flex_space))
    match track {
      DimLength(v) => fixed_used = fixed_used + v
      DimPercent(p) => fixed_used = fixed_used + flex_space * p
      DimMinMax(min_d, max_d) =>
        match max_d {
          DimFr(weight) => {
            if weight > 0.0 {
              flex_sum = flex_sum + weight
            }
            match min_d {
              DimLength(v) => state.base_size = v
              _ => ()
            }
          }
          _ =>
            match track_definite_len(track) {
              Some(v) => fixed_used = fixed_used + v
              None => ()
            }
        }
      DimFr(weight) => if weight > 0.0 { flex_sum = flex_sum + weight }
      _ => ()
    }
    states.push(state)
  }
  let remaining = @util.max_double(flex_space - fixed_used, 0.0)
  if flex_sum > 0.0 {
    for state in states {
      let weight = track_flex_weight(state.dimension)
      if weight > 0.0 {
        state.base_size = @util.max_double(
          state.base_size,
          remaining * weight / flex_sum,
        )
      }
    }
  }
  Some((grid_track_base_sizes(states), flex_space))
}

///|
fn compute_max_content_spanning_track_sizes(
  tracks : Array[Dimension],
  snapshot : GridTrackSizingItemSnapshot,
) -> (Array[Double], Double)? {
  let mut has_spanning_item = false
  let mut has_flexible_spanning_item = false
  let mut has_intrinsic_spanning_item = false
  for i in 0..<snapshot.placed.length() {
    if snapshot.placed[i] && snapshot.span[i] > 1 {
      has_spanning_item = true
      if snapshot.crosses_flexible_track[i] {
        has_flexible_spanning_item = true
      }
      if snapshot.crosses_intrinsic_track[i] {
        has_intrinsic_spanning_item = true
      }
    }
  }
  if !has_spanning_item ||
    (!has_flexible_spanning_item && !has_intrinsic_spanning_item) {
    return None
  }
  let mut has_percent_track = false
  let mut has_flexible_track = false
  let mut has_intrinsic_track = false
  for track in tracks {
    if track_uses_percentage(track) {
      has_percent_track = true
    }
    if track_has_flexible_max(track) {
      has_flexible_track = true
    }
    if track_min_sizing_kind(track) != 0 {
      has_intrinsic_track = true
    }
  }
  if has_flexible_track && has_percent_track {
    return compute_flexible_percent_max_content_track_sizes(tracks, snapshot)
  }
  if !has_intrinsic_track || has_flexible_track {
    return None
  }
  let sizes1 = compute_intrinsic_base_sizes_max_content(tracks, snapshot, None)
  let mut basis = 0.0
  for size in sizes1 {
    basis = basis + size
  }
  if has_percent_track {
    let sizes2 = compute_intrinsic_base_sizes_max_content(
      tracks,
      snapshot,
      Some(basis),
    )
    basis = 0.0
    for size in sizes2 {
      basis = basis + size
    }
    Some((sizes2, basis))
  } else {
    Some((sizes1, basis))
  }
}
