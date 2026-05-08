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
pub fn max_double(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

///|
pub fn min_double(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
  }
}

///|
pub fn abs_double(v : Double) -> Double {
  if v < 0.0 {
    -v
  } else {
    v
  }
}

///|
pub fn double_approx_equal(a : Double, b : Double) -> Bool {
  abs_double(a - b) <= 0.000001
}

///|
pub fn optional_double_equal(a : Double?, b : Double?) -> Bool {
  match (a, b) {
    (None, None) => true
    (Some(x), Some(y)) => double_approx_equal(x, y)
    _ => false
  }
}

///|
pub fn available_space_equal(a : AvailableSpace, b : AvailableSpace) -> Bool {
  match (a, b) {
    (AvailDefinite(x), AvailDefinite(y)) => double_approx_equal(x, y)
    (AvailMinContent, AvailMinContent) => true
    (AvailMaxContent, AvailMaxContent) => true
    _ => false
  }
}
