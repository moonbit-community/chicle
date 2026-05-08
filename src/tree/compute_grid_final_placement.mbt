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
fn[C] compute_grid_relative_children_final_placement(
  view : TaffyView[C],
  node_id : NodeId,
  grid_items : Array[GridItem],
  placement_count : Int,
  col_tracks : Array[Dimension],
  row_tracks : Array[Dimension],
  col_sizes : Array[Double],
  row_sizes : Array[Double],
  col_gap_effective : Double,
  row_gap_effective : Double,
  start_x : Double,
  start_y : Double,
  absolute_origin : Point[Double],
  border : Rect[Double],
  padding : Rect[Double],
  content_width : Double,
  default_align_items : AlignItems,
  default_justify_items : AlignItems,
  row_count : Int,
  col_count : Int,
) -> Unit raise TaffyError {
  let tree = view.tree
  let base_x = absolute_origin.x + border.left + padding.left
  let base_y = absolute_origin.y + border.top + padding.top
  let row_baseline_before_max : Array[Double] = Array::make(row_count, 0.0)
  let row_baseline_after_max : Array[Double] = Array::make(row_count, 0.0)
  for i in 0..<placement_count {
    let item = grid_items[i]
    if !item.is_relative_grid_child() ||
      !item.is_in_bounds(row_count, col_count) {
      continue
    }
    let child_id = item.node
    let child_style = item.style
    let align = match child_style.align_self {
      Some(v) => v
      None => default_align_items
    }
    if item.row_span != 1 {
      continue
    }
    match align {
      ItemsBaseline => ()
      _ => continue
    }
    let grid_area_size = item.grid_area_size(
      col_sizes, row_sizes, col_gap_effective, row_gap_effective,
    )
    let cell_w = grid_area_size.width
    let cell_h = grid_area_size.height
    let child_available = Size(
      width=@geometry.AvailDefinite(cell_w),
      height=AvailDefinite(cell_h),
    )
    let resolved_margin = @util.resolve_rect_width_basis(
      child_style.margin,
      child_available,
    )
    let margin_left_auto = child_style.margin.left is DimAuto
    let margin_right_auto = child_style.margin.right is DimAuto
    let margin_top_auto = child_style.margin.top is DimAuto
    let margin_bottom_auto = child_style.margin.bottom is DimAuto
    let has_auto_margin_x = margin_left_auto || margin_right_auto
    let has_auto_margin_y = margin_top_auto || margin_bottom_auto
    if has_auto_margin_y {
      continue
    }
    let available_w_for_item = @util.max_double(
      cell_w - resolved_margin.left - resolved_margin.right,
      0.0,
    )
    let available_h_for_item = @util.max_double(
      cell_h - resolved_margin.top - resolved_margin.bottom,
      0.0,
    )
    let item_available = Size(
      width=@geometry.AvailDefinite(available_w_for_item),
      height=AvailDefinite(available_h_for_item),
    )
    let justify = match child_style.justify_self {
      Some(v) => v
      None => default_justify_items
    }
    let stretch_fit_limit_w = if item.column_span == 1 {
      match child_style.overflow.x {
        OverflowVisible => None
        _ =>
          match col_tracks[item.column] {
            DimFitContent(limit) =>
              @util.resolve_optional_dimension(
                limit,
                AvailDefinite(content_width),
              )
            _ => None
          }
      }
    } else {
      None
    }
    let known_w = match justify {
      ItemsStretch =>
        if child_style.size.width is DimAuto && !has_auto_margin_x {
          match stretch_fit_limit_w {
            Some(limit_w) =>
              Some(
                if limit_w < available_w_for_item {
                  limit_w
                } else {
                  available_w_for_item
                },
              )
            None => Some(available_w_for_item)
          }
        } else {
          None
        }
      _ => None
    }
    let known_w = match (known_w, child_style.size.width) {
      (None, DimPercent(p)) => Some(cell_w * p)
      _ => known_w
    }
    view.perform_child_layout(
      child_id,
      Size(width=known_w, height=None),
      item_available,
      Point::zero(),
      false,
    )
    let baseline = grid_item_baseline_offset_y(tree, child_id)
    let intrinsic = tree.nodes[child_id].unrounded_layout.size
    item.set_baseline(baseline~)
    let before = resolved_margin.top + baseline
    let after = resolved_margin.bottom +
      @util.max_double(intrinsic.height - baseline, 0.0)
    row_baseline_before_max[item.row] = @util.max_double(
      row_baseline_before_max[item.row],
      before,
    )
    row_baseline_after_max[item.row] = @util.max_double(
      row_baseline_after_max[item.row],
      after,
    )
  }
  for row in 0..<row_count {
    let baseline_total = row_baseline_before_max[row] +
      row_baseline_after_max[row]
    match row_tracks[row] {
      DimAuto =>
        if baseline_total > row_sizes[row] {
          row_sizes[row] = baseline_total
        }
      _ => ()
    }
  }
  for i in 0..<placement_count {
    let item = grid_items[i]
    let child_id = item.node
    let child_style = item.style
    match child_style.display {
      DisplayNone => compute_hidden_layout(tree, child_id, Point::zero())
      _ => {
        if !item.is_in_bounds(row_count, col_count) {
          continue
        } else {
          ()
        }
        match child_style.position {
          PosAbsolute => continue
          PosRelative => ()
        }
        let grid_area_origin = item.grid_area_origin(
          col_sizes, row_sizes, col_gap_effective, row_gap_effective, start_x, start_y,
        )
        let grid_area_size = item.grid_area_size(
          col_sizes, row_sizes, col_gap_effective, row_gap_effective,
        )
        let cell_w = grid_area_size.width
        let cell_h = grid_area_size.height
        let child_available = Size(
          width=@geometry.AvailDefinite(cell_w),
          height=AvailDefinite(cell_h),
        )
        let resolved_margin = @util.resolve_rect_width_basis(
          child_style.margin,
          child_available,
        )
        let baseline_shim = item.baseline_shim
        let margin_left_auto = child_style.margin.left is DimAuto
        let margin_right_auto = child_style.margin.right is DimAuto
        let margin_top_auto = child_style.margin.top is DimAuto
        let margin_bottom_auto = child_style.margin.bottom is DimAuto
        let has_auto_margin_x = margin_left_auto || margin_right_auto
        let has_auto_margin_y = margin_top_auto || margin_bottom_auto
        let available_w_for_item = @util.max_double(
          cell_w - resolved_margin.left - resolved_margin.right,
          0.0,
        )
        let available_h_for_item = @util.max_double(
          cell_h - resolved_margin.top - resolved_margin.bottom - baseline_shim,
          0.0,
        )
        let item_available = Size(
          width=@geometry.AvailDefinite(available_w_for_item),
          height=AvailDefinite(available_h_for_item),
        )
        let justify = match child_style.justify_self {
          Some(v) => v
          None => default_justify_items
        }
        let align = match child_style.align_self {
          Some(v) => v
          None => default_align_items
        }
        let stretch_fit_limit_w = if item.column_span == 1 {
          match child_style.overflow.x {
            OverflowVisible => None
            _ =>
              match col_tracks[item.column] {
                DimFitContent(limit) =>
                  @util.resolve_optional_dimension(
                    limit,
                    AvailDefinite(content_width),
                  )
                _ => None
              }
          }
        } else {
          None
        }
        let mut known_w = match justify {
          ItemsStretch =>
            if child_style.size.width is DimAuto && !has_auto_margin_x {
              match stretch_fit_limit_w {
                Some(limit_w) =>
                  Some(
                    if limit_w < available_w_for_item {
                      limit_w
                    } else {
                      available_w_for_item
                    },
                  )
                None => Some(available_w_for_item)
              }
            } else {
              None
            }
          _ => None
        }
        let mut known_h = match align {
          ItemsStretch =>
            if child_style.size.height is DimAuto &&
              !has_auto_margin_y &&
              child_style.aspect_ratio is None {
              Some(available_h_for_item)
            } else {
              None
            }
          _ => None
        }
        match (known_w, child_style.size.width) {
          (None, DimPercent(p)) => known_w = Some(cell_w * p)
          _ => ()
        }
        match (known_h, child_style.size.height) {
          (None, DimPercent(p)) => known_h = Some(cell_h * p)
          _ => ()
        }
        view.perform_child_layout(
          child_id,
          Size(width=known_w, height=known_h),
          child_available,
          Point::zero(),
          false,
        )
        match (align, child_style.aspect_ratio, child_style.size.height) {
          (ItemsStretch, Some(ratio), DimAuto) =>
            if ratio > 0.0 &&
              known_w is Some(_) &&
              known_h is None &&
              !has_auto_margin_y {
              let intrinsic_after_stretch = tree.nodes[child_id].unrounded_layout.size
              let max_height = @util.resolve_optional_dimension(
                child_style.max_size.height,
                item_available.height,
              )
              match max_height {
                Some(max_h) if intrinsic_after_stretch.height > max_h => {
                  known_h = Some(max_h)
                  known_w = Some((max_h * ratio).round())
                }
                _ => {
                  let ratio_height = (intrinsic_after_stretch.width / ratio).round()
                  if intrinsic_after_stretch.height > ratio_height {
                    known_h = Some(ratio_height)
                  } else if intrinsic_after_stretch.height < ratio_height {
                    known_w = Some(
                      (intrinsic_after_stretch.height * ratio).round(),
                    )
                  } else {
                    ()
                  }
                }
              }
              view.perform_child_layout(
                child_id,
                Size(width=known_w, height=known_h),
                child_available,
                Point::zero(),
                false,
              )
            } else {
              ()
            }
          _ => ()
        }
        let intrinsic = tree.nodes[child_id].unrounded_layout.size
        let free_x = @util.max_double(
          available_w_for_item - intrinsic.width,
          0.0,
        )
        let free_y = @util.max_double(
          available_h_for_item - intrinsic.height,
          0.0,
        )
        let margin_left = if margin_left_auto {
          if margin_right_auto {
            free_x / 2.0
          } else {
            free_x
          }
        } else {
          resolved_margin.left
        }
        let margin_top = if margin_top_auto {
          if margin_bottom_auto {
            free_y / 2.0 + baseline_shim
          } else {
            free_y + baseline_shim
          }
        } else {
          resolved_margin.top + baseline_shim
        }
        let offset_x = if has_auto_margin_x {
          0.0
        } else {
          match justify {
            ItemsEnd | ItemsFlexEnd => available_w_for_item - intrinsic.width
            ItemsCenter => (available_w_for_item - intrinsic.width) / 2.0
            _ => 0.0
          }
        }
        let offset_y = if has_auto_margin_y {
          0.0
        } else {
          match align {
            ItemsEnd | ItemsFlexEnd => available_h_for_item - intrinsic.height
            ItemsCenter => (available_h_for_item - intrinsic.height) / 2.0
            ItemsBaseline => 0.0
            _ => 0.0
          }
        }
        let final_location = Point(
          x=base_x + grid_area_origin.x + margin_left + offset_x,
          y=base_y + grid_area_origin.y + margin_top + offset_y,
        )
        view.perform_child_layout(
          child_id,
          Size(width=known_w, height=known_h),
          child_available,
          final_location,
          false,
        )
        let final_size = tree.nodes[child_id].unrounded_layout.size
        item.set_final_area(
          y_position=final_location.y,
          height=final_size.height,
        )
      }
    }
  }
  tree.set_first_baselines(
    node_id,
    Point(x=None, y=grid_items_first_row_baseline(grid_items)),
  )
}
