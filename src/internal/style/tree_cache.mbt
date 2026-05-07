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
fn find_leaf_measure_cache(
  cache : Array[LeafMeasureCacheEntry],
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
) -> Size[Double]? {
  for entry in cache {
    if known_dimensions_equal(entry.known_dimensions, known_dimensions) &&
      available_size_equal(entry.available_space, available_space) {
      return Some(entry.measured)
    }
  }
  None
}

///|
fn find_node_layout_cache(
  cache : Array[NodeLayoutCacheEntry],
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  is_layout_root : Bool,
) -> NodeLayoutCacheEntry? {
  for entry in cache {
    if known_dimensions_equal(entry.known_dimensions, known_dimensions) &&
      available_size_equal(entry.available_space, available_space) &&
      point_equal(entry.absolute_origin, absolute_origin) &&
      entry.is_layout_root == is_layout_root {
      return Some(entry)
    }
  }
  None
}
