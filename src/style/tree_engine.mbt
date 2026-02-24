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
  let can_use_layout_cache = node.children.length() <= 1 &&
    double_approx_equal(absolute_origin.x, 0.0) &&
    double_approx_equal(absolute_origin.y, 0.0)
  if can_use_layout_cache {
    match
      find_node_layout_cache(
        node.node_layout_cache,
        known_dimensions,
        available_space,
        absolute_origin,
        is_layout_root,
      ) {
      Some(entry) => {
        tree.nodes[node_id].layout = Layout::{
          location: entry.location,
          size: entry.size,
        }
        tree.nodes[node_id].effective_margin_top = entry.effective_margin_top
        tree.nodes[node_id].effective_margin_bottom = entry.effective_margin_bottom
        tree.nodes[node_id].effective_margin_top_max_pos = entry.effective_margin_top_max_pos
        tree.nodes[node_id].effective_margin_top_min_neg = entry.effective_margin_top_min_neg
        tree.nodes[node_id].effective_margin_bottom_max_pos = entry.effective_margin_bottom_max_pos
        tree.nodes[node_id].effective_margin_bottom_min_neg = entry.effective_margin_bottom_min_neg
        return
      }
      None => ()
    }
  }
  match node.style.display {
    DisplayNone => compute_hidden_layout(tree, node_id, absolute_origin)
    DisplayGrid =>
      compute_grid_layout_with_measure(
        tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
        is_layout_root,
      )
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

  // Position::Relative: apply inset as a final offset without affecting sibling layout.
  // `display: none` nodes must remain at zero-size/zero-offset.
  if !(node.style.display is DisplayNone) {
    match node.style.position {
      PosRelative => {
        let inset = node.style.inset
        let dx = match
          resolve_optional_dimension(inset.left, available_space.width) {
          Some(v) => v
          None =>
            match
              resolve_optional_dimension(inset.right, available_space.width) {
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
  if can_use_layout_cache {
    let layout = tree.nodes[node_id].layout
    tree.nodes[node_id].node_layout_cache.push(NodeLayoutCacheEntry::{
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
}

///|
fn[C] compute_hidden_layout(
  tree : TaffyTree[C],
  node_id : NodeId,
  absolute_origin : Point[Double],
) -> Unit raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: Size::zero(),
  }
  tree.nodes[node_id].effective_margin_top = 0.0
  tree.nodes[node_id].effective_margin_bottom = 0.0
  tree.nodes[node_id].effective_margin_top_max_pos = 0.0
  tree.nodes[node_id].effective_margin_top_min_neg = 0.0
  tree.nodes[node_id].effective_margin_bottom_max_pos = 0.0
  tree.nodes[node_id].effective_margin_bottom_min_neg = 0.0
  for child_id in node.children {
    compute_hidden_layout(tree, child_id, absolute_origin)
  }
}

///|
fn[C] offset_subtree(
  tree : TaffyTree[C],
  node_id : NodeId,
  dx : Double,
  dy : Double,
) -> Unit raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let layout = node.layout
  tree.nodes[node_id].layout = Layout::{
    location: Point::{ x: layout.location.x + dx, y: layout.location.y + dy },
    size: layout.size,
  }
  for child_id in node.children {
    offset_subtree(tree, child_id, dx, dy)
  }
}

///|
fn[C] subtree_has_measure_context(
  tree : TaffyTree[C],
  node_id : NodeId,
) -> Bool raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  if node.context is Some(_) {
    return true
  }
  for child_id in node.children {
    if subtree_has_measure_context(tree, child_id) {
      return true
    }
  }
  false
}

///|
fn[C] compute_leaf_layout_with_measure(
  tree : TaffyTree[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  measure_function : (Size[Double?], Size[AvailableSpace], NodeId, C?, Style) -> Size[
    Double,
  ],
) -> Unit raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  // CSS compatibility: vertical padding/border percentages are resolved against the width.
  let resolved_padding = resolve_rect_width_basis(
    node.style.padding,
    available_space,
  )
  let resolved_border = resolve_rect_width_basis(
    node.style.border,
    available_space,
  )
  let scrollbar_w = node.style.scrollbar_width
  let scrollbar_x = match node.style.overflow.x {
    OverflowScroll => scrollbar_w
    _ => 0.0
  }
  let scrollbar_y = match node.style.overflow.y {
    OverflowScroll => scrollbar_w
    _ => 0.0
  }
  let horiz_non_scroll_inset = resolved_padding.left +
    resolved_padding.right +
    resolved_border.left +
    resolved_border.right
  let vert_non_scroll_inset = resolved_padding.top +
    resolved_padding.bottom +
    resolved_border.top +
    resolved_border.bottom
  let horiz_inset = horiz_non_scroll_inset + scrollbar_y
  let vert_inset = vert_non_scroll_inset + scrollbar_x
  let mut specified_width = resolve_optional_dimension(
    node.style.size.width,
    available_space.width,
  )
  let mut specified_height = resolve_optional_dimension(
    node.style.size.height,
    available_space.height,
  )
  let known_width = known_dimensions.width
  let known_height = known_dimensions.height

  // aspect-ratio: apply to the node's preferred size (not to known_dimensions).
  match node.style.aspect_ratio {
    Some(ratio) =>
      if ratio > 0.0 {
        match (specified_width, specified_height) {
          (Some(w), None) => specified_height = Some((w / ratio).round())
          (None, Some(h)) => specified_width = Some((h * ratio).round())
          _ => ()
        }
      }
    None => ()
  }
  let mut measure_known_dimensions = Size::new(
    width=match known_width {
      Some(w) => Some(w)
      None => specified_width
    },
    height=match known_height {
      Some(h) => Some(h)
      None => specified_height
    },
  )
  let resolved_max_width = resolve_optional_dimension(
    node.style.max_size.width,
    available_space.width,
  )
  let resolved_max_height = resolve_optional_dimension(
    node.style.max_size.height,
    available_space.height,
  )
  fn clamp_opt_to_max(v : Double?, max_v : Double?) -> Double? {
    match (v, max_v) {
      (Some(v0), Some(max0)) => Some(if v0 > max0 { max0 } else { v0 })
      _ => v
    }
  }
  measure_known_dimensions = Size::new(
    width=clamp_opt_to_max(measure_known_dimensions.width, resolved_max_width),
    height=clamp_opt_to_max(
      measure_known_dimensions.height,
      resolved_max_height,
    ),
  )
  let measure_available_space = Size::new(
    width=match (available_space.width, resolved_max_width) {
      (AvailDefinite(v), Some(max0)) =>
        AvailDefinite(if v > max0 { max0 } else { v })
      _ => available_space.width
    },
    height=match (available_space.height, resolved_max_height) {
      (AvailDefinite(v), Some(max0)) =>
        AvailDefinite(if v > max0 { max0 } else { v })
      _ => available_space.height
    },
  )
  let measured = match
    find_leaf_measure_cache(
      node.leaf_measure_cache,
      measure_known_dimensions,
      measure_available_space,
    ) {
    Some(v) => v
    None => {
      let m = measure_function(
        measure_known_dimensions,
        measure_available_space,
        node_id,
        node.context,
        node.style,
      )
      tree.nodes[node_id].leaf_measure_cache.push(LeafMeasureCacheEntry::{
        known_dimensions: measure_known_dimensions,
        available_space: measure_available_space,
        measured: m,
      })
      m
    }
  }
  let raw_width = match known_width {
    Some(w) => w
    None =>
      match specified_width {
        Some(w) => w
        None => max_double(measured.width + horiz_inset, horiz_inset)
      }
  }
  let raw_height = match known_height {
    Some(h) => h
    None =>
      match specified_height {
        Some(h) => h
        None => max_double(measured.height + vert_inset, vert_inset)
      }
  }
  let raw_border_box = Size::new(width=raw_width, height=raw_height)
  let mut border_box_size = Size::new(
    width=max_double(
      clamp_dimension(
        raw_border_box.width,
        node.style.min_size.width,
        node.style.max_size.width,
        available_space.width,
      ),
      horiz_non_scroll_inset,
    ),
    height=max_double(
      clamp_dimension(
        raw_border_box.height,
        node.style.min_size.height,
        node.style.max_size.height,
        available_space.height,
      ),
      vert_non_scroll_inset,
    ),
  )
  // aspect-ratio: when width is auto and height is constrained by min/max,
  // prefer deriving the width from the clamped height.
  match node.style.aspect_ratio {
    Some(ratio) =>
      if ratio > 0.0 {
        let width_is_auto = known_width is None && specified_width is None
        let height_is_auto = known_height is None && specified_height is None
        let resolved_min_height = resolve_optional_dimension(
          node.style.min_size.height,
          available_space.height,
        )
        let resolved_max_height = resolve_optional_dimension(
          node.style.max_size.height,
          available_space.height,
        )
        let height_is_definite = known_height is Some(_) ||
          specified_height is Some(_) ||
          (match resolved_min_height {
            Some(min_h) => raw_border_box.height <= min_h
            None => false
          }) ||
          (match resolved_max_height {
            Some(max_h) => raw_border_box.height >= max_h
            None => false
          })
        if width_is_auto && height_is_definite {
          let ratio_width = max_double(
            (border_box_size.height * ratio).round(),
            horiz_inset,
          )
          border_box_size = Size::new(
            width=max_double(
              clamp_dimension(
                ratio_width,
                node.style.min_size.width,
                node.style.max_size.width,
                available_space.width,
              ),
              horiz_inset,
            ),
            height=border_box_size.height,
          )
        } else {
          ()
        }
        if height_is_auto {
          let min_height = max_double(
            (border_box_size.width / ratio).round(),
            vert_inset,
          )
          if min_height > border_box_size.height {
            border_box_size = Size::new(
              width=border_box_size.width,
              height=min_height,
            )
          } else {
            ()
          }
        } else {
          ()
        }
        border_box_size = Size::new(
          width=max_double(
            clamp_dimension(
              border_box_size.width,
              node.style.min_size.width,
              node.style.max_size.width,
              available_space.width,
            ),
            horiz_non_scroll_inset,
          ),
          height=max_double(
            clamp_dimension(
              border_box_size.height,
              node.style.min_size.height,
              node.style.max_size.height,
              available_space.height,
            ),
            vert_non_scroll_inset,
          ),
        )
      }
    None => ()
  }
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: border_box_size,
  }
  let resolved_margin = resolve_rect_width_basis(
    node.style.margin,
    available_space,
  )
  set_effective_margin_states(
    tree,
    node_id,
    margin_collapse_state_from(resolved_margin.top),
    margin_collapse_state_from(resolved_margin.bottom),
  )
}

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
