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
fn merged_placement_line(
  placement : Line[GridPlacement],
  legacy_start : Int?,
) -> Line[GridPlacement] {
  match legacy_start {
    Some(v) => Line(start=PlaceLine(v), end=placement.end)
    None => placement
  }
}

///|
fn placement_span_value(span : Int) -> Int {
  if span > 0 {
    span
  } else {
    1
  }
}

///|
fn axis_resolve_start_line_and_span(
  placement : Line[GridPlacement],
  explicit_track_count : Int,
) -> (Int?, Int) {
  let start_line = match placement.start {
    PlaceLine(v) => origin_zero_line(v, explicit_track_count)
    _ => None
  }
  let end_line = match placement.end {
    PlaceLine(v) => origin_zero_line(v, explicit_track_count)
    _ => None
  }
  let explicit_span = match placement.start {
    PlaceSpan(s) => Some(placement_span_value(s))
    _ =>
      match placement.end {
        PlaceSpan(s) => Some(placement_span_value(s))
        _ => None
      }
  }
  match explicit_span {
    Some(span) =>
      match (start_line, end_line) {
        (Some(sl), _) => (Some(sl), span)
        (None, Some(el)) => (Some(el - span), span)
        _ => (None, span)
      }
    None =>
      match (start_line, end_line) {
        (Some(sl), Some(el)) => {
          let span = if el > sl { el - sl } else { 1 }
          (Some(sl), span)
        }
        (Some(sl), None) => (Some(sl), 1)
        (None, Some(el)) => (Some(el - 1), 1)
        _ => (None, 1)
      }
  }
}

///|
fn axis_auto_track_list(auto_tracks : Array[Dimension]) -> Array[Dimension] {
  if auto_tracks.length() == 0 {
    [DimAuto]
  } else {
    auto_tracks
  }
}

///|
fn negative_auto_track_at(
  auto_tracks : Array[Dimension],
  offset_from_explicit : Int,
) -> Dimension {
  let len = auto_tracks.length()
  if len == 0 {
    DimAuto
  } else {
    // `offset_from_explicit` is 1-based: 1 means the track adjacent to the explicit grid.
    let m = offset_from_explicit % len
    let idx = (len - m) % len
    auto_tracks[idx]
  }
}

///|
fn axis_start_index_and_span(
  placement : Line[GridPlacement],
  legacy_start : Int?,
  explicit_track_count : Int,
  negative_implicit : Int,
) -> (Int?, Int) {
  let merged = merged_placement_line(placement, legacy_start)
  let resolved = axis_resolve_start_line_and_span(merged, explicit_track_count)
  let start = match resolved.0 {
    Some(sl) => Some(sl + negative_implicit)
    None => None
  }
  (start, resolved.1)
}

///|
fn child_start_indexes_and_spans(
  child_style : Style,
  explicit_cols : Int,
  explicit_rows : Int,
  negative_cols : Int,
  negative_rows : Int,
) -> (Int?, Int, Int?, Int) {
  let col = axis_start_index_and_span(
    child_style.grid_column,
    child_style.grid_column_start,
    explicit_cols,
    negative_cols,
  )
  let row = axis_start_index_and_span(
    child_style.grid_row,
    child_style.grid_row_start,
    explicit_rows,
    negative_rows,
  )
  (row.0, row.1, col.0, col.1)
}

///|
fn fr_track_weight(track : Dimension) -> Double {
  match track {
    DimFr(w) => if w > 0.0 { w } else { 0.0 }
    _ => 0.0
  }
}

///|
fn apply_col_contribution(
  col_tracks : Array[Dimension],
  start : Int,
  span : Int,
  needed : Double,
  contrib : Array[Double],
) -> Unit {
  if span <= 1 {
    if needed > contrib[start] {
      contrib[start] = needed
    }
    return
  }
  let mut all_fr = true
  let weights : Array[Double] = Array::make(span, 0.0)
  let mut positive_weight_sum = 0.0
  for offset in 0..<span {
    let idx = start + offset
    let track = col_tracks[idx]
    if !(track is DimFr(_)) {
      all_fr = false
    }
    let weight = fr_track_weight(track)
    weights[offset] = weight
    if weight > 0.0 {
      positive_weight_sum = positive_weight_sum + weight
    }
  }
  if all_fr {
    if positive_weight_sum > 0.0 {
      for offset in 0..<span {
        let idx = start + offset
        let share = needed * weights[offset] / positive_weight_sum
        if share > contrib[idx] {
          contrib[idx] = share
        }
      }
    } else {
      let share = needed / span.to_double()
      for offset in 0..<span {
        let idx = start + offset
        if share > contrib[idx] {
          contrib[idx] = share
        }
      }
    }
  } else if positive_weight_sum > 0.0 {
    let mut current_sum = 0.0
    for offset in 0..<span {
      let idx = start + offset
      current_sum = current_sum + contrib[idx]
    }
    let deficit = needed - current_sum
    if deficit > 0.0 {
      for offset in 0..<span {
        let idx = start + offset
        let weight = weights[offset]
        if weight > 0.0 {
          contrib[idx] = contrib[idx] + deficit * weight / positive_weight_sum
        }
      }
    }
  } else {
    let share = needed / span.to_double()
    for offset in 0..<span {
      let idx = start + offset
      if share > contrib[idx] {
        contrib[idx] = share
      }
    }
  }
}

///|
fn track_definite_len(track : Dimension) -> Double? {
  match track {
    DimLength(v) => Some(v)
    DimMinMax(min_d, max_d) =>
      match (min_d, max_d) {
        (DimLength(a), DimLength(b)) if a == b => Some(a)
        _ => None
      }
    _ => None
  }
}

///|
fn spanned_definite_len(
  tracks : Array[Dimension],
  start : Int,
  span : Int,
  gap : Double,
) -> Double? {
  if span <= 0 {
    return Some(0.0)
  }
  let mut total = 0.0
  for i in start..<(start + span) {
    match track_definite_len(tracks[i]) {
      Some(v) => total = total + v
      None => return None
    }
  }
  if span > 1 {
    total = total + gap * (span - 1).to_double()
  }
  Some(total)
}

///|
fn track_min_sizing_kind(track : Dimension) -> Int {
  // 0 = fixed/other, 1 = min-content, 2 = max-content, 3 = auto
  match track {
    DimMinContent => 1
    DimMaxContent => 2
    DimAuto => 3
    DimFitContent(_) => 3
    DimMinMax(min_d, _) =>
      match min_d {
        DimMinContent => 1
        DimMaxContent => 2
        DimAuto => 3
        DimFitContent(_) => 3
        _ => 0
      }
    _ => 0
  }
}

///|
fn grid_track_base_state(
  dimension : Dimension,
  percent_basis : Double?,
) -> GridTrack {
  let mut base_size = 0.0
  match dimension {
    DimLength(v) => base_size = v
    DimPercent(p) =>
      match percent_basis {
        Some(b) => base_size = b * p
        None => base_size = 0.0
      }
    DimMinMax(min_d, _) =>
      match min_d {
        DimLength(v) => base_size = v
        DimPercent(p) =>
          match percent_basis {
            Some(b) => base_size = b * p
            None => ()
          }
        _ => ()
      }
    _ => ()
  }
  {
    dimension,
    base_size,
    base_size_planned_increase: 0.0,
    item_incurred_increase: 0.0,
  }
}

///|
fn track_max_is_min_content(track : Dimension) -> Bool {
  match track {
    DimMinContent => true
    DimMinMax(_, max_d) => max_d is DimMinContent
    _ => false
  }
}

///|
fn track_has_intrinsic_min(track : Dimension, percent_basis : Double?) -> Bool {
  match track {
    DimAuto | DimMinContent | DimMaxContent | DimFitContent(_) => true
    DimPercent(_) => percent_basis is None
    DimMinMax(min_d, _) =>
      match min_d {
        DimAuto | DimMinContent | DimMaxContent | DimFitContent(_) => true
        DimPercent(_) => percent_basis is None
        _ => false
      }
    _ => false
  }
}

///|
fn track_has_intrinsic_max(track : Dimension, percent_basis : Double?) -> Bool {
  match track {
    DimAuto | DimMinContent | DimMaxContent | DimFitContent(_) => true
    DimPercent(_) => percent_basis is None
    DimFr(_) => true
    DimMinMax(_, max_d) =>
      match max_d {
        DimAuto | DimMinContent | DimMaxContent | DimFitContent(_) => true
        DimPercent(_) => percent_basis is None
        DimFr(_) => true
        _ => false
      }
    _ => false
  }
}

///|
fn track_has_max_content_or_fit_max(track : Dimension) -> Bool {
  match track {
    DimMaxContent | DimFitContent(_) => true
    DimMinMax(_, max_d) =>
      match max_d {
        DimMaxContent | DimFitContent(_) => true
        _ => false
      }
    _ => false
  }
}

///|
fn track_fit_content_limit(
  track : Dimension,
  percent_basis : Double?,
  inf : Double,
) -> Double {
  let limit = match track {
    DimFitContent(limit) => Some(limit)
    DimMinMax(_, DimFitContent(limit)) => Some(limit)
    _ => None
  }
  match limit {
    Some(DimPercent(p)) =>
      match percent_basis {
        Some(b) => b * p
        None => inf
      }
    Some(d) => resolve_track_dimension(d, 0.0)
    None => inf
  }
}

///|
fn track_uses_percentage(track : Dimension) -> Bool {
  match track {
    DimPercent(_) => true
    DimFitContent(DimPercent(_)) => true
    DimMinMax(min_d, max_d) =>
      match (min_d, max_d) {
        (DimPercent(_), _) => true
        (_, DimPercent(_)) => true
        (_, DimFitContent(DimPercent(_))) => true
        _ => false
      }
    _ => false
  }
}

///|
fn track_flex_weight(track : Dimension) -> Double {
  match track {
    DimFr(w) => if w > 0.0 { w } else { 0.0 }
    DimMinMax(_, DimFr(w)) => if w > 0.0 { w } else { 0.0 }
    _ => 0.0
  }
}

///|
fn track_has_flexible_max(track : Dimension) -> Bool {
  track_flex_weight(track) > 0.0
}

///|
fn compute_spanned_max_track_size(
  tracks : Array[Dimension],
  starts : Array[Int],
  spans : Array[Int],
  max_needed : Array[Double],
  placed : Array[Bool],
) -> Double {
  let mut space = 0.0
  for i in 0..<placed.length() {
    if placed[i] && spans[i] > 1 {
      let start = starts[i]
      let end = start + spans[i]
      let mut crosses_flex = false
      for j in start..<end {
        if track_has_flexible_max(tracks[j]) {
          crosses_flex = true
          break
        }
      }
      if crosses_flex && max_needed[i] > space {
        space = max_needed[i]
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
    let share = min_double(min_room, remaining / growable.to_double())
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
  col_start : Array[Int],
  col_span : Array[Int],
  minimum_needed : Array[Double],
  min_content_needed : Array[Double],
  max_needed : Array[Double],
  placed : Array[Bool],
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
  for i in 0..<placed.length() {
    if placed[i] && col_span[i] > max_span {
      max_span = col_span[i]
    }
  }

  for span in 1..<(max_span + 1) {
    for i in 0..<placed.length() {
      if !placed[i] || col_span[i] != span {
        continue
      }
      let s = col_start[i]
      let sp = col_span[i]
      let scroll_container = minimum_needed[i] + eps < min_content_needed[i]
      let min_space = if scroll_container {
        minimum_needed[i]
      } else {
        max_double(minimum_needed[i], min_content_needed[i])
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
    for i in 0..<placed.length() {
      if !placed[i] || col_span[i] != span {
        continue
      }
      let s = col_start[i]
      let sp = col_span[i]
      let scroll_container = minimum_needed[i] + eps < min_content_needed[i]
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
        min_content_needed[i],
        fn(state : GridTrack) -> Bool {
          let k = track_min_sizing_kind(state.dimension)
          k == 1 || k == 2
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
    for i in 0..<placed.length() {
      if !placed[i] || col_span[i] != span {
        continue
      }
      let s = col_start[i]
      let sp = col_span[i]
      let max_space = max_needed[i]
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
    for i in 0..<placed.length() {
      if !placed[i] || col_span[i] != span {
        continue
      }
      let s = col_start[i]
      let sp = col_span[i]
      distribute_item_space_to_base_size(
        states,
        s,
        sp,
        max_needed[i],
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
  col_start : Array[Int],
  col_span : Array[Int],
  max_needed : Array[Double],
  placed : Array[Bool],
) -> (Array[Double], Double)? {
  let flex_space = compute_spanned_max_track_size(
    tracks, col_start, col_span, max_needed, placed,
  )
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
          DimFr(w) => {
            if w > 0.0 {
              flex_sum = flex_sum + w
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
      DimFr(w) => if w > 0.0 { flex_sum = flex_sum + w }
      _ => ()
    }
    states.push(state)
  }
  let remaining = max_double(flex_space - fixed_used, 0.0)
  if flex_sum > 0.0 {
    for state in states {
      let weight = track_flex_weight(state.dimension)
      if weight > 0.0 {
        state.base_size = max_double(
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
  col_start : Array[Int],
  col_span : Array[Int],
  minimum_needed : Array[Double],
  min_content_needed : Array[Double],
  max_needed : Array[Double],
  placed : Array[Bool],
) -> (Array[Double], Double)? {
  let mut has_spanning_item = false
  for i in 0..<placed.length() {
    if placed[i] && col_span[i] > 1 {
      has_spanning_item = true
      break
    }
  }
  if !has_spanning_item {
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
    return compute_flexible_percent_max_content_track_sizes(
      tracks, col_start, col_span, max_needed, placed,
    )
  }
  if !has_intrinsic_track || has_flexible_track {
    return None
  }
  let sizes1 = compute_intrinsic_base_sizes_max_content(
    tracks,
    col_start,
    col_span,
    minimum_needed,
    min_content_needed,
    max_needed,
    placed,
    None,
  )
  let mut basis = 0.0
  for size in sizes1 {
    basis = basis + size
  }
  if has_percent_track {
    let sizes2 = compute_intrinsic_base_sizes_max_content(
      tracks,
      col_start,
      col_span,
      minimum_needed,
      min_content_needed,
      max_needed,
      placed,
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

///|
fn track_basis_fit_content(
  min_c : Double,
  max_c : Double,
  limit : Dimension,
  available : Double,
) -> Double {
  match limit {
    DimPercent(_) => max_c
    _ => {
      let lim = resolve_track_dimension(limit, available)
      let preferred = if max_c < lim { max_c } else { lim }
      if preferred < min_c {
        min_c
      } else {
        preferred
      }
    }
  }
}

///|
fn axis_min_content_basis(
  tracks : Array[Dimension],
  min_contrib : Array[Double],
  max_contrib : Array[Double],
  gap : Double,
) -> Double {
  let mut total = 0.0
  let mut fr_sum = 0.0
  let mut fr_fraction = 0.0
  for i in 0..<tracks.length() {
    let min_c = min_contrib[i]
    let max_c = max_contrib[i]
    match tracks[i] {
      DimFr(w) =>
        if w > 0.0 {
          fr_sum = fr_sum + w
          let ratio = min_c / w
          if ratio > fr_fraction {
            fr_fraction = ratio
          }
        } else {
          total = total + min_c
        }
      _ =>
        total = total +
          (match tracks[i] {
            DimLength(v) => v
            DimAuto => min_c
            DimPercent(_) => min_c
            DimMinContent => min_c
            DimMaxContent => max_c
            DimFitContent(limit) =>
              track_basis_fit_content(min_c, max_c, limit, 0.0)
            DimMinMax(min_d, _max_d) =>
              // Conservative: use the min sizing function where possible.
              match min_d {
                DimAuto | DimMinContent => min_c
                DimMaxContent => max_c
                _ => resolve_track_dimension(min_d, 0.0)
              }
            _ => 0.0
          })
    }
  }
  total = total + fr_fraction * fr_sum
  if tracks.length() > 1 {
    total = total + gap * (tracks.length() - 1).to_double()
  }
  total
}

///|
fn axis_max_content_basis(
  tracks : Array[Dimension],
  min_contrib : Array[Double],
  max_contrib : Array[Double],
  gap : Double,
) -> Double {
  let mut total = 0.0
  let mut fr_sum = 0.0
  let mut fr_fraction = 0.0
  for i in 0..<tracks.length() {
    let min_c = min_contrib[i]
    let max_c = max_contrib[i]
    match tracks[i] {
      DimFr(w) =>
        if w > 0.0 {
          fr_sum = fr_sum + w
          let ratio = max_c / w
          if ratio > fr_fraction {
            fr_fraction = ratio
          }
        } else {
          total = total + max_c
        }
      _ =>
        total = total +
          (match tracks[i] {
            DimLength(v) => v
            DimAuto => max_c
            DimPercent(_) => max_c
            DimMinContent => min_c
            DimMaxContent => max_c
            DimFitContent(limit) =>
              track_basis_fit_content(min_c, max_c, limit, 0.0)
            DimMinMax(_min_d, max_d) => {
              let min_basis = match _min_d {
                DimAuto => 0.0
                DimMinContent => min_c
                DimMaxContent => max_c
                DimFitContent(limit) =>
                  track_basis_fit_content(min_c, max_c, limit, 0.0)
                _ => resolve_track_dimension(_min_d, 0.0)
              }
              let max_basis = match max_d {
                DimAuto | DimMaxContent => max_c
                DimMinContent => min_c
                DimPercent(_) => max_c
                DimFr(_) => max_c
                DimFitContent(limit) =>
                  track_basis_fit_content(min_c, max_c, limit, 0.0)
                _ => resolve_track_dimension(max_d, 0.0)
              }
              if max_basis < min_basis {
                min_basis
              } else {
                max_basis
              }
            }
            _ => 0.0
          })
    }
  }
  total = total + fr_fraction * fr_sum
  if tracks.length() > 1 {
    total = total + gap * (tracks.length() - 1).to_double()
  }
  total
}

///|
fn available_inset_or_basis(
  available : AvailableSpace,
  inset : Double,
  min_basis : Double,
  max_basis : Double,
) -> Double {
  match available {
    AvailDefinite(v) => max_double(v - inset, 0.0)
    AvailMinContent => min_basis
    AvailMaxContent => max_basis
  }
}

///|
fn resolve_grid_abs_line_position(lines : Array[Double], line : Int) -> Double {
  let last = lines.length() - 1
  if last <= 0 {
    lines[0]
  } else {
    let raw = if line > 0 { line - 1 } else { last + line + 1 }
    let idx = if raw < 0 { 0 } else if raw > last { last } else { raw }
    lines[idx]
  }
}

///|
fn resolve_grid_abs_axis_containing_block(
  placement : Line[GridPlacement],
  lines : Array[Double],
  padding_box_size : Double,
) -> (Double, Double) {
  let start_line = match placement.start {
    PlaceLine(v) => Some(resolve_grid_abs_line_position(lines, v))
    _ => None
  }
  let end_line = match placement.end {
    PlaceLine(v) => Some(resolve_grid_abs_line_position(lines, v))
    _ => None
  }
  let start_pos = match (start_line, end_line) {
    (Some(s), _) => s
    (None, Some(_)) => 0.0
    (None, None) => 0.0
  }
  let end_pos = match (start_line, end_line) {
    (_, Some(e)) => e
    (Some(_), None) => padding_box_size
    (None, None) => padding_box_size
  }
  if end_pos >= start_pos {
    (start_pos, end_pos)
  } else {
    (end_pos, start_pos)
  }
}
