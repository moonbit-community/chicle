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
fn cache_slot(
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
) -> Int {
  let has_known_width = known_dimensions.width is Some(_)
  let has_known_height = known_dimensions.height is Some(_)
  if has_known_width && has_known_height {
    return 0
  }
  if has_known_width && !has_known_height {
    return 1 + (if available_space.height is AvailMinContent { 1 } else { 0 })
  }
  if has_known_height && !has_known_width {
    return 3 + (if available_space.width is AvailMinContent { 1 } else { 0 })
  }
  match (available_space.width, available_space.height) {
    (AvailMinContent, AvailMinContent) => 8
    (AvailMinContent, _) => 7
    (_, AvailMinContent) => 6
    _ => 5
  }
}

///|
fn find_leaf_measure_cache(
  cache : Cache,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  run_mode : RunMode,
) -> Size[Double]? {
  if !(run_mode is ComputeSize) {
    return None
  }
  for entry_option in cache.measure_entries {
    match entry_option {
      Some(entry) =>
        if known_dimensions_equal(entry.known_dimensions, known_dimensions) &&
          available_size_equal(entry.available_space, available_space) {
          return Some(entry.content)
        }
      None => ()
    }
  }
  None
}

///|
fn store_leaf_measure_cache(
  cache : Cache,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  run_mode : RunMode,
  measured : Size[Double],
) -> Unit {
  if !(run_mode is ComputeSize) {
    return
  }
  let slot = cache_slot(known_dimensions, available_space)
  cache.measure_entries[slot] = Some({
    known_dimensions,
    available_space,
    content: measured,
  })
}

///|
fn find_node_layout_cache(
  cache : Cache,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  is_layout_root : Bool,
  run_mode : RunMode,
) -> NodeLayoutCacheEntry? {
  if !(run_mode is PerformLayout) {
    return None
  }
  match cache.final_layout_entry {
    Some(entry) =>
      if known_dimensions_equal(entry.known_dimensions, known_dimensions) &&
        available_size_equal(entry.available_space, available_space) &&
        point_equal(entry.absolute_origin, absolute_origin) &&
        entry.is_layout_root == is_layout_root {
        Some(entry)
      } else {
        None
      }
    None => None
  }
}

///|
fn store_node_layout_cache(
  cache : Cache,
  run_mode : RunMode,
  entry : NodeLayoutCacheEntry,
) -> Unit {
  if !(run_mode is PerformLayout) {
    return
  }
  cache.final_layout_entry = Some(entry)
}

///|
fn Cache::clear(self : Cache) -> Unit {
  self.final_layout_entry = None
  for i in 0..<self.measure_entries.length() {
    self.measure_entries[i] = None
  }
}

///|
