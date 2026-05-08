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
