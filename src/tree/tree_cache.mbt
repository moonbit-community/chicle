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
) -> LayoutOutput? {
  if !(run_mode is ComputeSize) {
    return None
  }
  for entry_option in cache.measure_entries {
    match entry_option {
      Some(entry) =>
        if cache_entry_matches(
            entry.known_dimensions,
            entry.available_space,
            LayoutOutput::from_outer_size(entry.content).outer_size(),
            known_dimensions,
            available_space,
          ) {
          return Some(LayoutOutput::from_outer_size(entry.content))
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
  run_mode : RunMode,
) -> NodeLayoutCacheEntry? {
  if !(run_mode is PerformLayout) {
    return None
  }
  match cache.final_layout_entry {
    Some(entry) =>
      if cache_entry_matches(
          entry.known_dimensions,
          entry.available_space,
          entry.content.outer_size(),
          known_dimensions,
          available_space,
        ) {
        Some(entry)
      } else {
        None
      }
    None => None
  }
}

///|
fn cache_entry_matches(
  entry_known_dimensions : Size[Double?],
  entry_available_space : Size[AvailableSpace],
  cached_size : Size[Double],
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
) -> Bool {
  (
    @util.optional_double_equal(
      known_dimensions.width,
      entry_known_dimensions.width,
    ) ||
    @util.optional_double_equal(known_dimensions.width, Some(cached_size.width))
  ) &&
  (
    @util.optional_double_equal(
      known_dimensions.height,
      entry_known_dimensions.height,
    ) ||
    @util.optional_double_equal(
      known_dimensions.height,
      Some(cached_size.height),
    )
  ) &&
  (
    known_dimensions.width is Some(_) ||
    @util.available_space_equal(
      entry_available_space.width,
      available_space.width,
    )
  ) &&
  (
    known_dimensions.height is Some(_) ||
    @util.available_space_equal(
      entry_available_space.height,
      available_space.height,
    )
  )
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
