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
fn[C] compute_block_absolute_children(
  tree : TaffyTree[C],
  abs_child_ids : Array[NodeId],
  abs_child_static_y : Array[Double],
  padding_origin : Point[Double],
  padding : Rect[Double],
  border : Rect[Double],
  final_border_box_width : Double,
  final_border_box_height : Double,
  scrollbar_x : Double,
  scrollbar_y : Double,
  measure_function : (Size[Double?], Size[AvailableSpace], NodeId, C?, Style) -> Size[
    Double,
  ],
) -> Unit raise TaffyError {
  // Absolute children: positioned relative to the final padding box.
  let final_padding_box_width = max_double(
    final_border_box_width - border.left - border.right - scrollbar_y,
    0.0,
  )
  let final_padding_box_height = max_double(
    final_border_box_height - border.top - border.bottom - scrollbar_x,
    0.0,
  )
  let abs_available = Size(
    width=AvailDefinite(final_padding_box_width),
    height=AvailDefinite(final_padding_box_height),
  )
  for i in 0..<abs_child_ids.length() {
    let child_id = abs_child_ids[i]
    let static_y = abs_child_static_y[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    let margin = child.style.margin
    // CSS compatibility: margin percentages are resolved against the width.
    let margin_left_auto = match margin.left {
      DimAuto => true
      _ => false
    }
    let margin_right_auto = match margin.right {
      DimAuto => true
      _ => false
    }
    let margin_top_auto = match margin.top {
      DimAuto => true
      _ => false
    }
    let margin_bottom_auto = match margin.bottom {
      DimAuto => true
      _ => false
    }
    let margin_left_fixed = resolve_dimension_width_basis(
      margin.left,
      final_padding_box_width,
    )
    let margin_right_fixed = resolve_dimension_width_basis(
      margin.right,
      final_padding_box_width,
    )
    let margin_top_fixed = resolve_dimension_width_basis(
      margin.top,
      final_padding_box_width,
    )
    let margin_bottom_fixed = resolve_dimension_width_basis(
      margin.bottom,
      final_padding_box_width,
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
    let width_was_auto = match used_width {
      Some(_) => false
      None => true
    }
    let height_was_auto = match used_height {
      Some(_) => false
      None => true
    }
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
                final_padding_box_width -
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
                final_padding_box_height -
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
      (Some(w), Some(h)) => Size(width=w, height=h)
      _ => {
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size(width=None, height=None),
          abs_available,
          Point::zero(),
          measure_function,
          false,
        )
        tree.nodes[child_id].unrounded_layout.size
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
      Size(width=Some(clamped_final_width), height=Some(clamped_final_height)),
      abs_available,
      Point::zero(),
      measure_function,
      false,
    )
    let final_size = tree.nodes[child_id].unrounded_layout.size
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
        let remaining = final_padding_box_width -
          l -
          r -
          final_size.width -
          fixed
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
        let remaining = final_padding_box_height -
          t -
          b -
          final_size.height -
          fixed
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
    let x_in_padding = match left {
      Some(v) => v + final_margin_left
      None =>
        match right {
          Some(v) =>
            final_padding_box_width - v - final_margin_right - final_size.width
          None => padding.left + final_margin_left
        }
    }
    let y_in_padding = match top {
      Some(v) => v + final_margin_top
      None =>
        match bottom {
          Some(v) =>
            final_padding_box_height -
            v -
            final_margin_bottom -
            final_size.height
          None => padding.top + static_y + final_margin_top
        }
    }
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size(width=Some(final_size.width), height=Some(final_size.height)),
      abs_available,
      Point(
        x=padding_origin.x + x_in_padding,
        y=padding_origin.y + y_in_padding,
      ),
      measure_function,
      false,
    )
  }
}
