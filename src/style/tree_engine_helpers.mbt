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
fn is_column(direction : FlexDirection) -> Bool {
  match direction {
    FlexRow => false
    FlexRowReverse => false
    FlexColumn => true
    FlexColumnReverse => true
  }
}

///|
fn get_main(size : Size[Double], is_col : Bool) -> Double {
  if is_col {
    size.height
  } else {
    size.width
  }
}

///|
fn get_cross(size : Size[Double], is_col : Bool) -> Double {
  if is_col {
    size.width
  } else {
    size.height
  }
}

///|
fn make_size_from_main_cross(
  main : Double,
  cross : Double,
  is_col : Bool,
) -> Size[Double] {
  if is_col {
    Size::new(width=cross, height=main)
  } else {
    Size::new(width=main, height=cross)
  }
}

///|
fn resolve_gap_main(
  gap : Size[Dimension],
  is_col : Bool,
  available_main : AvailableSpace,
) -> Double {
  if is_col {
    resolve_dimension(gap.height, available_main)
  } else {
    resolve_dimension(gap.width, available_main)
  }
}

///|
fn resolve_gap_cross(
  gap : Size[Dimension],
  is_col : Bool,
  available_cross : AvailableSpace,
) -> Double {
  if is_col {
    resolve_dimension(gap.width, available_cross)
  } else {
    resolve_dimension(gap.height, available_cross)
  }
}

///|
fn resolve_available_for_percent(
  is_definite : Bool,
  value : Double,
) -> AvailableSpace {
  if is_definite {
    AvailDefinite(value)
  } else {
    AvailMaxContent
  }
}

///|
fn resolve_justify_start_main(
  justify : AlignContent,
  leftover_main : Double,
  is_reverse : Bool,
) -> Double {
  match justify {
    AlignCenter => leftover_main / 2.0
    AlignStart => if is_reverse { leftover_main } else { 0.0 }
    AlignEnd => if is_reverse { 0.0 } else { leftover_main }
    AlignFlexEnd => leftover_main
    _ => 0.0
  }
}

///|
fn expand_grid_template_axis(
  template : Array[Dimension],
  content_size : Double,
  gap : Double,
) -> (Array[Dimension], Int, Bool) {
  let expanded : Array[Dimension] = []
  let mut used = 0.0
  let mut first = true
  let mut non_auto_fit_count = 0
  let mut has_auto_fit = false
  fn push_track(
    expanded : Array[Dimension],
    track : Dimension,
    content_size : Double,
    gap : Double,
    used : Double,
    first : Bool,
  ) -> (Double, Bool) {
    let mut u = used
    if not(first) {
      u = u + gap
    }
    u = u + resolve_track_dimension(track, content_size)
    expanded.push(track)
    (u, false)
  }

  for item in template {
    match item {
      DimRepeat(rep, tracks) => {
        if tracks.length() == 0 {
          continue
        }
        match rep {
          RepeatCount(n) => {
            let count = if n > 0 { n } else { 0 }
            for _i in 0..<count {
              for t in tracks {
                let r = push_track(expanded, t, content_size, gap, used, first)
                used = r.0
                first = r.1
                non_auto_fit_count = non_auto_fit_count + 1
              }
            }
          }
          RepeatAutoFill | RepeatAutoFit => {
            let is_auto_fit = rep is RepeatAutoFit
            if is_auto_fit {
              has_auto_fit = true
            }
            let mut reps = 0
            while true {
              // Try appending one full track-list.
              let mut u_try = used
              let mut first_try = first
              for t in tracks {
                if not(first_try) {
                  u_try = u_try + gap
                }
                u_try = u_try + resolve_track_dimension(t, content_size)
                first_try = false
              }
              let fits = u_try <= content_size + 0.000001
              if reps > 0 && not(fits) {
                break
              }
              // Always append at least once.
              for t in tracks {
                let r = push_track(expanded, t, content_size, gap, used, first)
                used = r.0
                first = r.1
                if not(is_auto_fit) {
                  non_auto_fit_count = non_auto_fit_count + 1
                }
              }
              reps = reps + 1
              if not(fits) {
                break
              }
            }
          }
        }
      }
      _ => {
        let r = push_track(expanded, item, content_size, gap, used, first)
        used = r.0
        first = r.1
        non_auto_fit_count = non_auto_fit_count + 1
      }
    }
  }
  (expanded, non_auto_fit_count, has_auto_fit)
}
