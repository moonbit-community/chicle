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
    Size(width=original_style.size.width, height=DimAuto)
  } else {
    Size(width=DimAuto, height=original_style.size.height)
  }
  tree.nodes[child_id].style = { ..original_style, size: cleared_size }
  let min_content_space = if is_col {
    Size(width=parent_available_for_children.width, height=AvailMinContent)
  } else {
    Size(width=AvailMinContent, height=parent_available_for_children.height)
  }
  compute_node_layout_with_measure(
    tree,
    child_id,
    Size(width=None, height=None),
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
