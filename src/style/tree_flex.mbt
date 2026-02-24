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
fn[C] baseline_offset_y(
  tree : TaffyTree[C],
  node_id : NodeId,
) -> Double raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let node_layout = node.layout
  match node.style.display {
    DisplayBlock | DisplayGrid => node_layout.size.height
    _ =>
      if node.children.length() == 0 {
        node_layout.size.height
      } else {
        if node.style.display is DisplayFlex &&
          !is_column(node.style.flex_direction) {
          let default_align = match node.style.align_items {
            Some(v) => v
            None => ItemsStretch
          }
          let mut first_line_top : Double? = None
          for child_id in node.children {
            let child = match tree.nodes.get(child_id) {
              Some(c) => c
              None => raise InvalidNodeId(child_id)
            }
            match (child.style.display, child.style.position) {
              (DisplayNone, _) | (_, PosAbsolute) => ()
              _ => {
                let rel_top = child.layout.location.y - node_layout.location.y
                first_line_top = match first_line_top {
                  Some(v) => Some(min_double(v, rel_top))
                  None => Some(rel_top)
                }
              }
            }
          }
          match first_line_top {
            Some(first_line_top) => {
              let mut first_candidate : NodeId? = None
              let mut baseline_candidate : NodeId? = None
              for child_id in node.children {
                let child = match tree.nodes.get(child_id) {
                  Some(c) => c
                  None => raise InvalidNodeId(child_id)
                }
                match (child.style.display, child.style.position) {
                  (DisplayNone, _) | (_, PosAbsolute) => ()
                  _ => {
                    let rel_top = child.layout.location.y -
                      node_layout.location.y
                    if abs_double(rel_top - first_line_top) < 0.0001 {
                      if first_candidate is None {
                        first_candidate = Some(child_id)
                      }
                      let align = match child.style.align_self {
                        Some(v) => v
                        None => default_align
                      }
                      if baseline_candidate is None && align is ItemsBaseline {
                        baseline_candidate = Some(child_id)
                      }
                    }
                  }
                }
              }
              let chosen = match baseline_candidate {
                Some(id) => Some(id)
                None => first_candidate
              }
              match chosen {
                Some(chosen_id) => {
                  let chosen_layout = tree.nodes[chosen_id].layout
                  return chosen_layout.location.y -
                    node_layout.location.y +
                    baseline_offset_y(tree, chosen_id)
                }
                None => ()
              }
            }
            None => ()
          }
        }
        for child_id in node.children {
          let child = match tree.nodes.get(child_id) {
            Some(c) => c
            None => raise InvalidNodeId(child_id)
          }
          match child.style.display {
            DisplayNone => ()
            _ =>
              match child.style.position {
                PosAbsolute => ()
                PosRelative => {
                  let child_layout = child.layout
                  let child_margin_top = if node.style.display is DisplayFlex &&
                    is_column(node.style.flex_direction) {
                    match child.style.margin.top {
                      DimPercent(_) =>
                        resolve_dimension_width_basis(
                          child.style.margin.top,
                          node_layout.size.width,
                        )
                      _ => 0.0
                    }
                  } else {
                    0.0
                  }
                  return child_layout.location.y -
                    node_layout.location.y +
                    baseline_offset_y(tree, child_id) -
                    child_margin_top
                }
              }
          }
        }
        node_layout.size.height
      }
  }
}

///|
fn[C] grid_item_baseline_offset_y(
  tree : TaffyTree[C],
  node_id : NodeId,
) -> Double raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let node_layout = node.layout
  if node.children.length() == 0 {
    node_layout.size.height
  } else {
    for child_id in node.children {
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      match child.style.display {
        DisplayNone => ()
        _ =>
          match child.style.position {
            PosAbsolute => ()
            PosRelative => {
              let child_layout = child.layout
              return child_layout.location.y -
                node_layout.location.y +
                grid_item_baseline_offset_y(tree, child_id)
            }
          }
      }
    }
    node_layout.size.height
  }
}

///|
fn[C] resolve_flex_auto_min_main(
  tree : TaffyTree[C],
  child_id : NodeId,
  is_col : Bool,
  parent_available_for_children : Size[AvailableSpace],
  main_axis_available : AvailableSpace,
  measure_function : (Size[Double?], Size[AvailableSpace], NodeId, C?, Style) -> Size[
    Double,
  ],
) -> Double raise TaffyError {
  let child = match tree.nodes.get(child_id) {
    Some(c) => c
    None => raise InvalidNodeId(child_id)
  }
  let main_from_size = if is_col {
    resolve_optional_dimension(child.style.size.height, main_axis_available)
  } else {
    resolve_optional_dimension(child.style.size.width, main_axis_available)
  }
  let max_from_style = if is_col {
    resolve_optional_dimension(child.style.max_size.height, main_axis_available)
  } else {
    resolve_optional_dimension(child.style.max_size.width, main_axis_available)
  }
  let original_style = child.style
  let original_layout = child.layout
  let cleared_size = if is_col {
    Size::new(width=original_style.size.width, height=DimAuto)
  } else {
    Size::new(width=DimAuto, height=original_style.size.height)
  }
  tree.nodes[child_id].style = { ..original_style, size: cleared_size }
  let min_content_space = if is_col {
    Size::new(width=parent_available_for_children.width, height=AvailMinContent)
  } else {
    Size::new(
      width=AvailMinContent,
      height=parent_available_for_children.height,
    )
  }
  compute_node_layout_with_measure(
    tree,
    child_id,
    Size::new(width=None, height=None),
    min_content_space,
    Point::zero(),
    measure_function,
    false,
  )
  let min_layout = tree.layout(child_id)
  let min_content_main = if is_col {
    min_layout.size.height
  } else {
    min_layout.size.width
  }
  tree.nodes[child_id].style = original_style
  tree.nodes[child_id].layout = original_layout
  let mut clamped = min_content_main
  match main_from_size {
    Some(v) => clamped = min_double(clamped, v)
    None => ()
  }
  match max_from_style {
    Some(v) => clamped = min_double(clamped, v)
    None => ()
  }
  let resolved_padding = resolve_rect_width_basis(
    original_style.padding,
    parent_available_for_children,
  )
  let resolved_border = resolve_rect_width_basis(
    original_style.border,
    parent_available_for_children,
  )
  let padding_main_sum = if is_col {
    resolved_padding.top + resolved_padding.bottom
  } else {
    resolved_padding.left + resolved_padding.right
  }
  let border_main_sum = if is_col {
    resolved_border.top + resolved_border.bottom
  } else {
    resolved_border.left + resolved_border.right
  }
  max_double(clamped, padding_main_sum + border_main_sum)
}

///|
fn[C] resolve_wrap_line_main_sizes(
  tree : TaffyTree[C],
  flow_children : Array[NodeId],
  indices : Array[Int],
  is_col : Bool,
  container_main : Double,
  gap_main : Double,
  base_sizes : Array[Size[Double]],
  flex_grow : Array[Double],
  flex_shrink : Array[Double],
  margin_main_start : Array[Double],
  margin_main_end : Array[Double],
  min_main_sizes : Array[Double],
  max_main_sizes : Array[Double?],
  main_available_pre : AvailableSpace,
  parent_available_for_children : Size[AvailableSpace],
  measure_function : (Size[Double?], Size[AvailableSpace], NodeId, C?, Style) -> Size[
    Double,
  ],
) -> Array[Double] raise TaffyError {
  let flow_count = flow_children.length()
  let count = indices.length()
  let line_main_sizes : Array[Double] = Array::make(flow_count, 0.0)
  let line_frozen : Array[Bool] = Array::make(flow_count, false)
  let line_violations : Array[Double] = Array::make(flow_count, 0.0)
  for idx in indices {
    line_main_sizes[idx] = get_main(base_sizes[idx], is_col)
  }
  let line_gap_main = if count > 1 {
    gap_main * (count - 1).to_double()
  } else {
    0.0
  }
  let mut line_initial_used = line_gap_main
  for idx in indices {
    line_initial_used = line_initial_used +
      margin_main_start[idx] +
      margin_main_end[idx] +
      line_main_sizes[idx]
  }
  let line_initial_free_space = container_main - line_initial_used
  while true {
    let mut all_line_frozen = true
    for idx in indices {
      if !line_frozen[idx] {
        all_line_frozen = false
      }
    }
    if all_line_frozen {
      break
    }
    let mut used = line_gap_main
    for idx in indices {
      used = used +
        margin_main_start[idx] +
        margin_main_end[idx] +
        (if line_frozen[idx] {
          line_main_sizes[idx]
        } else {
          get_main(base_sizes[idx], is_col)
        })
    }
    let free_space_raw = container_main - used
    let mut sum_grow = 0.0
    let mut sum_shrink = 0.0
    let mut sum_scaled_shrink = 0.0
    for idx in indices {
      if !line_frozen[idx] {
        sum_grow = sum_grow + flex_grow[idx]
        sum_shrink = sum_shrink + flex_shrink[idx]
        sum_scaled_shrink = sum_scaled_shrink +
          get_main(base_sizes[idx], is_col) * flex_shrink[idx]
      }
    }
    let free_space = if free_space_raw > 0.0 && sum_grow > 0.0 && sum_grow < 1.0 {
      let scaled = line_initial_free_space * sum_grow
      if abs_double(scaled) < abs_double(free_space_raw) {
        scaled
      } else {
        free_space_raw
      }
    } else if free_space_raw < 0.0 && sum_shrink > 0.0 && sum_shrink < 1.0 {
      let scaled = line_initial_free_space * sum_shrink
      if abs_double(scaled) < abs_double(free_space_raw) {
        scaled
      } else {
        free_space_raw
      }
    } else {
      free_space_raw
    }
    for idx in indices {
      if !line_frozen[idx] {
        let base_main = get_main(base_sizes[idx], is_col)
        if free_space > 0.0 && sum_grow > 0.0 {
          line_main_sizes[idx] = base_main +
            free_space * (flex_grow[idx] / sum_grow)
        } else if free_space < 0.0 &&
          sum_shrink > 0.0 &&
          sum_scaled_shrink > 0.0 {
          let scaled = base_main * flex_shrink[idx]
          line_main_sizes[idx] = base_main +
            free_space * (scaled / sum_scaled_shrink)
        } else {
          line_main_sizes[idx] = base_main
        }
      }
    }
    for idx in indices {
      let child_for_min = match tree.nodes.get(flow_children[idx]) {
        Some(c) => c
        None => raise InvalidNodeId(flow_children[idx])
      }
      let has_definite_basis = resolve_optional_dimension(
          child_for_min.style.flex_basis,
          main_available_pre,
        )
        is Some(_)
      let should_resolve_auto_min = free_space < 0.0 ||
        has_definite_basis ||
        (
          double_approx_equal(free_space, 0.0) &&
          child_for_min.context is Some(_) &&
          main_available_pre is AvailMaxContent
        )
      if !line_frozen[idx] &&
        min_main_sizes[idx] < 0.0 &&
        should_resolve_auto_min {
        let auto_min = resolve_flex_auto_min_main(
          tree,
          flow_children[idx],
          is_col,
          parent_available_for_children,
          main_available_pre,
          measure_function,
        )
        min_main_sizes[idx] = auto_min
      }
    }
    let mut total_violation = 0.0
    for idx in indices {
      if !line_frozen[idx] {
        let unclamped = line_main_sizes[idx]
        let min_main = min_main_sizes[idx]
        let max_main = max_main_sizes[idx]
        let mut clamped = unclamped
        if clamped < min_main {
          clamped = min_main
        }
        match max_main {
          Some(v) => if clamped > v { clamped = v }
          None => ()
        }
        if clamped < 0.0 {
          clamped = 0.0
        }
        line_violations[idx] = clamped - unclamped
        line_main_sizes[idx] = clamped
        total_violation = total_violation + line_violations[idx]
      }
    }
    for idx in indices {
      if !line_frozen[idx] {
        if total_violation > 0.0 {
          line_frozen[idx] = line_violations[idx] > 0.0
        } else if total_violation < 0.0 {
          line_frozen[idx] = line_violations[idx] < 0.0
        } else {
          line_frozen[idx] = true
        }
      }
    }
  }
  line_main_sizes
}

///|
fn compute_single_line_auto_intrinsic_main(
  flow_count : Int,
  gap_main : Double,
  base_main_sizes : Array[Double],
  preferred_main_sizes : Array[Double?],
  min_main_sizes : Array[Double],
  max_main_sizes : Array[Double?],
  flex_grow : Array[Double],
  flex_shrink : Array[Double],
  margin_main_start : Array[Double],
  margin_main_end : Array[Double],
  content_main_sizes : Array[Double],
) -> Double {
  let mut intrinsic_main = if flow_count > 1 {
    gap_main * (flow_count - 1).to_double()
  } else {
    0.0
  }
  for i in 0..<flow_count {
    let flex_basis = base_main_sizes[i]
    let resolved_min_main = max_double(
      if min_main_sizes[i] < 0.0 {
        0.0
      } else {
        min_main_sizes[i]
      },
      flex_basis,
    )
    let clamping_basis = match preferred_main_sizes[i] {
      Some(pref) => max_double(flex_basis, pref)
      None => flex_basis
    }
    let flex_basis_min = if flex_shrink[i] == 0.0 {
      Some(clamping_basis)
    } else {
      None
    }
    let flex_basis_max = if flex_grow[i] == 0.0 {
      Some(clamping_basis)
    } else {
      None
    }
    let min_main = max_double(
      match flex_basis_min {
        Some(v) => v
        None => resolved_min_main
      },
      resolved_min_main,
    )
    let max_main = match (max_main_sizes[i], flex_basis_max) {
      (Some(a), Some(b)) => Some(min_double(a, b))
      (Some(a), None) => Some(a)
      (None, Some(b)) => Some(b)
      (None, None) => None
    }
    let contribution = match (preferred_main_sizes[i], max_main) {
      (Some(pref), Some(max_v)) if max_v <= min_main || max_v <= pref => {
        let mut v = pref
        if v > max_v {
          v = max_v
        }
        if v < min_main {
          v = min_main
        }
        v
      }
      (_, Some(max_v)) if max_v <= min_main => min_main
      _ => {
        let mut v = content_main_sizes[i]
        if v < min_main {
          v = min_main
        }
        match max_main {
          Some(max_v) => if v > max_v { v = max_v }
          None => ()
        }
        v
      }
    }
    intrinsic_main = intrinsic_main +
      margin_main_start[i] +
      contribution +
      margin_main_end[i]
  }
  intrinsic_main
}

///|
fn[C] compute_flex_layout_with_measure(
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
  let padding = resolve_rect_width_basis(node.style.padding, available_space)
  let border = resolve_rect_width_basis(node.style.border, available_space)
  let horiz_inset = padding.left + padding.right + border.left + border.right
  let vert_inset = padding.top + padding.bottom + border.top + border.bottom
  let is_col = is_column(node.style.flex_direction)
  let style_width = resolve_optional_dimension(
    node.style.size.width,
    available_space.width,
  )
  let style_height = resolve_optional_dimension(
    node.style.size.height,
    available_space.height,
  )
  let specified_width = match known_dimensions.width {
    Some(w) => Some(w)
    None => style_width
  }
  let specified_height = match known_dimensions.height {
    Some(h) => Some(h)
    None => style_height
  }
  let width_def_for_percent = known_dimensions.width is Some(_) ||
    style_width is Some(_)
  let height_def_for_percent = known_dimensions.height is Some(_) ||
    style_height is Some(_)
  let tentative_border_box_width = match specified_width {
    Some(w) => max_double(w, horiz_inset)
    None => horiz_inset
  }
  let tentative_border_box_height = match specified_height {
    Some(h) => max_double(h, vert_inset)
    None => vert_inset
  }
  let tentative_content_width = max_double(
    tentative_border_box_width - horiz_inset,
    0.0,
  )
  let tentative_content_height = max_double(
    tentative_border_box_height - vert_inset,
    0.0,
  )
  let parent_available_for_children = Size::new(
    width=if width_def_for_percent {
      AvailDefinite(tentative_content_width)
    } else {
      available_space.width
    },
    height=if height_def_for_percent {
      AvailDefinite(tentative_content_height)
    } else {
      available_space.height
    },
  )
  let flow_children : Array[NodeId] = []
  let abs_children : Array[NodeId] = []
  let hidden_children : Array[NodeId] = []
  for child_id in node.children {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => hidden_children.push(child_id)
      _ =>
        match child.style.position {
          PosAbsolute => abs_children.push(child_id)
          PosRelative => flow_children.push(child_id)
        }
    }
  }
  let flow_count = flow_children.length()
  let default_align_items = match node.style.align_items {
    Some(v) => v
    None => ItemsStretch
  }
  let base_sizes : Array[Size[Double]] = Array::make(flow_count, Size::zero())
  let cross_is_auto : Array[Bool] = Array::make(flow_count, true)
  let flex_grow : Array[Double] = Array::make(flow_count, 0.0)
  let flex_shrink : Array[Double] = Array::make(flow_count, 1.0)
  let margin_main_start : Array[Double] = Array::make(flow_count, 0.0)
  let margin_main_end : Array[Double] = Array::make(flow_count, 0.0)
  let margin_cross_start : Array[Double] = Array::make(flow_count, 0.0)
  let margin_cross_end : Array[Double] = Array::make(flow_count, 0.0)
  let margin_main_start_auto : Array[Bool] = Array::make(flow_count, false)
  let margin_main_end_auto : Array[Bool] = Array::make(flow_count, false)
  let margin_cross_start_auto : Array[Bool] = Array::make(flow_count, false)
  let margin_cross_end_auto : Array[Bool] = Array::make(flow_count, false)
  let align_for_flow : Array[AlignItems] = Array::make(
    flow_count, default_align_items,
  )
  let baseline_offsets : Array[Double] = Array::make(flow_count, 0.0)
  let base_main_sizes : Array[Double] = Array::make(flow_count, 0.0)
  let preferred_main_sizes : Array[Double?] = Array::make(flow_count, None)
  let main_size_is_known_constraint : Array[Bool] = Array::make(
    flow_count, false,
  )
  let content_main_sizes : Array[Double] = Array::make(flow_count, 0.0)
  let min_main_sizes : Array[Double] = Array::make(flow_count, 0.0)
  let max_main_sizes : Array[Double?] = Array::make(flow_count, None)
  let mut total_base_main = 0.0
  let mut total_base_margin_main = 0.0
  let mut max_cross = 0.0
  let main_available_pre = if is_col {
    parent_available_for_children.height
  } else {
    parent_available_for_children.width
  }
  let cross_available_pre = if is_col {
    parent_available_for_children.width
  } else {
    parent_available_for_children.height
  }
  let gap_main_pre = resolve_gap_main(
    node.style.gap,
    is_col,
    main_available_pre,
  )
  let gap_cross_pre = resolve_gap_cross(
    node.style.gap,
    is_col,
    cross_available_pre,
  )
  let total_gap_main_pre = if flow_count > 1 {
    gap_main_pre * (flow_count - 1).to_double()
  } else {
    0.0
  }
  let total_gap_cross_pre = if flow_count > 1 {
    gap_cross_pre * (flow_count - 1).to_double()
  } else {
    0.0
  }
  let intrinsic_main_available = match main_available_pre {
    AvailMinContent => AvailMinContent
    _ => AvailMaxContent
  }
  let intrinsic_available_for_children = if is_col {
    Size::new(
      width=parent_available_for_children.width,
      height=intrinsic_main_available,
    )
  } else {
    Size::new(
      width=intrinsic_main_available,
      height=parent_available_for_children.height,
    )
  }
  for i in 0..<flow_count {
    let child_id = flow_children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    let align = match child.style.align_self {
      Some(v) => v
      None => default_align_items
    }
    align_for_flow[i] = align
    let resolved_margin = resolve_rect_width_basis(
      child.style.margin,
      parent_available_for_children,
    )
    let resolved_padding = resolve_rect_width_basis(
      child.style.padding,
      parent_available_for_children,
    )
    let resolved_border = resolve_rect_width_basis(
      child.style.border,
      parent_available_for_children,
    )
    let padding_border_main = if is_col {
      resolved_padding.top +
      resolved_padding.bottom +
      resolved_border.top +
      resolved_border.bottom
    } else {
      resolved_padding.left +
      resolved_padding.right +
      resolved_border.left +
      resolved_border.right
    }
    let main_margin_start_auto = if is_col {
      child.style.margin.top is DimAuto
    } else {
      child.style.margin.left is DimAuto
    }
    let main_margin_end_auto = if is_col {
      child.style.margin.bottom is DimAuto
    } else {
      child.style.margin.right is DimAuto
    }
    let cross_margin_start_auto = if is_col {
      child.style.margin.left is DimAuto
    } else {
      child.style.margin.top is DimAuto
    }
    let cross_margin_end_auto = if is_col {
      child.style.margin.right is DimAuto
    } else {
      child.style.margin.bottom is DimAuto
    }
    let main_margin_start = if is_col {
      resolved_margin.top
    } else {
      resolved_margin.left
    }
    let main_margin_end = if is_col {
      resolved_margin.bottom
    } else {
      resolved_margin.right
    }
    let cross_margin_start = if is_col {
      resolved_margin.left
    } else {
      resolved_margin.top
    }
    let cross_margin_end = if is_col {
      resolved_margin.right
    } else {
      resolved_margin.bottom
    }
    let child_intrinsic_available = if is_col {
      match (specified_width, child.style.size.width) {
        (None, DimPercent(_)) =>
          Size::new(
            width=match parent_available_for_children.width {
              AvailMinContent => AvailMinContent
              _ => AvailMaxContent
            },
            height=intrinsic_available_for_children.height,
          )
        _ => intrinsic_available_for_children
      }
    } else {
      intrinsic_available_for_children
    }
    let intrinsic_known_dimensions = if child.context is Some(_) &&
      child.children.length() == 0 &&
      align is ItemsStretch {
      let intrinsic_cross_available = if is_col {
        child_intrinsic_available.width
      } else {
        child_intrinsic_available.height
      }
      match intrinsic_cross_available {
        AvailDefinite(v) => {
          let stretched = max_double(
            v - cross_margin_start - cross_margin_end,
            0.0,
          )
          if is_col {
            Size::new(width=Some(stretched), height=None)
          } else {
            Size::new(width=None, height=Some(stretched))
          }
        }
        _ => Size::new(width=None, height=None)
      }
    } else {
      Size::new(width=None, height=None)
    }
    compute_node_layout_with_measure(
      tree,
      child_id,
      intrinsic_known_dimensions,
      child_intrinsic_available,
      Point::zero(),
      measure_function,
      false,
    )
    let child_layout = tree.layout(child_id)
    content_main_sizes[i] = if is_col {
      child_layout.size.height
    } else {
      child_layout.size.width
    }
    let main_axis_available = main_available_pre
    let cross_axis_available = cross_available_pre
    let basis = resolve_optional_dimension(
      child.style.flex_basis,
      main_axis_available,
    )
    let main_from_size = if is_col {
      resolve_optional_dimension(child.style.size.height, main_axis_available)
    } else {
      resolve_optional_dimension(child.style.size.width, main_axis_available)
    }
    let max_from_style = if is_col {
      resolve_optional_dimension(
        child.style.max_size.height,
        main_axis_available,
      )
    } else {
      resolve_optional_dimension(
        child.style.max_size.width,
        main_axis_available,
      )
    }
    let mut main = match basis {
      Some(v) => v
      None =>
        match main_from_size {
          Some(v) => v
          None =>
            if is_col {
              child_layout.size.height
            } else {
              child_layout.size.width
            }
        }
    }
    if basis is None &&
      main_from_size is None &&
      child.children.length() == 0 &&
      child.context is None &&
      child.style.aspect_ratio is None {
      main = padding_border_main
    }
    if main < padding_border_main {
      main = padding_border_main
    }
    main_size_is_known_constraint[i] = basis is Some(_) ||
      main_from_size is Some(_)
    base_main_sizes[i] = main
    preferred_main_sizes[i] = main_from_size
    max_main_sizes[i] = max_from_style
    let cross_from_size = if is_col {
      match child.style.size.width {
        DimPercent(_) =>
          if specified_width is None {
            None
          } else {
            resolve_optional_dimension(
              child.style.size.width,
              cross_axis_available,
            )
          }
        _ =>
          resolve_optional_dimension(
            child.style.size.width,
            cross_axis_available,
          )
      }
    } else {
      resolve_optional_dimension(child.style.size.height, cross_axis_available)
    }
    let cross = match cross_from_size {
      Some(v) => v
      None =>
        if is_col {
          child_layout.size.width
        } else {
          child_layout.size.height
        }
    }
    base_sizes[i] = make_size_from_main_cross(main, cross, is_col)
    cross_is_auto[i] = match cross_from_size {
      Some(_) => false
      None => true
    }
    flex_grow[i] = child.style.flex_grow
    flex_shrink[i] = child.style.flex_shrink
    margin_main_start[i] = main_margin_start
    margin_main_end[i] = main_margin_end
    margin_cross_start[i] = cross_margin_start
    margin_cross_end[i] = cross_margin_end
    margin_main_start_auto[i] = main_margin_start_auto
    margin_main_end_auto[i] = main_margin_end_auto
    margin_cross_start_auto[i] = cross_margin_start_auto
    margin_cross_end_auto[i] = cross_margin_end_auto
    total_base_main = total_base_main + main
    total_base_margin_main = total_base_margin_main +
      main_margin_start +
      main_margin_end
    max_cross = max_double(
      max_cross,
      cross + cross_margin_start + cross_margin_end,
    )
    if !is_col {
      match align {
        ItemsBaseline => baseline_offsets[i] = baseline_offset_y(tree, child_id)
        _ => ()
      }
    }
    let min_from_style = if is_col {
      resolve_optional_dimension(
        child.style.min_size.height,
        main_axis_available,
      )
    } else {
      resolve_optional_dimension(
        child.style.min_size.width,
        main_axis_available,
      )
    }
    let overflow_main = if is_col {
      child.style.overflow.y
    } else {
      child.style.overflow.x
    }
    min_main_sizes[i] = match min_from_style {
      Some(v) => max_double(v, 0.0)
      None =>
        match overflow_main {
          OverflowVisible => -1.0
          _ => 0.0
        }
    }
  }
  if !is_col {
    let mut baseline_before_max = 0.0
    let mut baseline_after_max = 0.0
    for i in 0..<flow_count {
      match align_for_flow[i] {
        ItemsBaseline => {
          let cross = get_cross(base_sizes[i], is_col)
          let baseline = baseline_offsets[i]
          let after_inner = cross - baseline
          let after_inner = if after_inner > 0.0 { after_inner } else { 0.0 }
          let before = margin_cross_start[i] + baseline
          let after = margin_cross_end[i] + after_inner
          baseline_before_max = max_double(baseline_before_max, before)
          baseline_after_max = max_double(baseline_after_max, after)
        }
        _ => ()
      }
    }
    max_cross = max_double(max_cross, baseline_before_max + baseline_after_max)
  }
  let total_base_outer_main = total_base_main + total_base_margin_main
  // Container sizing (border-box)
  let raw_width = match specified_width {
    Some(w) => max_double(w, horiz_inset)
    None =>
      if is_col {
        max_double(max_cross + total_gap_cross_pre + horiz_inset, horiz_inset)
      } else {
        max_double(
          total_base_outer_main + total_gap_main_pre + horiz_inset,
          horiz_inset,
        )
      }
  }
  let raw_height = match specified_height {
    Some(h) => max_double(h, vert_inset)
    None =>
      if is_col {
        max_double(
          total_base_outer_main + total_gap_main_pre + vert_inset,
          vert_inset,
        )
      } else {
        max_double(max_cross + total_gap_cross_pre + vert_inset, vert_inset)
      }
  }
  let mut border_box_width = clamp_dimension(
    raw_width,
    node.style.min_size.width,
    node.style.max_size.width,
    available_space.width,
  )
  let mut border_box_height = clamp_dimension(
    raw_height,
    node.style.min_size.height,
    node.style.max_size.height,
    available_space.height,
  )
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: Size::new(width=border_box_width, height=border_box_height),
  }
  let mut content_width = max_double(border_box_width - horiz_inset, 0.0)
  let mut content_height = max_double(border_box_height - vert_inset, 0.0)

  // Resolve gaps again now that the container's content size is known
  let main_available_final = if flow_count > 1 {
    if is_col {
      AvailDefinite(content_height)
    } else {
      AvailDefinite(content_width)
    }
  } else if is_col {
    resolve_available_for_percent(height_def_for_percent, content_height)
  } else {
    resolve_available_for_percent(width_def_for_percent, content_width)
  }
  let cross_available_final = if is_col {
    resolve_available_for_percent(width_def_for_percent, content_width)
  } else {
    resolve_available_for_percent(height_def_for_percent, content_height)
  }
  let gap_main = resolve_gap_main(node.style.gap, is_col, main_available_final)
  let gap_cross = resolve_gap_cross(
    node.style.gap,
    is_col,
    cross_available_final,
  )
  let justify = match node.style.justify_content {
    Some(j) => j
    None => AlignFlexStart
  }
  let is_reverse = match node.style.flex_direction {
    FlexRowReverse | FlexColumnReverse => true
    _ => false
  }
  let base_x = absolute_origin.x + border.left + padding.left
  let base_y = absolute_origin.y + border.top + padding.top
  let mut container_main = if is_col { content_height } else { content_width }
  let mut container_cross = if is_col { content_width } else { content_height }
  let is_wrap = match node.style.flex_wrap {
    FlexNoWrap => false
    _ => true
  }
  let is_wrap_reverse = node.style.flex_wrap is FlexWrapReverse
  let main_is_definite = if is_col {
    specified_height is Some(_)
  } else {
    specified_width is Some(_)
  }
  let cross_is_auto_container = if is_col {
    specified_width is None
  } else {
    specified_height is None
  }
  if is_wrap && main_is_definite && flow_count > 0 {
    // Build flex lines (single pass, simplified).
    let lines : Array[Array[Int]] = []
    let line_crosses : Array[Double] = []
    let line_baseline_befores : Array[Double] = []
    let mut current_line : Array[Int] = []
    let mut current_outer_main = 0.0
    let mut current_cross = 0.0
    let mut current_baseline_before = 0.0
    let mut current_baseline_after = 0.0
    for i in 0..<flow_count {
      let mut main = get_main(base_sizes[i], is_col)
      let min_main_for_wrap = if min_main_sizes[i] < 0.0 {
        0.0
      } else {
        min_main_sizes[i]
      }
      if main < min_main_for_wrap {
        main = min_main_for_wrap
      }
      match max_main_sizes[i] {
        Some(max_main) => if main > max_main { main = max_main }
        None => ()
      }
      let cross = get_cross(base_sizes[i], is_col)
      let outer_main = margin_main_start[i] + main + margin_main_end[i]
      let outer_cross = margin_cross_start[i] + cross + margin_cross_end[i]
      let mut item_before = 0.0
      let mut item_after = 0.0
      if !is_col {
        match align_for_flow[i] {
          ItemsBaseline => {
            let baseline = baseline_offsets[i]
            let after_inner = cross - baseline
            let after_inner = if after_inner > 0.0 { after_inner } else { 0.0 }
            item_before = margin_cross_start[i] + baseline
            item_after = margin_cross_end[i] + after_inner
          }
          _ => ()
        }
      }
      if current_line.length() == 0 {
        current_line.push(i)
        current_outer_main = outer_main
        current_cross = outer_cross
        current_baseline_before = item_before
        current_baseline_after = item_after
        current_cross = max_double(
          current_cross,
          current_baseline_before + current_baseline_after,
        )
      } else {
        let tentative = current_outer_main + gap_main + outer_main
        if tentative > container_main {
          lines.push(current_line)
          line_crosses.push(current_cross)
          line_baseline_befores.push(current_baseline_before)
          current_line = []
          current_line.push(i)
          current_outer_main = outer_main
          current_cross = outer_cross
          current_baseline_before = item_before
          current_baseline_after = item_after
          current_cross = max_double(
            current_cross,
            current_baseline_before + current_baseline_after,
          )
        } else {
          current_line.push(i)
          current_outer_main = tentative
          current_cross = max_double(current_cross, outer_cross)
          current_baseline_before = max_double(
            current_baseline_before, item_before,
          )
          current_baseline_after = max_double(
            current_baseline_after, item_after,
          )
          current_cross = max_double(
            current_cross,
            current_baseline_before + current_baseline_after,
          )
        }
      }
    }
    if current_line.length() > 0 {
      lines.push(current_line)
      line_crosses.push(current_cross)
      line_baseline_befores.push(current_baseline_before)
    }
    let line_count = lines.length()
    let mut total_lines_cross = 0.0
    for c in line_crosses {
      total_lines_cross = total_lines_cross + c
    }
    let total_cross_gaps = if line_count > 1 {
      gap_cross * (line_count - 1).to_double()
    } else {
      0.0
    }
    total_lines_cross = total_lines_cross + total_cross_gaps

    // If the container's cross size is auto, compute it from wrapped line sizes.
    if cross_is_auto_container {
      if is_col {
        border_box_width = clamp_dimension(
          max_double(total_lines_cross + horiz_inset, horiz_inset),
          node.style.min_size.width,
          node.style.max_size.width,
          available_space.width,
        )
        content_width = max_double(border_box_width - horiz_inset, 0.0)
      } else {
        border_box_height = clamp_dimension(
          max_double(total_lines_cross + vert_inset, vert_inset),
          node.style.min_size.height,
          node.style.max_size.height,
          available_space.height,
        )
        content_height = max_double(border_box_height - vert_inset, 0.0)
      }
      tree.nodes[node_id].layout = Layout::{
        location: absolute_origin,
        size: Size::new(width=border_box_width, height=border_box_height),
      }
      container_main = if is_col { content_height } else { content_width }
      container_cross = if is_col { content_width } else { content_height }
    }
    let align_content = match node.style.align_content {
      Some(v) => v
      None => AlignStretch
    }
    let leftover_cross = container_cross - total_lines_cross
    let distributable_cross = if leftover_cross > 0.0 {
      leftover_cross
    } else {
      0.0
    }
    let extra_per_line = match align_content {
      AlignStretch =>
        if line_count > 0 {
          distributable_cross / line_count.to_double()
        } else {
          0.0
        }
      _ => 0.0
    }
    let mut start_cross = 0.0
    let mut extra_gap_cross = 0.0
    match align_content {
      AlignStretch => ()
      AlignCenter => start_cross = leftover_cross / 2.0
      AlignFlexEnd | AlignEnd => start_cross = leftover_cross
      AlignSpaceBetween =>
        if line_count > 1 {
          extra_gap_cross = distributable_cross / (line_count - 1).to_double()
        }
      AlignSpaceAround =>
        if line_count > 0 {
          extra_gap_cross = distributable_cross / line_count.to_double()
          start_cross = extra_gap_cross / 2.0
        }
      AlignSpaceEvenly =>
        if line_count > 0 {
          extra_gap_cross = distributable_cross / (line_count + 1).to_double()
          start_cross = extra_gap_cross
        }
      _ => ()
    }
    let line_cross_sizes : Array[Double] = Array::make(line_count, 0.0)
    for li in 0..<line_count {
      line_cross_sizes[li] = line_crosses[li] + extra_per_line
    }
    let line_offsets : Array[Double] = Array::make(line_count, 0.0)
    let mut cross_cursor = start_cross
    for li in 0..<line_count {
      line_offsets[li] = cross_cursor
      cross_cursor = cross_cursor +
        line_cross_sizes[li] +
        gap_cross +
        extra_gap_cross
    }
    if is_wrap_reverse {
      for li in 0..<line_count {
        line_offsets[li] = container_cross -
          line_offsets[li] -
          line_cross_sizes[li]
      }
    }
    let child_available_for_final = Size::new(
      width=AvailDefinite(content_width),
      height=AvailDefinite(content_height),
    )
    for li in 0..<line_count {
      let indices = lines[li]
      let count = indices.length()
      let line_cross = line_cross_sizes[li]
      let line_offset = line_offsets[li]
      let baseline_before_max = line_baseline_befores[li]
      let line_main_sizes = resolve_wrap_line_main_sizes(
        tree, flow_children, indices, is_col, container_main, gap_main, base_sizes,
        flex_grow, flex_shrink, margin_main_start, margin_main_end, min_main_sizes,
        max_main_sizes, main_available_pre, parent_available_for_children, measure_function,
      )
      let mut line_used = 0.0
      for idx in indices {
        let main = line_main_sizes[idx]
        line_used = line_used +
          margin_main_start[idx] +
          main +
          margin_main_end[idx]
      }
      if count > 1 {
        line_used = line_used + gap_main * (count - 1).to_double()
      }
      let line_leftover = container_main - line_used
      let auto_main_start_values : Array[Double] = Array::make(flow_count, 0.0)
      let auto_main_end_values : Array[Double] = Array::make(flow_count, 0.0)
      let mut line_leftover_for_justify = line_leftover
      let mut main_auto_count = 0
      for idx in indices {
        if margin_main_start_auto[idx] {
          main_auto_count = main_auto_count + 1
        }
        if margin_main_end_auto[idx] {
          main_auto_count = main_auto_count + 1
        }
      }
      if main_auto_count > 0 && line_leftover > 0.0 {
        let share = line_leftover / main_auto_count.to_double()
        for idx in indices {
          if margin_main_start_auto[idx] {
            auto_main_start_values[idx] = share
          }
          if margin_main_end_auto[idx] {
            auto_main_end_values[idx] = share
          }
        }
        line_leftover_for_justify = 0.0
      }
      let distributable_line_leftover = if line_leftover_for_justify > 0.0 {
        line_leftover_for_justify
      } else {
        0.0
      }
      let mut extra_between = 0.0
      let start_main = match justify {
        AlignSpaceBetween =>
          if count > 1 {
            extra_between = distributable_line_leftover /
              (count - 1).to_double()
            0.0
          } else {
            0.0
          }
        AlignSpaceAround =>
          if count > 0 {
            extra_between = distributable_line_leftover / count.to_double()
            extra_between / 2.0
          } else {
            0.0
          }
        AlignSpaceEvenly =>
          if count > 0 {
            extra_between = distributable_line_leftover /
              (count + 1).to_double()
            extra_between
          } else {
            0.0
          }
        _ =>
          resolve_justify_start_main(
            justify, line_leftover_for_justify, is_reverse,
          )
      }
      let actual_gap_main = gap_main + extra_between
      let mut main_cursor = if is_reverse {
        container_main - start_main
      } else {
        start_main
      }
      for idx in indices {
        let child_id = flow_children[idx]
        let child = match tree.nodes.get(child_id) {
          Some(c) => c
          None => raise InvalidNodeId(child_id)
        }
        let main_size = line_main_sizes[idx]
        let align = match child.style.align_self {
          Some(v) => v
          None =>
            match node.style.align_items {
              Some(v) => v
              None => ItemsStretch
            }
        }
        let intrinsic_cross = get_cross(base_sizes[idx], is_col)
        let available_cross_for_item = line_cross -
          margin_cross_start[idx] -
          margin_cross_end[idx]
        let stretch_cross_available = max_double(available_cross_for_item, 0.0)
        let cross_size_is_auto = if is_col {
          child.style.size.width is DimAuto
        } else {
          child.style.size.height is DimAuto
        }
        let mut cross_size = match align {
          ItemsStretch =>
            if cross_size_is_auto {
              stretch_cross_available
            } else {
              intrinsic_cross
            }
          _ =>
            if cross_size_is_auto {
              let child_wraps = match child.style.flex_wrap {
                FlexNoWrap => false
                _ => true
              }
              if child.children.length() > 0 && child_wraps {
                min_double(intrinsic_cross, stretch_cross_available)
              } else {
                intrinsic_cross
              }
            } else {
              intrinsic_cross
            }
        }
        let cross_axis_available = if is_col {
          child_available_for_final.width
        } else {
          child_available_for_final.height
        }
        let cross_min = if is_col {
          resolve_optional_dimension(
            child.style.min_size.width,
            cross_axis_available,
          )
        } else {
          resolve_optional_dimension(
            child.style.min_size.height,
            cross_axis_available,
          )
        }
        let cross_max = if is_col {
          resolve_optional_dimension(
            child.style.max_size.width,
            cross_axis_available,
          )
        } else {
          resolve_optional_dimension(
            child.style.max_size.height,
            cross_axis_available,
          )
        }
        match cross_min {
          Some(v) => if cross_size < v { cross_size = v }
          None => ()
        }
        match cross_max {
          Some(v) => if cross_size > v { cross_size = v }
          None => ()
        }
        if cross_size < 0.0 {
          cross_size = 0.0
        }
        let mut auto_cross_start = 0.0
        let mut auto_cross_count = 0
        if margin_cross_start_auto[idx] {
          auto_cross_count = auto_cross_count + 1
        }
        if margin_cross_end_auto[idx] {
          auto_cross_count = auto_cross_count + 1
        }
        if auto_cross_count > 0 {
          let remaining_cross = available_cross_for_item - cross_size
          if auto_cross_count == 2 {
            if remaining_cross > 0.0 {
              auto_cross_start = remaining_cross / 2.0
            } else {
              auto_cross_start = 0.0
            }
          } else if margin_cross_start_auto[idx] {
            auto_cross_start = if remaining_cross > 0.0 {
              remaining_cross
            } else {
              0.0
            }
          } else {
            ()
          }
        }
        let cross_pos_in_available = if auto_cross_count > 0 {
          auto_cross_start
        } else {
          match align {
            ItemsBaseline =>
              if !is_col {
                baseline_before_max -
                margin_cross_start[idx] -
                baseline_offsets[idx]
              } else {
                0.0
              }
            ItemsEnd | ItemsFlexEnd => available_cross_for_item - cross_size
            ItemsCenter => (available_cross_for_item - cross_size) / 2.0
            _ => 0.0
          }
        }
        let cross_pos_in_available = if is_wrap_reverse {
          available_cross_for_item - cross_size - cross_pos_in_available
        } else {
          cross_pos_in_available
        }
        let cross_offset = line_offset +
          margin_cross_start[idx] +
          cross_pos_in_available
        let item_main_margin_start = margin_main_start[idx] +
          auto_main_start_values[idx]
        let item_main_margin_end = margin_main_end[idx] +
          auto_main_end_values[idx]
        let main_pos = if is_reverse {
          main_cursor = main_cursor - item_main_margin_end - main_size
          let pos = main_cursor + item_main_margin_start
          main_cursor = main_cursor - item_main_margin_start - actual_gap_main
          pos
        } else {
          let pos = main_cursor + item_main_margin_start
          main_cursor = main_cursor +
            item_main_margin_start +
            main_size +
            item_main_margin_end +
            actual_gap_main
          pos
        }
        let has_measure_context = tree.nodes[child_id].context is Some(_)
        let known_width = if has_measure_context {
          let main_changed = abs_double(main_size - base_main_sizes[idx]) >
            0.0001
          let main_known = if main_size_is_known_constraint[idx] || main_changed {
            Some(main_size)
          } else {
            None
          }
          let cross_known = if !cross_is_auto[idx] {
            Some(cross_size)
          } else {
            match align {
              ItemsStretch =>
                if cross_is_auto_container &&
                  main_is_definite &&
                  flow_count == 1 {
                  None
                } else {
                  Some(cross_size)
                }
              _ => None
            }
          }
          if is_col {
            cross_known
          } else {
            main_known
          }
        } else {
          let main_changed = abs_double(main_size - base_main_sizes[idx]) >
            0.0001
          let child_wraps = match child.style.flex_wrap {
            FlexNoWrap => false
            _ => true
          }
          let allow_auto_main = child.children.length() > 0 &&
            child_wraps &&
            !main_size_is_known_constraint[idx] &&
            !main_changed
          let main_known = if allow_auto_main { None } else { Some(main_size) }
          if is_col {
            Some(cross_size)
          } else {
            main_known
          }
        }
        let known_height = if has_measure_context {
          let main_changed = abs_double(main_size - base_main_sizes[idx]) >
            0.0001
          let main_known = if main_size_is_known_constraint[idx] || main_changed {
            Some(main_size)
          } else {
            None
          }
          let cross_known = if !cross_is_auto[idx] {
            Some(cross_size)
          } else {
            match align {
              ItemsStretch =>
                if cross_is_auto_container &&
                  main_is_definite &&
                  flow_count == 1 {
                  None
                } else {
                  Some(cross_size)
                }
              _ => None
            }
          }
          if is_col {
            main_known
          } else {
            cross_known
          }
        } else {
          let main_changed = abs_double(main_size - base_main_sizes[idx]) >
            0.0001
          let child_wraps = match child.style.flex_wrap {
            FlexNoWrap => false
            _ => true
          }
          let allow_auto_main = child.children.length() > 0 &&
            child_wraps &&
            !main_size_is_known_constraint[idx] &&
            !main_changed
          let main_known = if allow_auto_main { None } else { Some(main_size) }
          if is_col {
            main_known
          } else {
            Some(cross_size)
          }
        }
        let child_origin = if is_col {
          Point::new(x=base_x + cross_offset, y=base_y + main_pos)
        } else {
          Point::new(x=base_x + main_pos, y=base_y + cross_offset)
        }
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size::new(width=known_width, height=known_height),
          child_available_for_final,
          child_origin,
          measure_function,
          false,
        )
      }
    }
  } else {
    // Single-line flex layout
    let total_gap_main = if flow_count > 1 {
      gap_main * (flow_count - 1).to_double()
    } else {
      0.0
    }
    if flow_count > 1 &&
      !main_is_definite &&
      !is_wrap &&
      (match justify {
        AlignFlexStart | AlignStart => true
        _ => false
      }) &&
      !subtree_has_measure_context(tree, node_id) {
      let intrinsic_main = compute_single_line_auto_intrinsic_main(
        flow_count, gap_main_pre, base_main_sizes, preferred_main_sizes, min_main_sizes,
        max_main_sizes, flex_grow, flex_shrink, margin_main_start, margin_main_end,
        content_main_sizes,
      )
      if intrinsic_main > container_main {
        if is_col {
          border_box_height = clamp_dimension(
            max_double(intrinsic_main + vert_inset, vert_inset),
            node.style.min_size.height,
            node.style.max_size.height,
            available_space.height,
          )
          content_height = max_double(border_box_height - vert_inset, 0.0)
          container_main = content_height
        } else {
          border_box_width = clamp_dimension(
            max_double(intrinsic_main + horiz_inset, horiz_inset),
            node.style.min_size.width,
            node.style.max_size.width,
            available_space.width,
          )
          content_width = max_double(border_box_width - horiz_inset, 0.0)
          container_main = content_width
        }
        tree.nodes[node_id].layout = Layout::{
          location: absolute_origin,
          size: Size::new(width=border_box_width, height=border_box_height),
        }
      }
    }

    // Flex grow/shrink (single-line, simplified)
    let final_main_sizes : Array[Double] = Array::make(flow_count, 0.0)
    let frozen : Array[Bool] = Array::make(flow_count, false)
    let violations : Array[Double] = Array::make(flow_count, 0.0)
    let mut initial_used = total_gap_main
    for i in 0..<flow_count {
      initial_used = initial_used +
        margin_main_start[i] +
        margin_main_end[i] +
        base_main_sizes[i]
    }
    let initial_free_space = container_main - initial_used
    for i in 0..<flow_count {
      final_main_sizes[i] = base_main_sizes[i]
    }
    while true {
      let mut all_frozen = true
      for i in 0..<flow_count {
        if !frozen[i] {
          all_frozen = false
        }
      }
      if all_frozen {
        break
      }
      let mut used = total_gap_main
      for i in 0..<flow_count {
        used = used +
          margin_main_start[i] +
          margin_main_end[i] +
          (if frozen[i] { final_main_sizes[i] } else { base_main_sizes[i] })
      }
      let free_space = container_main - used
      let mut sum_grow = 0.0
      let mut sum_shrink = 0.0
      let mut sum_scaled_shrink = 0.0
      for i in 0..<flow_count {
        if !frozen[i] {
          sum_grow = sum_grow + flex_grow[i]
          sum_shrink = sum_shrink + flex_shrink[i]
          sum_scaled_shrink = sum_scaled_shrink +
            base_main_sizes[i] * flex_shrink[i]
        }
      }
      let free_space = if free_space > 0.0 && sum_grow > 0.0 && sum_grow < 1.0 {
        let scaled = initial_free_space * sum_grow
        if abs_double(scaled) < abs_double(free_space) {
          scaled
        } else {
          free_space
        }
      } else if free_space < 0.0 && sum_shrink > 0.0 && sum_shrink < 1.0 {
        let scaled = initial_free_space * sum_shrink
        if abs_double(scaled) < abs_double(free_space) {
          scaled
        } else {
          free_space
        }
      } else {
        free_space
      }
      for i in 0..<flow_count {
        if !frozen[i] {
          let base_main = base_main_sizes[i]
          if free_space > 0.0 && sum_grow > 0.0 {
            final_main_sizes[i] = base_main +
              free_space * (flex_grow[i] / sum_grow)
          } else if free_space < 0.0 &&
            sum_shrink > 0.0 &&
            sum_scaled_shrink > 0.0 {
            let scaled = base_main * flex_shrink[i]
            final_main_sizes[i] = base_main +
              free_space * (scaled / sum_scaled_shrink)
          } else {
            final_main_sizes[i] = base_main
          }
        }
      }
      for i in 0..<flow_count {
        let child_for_min = match tree.nodes.get(flow_children[i]) {
          Some(c) => c
          None => raise InvalidNodeId(flow_children[i])
        }
        let has_definite_basis = resolve_optional_dimension(
            child_for_min.style.flex_basis,
            main_available_pre,
          )
          is Some(_)
        let should_resolve_auto_min = free_space < 0.0 ||
          has_definite_basis ||
          (
            double_approx_equal(free_space, 0.0) &&
            child_for_min.context is Some(_) &&
            main_available_pre is AvailMaxContent &&
            cross_available_pre is AvailMaxContent
          )
        if !frozen[i] && min_main_sizes[i] < 0.0 && should_resolve_auto_min {
          let auto_min = resolve_flex_auto_min_main(
            tree,
            flow_children[i],
            is_col,
            parent_available_for_children,
            main_available_pre,
            measure_function,
          )
          min_main_sizes[i] = auto_min
        }
      }
      let mut total_violation = 0.0
      for i in 0..<flow_count {
        if !frozen[i] {
          let unclamped = final_main_sizes[i]
          let min_main = min_main_sizes[i]
          let max_main = max_main_sizes[i]
          let mut clamped = unclamped
          if clamped < min_main {
            clamped = min_main
          }
          match max_main {
            Some(v) => if clamped > v { clamped = v }
            None => ()
          }
          if clamped < 0.0 {
            clamped = 0.0
          }
          violations[i] = clamped - unclamped
          final_main_sizes[i] = clamped
          total_violation = total_violation + violations[i]
        }
      }
      for i in 0..<flow_count {
        if !frozen[i] {
          if total_violation > 0.0 {
            frozen[i] = violations[i] > 0.0
          } else if total_violation < 0.0 {
            frozen[i] = violations[i] < 0.0
          } else {
            frozen[i] = true
          }
        }
      }
    }

    // Justify content (single-line)
    let mut used_main = 0.0
    for i in 0..<flow_count {
      used_main = used_main +
        final_main_sizes[i] +
        margin_main_start[i] +
        margin_main_end[i]
    }
    let leftover = container_main - used_main - total_gap_main
    let auto_main_start_values : Array[Double] = Array::make(flow_count, 0.0)
    let auto_main_end_values : Array[Double] = Array::make(flow_count, 0.0)
    let mut leftover_for_justify = leftover
    let mut main_auto_count = 0
    for i in 0..<flow_count {
      if margin_main_start_auto[i] {
        main_auto_count = main_auto_count + 1
      }
      if margin_main_end_auto[i] {
        main_auto_count = main_auto_count + 1
      }
    }
    if main_auto_count > 0 && leftover > 0.0 {
      let share = leftover / main_auto_count.to_double()
      for i in 0..<flow_count {
        if margin_main_start_auto[i] {
          auto_main_start_values[i] = share
        }
        if margin_main_end_auto[i] {
          auto_main_end_values[i] = share
        }
      }
      leftover_for_justify = 0.0
    }
    let distributable_leftover = if leftover_for_justify > 0.0 {
      leftover_for_justify
    } else {
      0.0
    }
    let mut extra_between = 0.0
    let start_main = match justify {
      AlignSpaceBetween =>
        if flow_count > 1 {
          extra_between = distributable_leftover / (flow_count - 1).to_double()
          0.0
        } else {
          0.0
        }
      AlignSpaceAround =>
        if flow_count > 0 {
          extra_between = distributable_leftover / flow_count.to_double()
          extra_between / 2.0
        } else {
          0.0
        }
      AlignSpaceEvenly =>
        if flow_count > 0 {
          extra_between = distributable_leftover / (flow_count + 1).to_double()
          extra_between
        } else {
          0.0
        }
      _ => resolve_justify_start_main(justify, leftover_for_justify, is_reverse)
    }
    let actual_gap_main = gap_main + extra_between
    let child_available_for_final = Size::new(
      width=AvailDefinite(content_width),
      height=AvailDefinite(content_height),
    )
    let container_cross_for_placement = {
      let s = tree.nodes[node_id].layout.size
      if is_col {
        max_double(s.width - horiz_inset, 0.0)
      } else {
        max_double(s.height - vert_inset, 0.0)
      }
    }
    let mut baseline_before_max = 0.0
    if !is_col {
      let mut baseline_after_max = 0.0
      for i in 0..<flow_count {
        match align_for_flow[i] {
          ItemsBaseline => {
            let cross = get_cross(base_sizes[i], is_col)
            let baseline = baseline_offsets[i]
            let after_inner = cross - baseline
            let after_inner = if after_inner > 0.0 { after_inner } else { 0.0 }
            let before = margin_cross_start[i] + baseline
            let after = margin_cross_end[i] + after_inner
            baseline_before_max = max_double(baseline_before_max, before)
            baseline_after_max = max_double(baseline_after_max, after)
          }
          _ => ()
        }
      }
    }
    let mut cursor = if is_reverse {
      container_main - start_main
    } else {
      start_main
    }
    for i in 0..<flow_count {
      let child_id = flow_children[i]
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      let main_size = final_main_sizes[i]
      let align = match child.style.align_self {
        Some(v) => v
        None =>
          match node.style.align_items {
            Some(v) => v
            None => ItemsStretch
          }
      }
      let intrinsic_cross = get_cross(base_sizes[i], is_col)
      let available_cross_for_item = container_cross_for_placement -
        margin_cross_start[i] -
        margin_cross_end[i]
      let stretch_cross_available = max_double(available_cross_for_item, 0.0)
      let cross_size_is_auto = if is_col {
        child.style.size.width is DimAuto
      } else {
        child.style.size.height is DimAuto
      }
      let mut cross_size = match align {
        ItemsStretch =>
          if cross_size_is_auto {
            stretch_cross_available
          } else {
            intrinsic_cross
          }
        _ =>
          if cross_size_is_auto {
            let child_wraps = match child.style.flex_wrap {
              FlexNoWrap => false
              _ => true
            }
            if child.children.length() > 0 && child_wraps {
              min_double(intrinsic_cross, stretch_cross_available)
            } else {
              intrinsic_cross
            }
          } else {
            intrinsic_cross
          }
      }
      let cross_axis_available = if is_col {
        child_available_for_final.width
      } else {
        child_available_for_final.height
      }
      let cross_min = if is_col {
        resolve_optional_dimension(
          child.style.min_size.width,
          cross_axis_available,
        )
      } else {
        resolve_optional_dimension(
          child.style.min_size.height,
          cross_axis_available,
        )
      }
      let cross_max = if is_col {
        resolve_optional_dimension(
          child.style.max_size.width,
          cross_axis_available,
        )
      } else {
        resolve_optional_dimension(
          child.style.max_size.height,
          cross_axis_available,
        )
      }
      match cross_min {
        Some(v) => if cross_size < v { cross_size = v }
        None => ()
      }
      match cross_max {
        Some(v) => if cross_size > v { cross_size = v }
        None => ()
      }
      if cross_size < 0.0 {
        cross_size = 0.0
      }
      let mut auto_cross_start = 0.0
      let mut auto_cross_count = 0
      if margin_cross_start_auto[i] {
        auto_cross_count = auto_cross_count + 1
      }
      if margin_cross_end_auto[i] {
        auto_cross_count = auto_cross_count + 1
      }
      if auto_cross_count > 0 {
        let remaining_cross = available_cross_for_item - cross_size
        if auto_cross_count == 2 {
          if remaining_cross > 0.0 {
            auto_cross_start = remaining_cross / 2.0
          } else {
            auto_cross_start = 0.0
          }
        } else if margin_cross_start_auto[i] {
          auto_cross_start = if remaining_cross > 0.0 {
            remaining_cross
          } else {
            0.0
          }
        } else {
          ()
        }
      }
      let cross_pos_in_available = if auto_cross_count > 0 {
        auto_cross_start
      } else {
        match align {
          ItemsBaseline =>
            if !is_col {
              baseline_before_max - margin_cross_start[i] - baseline_offsets[i]
            } else {
              0.0
            }
          ItemsEnd | ItemsFlexEnd => available_cross_for_item - cross_size
          ItemsCenter => (available_cross_for_item - cross_size) / 2.0
          _ => 0.0
        }
      }
      let cross_pos_in_available = if is_wrap_reverse {
        available_cross_for_item - cross_size - cross_pos_in_available
      } else {
        cross_pos_in_available
      }
      let cross_offset = margin_cross_start[i] + cross_pos_in_available
      let item_main_margin_start = margin_main_start[i] +
        auto_main_start_values[i]
      let item_main_margin_end = margin_main_end[i] + auto_main_end_values[i]
      let main_pos = if is_reverse {
        cursor = cursor - item_main_margin_end - main_size
        let pos = cursor + item_main_margin_start
        cursor = cursor - item_main_margin_start - actual_gap_main
        pos
      } else {
        let pos = cursor + item_main_margin_start
        cursor = cursor +
          item_main_margin_start +
          main_size +
          item_main_margin_end +
          actual_gap_main
        pos
      }
      let has_measure_context = tree.nodes[child_id].context is Some(_)
      let known_width = if has_measure_context {
        let main_changed = abs_double(main_size - base_main_sizes[i]) > 0.0001
        let main_known = if main_size_is_known_constraint[i] || main_changed {
          Some(main_size)
        } else {
          None
        }
        let cross_known = if !cross_is_auto[i] {
          Some(cross_size)
        } else {
          match align {
            ItemsStretch =>
              if cross_is_auto_container && main_is_definite && flow_count == 1 {
                None
              } else {
                Some(cross_size)
              }
            _ => None
          }
        }
        if is_col {
          cross_known
        } else {
          main_known
        }
      } else {
        let main_changed = abs_double(main_size - base_main_sizes[i]) > 0.0001
        let child_wraps = match child.style.flex_wrap {
          FlexNoWrap => false
          _ => true
        }
        let allow_auto_main = child.children.length() > 0 &&
          child_wraps &&
          !main_size_is_known_constraint[i] &&
          !main_changed
        let main_known = if allow_auto_main { None } else { Some(main_size) }
        let allow_auto_cross = child.children.length() > 0 &&
          child_wraps &&
          cross_is_auto[i]
        let cross_known = if !cross_is_auto[i] {
          Some(cross_size)
        } else {
          match align {
            ItemsStretch =>
              if cross_is_auto_container && allow_auto_cross {
                None
              } else {
                Some(cross_size)
              }
            _ => Some(cross_size)
          }
        }
        if is_col {
          cross_known
        } else {
          main_known
        }
      }
      let known_height = if has_measure_context {
        let main_changed = abs_double(main_size - base_main_sizes[i]) > 0.0001
        let main_known = if main_size_is_known_constraint[i] || main_changed {
          Some(main_size)
        } else {
          None
        }
        let cross_known = if !cross_is_auto[i] {
          Some(cross_size)
        } else {
          match align {
            ItemsStretch =>
              if cross_is_auto_container && main_is_definite && flow_count == 1 {
                None
              } else {
                Some(cross_size)
              }
            _ => None
          }
        }
        if is_col {
          main_known
        } else {
          cross_known
        }
      } else {
        let main_changed = abs_double(main_size - base_main_sizes[i]) > 0.0001
        let child_wraps = match child.style.flex_wrap {
          FlexNoWrap => false
          _ => true
        }
        let allow_auto_main = child.children.length() > 0 &&
          child_wraps &&
          !main_size_is_known_constraint[i] &&
          !main_changed
        let main_known = if allow_auto_main { None } else { Some(main_size) }
        let allow_auto_cross = child.children.length() > 0 &&
          child_wraps &&
          cross_is_auto[i]
        let cross_known = if !cross_is_auto[i] {
          Some(cross_size)
        } else {
          match align {
            ItemsStretch =>
              if cross_is_auto_container && allow_auto_cross {
                None
              } else {
                Some(cross_size)
              }
            _ => Some(cross_size)
          }
        }
        if is_col {
          main_known
        } else {
          cross_known
        }
      }
      let child_origin = if is_col {
        Point::new(x=base_x + cross_offset, y=base_y + main_pos)
      } else {
        Point::new(x=base_x + main_pos, y=base_y + cross_offset)
      }
      compute_node_layout_with_measure(
        tree,
        child_id,
        Size::new(width=known_width, height=known_height),
        child_available_for_final,
        child_origin,
        measure_function,
        false,
      )
    }
    if cross_is_auto_container &&
      flow_count > 1 &&
      !subtree_has_measure_context(tree, node_id) {
      let mut needed_cross = 0.0
      for i in 0..<flow_count {
        let child_layout = tree.layout(flow_children[i])
        let cross_start = if is_col {
          child_layout.location.x - base_x
        } else {
          child_layout.location.y - base_y
        }
        let cross_size = if is_col {
          child_layout.size.width
        } else {
          child_layout.size.height
        }
        let end = cross_start + cross_size + margin_cross_end[i]
        if end > needed_cross {
          needed_cross = end
        }
      }
      container_cross = needed_cross
      if is_col {
        border_box_width = clamp_dimension(
          max_double(container_cross + horiz_inset, horiz_inset),
          node.style.min_size.width,
          node.style.max_size.width,
          available_space.width,
        )
        content_width = max_double(border_box_width - horiz_inset, 0.0)
      } else {
        border_box_height = clamp_dimension(
          max_double(container_cross + vert_inset, vert_inset),
          node.style.min_size.height,
          node.style.max_size.height,
          available_space.height,
        )
        content_height = max_double(border_box_height - vert_inset, 0.0)
      }
      tree.nodes[node_id].layout = Layout::{
        location: absolute_origin,
        size: Size::new(width=border_box_width, height=border_box_height),
      }
    }
  }

  let justify_is_startish = match justify {
    AlignFlexStart | AlignStart => true
    _ => false
  }
  let align_items_for_resize = match node.style.align_items {
    Some(v) => v
    None => ItemsStretch
  }
  let cross_align_is_stretch = align_items_for_resize is ItemsStretch
  let allow_auto_resize = !subtree_has_measure_context(tree, node_id)
  if flow_count == 1 &&
    (!main_is_definite || cross_is_auto_container) &&
    justify_is_startish &&
    cross_align_is_stretch {
    let only_child = flow_children[0]
    let child = match tree.nodes.get(only_child) {
      Some(c) => c
      None => raise InvalidNodeId(only_child)
    }
    let child_layout = tree.layout(only_child)
    let child_main_size = if is_col {
      child_layout.size.height
    } else {
      child_layout.size.width
    }
    let child_cross_size = if is_col {
      child_layout.size.width
    } else {
      child_layout.size.height
    }
    let mut child_outer_main = margin_main_start[0] +
      child_main_size +
      margin_main_end[0]
    let child_outer_cross = margin_cross_start[0] +
      child_cross_size +
      margin_cross_end[0]
    let cross_axis_available_for_min = if is_col {
      AvailDefinite(content_width)
    } else {
      AvailDefinite(content_height)
    }
    let cross_min_for_resize = if is_col {
      resolve_optional_dimension(
        child.style.min_size.width,
        cross_axis_available_for_min,
      )
    } else {
      resolve_optional_dimension(
        child.style.min_size.height,
        cross_axis_available_for_min,
      )
    }
    let needs_main_resize_for_cross_min = match cross_min_for_resize {
      Some(v) => v > container_cross + 0.0001
      None => false
    }
    let needs_main_resize_for_measured_margin_reflow = child.context is Some(_) &&
      (
        margin_main_start[0] > 0.0 ||
        margin_main_end[0] > 0.0 ||
        margin_cross_start[0] > 0.0 ||
        margin_cross_end[0] > 0.0
      ) &&
      abs_double(child_main_size - base_main_sizes[0]) > 0.0001
    let child_basis_is_definite = resolve_optional_dimension(
        child.style.flex_basis,
        main_available_pre,
      )
      is Some(_)
    let force_basisless_leaf_main = !is_col &&
      child.children.length() == 0 &&
      child.style.size.width is DimAuto &&
      child.context is None &&
      child_basis_is_definite &&
      main_available_pre is AvailMaxContent
    if force_basisless_leaf_main {
      child_outer_main = margin_main_start[0] +
        content_main_sizes[0] +
        margin_main_end[0]
    }
    let mut resized = false
    if !main_is_definite &&
      (
        allow_auto_resize ||
        needs_main_resize_for_cross_min ||
        needs_main_resize_for_measured_margin_reflow
      ) {
      container_main = child_outer_main
      if is_col {
        border_box_height = clamp_dimension(
          max_double(container_main + vert_inset, vert_inset),
          node.style.min_size.height,
          node.style.max_size.height,
          available_space.height,
        )
        content_height = max_double(border_box_height - vert_inset, 0.0)
      } else {
        border_box_width = clamp_dimension(
          max_double(container_main + horiz_inset, horiz_inset),
          node.style.min_size.width,
          node.style.max_size.width,
          available_space.width,
        )
        content_width = max_double(border_box_width - horiz_inset, 0.0)
      }
      resized = true
    }
    if cross_is_auto_container {
      container_cross = child_outer_cross
      if is_col {
        border_box_width = clamp_dimension(
          max_double(container_cross + horiz_inset, horiz_inset),
          node.style.min_size.width,
          node.style.max_size.width,
          available_space.width,
        )
        content_width = max_double(border_box_width - horiz_inset, 0.0)
      } else {
        border_box_height = clamp_dimension(
          max_double(container_cross + vert_inset, vert_inset),
          node.style.min_size.height,
          node.style.max_size.height,
          available_space.height,
        )
        content_height = max_double(border_box_height - vert_inset, 0.0)
      }
      resized = true
    }
    if resized {
      tree.nodes[node_id].layout = Layout::{
        location: absolute_origin,
        size: Size::new(width=border_box_width, height=border_box_height),
      }
      if force_basisless_leaf_main {
        let child_available_for_final = Size::new(
          width=AvailDefinite(content_width),
          height=AvailDefinite(content_height),
        )
        let child_origin = Point::new(
          x=base_x + margin_main_start[0],
          y=base_y + margin_cross_start[0],
        )
        compute_node_layout_with_measure(
          tree,
          only_child,
          Size::new(
            width=Some(content_main_sizes[0]),
            height=Some(child_cross_size),
          ),
          child_available_for_final,
          child_origin,
          measure_function,
          false,
        )
      }
    }
  }
  if flow_count > 1 &&
    !main_is_definite &&
    !is_wrap &&
    abs_double(gap_main - gap_main_pre) < 0.0001 &&
    justify_is_startish &&
    allow_auto_resize {
    let mut needed_main = 0.0
    for i in 0..<flow_count {
      let child_layout = tree.layout(flow_children[i])
      let main_start = if is_col {
        child_layout.location.y - base_y
      } else {
        child_layout.location.x - base_x
      }
      let main_size = if is_col {
        child_layout.size.height
      } else {
        child_layout.size.width
      }
      let end = main_start + main_size + margin_main_end[i]
      if end > needed_main {
        needed_main = end
      }
    }
    let mut intrinsic_needed_main = if flow_count > 1 {
      gap_main_pre * (flow_count - 1).to_double()
    } else {
      0.0
    }
    for i in 0..<flow_count {
      let flex_basis = base_main_sizes[i]
      let resolved_min_main = if min_main_sizes[i] < 0.0 {
        0.0
      } else {
        min_main_sizes[i]
      }
      let clamping_basis = match preferred_main_sizes[i] {
        Some(pref) => max_double(flex_basis, pref)
        None => flex_basis
      }
      let flex_basis_min = if flex_shrink[i] == 0.0 {
        Some(clamping_basis)
      } else {
        None
      }
      let flex_basis_max = if flex_grow[i] == 0.0 {
        Some(clamping_basis)
      } else {
        None
      }
      let min_main = max_double(
        match flex_basis_min {
          Some(v) => v
          None => resolved_min_main
        },
        resolved_min_main,
      )
      let max_main = match (max_main_sizes[i], flex_basis_max) {
        (Some(a), Some(b)) => Some(min_double(a, b))
        (Some(a), None) => Some(a)
        (None, Some(b)) => Some(b)
        (None, None) => None
      }
      let content_contribution = match (preferred_main_sizes[i], max_main) {
        (Some(pref), Some(max_v)) if max_v <= min_main || max_v <= pref => {
          let mut v = pref
          if v > max_v {
            v = max_v
          }
          if v < min_main {
            v = min_main
          }
          v
        }
        (_, Some(max_v)) if max_v <= min_main => min_main
        _ => {
          let mut v = content_main_sizes[i]
          if v < min_main {
            v = min_main
          }
          match max_main {
            Some(max_v) => if v > max_v { v = max_v }
            None => ()
          }
          v
        }
      }
      intrinsic_needed_main = intrinsic_needed_main +
        margin_main_start[i] +
        content_contribution +
        margin_main_end[i]
    }
    if intrinsic_needed_main > needed_main {
      needed_main = intrinsic_needed_main
    }
    if is_col {
      border_box_height = clamp_dimension(
        max_double(needed_main + vert_inset, vert_inset),
        node.style.min_size.height,
        node.style.max_size.height,
        available_space.height,
      )
      content_height = max_double(border_box_height - vert_inset, 0.0)
      container_main = content_height
    } else {
      border_box_width = clamp_dimension(
        max_double(needed_main + horiz_inset, horiz_inset),
        node.style.min_size.width,
        node.style.max_size.width,
        available_space.width,
      )
      content_width = max_double(border_box_width - horiz_inset, 0.0)
      container_main = content_width
    }
    tree.nodes[node_id].layout = Layout::{
      location: absolute_origin,
      size: Size::new(width=border_box_width, height=border_box_height),
    }
    if cross_is_auto_container {
      let mut needed_cross = 0.0
      for i in 0..<flow_count {
        let child_layout = tree.layout(flow_children[i])
        let cross_start = if is_col {
          child_layout.location.x - base_x
        } else {
          child_layout.location.y - base_y
        }
        let cross_size = if is_col {
          child_layout.size.width
        } else {
          child_layout.size.height
        }
        let end = cross_start + cross_size + margin_cross_end[i]
        if end > needed_cross {
          needed_cross = end
        }
      }
      if is_col {
        border_box_width = clamp_dimension(
          max_double(needed_cross + horiz_inset, horiz_inset),
          node.style.min_size.width,
          node.style.max_size.width,
          available_space.width,
        )
        content_width = max_double(border_box_width - horiz_inset, 0.0)
        container_cross = content_width
      } else {
        border_box_height = clamp_dimension(
          max_double(needed_cross + vert_inset, vert_inset),
          node.style.min_size.height,
          node.style.max_size.height,
          available_space.height,
        )
        content_height = max_double(border_box_height - vert_inset, 0.0)
        container_cross = content_height
      }
      tree.nodes[node_id].layout = Layout::{
        location: absolute_origin,
        size: Size::new(width=border_box_width, height=border_box_height),
      }
    }
  }

  // Absolute positioned children: compute after container size is known, and do not affect flow layout.
  // Follow the same sizing rules as the block layout absolute-positioning pass:
  // inset constraints can determine auto sizes, and aspect-ratio participates in sizing.
  let padding_origin = Point::new(
    x=absolute_origin.x + border.left,
    y=absolute_origin.y + border.top,
  )
  let padding_box_width = max_double(
    border_box_width - border.left - border.right,
    0.0,
  )
  let padding_box_height = max_double(
    border_box_height - border.top - border.bottom,
    0.0,
  )
  let abs_available = Size::new(
    width=AvailDefinite(padding_box_width),
    height=AvailDefinite(padding_box_height),
  )
  for child_id in abs_children {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    let margin = child.style.margin
    // CSS compatibility: margin percentages are resolved against the width.
    let margin_left_auto = margin.left is DimAuto
    let margin_right_auto = margin.right is DimAuto
    let margin_top_auto = margin.top is DimAuto
    let margin_bottom_auto = margin.bottom is DimAuto
    let margin_left_fixed = resolve_dimension_width_basis(
      margin.left,
      padding_box_width,
    )
    let margin_right_fixed = resolve_dimension_width_basis(
      margin.right,
      padding_box_width,
    )
    let margin_top_fixed = resolve_dimension_width_basis(
      margin.top,
      padding_box_width,
    )
    let margin_bottom_fixed = resolve_dimension_width_basis(
      margin.bottom,
      padding_box_width,
    )
    let inset = child.style.inset
    let left = resolve_optional_dimension(inset.left, abs_available.width)
    let right = resolve_optional_dimension(inset.right, abs_available.width)
    let top = resolve_optional_dimension(inset.top, abs_available.height)
    let bottom = resolve_optional_dimension(inset.bottom, abs_available.height)

    // Compute the used size for absolutely positioned items.
    let mut used_width = resolve_optional_dimension(
      child.style.size.width,
      abs_available.width,
    )
    let mut used_height = resolve_optional_dimension(
      child.style.size.height,
      abs_available.height,
    )
    let width_was_auto = used_width is None
    let height_was_auto = used_height is None
    let mut width_from_inset = false
    let mut height_from_inset = false
    // If size is auto and both insets are definite, the size is determined by the inset constraints.
    match used_width {
      Some(_) => ()
      None =>
        match (left, right) {
          (Some(l), Some(r)) =>
            used_width = Some(
              max_double(
                padding_box_width -
                l -
                r -
                margin_left_fixed -
                margin_right_fixed,
                0.0,
              ),
            )
          _ => ()
        }
    }
    match used_height {
      Some(_) => ()
      None =>
        match (top, bottom) {
          (Some(t), Some(b)) =>
            used_height = Some(
              max_double(
                padding_box_height -
                t -
                b -
                margin_top_fixed -
                margin_bottom_fixed,
                0.0,
              ),
            )
          _ => ()
        }
    }
    match (used_width, used_height) {
      (Some(_), _) =>
        if width_was_auto {
          match (left, right) {
            (Some(_), Some(_)) => width_from_inset = true
            _ => ()
          }
        } else {
          ()
        }
      _ => ()
    }
    match (used_width, used_height) {
      (_, Some(_)) =>
        if height_was_auto {
          match (top, bottom) {
            (Some(_), Some(_)) => height_from_inset = true
            _ => ()
          }
        } else {
          ()
        }
      _ => ()
    }
    // Apply aspect ratio when only one axis is known.
    match child.style.aspect_ratio {
      Some(ratio) =>
        if ratio > 0.0 {
          match (used_width, used_height) {
            (Some(w), None) => used_height = Some((w / ratio).round())
            (None, Some(h)) => used_width = Some((h * ratio).round())
            (Some(w), Some(_h)) =>
              if width_was_auto &&
                height_was_auto &&
                width_from_inset &&
                height_from_inset {
                used_height = Some((w / ratio).round())
              } else {
                ()
              }
            _ => ()
          }
        }
      None => ()
    }

    // Apply aspect ratio to min/max constraints (taffy 0.5 behavior).
    let mut min_width = resolve_optional_dimension(
      child.style.min_size.width,
      abs_available.width,
    )
    let mut min_height = resolve_optional_dimension(
      child.style.min_size.height,
      abs_available.height,
    )
    let mut max_width = resolve_optional_dimension(
      child.style.max_size.width,
      abs_available.width,
    )
    let mut max_height = resolve_optional_dimension(
      child.style.max_size.height,
      abs_available.height,
    )
    match child.style.aspect_ratio {
      Some(ratio) =>
        if ratio > 0.0 {
          match (min_width, min_height) {
            (None, Some(h)) => min_width = Some((h * ratio).round())
            (Some(w), None) => min_height = Some((w / ratio).round())
            _ => ()
          }
          match (max_width, max_height) {
            (None, Some(h)) => max_width = Some((h * ratio).round())
            (Some(w), None) => max_height = Some((w / ratio).round())
            _ => ()
          }
        } else {
          ()
        }
      None => ()
    }

    // First pass: determine intrinsic size under the containing block constraints, if needed.
    let intrinsic = match (used_width, used_height) {
      (Some(w), Some(h)) => Size::new(width=w, height=h)
      _ => {
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size::new(width=None, height=None),
          abs_available,
          Point::zero(),
          measure_function,
          false,
        )
        tree.nodes[child_id].layout.size
      }
    }
    let final_width = match used_width {
      Some(w) => w
      None => intrinsic.width
    }
    let final_height = match used_height {
      Some(h) => h
      None => intrinsic.height
    }
    let mut clamped_final_width = final_width
    let mut clamped_final_height = final_height
    match min_width {
      Some(m) => clamped_final_width = max_double(clamped_final_width, m)
      None => ()
    }
    match max_width {
      Some(m) =>
        if clamped_final_width > m {
          clamped_final_width = m
        } else {
          ()
        }
      None => ()
    }
    match min_height {
      Some(m) => clamped_final_height = max_double(clamped_final_height, m)
      None => ()
    }
    match max_height {
      Some(m) =>
        if clamped_final_height > m {
          clamped_final_height = m
        } else {
          ()
        }
      None => ()
    }

    // Second pass: compute final size (may be clamped by min/max).
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(
        width=Some(clamped_final_width),
        height=Some(clamped_final_height),
      ),
      abs_available,
      Point::zero(),
      measure_function,
      false,
    )
    let final_size = tree.nodes[child_id].layout.size
    let mut final_margin_left = if margin_left_auto {
      0.0
    } else {
      margin_left_fixed
    }
    let mut final_margin_right = if margin_right_auto {
      0.0
    } else {
      margin_right_fixed
    }
    let mut final_margin_top = if margin_top_auto {
      0.0
    } else {
      margin_top_fixed
    }
    let mut final_margin_bottom = if margin_bottom_auto {
      0.0
    } else {
      margin_bottom_fixed
    }

    // Absolute auto margins: distribute remaining space when both inset sides are definite.
    match (left, right) {
      (Some(l), Some(r)) => {
        let fixed = (if margin_left_auto { 0.0 } else { final_margin_left }) +
          (if margin_right_auto { 0.0 } else { final_margin_right })
        let remaining = padding_box_width - l - r - final_size.width - fixed
        let auto_count = (if margin_left_auto { 1 } else { 0 }) +
          (if margin_right_auto { 1 } else { 0 })
        match auto_count {
          2 =>
            if remaining >= 0.0 {
              final_margin_left = remaining / 2.0
              final_margin_right = remaining / 2.0
            } else {
              final_margin_left = 0.0
              final_margin_right = 0.0
            }
          1 =>
            if margin_left_auto {
              final_margin_left = remaining
            } else {
              final_margin_right = remaining
            }
          _ => ()
        }
      }
      _ => ()
    }
    match (top, bottom) {
      (Some(t), Some(b)) => {
        let fixed = (if margin_top_auto { 0.0 } else { final_margin_top }) +
          (if margin_bottom_auto { 0.0 } else { final_margin_bottom })
        let remaining = padding_box_height - t - b - final_size.height - fixed
        let auto_count = (if margin_top_auto { 1 } else { 0 }) +
          (if margin_bottom_auto { 1 } else { 0 })
        match auto_count {
          2 =>
            if remaining >= 0.0 {
              final_margin_top = remaining / 2.0
              final_margin_bottom = remaining / 2.0
            } else {
              final_margin_top = 0.0
              final_margin_bottom = 0.0
            }
          1 =>
            if margin_top_auto {
              final_margin_top = remaining
            } else {
              final_margin_bottom = remaining
            }
          _ => ()
        }
      }
      _ => ()
    }

    // Static position fallback when no inset is specified on an axis.
    let main_margin_start = if is_col {
      final_margin_top
    } else {
      final_margin_left
    }
    let main_margin_end = if is_col {
      final_margin_bottom
    } else {
      final_margin_right
    }
    let cross_margin_start = if is_col {
      final_margin_left
    } else {
      final_margin_top
    }
    let cross_margin_end = if is_col {
      final_margin_right
    } else {
      final_margin_bottom
    }
    let main_size = if is_col { final_size.height } else { final_size.width }
    let cross_size = if is_col { final_size.width } else { final_size.height }
    let outer_main = main_margin_start + main_size + main_margin_end
    let leftover_main = container_main - outer_main
    let leftover_main = if leftover_main > 0.0 { leftover_main } else { 0.0 }
    let static_start_main = resolve_justify_start_main(
      justify, leftover_main, is_reverse,
    )
    let static_main = static_start_main + main_margin_start
    let align = match child.style.align_self {
      Some(v) => v
      None =>
        match node.style.align_items {
          Some(v) => v
          None => ItemsStretch
        }
    }
    let available_cross_for_item = max_double(
      container_cross - cross_margin_start - cross_margin_end,
      0.0,
    )
    let cross_pos_in_available = match align {
      ItemsEnd | ItemsFlexEnd => available_cross_for_item - cross_size
      ItemsCenter => (available_cross_for_item - cross_size) / 2.0
      _ => 0.0
    }
    let cross_pos_in_available = if is_wrap_reverse {
      available_cross_for_item - cross_size - cross_pos_in_available
    } else {
      cross_pos_in_available
    }
    let static_cross = cross_margin_start + cross_pos_in_available
    let x_in_padding = match left {
      Some(v) => v + final_margin_left
      None =>
        match right {
          Some(v) =>
            padding_box_width - v - final_margin_right - final_size.width
          None =>
            padding.left + (if is_col { static_cross } else { static_main })
        }
    }
    let y_in_padding = match top {
      Some(v) => v + final_margin_top
      None =>
        match bottom {
          Some(v) =>
            padding_box_height - v - final_margin_bottom - final_size.height
          None =>
            padding.top + (if is_col { static_main } else { static_cross })
        }
    }
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=Some(final_size.width), height=Some(final_size.height)),
      abs_available,
      Point::new(
        x=padding_origin.x + x_in_padding,
        y=padding_origin.y + y_in_padding,
      ),
      measure_function,
      false,
    )
  }

  // Ensure `display: none` children get laid out (to zero) as well.
  for child_id in hidden_children {
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=None, height=None),
      abs_available,
      Point::zero(),
      measure_function,
      false,
    )
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
