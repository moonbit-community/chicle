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
fn[C] compute_grid_layout(
  view : TaffyView[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  is_layout_root : Bool,
) -> Unit raise TaffyError {
  let tree = view.tree
  ignore(is_layout_root)
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }

  let padding = @util.resolve_rect_width_basis(
    node.style.padding,
    available_space,
  )
  let border = @util.resolve_rect_width_basis(
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
  let horiz_non_scroll_inset = padding.left +
    padding.right +
    border.left +
    border.right
  let vert_non_scroll_inset = padding.top +
    padding.bottom +
    border.top +
    border.bottom
  // Overflow::Scroll reserves scrollbar space inside the border box.
  // Horizontal scrollbar consumes cross (vertical) space; vertical scrollbar consumes main (horizontal) space.
  let horiz_inset = horiz_non_scroll_inset + scrollbar_y
  let vert_inset = vert_non_scroll_inset + scrollbar_x
  let style_width = @util.resolve_optional_dimension(
    node.style.size.width,
    available_space.width,
  )
  let style_height = @util.resolve_optional_dimension(
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

  // If the container size is definite, resolve track sizing against the content box.
  // Otherwise fall back to a simplified "fixed only" resolution.
  let mut content_width = 0.0
  let mut content_height = 0.0
  let mut border_box_width = 0.0
  let mut border_box_height = 0.0
  let definite_width = grid_definite_axis_border_content_size(
    specified_width,
    node.style.min_size.width,
    node.style.max_size.width,
    available_space.width,
    horiz_inset,
    horiz_non_scroll_inset,
  )
  border_box_width = definite_width.0
  content_width = definite_width.1
  let definite_height = grid_definite_axis_border_content_size(
    specified_height,
    node.style.min_size.height,
    node.style.max_size.height,
    available_space.height,
    vert_inset,
    vert_non_scroll_inset,
  )
  border_box_height = definite_height.0
  content_height = definite_height.1

  // Grid gaps: treat `gap.width` as column gap, and `gap.height` as row gap.
  // For `percent` gaps, follow CSS semantics and resolve against the container's inline content size (width).
  // If that basis is not yet known (intrinsic sizing), percent gaps are deferred and handled after sizing.
  let gap_width_percent = match node.style.gap.width {
    DimPercent(p) => Some(p)
    _ => None
  }
  let gap_height_percent = match node.style.gap.height {
    DimPercent(p) => Some(p)
    _ => None
  }
  let gap_inline_basis = match specified_width {
    Some(_) => content_width
    None =>
      match available_space.width {
        AvailDefinite(v) => @util.max_double(v - horiz_inset, 0.0)
        _ => 0.0
      }
  }
  let mut col_gap = match gap_width_percent {
    Some(p) => gap_inline_basis * p
    None => @util.resolve_dimension(node.style.gap.width, available_space.width)
  }
  let mut row_gap = match gap_height_percent {
    Some(p) => gap_inline_basis * p
    None =>
      @util.resolve_dimension(node.style.gap.height, available_space.height)
  }

  // Expand `@style_helpers.repeat(...)` in grid templates.
  let col_expanded = expand_grid_template_axis(
    node.style.grid_template_columns,
    content_width,
    col_gap,
  )
  let row_expanded = expand_grid_template_axis(
    node.style.grid_template_rows,
    content_height,
    row_gap,
  )
  let mut explicit_col_template = col_expanded.0
  let mut explicit_row_template = row_expanded.0
  let mut non_auto_fit_col_count = col_expanded.1
  let has_auto_fit_cols = col_expanded.2
  let mut non_auto_fit_row_count = row_expanded.1
  let has_auto_fit_rows = row_expanded.2

  // If an axis has no explicit tracks, treat it as having a single implicit `auto` track.
  // This matches upstream behavior for column-only/row-only templates.
  if explicit_col_template.length() == 0 {
    explicit_col_template = [DimAuto]
    non_auto_fit_col_count = 1
  }
  if explicit_row_template.length() == 0 {
    explicit_row_template = [DimAuto]
    non_auto_fit_row_count = 1
  }
  let explicit_col_count = explicit_col_template.length()
  let explicit_row_count = explicit_row_template.length()

  let track_counts = compute_grid_size_estimate(
    tree,
    tree.children[node_id],
    explicit_col_count,
    explicit_row_count,
  )
  let col_counts = track_counts.0
  let row_counts = track_counts.1
  let negative_cols = col_counts.negative_implicit
  let negative_rows = row_counts.negative_implicit

  // Build an initial implicit grid from templates + auto tracks.
  let auto_cols = axis_auto_track_list(node.style.grid_auto_columns)
  let auto_rows = axis_auto_track_list(node.style.grid_auto_rows)
  let mut col_tracks = initialize_grid_tracks(
    col_counts, explicit_col_template, auto_cols,
  )
  let mut row_tracks = initialize_grid_tracks(
    row_counts, explicit_row_template, auto_rows,
  )

  let placement_count = tree.children[node_id].length()
  let grid_items = make_grid_items(tree, tree.children[node_id])
  let occ = matrix_make(row_tracks.length(), col_tracks.length())

  // Placement algorithm: CSS Grid auto-placement for explicit and implicit tracks.
  let primary_is_col = match node.style.grid_auto_flow {
    Row | RowDense => true
    Column | ColumnDense => false
  }
  let dense = match node.style.grid_auto_flow {
    RowDense | ColumnDense => true
    _ => false
  }

  // Pass 1: both axes definite.
  for i in 0..<placement_count {
    let item = grid_items[i]
    if item.participates_in_grid() {
      let def = item.placement_indexes_and_spans(
        explicit_col_count, explicit_row_count, negative_cols, negative_rows,
      )
      match (def.0, def.2) {
        (Some(r), Some(c)) =>
          mark_grid_item_placed(
            grid_items,
            occ,
            row_tracks,
            col_tracks,
            auto_rows,
            auto_cols,
            negative_rows,
            negative_cols,
            explicit_row_count,
            explicit_col_count,
            i,
            r,
            c,
            def.1,
            def.3,
          )
        _ => ()
      }
    }
  }

  // Pass 2: definite in secondary axis only.
  for i in 0..<placement_count {
    if grid_items[i].placed {
      continue
    }
    let item = grid_items[i]
    if item.participates_in_grid() {
      let def = item.placement_indexes_and_spans(
        explicit_col_count, explicit_row_count, negative_cols, negative_rows,
      )
      if primary_is_col {
        // Flow rows: primary axis is columns, secondary axis is rows.
        match (def.0, def.2) {
          (Some(r), None) => {
            let row_span = def.1
            let col_span = def.3
            let mut c = 0
            while true {
              ensure_rows(
                occ,
                row_tracks,
                auto_rows,
                negative_rows,
                explicit_row_count,
                r + row_span - 1,
              )
              ensure_cols(
                occ,
                col_tracks,
                auto_cols,
                negative_cols,
                explicit_col_count,
                c + col_span - 1,
              )
              if region_is_free(occ, r, c, row_span, col_span) {
                mark_grid_item_placed(
                  grid_items, occ, row_tracks, col_tracks, auto_rows, auto_cols,
                  negative_rows, negative_cols, explicit_row_count, explicit_col_count,
                  i, r, c, row_span, col_span,
                )
                break
              }
              c = c + 1
            }
          }
          _ => ()
        }
      } else {
        // Flow columns: primary axis is rows, secondary axis is columns.
        match (def.0, def.2) {
          (None, Some(c)) => {
            let row_span = def.1
            let col_span = def.3
            let mut r = 0
            while true {
              ensure_rows(
                occ,
                row_tracks,
                auto_rows,
                negative_rows,
                explicit_row_count,
                r + row_span - 1,
              )
              ensure_cols(
                occ,
                col_tracks,
                auto_cols,
                negative_cols,
                explicit_col_count,
                c + col_span - 1,
              )
              if region_is_free(occ, r, c, row_span, col_span) {
                mark_grid_item_placed(
                  grid_items, occ, row_tracks, col_tracks, auto_rows, auto_cols,
                  negative_rows, negative_cols, explicit_row_count, explicit_col_count,
                  i, r, c, row_span, col_span,
                )
                break
              }
              r = r + 1
            }
          }
          _ => ()
        }
      }
    }
  }

  // Pass 3: remaining items (auto-placement in the flow direction).
  // Dense: restart the scan for each item, filling earlier holes.
  // Sparse: resume placement from the last cursor position.
  let mut cursor_sec = 0
  let mut cursor_prim = 0
  for i in 0..<placement_count {
    if grid_items[i].placed {
      continue
    }
    let item = grid_items[i]
    if item.participates_in_grid() {
      let def = item.placement_indexes_and_spans(
        explicit_col_count, explicit_row_count, negative_cols, negative_rows,
      )
      let row_span = def.1
      let col_span = def.3
      let mut sec = if dense { 0 } else { cursor_sec }
      while true {
        if primary_is_col {
          // Auto-flow rows: scan row-by-row
          let fixed_col = def.2
          match fixed_col {
            Some(c0) =>
              while true {
                if !dense && sec == cursor_sec && c0 < cursor_prim {
                  sec = sec + 1
                }
                ensure_rows(
                  occ,
                  row_tracks,
                  auto_rows,
                  negative_rows,
                  explicit_row_count,
                  sec + row_span - 1,
                )
                ensure_cols(
                  occ,
                  col_tracks,
                  auto_cols,
                  negative_cols,
                  explicit_col_count,
                  c0 + col_span - 1,
                )
                if region_is_free(occ, sec, c0, row_span, col_span) {
                  mark_grid_item_placed(
                    grid_items, occ, row_tracks, col_tracks, auto_rows, auto_cols,
                    negative_rows, negative_cols, explicit_row_count, explicit_col_count,
                    i, sec, c0, row_span, col_span,
                  )
                  if !dense {
                    cursor_sec = sec
                    cursor_prim = c0 + col_span
                    if cursor_prim >= col_tracks.length() {
                      cursor_sec = cursor_sec + 1
                      cursor_prim = 0
                    }
                  }
                  sec = -1
                  break
                }
                sec = sec + 1
              }
            None => {
              ensure_cols(
                occ,
                col_tracks,
                auto_cols,
                negative_cols,
                explicit_col_count,
                col_span - 1,
              )
              while true {
                ensure_rows(
                  occ,
                  row_tracks,
                  auto_rows,
                  negative_rows,
                  explicit_row_count,
                  sec + row_span - 1,
                )
                let mut prim = if dense || sec != cursor_sec {
                  0
                } else {
                  cursor_prim
                }
                let max_prim = col_tracks.length() - col_span + 1
                let mut found = false
                while prim < max_prim {
                  if region_is_free(occ, sec, prim, row_span, col_span) {
                    mark_grid_item_placed(
                      grid_items, occ, row_tracks, col_tracks, auto_rows, auto_cols,
                      negative_rows, negative_cols, explicit_row_count, explicit_col_count,
                      i, sec, prim, row_span, col_span,
                    )
                    if !dense {
                      cursor_sec = sec
                      cursor_prim = prim + col_span
                      if cursor_prim >= col_tracks.length() {
                        cursor_sec = cursor_sec + 1
                        cursor_prim = 0
                      }
                    }
                    found = true
                    break
                  }
                  prim = prim + 1
                }
                if found {
                  sec = -1
                  break
                }
                sec = sec + 1
              }
            }
          }
          if sec == -1 {
            break
          }
        } else {
          // Auto-flow columns: scan col-by-col
          let fixed_row = def.0
          match fixed_row {
            Some(r0) =>
              while true {
                if !dense && sec == cursor_sec && r0 < cursor_prim {
                  sec = sec + 1
                }
                ensure_cols(
                  occ,
                  col_tracks,
                  auto_cols,
                  negative_cols,
                  explicit_col_count,
                  sec + col_span - 1,
                )
                ensure_rows(
                  occ,
                  row_tracks,
                  auto_rows,
                  negative_rows,
                  explicit_row_count,
                  r0 + row_span - 1,
                )
                if region_is_free(occ, r0, sec, row_span, col_span) {
                  mark_grid_item_placed(
                    grid_items, occ, row_tracks, col_tracks, auto_rows, auto_cols,
                    negative_rows, negative_cols, explicit_row_count, explicit_col_count,
                    i, r0, sec, row_span, col_span,
                  )
                  if !dense {
                    cursor_sec = sec
                    cursor_prim = r0 + row_span
                    if cursor_prim >= row_tracks.length() {
                      cursor_sec = cursor_sec + 1
                      cursor_prim = 0
                    }
                  }
                  sec = -1
                  break
                }
                sec = sec + 1
              }
            None => {
              ensure_rows(
                occ,
                row_tracks,
                auto_rows,
                negative_rows,
                explicit_row_count,
                row_span - 1,
              )
              while true {
                ensure_cols(
                  occ,
                  col_tracks,
                  auto_cols,
                  negative_cols,
                  explicit_col_count,
                  sec + col_span - 1,
                )
                let mut prim = if dense || sec != cursor_sec {
                  0
                } else {
                  cursor_prim
                }
                let max_prim = row_tracks.length() - row_span + 1
                let mut found = false
                while prim < max_prim {
                  if region_is_free(occ, prim, sec, row_span, col_span) {
                    mark_grid_item_placed(
                      grid_items, occ, row_tracks, col_tracks, auto_rows, auto_cols,
                      negative_rows, negative_cols, explicit_row_count, explicit_col_count,
                      i, prim, sec, row_span, col_span,
                    )
                    if !dense {
                      cursor_sec = sec
                      cursor_prim = prim + row_span
                      if cursor_prim >= row_tracks.length() {
                        cursor_sec = cursor_sec + 1
                        cursor_prim = 0
                      }
                    }
                    found = true
                    break
                  }
                  prim = prim + 1
                }
                if found {
                  sec = -1
                  break
                }
                sec = sec + 1
              }
            }
          }
          if sec == -1 {
            break
          }
        }
      }
    }
  }
  let mut col_count = col_tracks.length()
  let mut row_count = row_tracks.length()
  initialize_grid_item_track_crossings(grid_items, col_tracks, row_tracks)

  // Compute min-content and max-content contributions for each track.
  let track_contributions = GridTrackContributions(
    column_count=col_count,
    row_count~,
  )

  let justify_content = match node.style.justify_content {
    Some(v) => v
    None => AlignStart
  }
  let default_align_items_for_contrib = match node.style.align_items {
    Some(v) => v
    None => ItemsStretch
  }
  let default_justify_items_for_contrib = match node.style.justify_items {
    Some(v) => v
    None => ItemsStretch
  }
  let initial_sizing = compute_initial_grid_track_sizing(
    view, grid_items, placement_count, col_tracks, row_tracks, track_contributions,
    col_gap, row_gap, content_width, content_height, available_space, horiz_inset,
    vert_inset, specified_width, specified_height, justify_content, default_align_items_for_contrib,
    default_justify_items_for_contrib,
  )
  let mut col_sizes = initial_sizing.0
  let mut row_sizes = initial_sizing.1
  let col_min_basis = initial_sizing.2
  let col_max_basis = initial_sizing.3
  let col_available_base = initial_sizing.4
  let row_min_basis = initial_sizing.5
  let row_max_basis = initial_sizing.6
  let row_available_base = initial_sizing.7
  let mut used_cols = grid_axis_used_size(col_sizes, col_gap)
  let mut used_rows = grid_axis_used_size(row_sizes, row_gap)

  // Container sizing (border-box). If width/height are not specified, size to tracks.
  if specified_width is None {
    let auto_width = grid_auto_axis_border_content_size(
      available_space.width,
      horiz_inset,
      horiz_non_scroll_inset,
      node.style.min_size.width,
      node.style.max_size.width,
      col_min_basis,
      col_max_basis,
      used_cols,
    )
    border_box_width = auto_width.0
    content_width = auto_width.1
  }
  if specified_height is None {
    let auto_height = grid_auto_axis_border_content_size(
      available_space.height,
      vert_inset,
      vert_non_scroll_inset,
      node.style.min_size.height,
      node.style.max_size.height,
      row_min_basis,
      row_max_basis,
      used_rows,
    )
    border_box_height = auto_height.0
    content_height = auto_height.1
  }

  // Deferred percentage gaps: if the container inline size was unknown during intrinsic sizing,
  // re-resolve percentage gaps against the computed inline content size and recompute track sizes.
  let resolved_gap_rerun = resolve_deferred_grid_percent_gaps(
    content_width, col_gap, row_gap, gap_width_percent, gap_height_percent,
  )
  col_gap = resolved_gap_rerun.0
  row_gap = resolved_gap_rerun.1
  let rerun_track_sizing = resolved_gap_rerun.2
  if rerun_track_sizing {
    let rerun_result = rerun_grid_track_sizing_after_percent_gap_resolution(
      view, grid_items, placement_count, col_tracks, row_tracks, track_contributions,
      col_available_base, row_available_base, col_gap, row_gap, content_height, specified_width,
      specified_height, justify_content, default_align_items_for_contrib, default_justify_items_for_contrib,
    )
    col_sizes = rerun_result.0
    row_sizes = rerun_result.1
    used_cols = rerun_result.2
    used_rows = rerun_result.3
  }
  tree.set_unrounded_layout(node_id, {
    ..Layout::zero(),
    location: absolute_origin,
    size: Size(width=border_box_width, height=border_box_height),
  })

  // Track alignment within the container's content box.
  let align_content = match node.style.align_content {
    Some(v) => v
    None => AlignStart
  }

  // `@style_helpers.repeat(auto-fit, ...)` collapses empty tracks.
  if has_auto_fit_cols || has_auto_fit_rows {
    let mut max_row_used = 0
    let mut max_col_used = 0
    for i in 0..<placement_count {
      if !grid_items[i].placed {
        continue
      }
      let item = grid_items[i]
      let row_end = item.row + item.row_span - 1
      let col_end = item.column + item.column_span - 1
      if row_end > max_row_used {
        max_row_used = row_end
      }
      if col_end > max_col_used {
        max_col_used = col_end
      }
    }
    if has_auto_fit_cols {
      let needed = max_col_used + 1
      let keep = if needed > non_auto_fit_col_count {
        needed
      } else {
        non_auto_fit_col_count
      }
      if keep > 0 && keep < col_count {
        col_count = keep
        let truncated : Array[Double] = Array::make(col_count, 0.0)
        for i in 0..<col_count {
          truncated[i] = col_sizes[i]
        }
        col_sizes = truncated
        let truncated_tracks : Array[Dimension] = Array::make(
          col_count,
          DimAuto,
        )
        for i in 0..<col_count {
          truncated_tracks[i] = col_tracks[i]
        }
        col_tracks = truncated_tracks
        used_cols = 0.0
        for w in col_sizes {
          used_cols = used_cols + w
        }
        if col_count > 1 {
          used_cols = used_cols + col_gap * (col_count - 1).to_double()
        }
      }
    }
    if has_auto_fit_rows {
      let needed = max_row_used + 1
      let keep = if needed > non_auto_fit_row_count {
        needed
      } else {
        non_auto_fit_row_count
      }
      if keep > 0 && keep < row_count {
        row_count = keep
        let truncated : Array[Double] = Array::make(row_count, 0.0)
        for i in 0..<row_count {
          truncated[i] = row_sizes[i]
        }
        row_sizes = truncated
        let truncated_tracks : Array[Dimension] = Array::make(
          row_count,
          DimAuto,
        )
        for i in 0..<row_count {
          truncated_tracks[i] = row_tracks[i]
        }
        row_tracks = truncated_tracks
        used_rows = 0.0
        for h in row_sizes {
          used_rows = used_rows + h
        }
        if row_count > 1 {
          used_rows = used_rows + row_gap * (row_count - 1).to_double()
        }
      }
    }
  }
  let leftover_x = content_width - used_cols
  let leftover_y = content_height - used_rows
  let mut start_x = 0.0
  let mut col_gap_effective = col_gap
  match justify_content {
    AlignCenter => start_x = leftover_x / 2.0
    AlignFlexEnd | AlignEnd => start_x = leftover_x
    AlignFlexStart | AlignStart => ()
    AlignSpaceBetween =>
      if col_count > 1 && leftover_x > 0.0 {
        col_gap_effective = col_gap_effective +
          leftover_x / (col_count - 1).to_double()
      }
    AlignSpaceAround =>
      if col_count > 0 && leftover_x > 0.0 {
        let extra = leftover_x / col_count.to_double()
        if is_near_int(leftover_x) {
          let gap_extra_floor = extra.floor()
          let gap_extra = if extra > gap_extra_floor {
            gap_extra_floor + 1.0
          } else {
            gap_extra_floor
          }
          col_gap_effective = col_gap_effective + gap_extra
          start_x = (extra / 2.0).floor()
        } else {
          col_gap_effective = col_gap_effective + extra
          start_x = extra / 2.0
        }
      }
    AlignSpaceEvenly =>
      if col_count > 0 && leftover_x > 0.0 {
        let spaces = (col_count + 1).to_double()
        let extra = leftover_x / spaces
        if leftover_x > 0.0 && is_near_int(leftover_x) {
          let start_extra = extra.floor()
          let gap_extra = if extra > start_extra {
            start_extra + 1.0
          } else {
            start_extra
          }
          col_gap_effective = col_gap_effective + gap_extra
          start_x = start_extra
        } else {
          col_gap_effective = col_gap_effective + extra
          start_x = extra
        }
      }
    AlignStretch =>
      if col_count > 0 {
        let extra = leftover_x / col_count.to_double()
        for i in 0..<col_count {
          let v = col_sizes[i] + extra
          col_sizes[i] = if v > 0.0 { v } else { 0.0 }
        }
      }
  }
  let mut start_y = 0.0
  let mut row_gap_effective = row_gap
  match align_content {
    AlignCenter => start_y = leftover_y / 2.0
    AlignFlexEnd | AlignEnd => start_y = leftover_y
    AlignFlexStart | AlignStart => ()
    AlignSpaceBetween =>
      if row_count > 1 && leftover_y > 0.0 {
        row_gap_effective = row_gap_effective +
          leftover_y / (row_count - 1).to_double()
      }
    AlignSpaceAround =>
      if row_count > 0 && leftover_y > 0.0 {
        let extra = leftover_y / row_count.to_double()
        if is_near_int(leftover_y) {
          let gap_extra_floor = extra.floor()
          let gap_extra = if extra > gap_extra_floor {
            gap_extra_floor + 1.0
          } else {
            gap_extra_floor
          }
          row_gap_effective = row_gap_effective + gap_extra
          start_y = (extra / 2.0).floor()
        } else {
          row_gap_effective = row_gap_effective + extra
          start_y = extra / 2.0
        }
      }
    AlignSpaceEvenly =>
      if row_count > 0 && leftover_y > 0.0 {
        let spaces = (row_count + 1).to_double()
        let extra = leftover_y / spaces
        if leftover_y > 0.0 && is_near_int(leftover_y) {
          let start_extra = extra.floor()
          let gap_extra = if extra > start_extra {
            start_extra + 1.0
          } else {
            start_extra
          }
          row_gap_effective = row_gap_effective + gap_extra
          start_y = start_extra
        } else {
          row_gap_effective = row_gap_effective + extra
          start_y = extra
        }
      }
    AlignStretch =>
      if row_count > 0 {
        let extra = leftover_y / row_count.to_double()
        for i in 0..<row_count {
          let v = row_sizes[i] + extra
          row_sizes[i] = if v > 0.0 { v } else { 0.0 }
        }
      }
  }
  let default_align_items = match node.style.align_items {
    Some(v) => v
    None => ItemsStretch
  }
  let default_justify_items = match node.style.justify_items {
    Some(v) => v
    None => ItemsStretch
  }
  compute_grid_relative_children_final_placement(
    view, node_id, grid_items, placement_count, col_tracks, row_tracks, col_sizes,
    row_sizes, col_gap_effective, row_gap_effective, start_x, start_y, absolute_origin,
    border, padding, content_width, default_align_items, default_justify_items, row_count,
    col_count,
  )
  compute_grid_absolute_placement(
    view,
    tree.children[node_id],
    node.style,
    col_sizes,
    row_sizes,
    col_gap_effective,
    row_gap_effective,
    start_x,
    start_y,
    absolute_origin,
    border,
    padding,
    border_box_width,
    border_box_height,
    explicit_col_count,
    explicit_row_count,
    negative_cols,
    negative_rows,
  )
  let resolved_margin = @util.resolve_rect_width_basis(
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
