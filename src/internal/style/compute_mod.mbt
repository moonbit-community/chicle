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
fn[C] TaffyView::perform_child_layout(
  self : TaffyView[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  is_layout_root : Bool,
) -> Unit raise TaffyError {
  let tree = self.tree
  let inputs = match tree.nodes.get(node_id) {
    Some(node) =>
      if node.style.display is DisplayNone {
        LayoutInput::hidden()
      } else {
        layout_input_for_perform_layout(known_dimensions, available_space)
      }
    None => layout_input_for_perform_layout(known_dimensions, available_space)
  }
  ignore(
    self.compute_child_layout(node_id, inputs, absolute_origin, is_layout_root),
  )
}

///|
fn[C] TaffyView::compute_child_layout(
  self : TaffyView[C],
  node_id : NodeId,
  inputs : LayoutInput,
  absolute_origin : Point[Double],
  is_layout_root : Bool,
) -> LayoutOutput raise TaffyError {
  let tree = self.tree
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let run_mode = if inputs.run_mode is PerformHiddenLayout ||
    node.style.display is DisplayNone {
    PerformHiddenLayout
  } else {
    inputs.run_mode
  }
  match inputs.sizing_mode {
    ContentSize | InherentSize => ()
  }
  match inputs.axis {
    RequestedHorizontal | RequestedVertical | RequestedBoth => ()
  }
  ignore(inputs.parent_size)
  ignore(inputs.vertical_margins_are_collapsible)
  let can_use_layout_cache = can_use_node_layout_cache(
    tree, node_id, absolute_origin,
  )
  match
    restore_node_layout_from_cache(
      tree,
      node_id,
      inputs.known_dimensions,
      inputs.available_space,
      run_mode,
      can_use_layout_cache,
    ) {
    Some(output) => return output
    None => ()
  }
  if run_mode is PerformHiddenLayout {
    compute_hidden_layout(tree, node_id, absolute_origin)
  } else {
    match node.style.display {
      DisplayNone => compute_hidden_layout(tree, node_id, absolute_origin)
      DisplayGrid =>
        if tree.children[node_id].length() == 0 {
          compute_leaf_layout(
            self,
            node_id,
            inputs.known_dimensions,
            inputs.available_space,
            absolute_origin,
          )
        } else {
          compute_grid_layout(
            self,
            node_id,
            inputs.known_dimensions,
            inputs.available_space,
            absolute_origin,
            is_layout_root,
          )
        }
      DisplayBlock =>
        if tree.children[node_id].length() == 0 {
          compute_leaf_layout(
            self,
            node_id,
            inputs.known_dimensions,
            inputs.available_space,
            absolute_origin,
          )
        } else {
          compute_block_layout(
            self,
            node_id,
            inputs.known_dimensions,
            inputs.available_space,
            absolute_origin,
            is_layout_root,
          )
        }
      _ =>
        if tree.children[node_id].length() == 0 {
          compute_leaf_layout(
            self,
            node_id,
            inputs.known_dimensions,
            inputs.available_space,
            absolute_origin,
          )
        } else {
          compute_flexbox_layout(
            self,
            node_id,
            inputs.known_dimensions,
            inputs.available_space,
            absolute_origin,
          )
        }
    }
  }

  apply_relative_inset_after_layout(
    tree,
    node_id,
    node.style,
    inputs.available_space,
  )
  finalize_layout_metadata(tree, node_id, node.style, inputs.available_space)
  let output = LayoutOutput::from_layout(tree.nodes[node_id].unrounded_layout)
  save_node_layout_cache(
    tree,
    node_id,
    inputs.known_dimensions,
    inputs.available_space,
    output,
    run_mode,
    can_use_layout_cache,
  )
  output
}

///|
fn[C] finalize_layout_metadata(
  tree : TaffyTree[C],
  node_id : NodeId,
  style : Style,
  available_space : Size[AvailableSpace],
) -> Unit {
  if style.display is DisplayNone {
    return
  }
  let layout = tree.nodes[node_id].unrounded_layout
  let padding = resolve_rect_width_basis(style.padding, available_space)
  let border = resolve_rect_width_basis(style.border, available_space)
  let scrollbar_width = style.scrollbar_width
  let scrollbar_size = Size(
    width=match style.overflow.y {
      OverflowScroll => scrollbar_width
      _ => 0.0
    },
    height=match style.overflow.x {
      OverflowScroll => scrollbar_width
      _ => 0.0
    },
  )
  let horizontal_inset = padding.left +
    padding.right +
    border.left +
    border.right +
    scrollbar_size.width
  let vertical_inset = padding.top +
    padding.bottom +
    border.top +
    border.bottom +
    scrollbar_size.height
  let content_size = if tree.children[node_id].length() == 0 {
    layout.content_size
  } else {
    Size(
      width=max_double(layout.size.width - horizontal_inset, 0.0),
      height=max_double(layout.size.height - vertical_inset, 0.0),
    )
  }
  tree.nodes[node_id].unrounded_layout = {
    ..layout,
    content_size,
    scrollbar_size,
    border,
    padding,
  }
}

///|
fn[C] TaffyView::measure_child_size(
  self : TaffyView[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  parent_size : Size[Double?],
  available_space : Size[AvailableSpace],
  sizing_mode : SizingMode,
  axis : AbsoluteAxis,
  vertical_margins_are_collapsible : Line[Bool],
  absolute_origin : Point[Double],
) -> Double raise TaffyError {
  let inputs = layout_input_for_compute_size(
    known_dimensions,
    parent_size,
    available_space,
    sizing_mode,
    requested_axis_from_absolute(axis),
    vertical_margins_are_collapsible,
  )
  let output = self.compute_child_layout(
    node_id, inputs, absolute_origin, false,
  )
  let size = output.outer_size()
  match axis {
    Horizontal => size.width
    Vertical => size.height
  }
}

///|
fn[C] can_use_node_layout_cache(
  tree : TaffyTree[C],
  node_id : NodeId,
  absolute_origin : Point[Double],
) -> Bool {
  tree.children[node_id].length() <= 1 &&
  double_approx_equal(absolute_origin.x, 0.0) &&
  double_approx_equal(absolute_origin.y, 0.0)
}

///|
fn[C] restore_node_layout_from_cache(
  tree : TaffyTree[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  run_mode : RunMode,
  can_use_layout_cache : Bool,
) -> LayoutOutput? {
  if !can_use_layout_cache {
    return None
  }
  let node = tree.nodes[node_id]
  match
    find_node_layout_cache(
      node.cache,
      known_dimensions,
      available_space,
      run_mode,
    ) {
    Some(entry) => {
      tree.nodes[node_id].unrounded_layout = entry.layout
      tree.nodes[node_id].effective_margin_top = entry.effective_margin_top
      tree.nodes[node_id].effective_margin_bottom = entry.effective_margin_bottom
      tree.nodes[node_id].effective_margin_top_max_pos = entry.effective_margin_top_max_pos
      tree.nodes[node_id].effective_margin_top_min_neg = entry.effective_margin_top_min_neg
      tree.nodes[node_id].effective_margin_bottom_max_pos = entry.effective_margin_bottom_max_pos
      tree.nodes[node_id].effective_margin_bottom_min_neg = entry.effective_margin_bottom_min_neg
      Some(entry.content)
    }
    None => None
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
  output : LayoutOutput,
  run_mode : RunMode,
  can_use_layout_cache : Bool,
) -> Unit {
  if !can_use_layout_cache {
    return
  }
  let layout = tree.nodes[node_id].unrounded_layout
  store_node_layout_cache(tree.nodes[node_id].cache, run_mode, {
    known_dimensions,
    available_space,
    content: output,
    layout,
    effective_margin_top: tree.nodes[node_id].effective_margin_top,
    effective_margin_bottom: tree.nodes[node_id].effective_margin_bottom,
    effective_margin_top_max_pos: tree.nodes[node_id].effective_margin_top_max_pos,
    effective_margin_top_min_neg: tree.nodes[node_id].effective_margin_top_min_neg,
    effective_margin_bottom_max_pos: tree.nodes[node_id].effective_margin_bottom_max_pos,
    effective_margin_bottom_min_neg: tree.nodes[node_id].effective_margin_bottom_min_neg,
  })
}
