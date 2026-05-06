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
fn origin_zero_line(value : Int, explicit_track_count : Int) -> Int? {
  if value == 0 {
    None
  } else if value > 0 {
    Some(value - 1)
  } else {
    // Negative indices count back from the end of the explicit grid.
    let explicit_line_count = explicit_track_count + 1
    Some(value + explicit_line_count)
  }
}

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
fn matrix_make(rows : Int, cols : Int) -> Array[Array[Bool]] {
  let m : Array[Array[Bool]] = []
  for _r in 0..<rows {
    m.push(Array::make(cols, false))
  }
  m
}

///|
fn ensure_cols(
  occ : Array[Array[Bool]],
  col_tracks : Array[Dimension],
  auto_cols : Array[Dimension],
  negative_cols : Int,
  explicit_cols : Int,
  target_col : Int,
) -> Unit {
  while col_tracks.length() <= target_col {
    let pos_existing = col_tracks.length() - negative_cols - explicit_cols
    let dim = auto_cols[pos_existing % auto_cols.length()]
    col_tracks.push(dim)
    for r in 0..<occ.length() {
      occ[r].push(false)
    }
  }
}

///|
fn ensure_rows(
  occ : Array[Array[Bool]],
  row_tracks : Array[Dimension],
  auto_rows : Array[Dimension],
  negative_rows : Int,
  explicit_rows : Int,
  target_row : Int,
) -> Unit {
  while row_tracks.length() <= target_row {
    let pos_existing = row_tracks.length() - negative_rows - explicit_rows
    let dim = auto_rows[pos_existing % auto_rows.length()]
    row_tracks.push(dim)
    occ.push(Array::make(occ[0].length(), false))
  }
}

///|
fn region_is_free(
  occ : Array[Array[Bool]],
  row : Int,
  col : Int,
  row_span : Int,
  col_span : Int,
) -> Bool {
  for r in row..<(row + row_span) {
    for c in col..<(col + col_span) {
      if occ[r][c] {
        return false
      }
    }
  }
  true
}

///|
fn mark_placed(
  placed : Array[Bool],
  placed_row : Array[Int],
  placed_col : Array[Int],
  placed_row_span : Array[Int],
  placed_col_span : Array[Int],
  occ : Array[Array[Bool]],
  row_tracks : Array[Dimension],
  col_tracks : Array[Dimension],
  auto_rows : Array[Dimension],
  auto_cols : Array[Dimension],
  negative_rows : Int,
  negative_cols : Int,
  explicit_rows : Int,
  explicit_cols : Int,
  idx : Int,
  row : Int,
  col : Int,
  row_span : Int,
  col_span : Int,
) -> Unit {
  let row_end = row + row_span - 1
  let col_end = col + col_span - 1
  ensure_rows(occ, row_tracks, auto_rows, negative_rows, explicit_rows, row_end)
  ensure_cols(occ, col_tracks, auto_cols, negative_cols, explicit_cols, col_end)
  for r in row..<(row + row_span) {
    for c in col..<(col + col_span) {
      occ[r][c] = true
    }
  }
  placed[idx] = true
  placed_row[idx] = row
  placed_col[idx] = col
  placed_row_span[idx] = row_span
  placed_col_span[idx] = col_span
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
fn col_min_sizing_kind(track : Dimension) -> Int {
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
fn compute_intrinsic_bases_max_content(
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
  let bases : Array[Double] = Array::make(count, 0.0)
  let planned : Array[Double] = Array::make(count, 0.0)
  for i in 0..<count {
    match tracks[i] {
      DimLength(v) => bases[i] = v
      DimPercent(p) =>
        match percent_basis {
          Some(b) => bases[i] = b * p
          None => bases[i] = 0.0
        }
      DimMinMax(min_d, _max_d) =>
        match min_d {
          DimLength(a) => bases[i] = a
          DimPercent(p) =>
            match percent_basis {
              Some(b) => bases[i] = b * p
              None => ()
            }
          _ => ()
        }
      _ => ()
    }
  }

  fn is_intrinsic_min(track : Dimension) -> Bool {
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

  fn max_is_min_content(track : Dimension) -> Bool {
    match track {
      DimMinContent => true
      DimMinMax(_, max_d) => max_d is DimMinContent
      _ => false
    }
  }

  fn max_is_intrinsic(track : Dimension) -> Bool {
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

  fn max_is_max_content_or_fit(track : Dimension) -> Bool {
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

  fn fit_content_limit(track : Dimension) -> Double {
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

  fn distribute_up_to_limits(
    bases : Array[Double],
    tracks : Array[Dimension],
    incurred : Array[Double],
    start : Int,
    span : Int,
    space : Double,
    should_affect : (Int, Dimension) -> Bool,
    limit_of : (Dimension) -> Double,
  ) -> Double {
    let mut remaining = space
    while remaining > eps {
      let mut growable = 0
      for j in start..<(start + span) {
        if should_affect(j, tracks[j]) &&
          bases[j] + incurred[j] < limit_of(tracks[j]) - eps {
          growable = growable + 1
        }
      }
      if growable == 0 {
        return remaining
      }
      let mut min_room = inf
      for j in start..<(start + span) {
        if should_affect(j, tracks[j]) &&
          bases[j] + incurred[j] < limit_of(tracks[j]) - eps {
          let room = limit_of(tracks[j]) - bases[j] - incurred[j]
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
        if should_affect(j, tracks[j]) &&
          bases[j] + incurred[j] < limit_of(tracks[j]) - eps {
          incurred[j] = incurred[j] + share
          remaining = remaining - share
        }
      }
    }
    remaining
  }

  fn distribute(
    bases : Array[Double],
    planned : Array[Double],
    tracks : Array[Dimension],
    start : Int,
    span : Int,
    space : Double,
    should_affect : (Int, Dimension) -> Bool,
    limit_of : (Dimension) -> Double,
    is_maximum : Bool,
  ) -> Unit {
    if space <= 0.0 || span <= 0 {
      return
    }
    let mut used = 0.0
    for j in start..<(start + span) {
      used = used + bases[j]
    }
    let extra = space - used
    if extra <= 0.0 {
      return
    }
    let mut has_affected = false
    for j in start..<(start + span) {
      if should_affect(j, tracks[j]) {
        has_affected = true
        break
      }
    }
    if !has_affected {
      return
    }
    let incurred : Array[Double] = Array::make(bases.length(), 0.0)
    let remaining = distribute_up_to_limits(
      bases, tracks, incurred, start, span, extra, should_affect, limit_of,
    )
    if remaining > eps {
      let mut matching_affected = false
      for j in start..<(start + span) {
        let matches_beyond = if is_maximum {
          max_is_max_content_or_fit(tracks[j]) ||
          col_min_sizing_kind(tracks[j]) == 2
        } else {
          max_is_intrinsic(tracks[j])
        }
        if should_affect(j, tracks[j]) && matches_beyond {
          matching_affected = true
          break
        }
      }
      let beyond_filter = fn(_idx : Int, track : Dimension) -> Bool {
        if matching_affected {
          if is_maximum {
            max_is_max_content_or_fit(track) || col_min_sizing_kind(track) == 2
          } else {
            max_is_intrinsic(track)
          }
        } else {
          true
        }
      }
      ignore(
        distribute_up_to_limits(
          bases, tracks, incurred, start, span, remaining, beyond_filter, limit_of,
        ),
      )
    }
    for j in start..<(start + span) {
      if incurred[j] > planned[j] {
        planned[j] = incurred[j]
      }
    }
  }

  fn flush() -> Unit {
    for i in 0..<count {
      bases[i] = bases[i] + planned[i]
      planned[i] = 0.0
    }
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
        fit_content_limit
      } else {
        fn(_track : Dimension) -> Double { inf }
      }
      distribute(
        bases,
        planned,
        tracks,
        s,
        sp,
        min_space,
        fn(_idx, track) { is_intrinsic_min(track) },
        limit_of,
        false,
      )
    }
  }
  flush()

  for span in 1..<(max_span + 1) {
    for i in 0..<placed.length() {
      if !placed[i] || col_span[i] != span {
        continue
      }
      let s = col_start[i]
      let sp = col_span[i]
      let scroll_container = minimum_needed[i] + eps < min_content_needed[i]
      let limit_of = if scroll_container {
        fit_content_limit
      } else {
        fn(_track : Dimension) -> Double { inf }
      }
      distribute(
        bases,
        planned,
        tracks,
        s,
        sp,
        min_content_needed[i],
        fn(_idx, track) {
          let k = col_min_sizing_kind(track)
          k == 1 || k == 2
        },
        limit_of,
        false,
      )
    }
  }
  flush()

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
        if col_min_sizing_kind(tracks[j]) == 2 {
          has_max_content = true
          break
        }
      }
      let affect_kind = if has_max_content { 2 } else { 3 }
      let limit_of = if has_max_content {
        fn(_track : Dimension) -> Double { inf }
      } else {
        fit_content_limit
      }
      distribute(
        bases,
        planned,
        tracks,
        s,
        sp,
        max_space,
        fn(_idx, track) {
          col_min_sizing_kind(track) == affect_kind &&
          !max_is_min_content(track)
        },
        limit_of,
        true,
      )
    }
  }
  flush()

  for span in 1..<(max_span + 1) {
    for i in 0..<placed.length() {
      if !placed[i] || col_span[i] != span {
        continue
      }
      let s = col_start[i]
      let sp = col_span[i]
      distribute(
        bases,
        planned,
        tracks,
        s,
        sp,
        max_needed[i],
        fn(_idx, track) { col_min_sizing_kind(track) == 2 },
        fn(_track : Dimension) -> Double { inf },
        true,
      )
    }
  }
  flush()

  for i in 0..<count {
    match tracks[i] {
      DimMinMax(_, max_d) =>
        match max_d {
          DimLength(b) => if b > bases[i] { bases[i] = b }
          DimPercent(q) =>
            match percent_basis {
              Some(basis) => {
                let b = basis * q
                if b > bases[i] {
                  bases[i] = b
                }
              }
              None => ()
            }
          _ => ()
        }
      _ => ()
    }
  }

  bases
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
