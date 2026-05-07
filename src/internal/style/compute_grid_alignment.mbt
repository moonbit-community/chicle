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
fn grid_area_axis_origin(
  track_sizes : Array[Double],
  gap : Double,
  start_offset : Double,
  start_index : Int,
) -> Double {
  let mut origin = start_offset
  for i in 0..<start_index {
    origin = origin + track_sizes[i] + gap
  }
  origin
}

///|
fn grid_area_axis_size(
  track_sizes : Array[Double],
  gap : Double,
  start_index : Int,
  span : Int,
) -> Double {
  let mut size = 0.0
  for i in start_index..<(start_index + span) {
    size = size + track_sizes[i]
  }
  if span > 1 {
    size + gap * (span - 1).to_double()
  } else {
    size
  }
}

///|
fn GridItem::grid_area_origin(
  self : GridItem,
  col_sizes : Array[Double],
  row_sizes : Array[Double],
  col_gap : Double,
  row_gap : Double,
  start_x : Double,
  start_y : Double,
) -> Point[Double] {
  Point(
    x=grid_area_axis_origin(col_sizes, col_gap, start_x, self.column),
    y=grid_area_axis_origin(row_sizes, row_gap, start_y, self.row),
  )
}

///|
fn GridItem::grid_area_size(
  self : GridItem,
  col_sizes : Array[Double],
  row_sizes : Array[Double],
  col_gap : Double,
  row_gap : Double,
) -> Size[Double] {
  Size(
    width=grid_area_axis_size(col_sizes, col_gap, self.column, self.column_span),
    height=grid_area_axis_size(row_sizes, row_gap, self.row, self.row_span),
  )
}

///|
fn[C] compute_grid_absolute_children(
  view : TaffyView[C],
  children : Array[NodeId],
  explicit_col_lines : Array[Double],
  explicit_row_lines : Array[Double],
  padding_origin : Point[Double],
  padding_box_width : Double,
  padding_box_height : Double,
  default_abs_align : AlignItems,
  default_abs_justify : AlignItems,
) -> Unit raise TaffyError {
  let tree = view.tree
  for child_id in children {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => ()
      _ =>
        match child.style.position {
          PosRelative => ()
          PosAbsolute => {
            let col_line = merged_placement_line(
              child.style.grid_column,
              child.style.grid_column_start,
            )
            let row_line = merged_placement_line(
              child.style.grid_row,
              child.style.grid_row_start,
            )
            let cb_x = resolve_grid_abs_axis_containing_block(
              col_line, explicit_col_lines, padding_box_width,
            )
            let cb_y = resolve_grid_abs_axis_containing_block(
              row_line, explicit_row_lines, padding_box_height,
            )
            let containing_x = cb_x.0
            let containing_y = cb_y.0
            let containing_width = max_double(cb_x.1 - cb_x.0, 0.0)
            let containing_height = max_double(cb_y.1 - cb_y.0, 0.0)
            let abs_available = Size(
              width=AvailDefinite(containing_width),
              height=AvailDefinite(containing_height),
            )
            let margin = child.style.margin
            let margin_left_auto = margin.left is DimAuto
            let margin_right_auto = margin.right is DimAuto
            let margin_top_auto = margin.top is DimAuto
            let margin_bottom_auto = margin.bottom is DimAuto
            let margin_left_fixed = resolve_dimension_width_basis(
              margin.left,
              containing_width,
            )
            let margin_right_fixed = resolve_dimension_width_basis(
              margin.right,
              containing_width,
            )
            let margin_top_fixed = resolve_dimension_width_basis(
              margin.top,
              containing_width,
            )
            let margin_bottom_fixed = resolve_dimension_width_basis(
              margin.bottom,
              containing_width,
            )
            let inset = child.style.inset
            let left = resolve_optional_dimension(
              inset.left,
              abs_available.width,
            )
            let right = resolve_optional_dimension(
              inset.right,
              abs_available.width,
            )
            let top = resolve_optional_dimension(
              inset.top,
              abs_available.height,
            )
            let bottom = resolve_optional_dimension(
              inset.bottom,
              abs_available.height,
            )
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
            match used_width {
              Some(_) => ()
              None =>
                match (left, right) {
                  (Some(l), Some(r)) =>
                    used_width = Some(
                      max_double(
                        containing_width -
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
                        containing_height -
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
              Some(m) =>
                clamped_final_width = max_double(clamped_final_width, m)
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
                clamped_final_height = max_double(clamped_final_height, m)
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
            view.perform_child_layout(
              child_id,
              Size(
                width=Some(clamped_final_width),
                height=Some(clamped_final_height),
              ),
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
            match (left, right) {
              (Some(l), Some(r)) => {
                let fixed = (if margin_left_auto {
                    0.0
                  } else {
                    final_margin_left
                  }) +
                  (if margin_right_auto { 0.0 } else { final_margin_right })
                let remaining = containing_width -
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
                let fixed = (if margin_top_auto {
                    0.0
                  } else {
                    final_margin_top
                  }) +
                  (if margin_bottom_auto { 0.0 } else { final_margin_bottom })
                let remaining = containing_height -
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
            let justify = match child.style.justify_self {
              Some(v) => v
              None => default_abs_justify
            }
            let align = match child.style.align_self {
              Some(v) => v
              None => default_abs_align
            }
            let available_width_for_static = max_double(
              containing_width - final_margin_left - final_margin_right,
              0.0,
            )
            let available_height_for_static = max_double(
              containing_height - final_margin_top - final_margin_bottom,
              0.0,
            )
            let static_x = final_margin_left +
              (match justify {
                ItemsEnd | ItemsFlexEnd =>
                  available_width_for_static - final_size.width
                ItemsCenter =>
                  (available_width_for_static - final_size.width) / 2.0
                _ => 0.0
              })
            let static_y = final_margin_top +
              (match align {
                ItemsEnd | ItemsFlexEnd =>
                  available_height_for_static - final_size.height
                ItemsCenter =>
                  (available_height_for_static - final_size.height) / 2.0
                _ => 0.0
              })
            let x_in_padding = match left {
              Some(v) => containing_x + v + final_margin_left
              None =>
                match right {
                  Some(v) =>
                    containing_x +
                    containing_width -
                    v -
                    final_margin_right -
                    final_size.width
                  None => containing_x + static_x
                }
            }
            let y_in_padding = match top {
              Some(v) => containing_y + v + final_margin_top
              None =>
                match bottom {
                  Some(v) =>
                    containing_y +
                    containing_height -
                    v -
                    final_margin_bottom -
                    final_size.height
                  None => containing_y + static_y
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
        }
    }
  }
}
