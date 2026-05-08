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
fn[C] compute_flex_absolute_and_hidden_children(
  view : TaffyView[C],
  abs_children : Array[NodeId],
  hidden_children : Array[NodeId],
  absolute_origin : Point[Double],
  border : Rect[Double],
  padding : Rect[Double],
  border_box_width : Double,
  border_box_height : Double,
  is_col : Bool,
  container_main : Double,
  container_cross : Double,
  justify : AlignContent,
  is_reverse : Bool,
  is_wrap_reverse : Bool,
  align_items : AlignItems?,
) -> Unit raise TaffyError {
  let tree = view.tree
  // Absolute positioned children: compute after container size is known, and do not affect flow layout.
  // Follow the same sizing rules as the block layout absolute-positioning pass:
  // inset constraints can determine auto sizes, and aspect-ratio participates in sizing.
  let padding_origin = Point(
    x=absolute_origin.x + border.left,
    y=absolute_origin.y + border.top,
  )
  let padding_box_width = @util.max_double(
    border_box_width - border.left - border.right,
    0.0,
  )
  let padding_box_height = @util.max_double(
    border_box_height - border.top - border.bottom,
    0.0,
  )
  let abs_available = Size(
    width=@geometry.AvailDefinite(padding_box_width),
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
    let margin_left_fixed = @util.resolve_dimension_width_basis(
      margin.left,
      padding_box_width,
    )
    let margin_right_fixed = @util.resolve_dimension_width_basis(
      margin.right,
      padding_box_width,
    )
    let margin_top_fixed = @util.resolve_dimension_width_basis(
      margin.top,
      padding_box_width,
    )
    let margin_bottom_fixed = @util.resolve_dimension_width_basis(
      margin.bottom,
      padding_box_width,
    )
    let inset = child.style.inset
    let left = @util.resolve_optional_dimension(inset.left, abs_available.width)
    let right = @util.resolve_optional_dimension(
      inset.right,
      abs_available.width,
    )
    let top = @util.resolve_optional_dimension(inset.top, abs_available.height)
    let bottom = @util.resolve_optional_dimension(
      inset.bottom,
      abs_available.height,
    )

    // Compute the used size for absolutely positioned items.
    let mut used_width = @util.resolve_optional_dimension(
      child.style.size.width,
      abs_available.width,
    )
    let mut used_height = @util.resolve_optional_dimension(
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
              @util.max_double(
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
              @util.max_double(
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
    let mut min_width = @util.resolve_optional_dimension(
      child.style.min_size.width,
      abs_available.width,
    )
    let mut min_height = @util.resolve_optional_dimension(
      child.style.min_size.height,
      abs_available.height,
    )
    let mut max_width = @util.resolve_optional_dimension(
      child.style.max_size.width,
      abs_available.width,
    )
    let mut max_height = @util.resolve_optional_dimension(
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
        view.perform_child_layout(
          child_id,
          Size(width=None, height=None),
          abs_available,
          Point::zero(),
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
      Some(m) => clamped_final_width = @util.max_double(clamped_final_width, m)
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
      Some(m) =>
        clamped_final_height = @util.max_double(clamped_final_height, m)
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
    view.perform_child_layout(
      child_id,
      Size(width=Some(clamped_final_width), height=Some(clamped_final_height)),
      abs_available,
      Point::zero(),
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
        match align_items {
          Some(v) => v
          None => ItemsStretch
        }
    }
    let available_cross_for_item = @util.max_double(
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
    view.perform_child_layout(
      child_id,
      Size(width=Some(final_size.width), height=Some(final_size.height)),
      abs_available,
      Point(
        x=padding_origin.x + x_in_padding,
        y=padding_origin.y + y_in_padding,
      ),
      false,
    )
  }

  // Ensure `display: none` children get laid out (to zero) as well.
  for child_id in hidden_children {
    view.perform_child_layout(
      child_id,
      Size(width=None, height=None),
      abs_available,
      Point::zero(),
      false,
    )
  }
}
