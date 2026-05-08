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
