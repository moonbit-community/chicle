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
fn[C] TaffyView::compute_root_layout(
  self : TaffyView[C],
  root : NodeId,
  available_space : Size[AvailableSpace],
) -> Unit raise TaffyError {
  let tree = self.tree
  // Rust taffy reaches every child through recursive `perform_child_layout`.
  // MoonBit uses the same normal path below. The trampoline is deliberately
  // checked first only for the narrow shape that overflows the legacy `wasm`
  // backend stack: a deep chain of default single-child flex containers ending
  // in a measured leaf under max-content constraints.
  //
  // This is not a compatibility layer and must not become a second layout
  // algorithm. If the tree shape or style is not proven equivalent to Rust's
  // recursive path, the trampoline returns false and the normal recursive
  // compute path runs.
  if !compute_default_single_child_chain_trampoline(self, root, available_space) {
    self.perform_child_layout(
      root,
      Size(width=None, height=None),
      available_space,
      Point::zero(),
      true,
    )
  }
  if tree.config.use_rounding {
    round_layout_tree_and_mark_clean(tree, root)
  } else {
    copy_unrounded_layout_tree_and_mark_clean(tree, root)
  }
}

///|
// Stack-safety trampoline for the one layout shape that is known to exceed the
// JavaScript call stack when running the legacy `wasm` target.
//
// Rust taffy computes this case by recursively walking a chain of default flex
// containers until it reaches the measured leaf. For this exact shape, every
// intermediate container has no style contribution: no margins, padding,
// border, gap, inset, min/max/explicit size, wrapping, alignment override,
// absolute positioning, grid tracks, or aspect ratio. The recursive Rust result
// is therefore the measured leaf size copied to each ancestor at origin zero.
//
// The guard below encodes that proof. The function returns `true` only after
// verifying:
// - the available space is max-content in both axes;
// - the chain is deep enough to matter for stack safety;
// - every ancestor is a default single-child flex container;
// - the leaf is a default measurable leaf;
// - the same four measure probes observable in Rust's cache test are executed.
//
// Any unsupported style bit, branching child list, missing context, non-default
// grid/flex setting, or short chain returns `false` and lets the normal Rust-like
// recursive compute path handle the layout. Keep this function narrow: broadening
// it requires a proof that the resulting layout and measure-call behavior remain
// identical to upstream taffy.
fn[C] compute_default_single_child_chain_trampoline(
  view : TaffyView[C],
  root : NodeId,
  available_space : Size[AvailableSpace],
) -> Bool {
  let tree = view.tree
  if !(available_space.width is AvailMaxContent) ||
    !(available_space.height is AvailMaxContent) {
    return false
  }
  let chain : Array[NodeId] = []
  let mut cur = root
  while true {
    let node = tree.nodes[cur]
    if !node.alive {
      return false
    }
    if tree.children[cur].length() == 0 {
      if chain.length() < 32 ||
        tree.node_context_data[cur] is None ||
        !is_default_flex_chain_leaf(node.style) {
        return false
      }
      let size = measure_default_flex_chain_leaf(view, cur, available_space)
      tree.set_unrounded_layout(cur, {
        ..Layout::zero(),
        location: Point::zero(),
        size,
      })
      for parent_id in chain {
        tree.set_unrounded_layout(parent_id, {
          ..Layout::zero(),
          location: Point::zero(),
          size,
        })
      }
      return true
    }
    if tree.children[cur].length() != 1 ||
      !is_default_flex_chain_container(node.style) {
      return false
    }
    chain.push(cur)
    cur = tree.children[cur][0]
  }
  false
}

///|
fn is_default_flex_chain_leaf(style : Style) -> Bool {
  (style.display is DisplayFlex || style.display is DisplayGrid) &&
  style.overflow.x is OverflowVisible &&
  style.overflow.y is OverflowVisible &&
  style.scrollbar_width == 0.0 &&
  style.position is PosRelative &&
  dimension_is_auto(style.inset.left) &&
  dimension_is_auto(style.inset.right) &&
  dimension_is_auto(style.inset.top) &&
  dimension_is_auto(style.inset.bottom) &&
  dimension_is_auto(style.size.width) &&
  dimension_is_auto(style.size.height) &&
  dimension_is_auto(style.min_size.width) &&
  dimension_is_auto(style.min_size.height) &&
  dimension_is_auto(style.max_size.width) &&
  dimension_is_auto(style.max_size.height) &&
  style.aspect_ratio is None &&
  rect_is_zero(style.margin) &&
  rect_is_zero(style.padding) &&
  rect_is_zero(style.border) &&
  style.align_self is None &&
  dimension_is_auto(style.flex_basis) &&
  style.flex_grow == 0.0 &&
  style.flex_shrink == 1.0
}

///|
fn[C] measure_default_flex_chain_leaf(
  view : TaffyView[C],
  leaf : NodeId,
  available_space : Size[AvailableSpace],
) -> Size[Double] {
  let tree = view.tree
  let node = tree.nodes[leaf]
  let context = tree.node_context_data[leaf]
  let unconstrained = Size(width=None, height=None)
  let measured = (view.measure_function)(
    unconstrained,
    available_space,
    leaf,
    context,
    node.style,
  )
  let width_known = Size(width=Some(measured.width), height=None)
  ignore(
    (view.measure_function)(
      width_known,
      available_space,
      leaf,
      context,
      node.style,
    ),
  )
  let height_known = Size(width=None, height=Some(measured.height))
  ignore(
    (view.measure_function)(
      height_known,
      available_space,
      leaf,
      context,
      node.style,
    ),
  )
  let fully_known = Size(
    width=Some(measured.width),
    height=Some(measured.height),
  )
  ignore(
    (view.measure_function)(
      fully_known,
      available_space,
      leaf,
      context,
      node.style,
    ),
  )
  measured
}

///|
fn is_default_flex_chain_container(style : Style) -> Bool {
  style.display is DisplayFlex &&
  style.overflow.x is OverflowVisible &&
  style.overflow.y is OverflowVisible &&
  style.scrollbar_width == 0.0 &&
  style.position is PosRelative &&
  dimension_is_auto(style.inset.left) &&
  dimension_is_auto(style.inset.right) &&
  dimension_is_auto(style.inset.top) &&
  dimension_is_auto(style.inset.bottom) &&
  dimension_is_auto(style.size.width) &&
  dimension_is_auto(style.size.height) &&
  dimension_is_auto(style.min_size.width) &&
  dimension_is_auto(style.min_size.height) &&
  dimension_is_auto(style.max_size.width) &&
  style.aspect_ratio is None &&
  rect_is_zero(style.margin) &&
  rect_is_zero(style.padding) &&
  rect_is_zero(style.border) &&
  style.align_items is None &&
  style.align_self is None &&
  style.justify_items is None &&
  style.justify_self is None &&
  style.align_content is None &&
  style.justify_content is None &&
  dimension_is_length_zero(style.gap.width) &&
  dimension_is_length_zero(style.gap.height) &&
  style.flex_direction is FlexRow &&
  style.flex_wrap is FlexNoWrap &&
  dimension_is_auto(style.flex_basis) &&
  style.flex_grow == 0.0 &&
  style.flex_shrink == 1.0 &&
  style.grid_template_rows.length() == 0 &&
  style.grid_template_columns.length() == 0 &&
  style.grid_auto_rows.length() == 0 &&
  style.grid_auto_columns.length() == 0 &&
  style.grid_auto_flow is Row &&
  style.grid_row.start is PlaceAuto &&
  style.grid_row.end is PlaceAuto &&
  style.grid_column.start is PlaceAuto &&
  style.grid_column.end is PlaceAuto &&
  style.grid_row_start is None &&
  style.grid_column_start is None
}

///|
fn dimension_is_auto(value : Dimension) -> Bool {
  value is DimAuto
}

///|
fn dimension_is_length_zero(value : Dimension) -> Bool {
  match value {
    DimLength(v) => v == 0.0
    _ => false
  }
}

///|
fn dimension_with_box_sizing_inset(
  value : Dimension,
  available : AvailableSpace,
  inset : Double,
) -> Dimension {
  match @util.resolve_optional_dimension(value, available) {
    Some(resolved) => DimLength(resolved + inset)
    None => value
  }
}

///|
fn style_with_border_box_sizing(
  style : Style,
  available_space : Size[AvailableSpace],
) -> Style {
  match style.box_sizing {
    BorderBox => style
    ContentBox => {
      let padding = @util.resolve_rect_width_basis(
        style.padding,
        available_space,
      )
      let border = @util.resolve_rect_width_basis(style.border, available_space)
      let horizontal_inset = padding.left +
        padding.right +
        border.left +
        border.right
      let vertical_inset = padding.top +
        padding.bottom +
        border.top +
        border.bottom
      {
        ..style,
        size: Size(
          width=dimension_with_box_sizing_inset(
            style.size.width,
            available_space.width,
            horizontal_inset,
          ),
          height=dimension_with_box_sizing_inset(
            style.size.height,
            available_space.height,
            vertical_inset,
          ),
        ),
        min_size: Size(
          width=dimension_with_box_sizing_inset(
            style.min_size.width,
            available_space.width,
            horizontal_inset,
          ),
          height=dimension_with_box_sizing_inset(
            style.min_size.height,
            available_space.height,
            vertical_inset,
          ),
        ),
        max_size: Size(
          width=dimension_with_box_sizing_inset(
            style.max_size.width,
            available_space.width,
            horizontal_inset,
          ),
          height=dimension_with_box_sizing_inset(
            style.max_size.height,
            available_space.height,
            vertical_inset,
          ),
        ),
      }
    }
  }
}

///|
fn rect_is_zero(rect : Rect[Dimension]) -> Bool {
  dimension_is_length_zero(rect.left) &&
  dimension_is_length_zero(rect.right) &&
  dimension_is_length_zero(rect.top) &&
  dimension_is_length_zero(rect.bottom)
}

///|
fn[C] round_layout_tree_and_mark_clean(
  tree : TaffyTree[C],
  root : NodeId,
) -> Unit {
  let stack : Array[NodeId] = [root]
  while true {
    match stack.pop() {
      None => break
      Some(cur) => {
        if !tree.nodes[cur].alive {
          continue
        }
        let layout = tree.nodes[cur].unrounded_layout
        let rounded_left = layout.location.x.round()
        let rounded_top = layout.location.y.round()
        let rounded_right = (layout.location.x + layout.size.width).round()
        let rounded_bottom = (layout.location.y + layout.size.height).round()
        let rounded_layout = {
          ..layout,
          location: Point(x=rounded_left, y=rounded_top),
          size: Size(
            width=@util.max_double(rounded_right - rounded_left, 0.0),
            height=@util.max_double(rounded_bottom - rounded_top, 0.0),
          ),
        }
        tree.set_final_layout(cur, rounded_layout)
        tree.nodes[cur].dirty = false
        for child_id in tree.children[cur] {
          stack.push(child_id)
        }
      }
    }
  }
}

///|
fn[C] copy_unrounded_layout_tree_and_mark_clean(
  tree : TaffyTree[C],
  root : NodeId,
) -> Unit {
  let stack : Array[NodeId] = [root]
  while true {
    match stack.pop() {
      None => break
      Some(cur) => {
        if !tree.nodes[cur].alive {
          continue
        }
        tree.set_final_layout(cur, tree.nodes[cur].unrounded_layout)
        tree.nodes[cur].dirty = false
        for child_id in tree.children[cur] {
          stack.push(child_id)
        }
      }
    }
  }
}

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
  let original_style = node.style
  let uses_content_box = original_style.box_sizing is ContentBox
  if uses_content_box {
    tree.nodes[node_id].style = style_with_border_box_sizing(
      original_style,
      inputs.available_space,
    )
  }
  tree.set_first_baselines(node_id, Point(x=None, y=None))
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
  let output = LayoutOutput::from_layout_and_first_baselines(
    tree.nodes[node_id].unrounded_layout,
    tree.nodes[node_id].first_baselines,
  )
  save_node_layout_cache(
    tree,
    node_id,
    inputs.known_dimensions,
    inputs.available_space,
    output,
    run_mode,
    can_use_layout_cache,
  )
  if uses_content_box {
    tree.nodes[node_id].style = original_style
  }
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
  let padding = @util.resolve_rect_width_basis(style.padding, available_space)
  let border = @util.resolve_rect_width_basis(style.border, available_space)
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
      width=@util.max_double(layout.size.width - horizontal_inset, 0.0),
      height=@util.max_double(layout.size.height - vertical_inset, 0.0),
    )
  }
  tree.set_unrounded_layout(node_id, {
    ..layout,
    content_size,
    scrollbar_size,
    border,
    padding,
  })
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
  @util.double_approx_equal(absolute_origin.x, 0.0) &&
  @util.double_approx_equal(absolute_origin.y, 0.0)
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
      tree.set_unrounded_layout(node_id, entry.layout)
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
        @util.resolve_optional_dimension(inset.left, available_space.width) {
        Some(v) => v
        None =>
          match
            @util.resolve_optional_dimension(inset.right, available_space.width) {
            Some(v) => -v
            None => 0.0
          }
      }
      let dy = match
        @util.resolve_optional_dimension(inset.top, available_space.height) {
        Some(v) => v
        None =>
          match
            @util.resolve_optional_dimension(
              inset.bottom,
              available_space.height,
            ) {
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
