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
fn[C] compute_node_layout_with_measure(
  tree : TaffyTree[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  measure_function : (Size[Double?], Size[AvailableSpace], NodeId, C?, Style) -> Size[
    Double,
  ],
  is_layout_root : Bool,
) -> Unit raise TaffyError {
  ignore(is_layout_root)
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let run_mode = if node.style.display is DisplayNone {
    PerformHiddenLayout
  } else {
    PerformLayout
  }
  let can_use_layout_cache = can_use_node_layout_cache(node, absolute_origin)
  if restore_node_layout_from_cache(
      tree, node_id, known_dimensions, available_space, absolute_origin, is_layout_root,
      run_mode, can_use_layout_cache,
    ) {
    return
  }
  match node.style.display {
    DisplayNone => compute_hidden_layout(tree, node_id, absolute_origin)
    DisplayGrid =>
      if node.children.length() == 0 {
        compute_leaf_layout_with_measure(
          tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
        )
      } else {
        compute_grid_layout_with_measure(
          tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
          is_layout_root,
        )
      }
    DisplayBlock =>
      if node.children.length() == 0 {
        compute_leaf_layout_with_measure(
          tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
        )
      } else {
        compute_block_layout_with_measure(
          tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
          is_layout_root,
        )
      }
    _ =>
      if node.children.length() == 0 {
        compute_leaf_layout_with_measure(
          tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
        )
      } else {
        compute_flex_layout_with_measure(
          tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
        )
      }
  }

  apply_relative_inset_after_layout(tree, node_id, node.style, available_space)
  save_node_layout_cache(
    tree, node_id, known_dimensions, available_space, absolute_origin, is_layout_root,
    run_mode, can_use_layout_cache,
  )
}

///|
fn[C] can_use_node_layout_cache(
  node : Node[C],
  absolute_origin : Point[Double],
) -> Bool {
  node.children.length() <= 1 &&
  double_approx_equal(absolute_origin.x, 0.0) &&
  double_approx_equal(absolute_origin.y, 0.0)
}

///|
fn[C] restore_node_layout_from_cache(
  tree : TaffyTree[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  is_layout_root : Bool,
  run_mode : RunMode,
  can_use_layout_cache : Bool,
) -> Bool {
  if !can_use_layout_cache {
    return false
  }
  let node = tree.nodes[node_id]
  match
    find_node_layout_cache(
      node.cache,
      known_dimensions,
      available_space,
      absolute_origin,
      is_layout_root,
      run_mode,
    ) {
    Some(entry) => {
      tree.nodes[node_id].layout = {
        ..Layout::zero(),
        location: entry.location,
        size: entry.size,
      }
      tree.nodes[node_id].effective_margin_top = entry.effective_margin_top
      tree.nodes[node_id].effective_margin_bottom = entry.effective_margin_bottom
      tree.nodes[node_id].effective_margin_top_max_pos = entry.effective_margin_top_max_pos
      tree.nodes[node_id].effective_margin_top_min_neg = entry.effective_margin_top_min_neg
      tree.nodes[node_id].effective_margin_bottom_max_pos = entry.effective_margin_bottom_max_pos
      tree.nodes[node_id].effective_margin_bottom_min_neg = entry.effective_margin_bottom_min_neg
      true
    }
    None => false
  }
}

///|
fn[C] apply_relative_inset_after_layout(
  tree : TaffyTree[C],
  node_id : NodeId,
  style : Style,
  available_space : Size[AvailableSpace],
) -> Unit raise TaffyError {
  if style.display is DisplayNone {
    return
  }
  match style.position {
    PosRelative => {
      let inset = style.inset
      let dx = match
        resolve_optional_dimension(inset.left, available_space.width) {
        Some(v) => v
        None =>
          match resolve_optional_dimension(inset.right, available_space.width) {
            Some(v) => -v
            None => 0.0
          }
      }
      let dy = match
        resolve_optional_dimension(inset.top, available_space.height) {
        Some(v) => v
        None =>
          match
            resolve_optional_dimension(inset.bottom, available_space.height) {
            Some(v) => -v
            None => 0.0
          }
      }
      if dx != 0.0 || dy != 0.0 {
        offset_subtree(tree, node_id, dx, dy)
      }
    }
    PosAbsolute => ()
  }
}

///|
fn[C] save_node_layout_cache(
  tree : TaffyTree[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  is_layout_root : Bool,
  run_mode : RunMode,
  can_use_layout_cache : Bool,
) -> Unit {
  if !can_use_layout_cache {
    return
  }
  let layout = tree.nodes[node_id].layout
  store_node_layout_cache(tree.nodes[node_id].cache, run_mode, {
    known_dimensions,
    available_space,
    absolute_origin,
    is_layout_root,
    location: layout.location,
    size: layout.size,
    effective_margin_top: tree.nodes[node_id].effective_margin_top,
    effective_margin_bottom: tree.nodes[node_id].effective_margin_bottom,
    effective_margin_top_max_pos: tree.nodes[node_id].effective_margin_top_max_pos,
    effective_margin_top_min_neg: tree.nodes[node_id].effective_margin_top_min_neg,
    effective_margin_bottom_max_pos: tree.nodes[node_id].effective_margin_bottom_max_pos,
    effective_margin_bottom_min_neg: tree.nodes[node_id].effective_margin_bottom_min_neg,
  })
}
