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
fn[C] compute_grid_layout_with_measure(
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
  fn origin_zero_line(value : Int, explicit_track_count : Int) -> Int? {
    if value == 0 {
      None
    } else if value > 0 {
      Some(value - 1)
    } else {
      // Negative indices count back from the end of the explicit grid.
      let explicit_line_count = explicit_track_count + 1
      Some(value + explicit_line_count)
    }
  }

  fn merged_placement_line(
    placement : Line[GridPlacement],
    legacy_start : Int?,
  ) -> Line[GridPlacement] {
    match legacy_start {
      Some(v) => Line::new(start=PlaceLine(v), end=placement.end)
      None => placement
    }
  }

  fn placement_span_value(span : Int) -> Int {
    if span > 0 {
      span
    } else {
      1
    }
  }

  fn axis_resolve_start_line_and_span(
    placement : Line[GridPlacement],
    explicit_track_count : Int,
  ) -> (Int?, Int) {
    let start_line = match placement.start {
      PlaceLine(v) => origin_zero_line(v, explicit_track_count)
      _ => None
    }
    let end_line = match placement.end {
      PlaceLine(v) => origin_zero_line(v, explicit_track_count)
      _ => None
    }
    let explicit_span = match placement.start {
      PlaceSpan(s) => Some(placement_span_value(s))
      _ =>
        match placement.end {
          PlaceSpan(s) => Some(placement_span_value(s))
          _ => None
        }
    }
    match explicit_span {
      Some(span) =>
        match (start_line, end_line) {
          (Some(sl), _) => (Some(sl), span)
          (None, Some(el)) => (Some(el - span), span)
          _ => (None, span)
        }
      None =>
        match (start_line, end_line) {
          (Some(sl), Some(el)) => {
            let span = if el > sl { el - sl } else { 1 }
            (Some(sl), span)
          }
          (Some(sl), None) => (Some(sl), 1)
          (None, Some(el)) => (Some(el - 1), 1)
          _ => (None, 1)
        }
    }
  }

  fn axis_auto_track_list(auto_tracks : Array[Dimension]) -> Array[Dimension] {
    if auto_tracks.length() == 0 {
      [DimAuto]
    } else {
      auto_tracks
    }
  }

  fn negative_auto_track_at(
    auto_tracks : Array[Dimension],
    offset_from_explicit : Int,
  ) -> Dimension {
    let len = auto_tracks.length()
    if len == 0 {
      DimAuto
    } else {
      // `offset_from_explicit` is 1-based: 1 means the track adjacent to the explicit grid.
      let m = offset_from_explicit % len
      let idx = (len - m) % len
      auto_tracks[idx]
    }
  }

  let padding = resolve_rect_width_basis(node.style.padding, available_space)
  let border = resolve_rect_width_basis(node.style.border, available_space)
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

  // If the container size is definite, resolve track sizing against the content box.
  // Otherwise fall back to a simplified "fixed only" resolution.
  let mut content_width = 0.0
  let mut content_height = 0.0
  let mut border_box_width = 0.0
  let mut border_box_height = 0.0
  match specified_width {
    Some(w) => {
      border_box_width = max_double(
        clamp_dimension(
          w,
          node.style.min_size.width,
          node.style.max_size.width,
          available_space.width,
        ),
        horiz_non_scroll_inset,
      )
      content_width = max_double(border_box_width - horiz_inset, 0.0)
    }
    None => ()
  }
  match specified_height {
    Some(h) => {
      border_box_height = max_double(
        clamp_dimension(
          h,
          node.style.min_size.height,
          node.style.max_size.height,
          available_space.height,
        ),
        vert_non_scroll_inset,
      )
      content_height = max_double(border_box_height - vert_inset, 0.0)
    }
    None => ()
  }

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
        AvailDefinite(v) => max_double(v - horiz_inset, 0.0)
        _ => 0.0
      }
  }
  let mut col_gap = match gap_width_percent {
    Some(p) => gap_inline_basis * p
    None => resolve_dimension(node.style.gap.width, available_space.width)
  }
  let mut row_gap = match gap_height_percent {
    Some(p) => gap_inline_basis * p
    None => resolve_dimension(node.style.gap.height, available_space.height)
  }

  // Expand `repeat(...)` in grid templates.
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

  // Compute implicit track counts required by definite placements (negative/positive implicit tracks).
  let mut min_col_line = 0
  let mut max_col_line = 0
  let mut min_row_line = 0
  let mut max_row_line = 0
  for child_id in node.children {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    let col_line = merged_placement_line(
      child.style.grid_column,
      child.style.grid_column_start,
    )
    let row_line = merged_placement_line(
      child.style.grid_row,
      child.style.grid_row_start,
    )
    let col_res = axis_resolve_start_line_and_span(col_line, explicit_col_count)
    match col_res.0 {
      Some(sl) => {
        if sl < min_col_line {
          min_col_line = sl
        }
        let end = sl + col_res.1
        if end > max_col_line {
          max_col_line = end
        }
      }
      None => ()
    }
    let row_res = axis_resolve_start_line_and_span(row_line, explicit_row_count)
    match row_res.0 {
      Some(sl) => {
        if sl < min_row_line {
          min_row_line = sl
        }
        let end = sl + row_res.1
        if end > max_row_line {
          max_row_line = end
        }
      }
      None => ()
    }
  }
  let negative_cols = if min_col_line < 0 { -min_col_line } else { 0 }
  let positive_cols = if max_col_line > explicit_col_count {
    max_col_line - explicit_col_count
  } else {
    0
  }
  let negative_rows = if min_row_line < 0 { -min_row_line } else { 0 }
  let positive_rows = if max_row_line > explicit_row_count {
    max_row_line - explicit_row_count
  } else {
    0
  }

  // Build an initial implicit grid from templates + auto tracks.
  let auto_cols = axis_auto_track_list(node.style.grid_auto_columns)
  let auto_rows = axis_auto_track_list(node.style.grid_auto_rows)
  let mut col_tracks : Array[Dimension] = []
  for i in 0..<negative_cols {
    let offset = negative_cols - i
    col_tracks.push(negative_auto_track_at(auto_cols, offset))
  }
  for t in explicit_col_template {
    col_tracks.push(t)
  }
  for i in 0..<positive_cols {
    col_tracks.push(auto_cols[i % auto_cols.length()])
  }
  let mut row_tracks : Array[Dimension] = []
  for i in 0..<negative_rows {
    let offset = negative_rows - i
    row_tracks.push(negative_auto_track_at(auto_rows, offset))
  }
  for t in explicit_row_template {
    row_tracks.push(t)
  }
  for i in 0..<positive_rows {
    row_tracks.push(auto_rows[i % auto_rows.length()])
  }
  fn matrix_make(rows : Int, cols : Int) -> Array[Array[Bool]] {
    let m : Array[Array[Bool]] = []
    for _r in 0..<rows {
      m.push(Array::make(cols, false))
    }
    m
  }

  let placement_count = node.children.length()
  let placed : Array[Bool] = Array::make(placement_count, false)
  let placed_row : Array[Int] = Array::make(placement_count, 0)
  let placed_col : Array[Int] = Array::make(placement_count, 0)
  let placed_row_span : Array[Int] = Array::make(placement_count, 1)
  let placed_col_span : Array[Int] = Array::make(placement_count, 1)
  let occ = matrix_make(row_tracks.length(), col_tracks.length())
  fn ensure_cols(
    occ : Array[Array[Bool]],
    col_tracks : Array[Dimension],
    auto_cols : Array[Dimension],
    negative_cols : Int,
    explicit_cols : Int,
    target_col : Int,
  ) -> Unit {
    while col_tracks.length() <= target_col {
      let pos_existing = col_tracks.length() - negative_cols - explicit_cols
      let dim = auto_cols[pos_existing % auto_cols.length()]
      col_tracks.push(dim)
      for r in 0..<occ.length() {
        occ[r].push(false)
      }
    }
  }

  fn ensure_rows(
    occ : Array[Array[Bool]],
    row_tracks : Array[Dimension],
    auto_rows : Array[Dimension],
    negative_rows : Int,
    explicit_rows : Int,
    target_row : Int,
  ) -> Unit {
    while row_tracks.length() <= target_row {
      let pos_existing = row_tracks.length() - negative_rows - explicit_rows
      let dim = auto_rows[pos_existing % auto_rows.length()]
      row_tracks.push(dim)
      occ.push(Array::make(occ[0].length(), false))
    }
  }

  fn region_is_free(
    occ : Array[Array[Bool]],
    row : Int,
    col : Int,
    row_span : Int,
    col_span : Int,
  ) -> Bool {
    for r in row..<(row + row_span) {
      for c in col..<(col + col_span) {
        if occ[r][c] {
          return false
        }
      }
    }
    true
  }

  fn mark_placed(
    placed : Array[Bool],
    placed_row : Array[Int],
    placed_col : Array[Int],
    placed_row_span : Array[Int],
    placed_col_span : Array[Int],
    occ : Array[Array[Bool]],
    row_tracks : Array[Dimension],
    col_tracks : Array[Dimension],
    auto_rows : Array[Dimension],
    auto_cols : Array[Dimension],
    negative_rows : Int,
    negative_cols : Int,
    explicit_rows : Int,
    explicit_cols : Int,
    idx : Int,
    row : Int,
    col : Int,
    row_span : Int,
    col_span : Int,
  ) -> Unit {
    let row_end = row + row_span - 1
    let col_end = col + col_span - 1
    ensure_rows(
      occ, row_tracks, auto_rows, negative_rows, explicit_rows, row_end,
    )
    ensure_cols(
      occ, col_tracks, auto_cols, negative_cols, explicit_cols, col_end,
    )
    for r in row..<(row + row_span) {
      for c in col..<(col + col_span) {
        occ[r][c] = true
      }
    }
    placed[idx] = true
    placed_row[idx] = row
    placed_col[idx] = col
    placed_row_span[idx] = row_span
    placed_col_span[idx] = col_span
  }

  fn axis_start_index_and_span(
    placement : Line[GridPlacement],
    legacy_start : Int?,
    explicit_track_count : Int,
    negative_implicit : Int,
  ) -> (Int?, Int) {
    let merged = merged_placement_line(placement, legacy_start)
    let resolved = axis_resolve_start_line_and_span(
      merged, explicit_track_count,
    )
    let start = match resolved.0 {
      Some(sl) => Some(sl + negative_implicit)
      None => None
    }
    (start, resolved.1)
  }

  fn child_start_indexes_and_spans(
    child_style : Style,
    explicit_cols : Int,
    explicit_rows : Int,
    negative_cols : Int,
    negative_rows : Int,
  ) -> (Int?, Int, Int?, Int) {
    let col = axis_start_index_and_span(
      child_style.grid_column,
      child_style.grid_column_start,
      explicit_cols,
      negative_cols,
    )
    let row = axis_start_index_and_span(
      child_style.grid_row,
      child_style.grid_row_start,
      explicit_rows,
      negative_rows,
    )
    (row.0, row.1, col.0, col.1)
  }

  // Placement algorithm: very small subset of CSS Grid (enough for upstream implicit/auto tracks tests).
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
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => ()
      _ => {
        match child.style.position {
          PosAbsolute => continue
          PosRelative => ()
        }
        let def = child_start_indexes_and_spans(
          child.style,
          explicit_col_count,
          explicit_row_count,
          negative_cols,
          negative_rows,
        )
        match (def.0, def.2) {
          (Some(r), Some(c)) =>
            mark_placed(
              placed,
              placed_row,
              placed_col,
              placed_row_span,
              placed_col_span,
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
  }

  // Pass 2: definite in secondary axis only.
  for i in 0..<placement_count {
    if placed[i] {
      continue
    }
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => ()
      _ => {
        match child.style.position {
          PosAbsolute => continue
          PosRelative => ()
        }
        let def = child_start_indexes_and_spans(
          child.style,
          explicit_col_count,
          explicit_row_count,
          negative_cols,
          negative_rows,
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
                  mark_placed(
                    placed, placed_row, placed_col, placed_row_span, placed_col_span,
                    occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                    negative_cols, explicit_row_count, explicit_col_count, i, r,
                    c, row_span, col_span,
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
                  mark_placed(
                    placed, placed_row, placed_col, placed_row_span, placed_col_span,
                    occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                    negative_cols, explicit_row_count, explicit_col_count, i, r,
                    c, row_span, col_span,
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
  }

  // Pass 3: remaining items (auto-placement in the flow direction).
  // Dense: restart the scan for each item, filling earlier holes.
  // Sparse: resume placement from the last cursor position.
  let mut cursor_sec = 0
  let mut cursor_prim = 0
  for i in 0..<placement_count {
    if placed[i] {
      continue
    }
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => ()
      _ => {
        match child.style.position {
          PosAbsolute => continue
          PosRelative => ()
        }
        let def = child_start_indexes_and_spans(
          child.style,
          explicit_col_count,
          explicit_row_count,
          negative_cols,
          negative_rows,
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
                  if not(dense) && sec == cursor_sec && c0 < cursor_prim {
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
                    mark_placed(
                      placed, placed_row, placed_col, placed_row_span, placed_col_span,
                      occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                      negative_cols, explicit_row_count, explicit_col_count, i, sec,
                      c0, row_span, col_span,
                    )
                    if not(dense) {
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
                      mark_placed(
                        placed, placed_row, placed_col, placed_row_span, placed_col_span,
                        occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                        negative_cols, explicit_row_count, explicit_col_count, i,
                        sec, prim, row_span, col_span,
                      )
                      if not(dense) {
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
                  if not(dense) && sec == cursor_sec && r0 < cursor_prim {
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
                    mark_placed(
                      placed, placed_row, placed_col, placed_row_span, placed_col_span,
                      occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                      negative_cols, explicit_row_count, explicit_col_count, i, r0,
                      sec, row_span, col_span,
                    )
                    if not(dense) {
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
                      mark_placed(
                        placed, placed_row, placed_col, placed_row_span, placed_col_span,
                        occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                        negative_cols, explicit_row_count, explicit_col_count, i,
                        prim, sec, row_span, col_span,
                      )
                      if not(dense) {
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
  }
  let mut col_count = col_tracks.length()
  let mut row_count = row_tracks.length()

  // Compute min-content and max-content contributions for each track.
  let col_min_contrib : Array[Double] = Array::make(col_count, 0.0)
  let col_max_contrib : Array[Double] = Array::make(col_count, 0.0)
  let row_min_contrib : Array[Double] = Array::make(row_count, 0.0)
  let row_max_contrib : Array[Double] = Array::make(row_count, 0.0)
  fn fr_track_weight(track : Dimension) -> Double {
    match track {
      DimFr(w) => if w > 0.0 { w } else { 0.0 }
      _ => 0.0
    }
  }

  fn apply_col_contribution(
    col_tracks : Array[Dimension],
    start : Int,
    span : Int,
    needed : Double,
    contrib : Array[Double],
  ) -> Unit {
    if span <= 1 {
      if needed > contrib[start] {
        contrib[start] = needed
      }
      return
    }
    let mut all_fr = true
    let weights : Array[Double] = Array::make(span, 0.0)
    let mut positive_weight_sum = 0.0
    for offset in 0..<span {
      let idx = start + offset
      let track = col_tracks[idx]
      if not(track is DimFr(_)) {
        all_fr = false
      }
      let weight = fr_track_weight(track)
      weights[offset] = weight
      if weight > 0.0 {
        positive_weight_sum = positive_weight_sum + weight
      }
    }
    if all_fr {
      if positive_weight_sum > 0.0 {
        for offset in 0..<span {
          let idx = start + offset
          let share = needed * weights[offset] / positive_weight_sum
          if share > contrib[idx] {
            contrib[idx] = share
          }
        }
      } else {
        let share = needed / span.to_double()
        for offset in 0..<span {
          let idx = start + offset
          if share > contrib[idx] {
            contrib[idx] = share
          }
        }
      }
    } else if positive_weight_sum > 0.0 {
      let mut current_sum = 0.0
      for offset in 0..<span {
        let idx = start + offset
        current_sum = current_sum + contrib[idx]
      }
      let deficit = needed - current_sum
      if deficit > 0.0 {
        for offset in 0..<span {
          let idx = start + offset
          let weight = weights[offset]
          if weight > 0.0 {
            contrib[idx] = contrib[idx] + deficit * weight / positive_weight_sum
          }
        }
      }
    } else {
      let share = needed / span.to_double()
      for offset in 0..<span {
        let idx = start + offset
        if share > contrib[idx] {
          contrib[idx] = share
        }
      }
    }
  }

  fn track_definite_len(track : Dimension) -> Double? {
    match track {
      DimLength(v) => Some(v)
      DimMinMax(min_d, max_d) =>
        match (min_d, max_d) {
          (DimLength(a), DimLength(b)) if a == b => Some(a)
          _ => None
        }
      _ => None
    }
  }

  fn spanned_definite_len(
    tracks : Array[Dimension],
    start : Int,
    span : Int,
    gap : Double,
  ) -> Double? {
    if span <= 0 {
      return Some(0.0)
    }
    let mut total = 0.0
    for i in start..<(start + span) {
      match track_definite_len(tracks[i]) {
        Some(v) => total = total + v
        None => return None
      }
    }
    if span > 1 {
      total = total + gap * (span - 1).to_double()
    }
    Some(total)
  }

  fn col_min_sizing_kind(track : Dimension) -> Int {
    // 0 = fixed/other, 1 = min-content, 2 = max-content, 3 = auto
    match track {
      DimMinContent => 1
      DimMaxContent => 2
      DimAuto => 3
      DimFitContent(_) => 3
      DimMinMax(min_d, _) =>
        match min_d {
          DimMinContent => 1
          DimMaxContent => 2
          DimAuto => 3
          DimFitContent(_) => 3
          _ => 0
        }
      _ => 0
    }
  }

  fn compute_intrinsic_bases_max_content(
    tracks : Array[Dimension],
    col_start : Array[Int],
    col_span : Array[Int],
    min_needed : Array[Double],
    max_needed : Array[Double],
    placed : Array[Bool],
    percent_basis : Double?,
  ) -> Array[Double] {
    let count = tracks.length()
    let bases : Array[Double] = Array::make(count, 0.0)
    for i in 0..<count {
      match tracks[i] {
        DimLength(v) => bases[i] = v
        DimPercent(p) =>
          match percent_basis {
            Some(b) => bases[i] = b * p
            None => bases[i] = 0.0
          }
        DimMinMax(min_d, max_d) =>
          // Handle simple fixed-length/percent minmax cases
          match (min_d, max_d, percent_basis) {
            (DimLength(a), DimLength(b), _) if a == b => bases[i] = a
            (DimPercent(p), DimPercent(q), Some(b)) if p == q =>
              bases[i] = b * p
            _ => ()
          }
        _ => ()
      }
    }

    fn distribute(
      bases : Array[Double],
      tracks : Array[Dimension],
      start : Int,
      span : Int,
      space : Double,
      should_affect : (Int, Dimension) -> Bool,
    ) -> Unit {
      if space <= 0.0 || span <= 0 {
        return
      }
      let mut used = 0.0
      for j in start..<(start + span) {
        used = used + bases[j]
      }
      let extra = space - used
      if extra <= 0.0 {
        return
      }
      let mut count = 0
      for j in start..<(start + span) {
        if should_affect(j, tracks[j]) {
          count = count + 1
        }
      }
      if count <= 0 {
        return
      }
      let share = extra / count.to_double()
      for j in start..<(start + span) {
        if should_affect(j, tracks[j]) {
          bases[j] = bases[j] + share
        }
      }
    }

    let mut max_span = 1
    for i in 0..<placed.length() {
      if placed[i] && col_span[i] > max_span {
        max_span = col_span[i]
      }
    }

    // Distribute min-content contributions, then max-content contributions (max-content constraint quirk).
    for span in 1..<(max_span + 1) {
      for i in 0..<placed.length() {
        if !placed[i] || col_span[i] != span {
          continue
        }
        let s = col_start[i]
        let sp = col_span[i]
        let min_space = min_needed[i]
        distribute(bases, tracks, s, sp, min_space, fn(_idx, track) {
          let k = col_min_sizing_kind(track)
          k == 1 || k == 2
        })
      }
    }

    for span in 1..<(max_span + 1) {
      for i in 0..<placed.length() {
        if !placed[i] || col_span[i] != span {
          continue
        }
        let s = col_start[i]
        let sp = col_span[i]
        let max_space = max_needed[i]
        let mut has_max_content = false
        for j in s..<(s + sp) {
          if col_min_sizing_kind(tracks[j]) == 2 {
            has_max_content = true
            break
          }
        }
        let affect_kind = if has_max_content { 2 } else { 3 }
        distribute(bases, tracks, s, sp, max_space, fn(_idx, track) {
          col_min_sizing_kind(track) == affect_kind
        })
      }
    }

    bases
  }

  let col_item_min_needed : Array[Double] = Array::make(placement_count, 0.0)
  let col_item_max_needed : Array[Double] = Array::make(placement_count, 0.0)

  for i in 0..<placement_count {
    if not(placed[i]) {
      continue
    }
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c0) => c0
      None => raise InvalidNodeId(child_id)
    }
    let c = placed_col[i]
    let col_span = placed_col_span[i]
    let r = placed_row[i]
    let row_span = placed_row_span[i]
    let gap_total = col_gap * (col_span - 1).to_double()
    let contrib_available_height = match specified_height {
      Some(_) => AvailDefinite(content_height)
      None =>
        match spanned_definite_len(row_tracks, r, row_span, row_gap) {
          Some(v) => AvailDefinite(v)
          None => AvailMaxContent
        }
    }

    // Max-content contribution in the column axis
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=None, height=None),
      Size::new(width=AvailMaxContent, height=contrib_available_height),
      Point::zero(),
      measure_function,
      false,
    )
    let max_sz = tree.nodes[child_id].layout.size
    let resolved_margin = resolve_rect_width_basis(
      child.style.margin,
      Size::new(width=AvailMaxContent, height=AvailMaxContent),
    )
    let max_needed = max_double(
      max_sz.width + resolved_margin.left + resolved_margin.right - gap_total,
      0.0,
    )
    col_item_max_needed[i] = max_needed
    apply_col_contribution(col_tracks, c, col_span, max_needed, col_max_contrib)

    // Min-content contribution in the column axis
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=None, height=None),
      Size::new(width=AvailMinContent, height=contrib_available_height),
      Point::zero(),
      measure_function,
      false,
    )
    let min_col_raw = tree.nodes[child_id].layout.size.width
    let min_col = match (child.style.overflow.x, child.style.overflow.y) {
      (OverflowVisible, OverflowVisible) => min_col_raw
      _ => 0.0
    }
    let min_needed = max_double(
      min_col + resolved_margin.left + resolved_margin.right - gap_total,
      0.0,
    )
    col_item_min_needed[i] = min_needed
    apply_col_contribution(col_tracks, c, col_span, min_needed, col_min_contrib)
  }
  fn track_basis_fit_content(
    min_c : Double,
    max_c : Double,
    limit : Dimension,
    available : Double,
  ) -> Double {
    match limit {
      DimPercent(_) => max_c
      _ => {
        let lim = resolve_track_dimension(limit, available)
        let preferred = if max_c < lim { max_c } else { lim }
        if preferred < min_c {
          min_c
        } else {
          preferred
        }
      }
    }
  }

  fn axis_min_content_basis(
    tracks : Array[Dimension],
    min_contrib : Array[Double],
    max_contrib : Array[Double],
    gap : Double,
  ) -> Double {
    let mut total = 0.0
    let mut fr_sum = 0.0
    let mut fr_fraction = 0.0
    for i in 0..<tracks.length() {
      let min_c = min_contrib[i]
      let max_c = max_contrib[i]
      match tracks[i] {
        DimFr(w) =>
          if w > 0.0 {
            fr_sum = fr_sum + w
            let ratio = min_c / w
            if ratio > fr_fraction {
              fr_fraction = ratio
            }
          } else {
            total = total + min_c
          }
        _ =>
          total = total +
            (match tracks[i] {
              DimLength(v) => v
              DimAuto => min_c
              DimPercent(_) => min_c
              DimMinContent => min_c
              DimMaxContent => max_c
              DimFitContent(limit) =>
                track_basis_fit_content(min_c, max_c, limit, 0.0)
              DimMinMax(min_d, _max_d) =>
                // Conservative: use the min sizing function where possible.
                match min_d {
                  DimAuto | DimMinContent => min_c
                  DimMaxContent => max_c
                  _ => resolve_track_dimension(min_d, 0.0)
                }
              _ => 0.0
            })
      }
    }
    total = total + fr_fraction * fr_sum
    if tracks.length() > 1 {
      total = total + gap * (tracks.length() - 1).to_double()
    }
    total
  }

  fn axis_max_content_basis(
    tracks : Array[Dimension],
    min_contrib : Array[Double],
    max_contrib : Array[Double],
    gap : Double,
  ) -> Double {
    let mut total = 0.0
    let mut fr_sum = 0.0
    let mut fr_fraction = 0.0
    for i in 0..<tracks.length() {
      let min_c = min_contrib[i]
      let max_c = max_contrib[i]
      match tracks[i] {
        DimFr(w) =>
          if w > 0.0 {
            fr_sum = fr_sum + w
            let ratio = max_c / w
            if ratio > fr_fraction {
              fr_fraction = ratio
            }
          } else {
            total = total + max_c
          }
        _ =>
          total = total +
            (match tracks[i] {
              DimLength(v) => v
              DimAuto => max_c
              DimPercent(_) => max_c
              DimMinContent => min_c
              DimMaxContent => max_c
              DimFitContent(limit) =>
                track_basis_fit_content(min_c, max_c, limit, 0.0)
              DimMinMax(_min_d, max_d) => {
                let min_basis = match _min_d {
                  DimAuto => 0.0
                  DimMinContent => min_c
                  DimMaxContent => max_c
                  DimFitContent(limit) =>
                    track_basis_fit_content(min_c, max_c, limit, 0.0)
                  _ => resolve_track_dimension(_min_d, 0.0)
                }
                let max_basis = match max_d {
                  DimAuto | DimMaxContent => max_c
                  DimMinContent => min_c
                  DimPercent(_) => max_c
                  DimFr(_) => max_c
                  DimFitContent(limit) =>
                    track_basis_fit_content(min_c, max_c, limit, 0.0)
                  _ => resolve_track_dimension(max_d, 0.0)
                }
                if max_basis < min_basis {
                  min_basis
                } else {
                  max_basis
                }
              }
              _ => 0.0
            })
      }
    }
    total = total + fr_fraction * fr_sum
    if tracks.length() > 1 {
      total = total + gap * (tracks.length() - 1).to_double()
    }
    total
  }

  fn available_inset_or_basis(
    available : AvailableSpace,
    inset : Double,
    min_basis : Double,
    max_basis : Double,
  ) -> Double {
    match available {
      AvailDefinite(v) => max_double(v - inset, 0.0)
      AvailMinContent => min_basis
      AvailMaxContent => max_basis
    }
  }

  let mut col_min_basis = axis_min_content_basis(
    col_tracks, col_min_contrib, col_max_contrib, col_gap,
  )
  let mut col_max_basis = axis_max_content_basis(
    col_tracks, col_min_contrib, col_max_contrib, col_gap,
  )
  let mut col_available = match specified_width {
    Some(_) => content_width
    None =>
      available_inset_or_basis(
        available_space.width,
        horiz_inset,
        col_min_basis,
        col_max_basis,
      )
  }
  let mut col_available_base = col_available
  let mut col_sizes : Array[Double] = compute_grid_track_sizes_with_contributions(
    col_tracks,
    col_available,
    col_gap,
    col_min_contrib,
    col_max_contrib,
    specified_width is Some(_),
  )
  let mut has_percent_col = false
  let mut has_flex_col = false
  let mut has_intrinsic_col = false
  for t in col_tracks {
    if col_min_sizing_kind(t) != 0 {
      has_intrinsic_col = true
    }
    match t {
      DimPercent(_) => has_percent_col = true
      DimFr(_) => has_flex_col = true
      DimMinMax(_, max_d) =>
        match max_d {
          DimFr(_) => has_flex_col = true
          _ => ()
        }
      _ => ()
    }
  }
  if specified_width is None &&
    available_space.width is AvailMaxContent &&
    has_percent_col &&
    has_intrinsic_col &&
    !has_flex_col {
    // Match taffy 0.5 behavior: when sizing under a max-content constraint, percentage tracks
    // initially resolve to 0, then are re-resolved against the computed content width and the
    // intrinsic sizing pass is rerun once.
    let bases1 = compute_intrinsic_bases_max_content(
      col_tracks,
      placed_col,
      placed_col_span,
      col_item_min_needed,
      col_item_max_needed,
      placed,
      None,
    )
    let mut basis1 = 0.0
    for v in bases1 {
      basis1 = basis1 + v
    }
    let bases2 = compute_intrinsic_bases_max_content(
      col_tracks,
      placed_col,
      placed_col_span,
      col_item_min_needed,
      col_item_max_needed,
      placed,
      Some(basis1),
    )
    col_sizes = bases2
    col_available = basis1
    col_available_base = col_available
    let basis_with_gaps = basis1 + col_gap * (col_count - 1).to_double()
    col_min_basis = basis_with_gaps
    col_max_basis = basis_with_gaps
  }
  let default_justify_items_for_contrib = match node.style.justify_items {
    Some(v) => v
    None => ItemsStretch
  }

  // Compute row contributions with the resolved column widths as a constraint.
  for i in 0..<placement_count {
    if not(placed[i]) {
      continue
    }
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c0) => c0
      None => raise InvalidNodeId(child_id)
    }
    let c = placed_col[i]
    let col_span = placed_col_span[i]
    let r = placed_row[i]
    let row_span = placed_row_span[i]
    let mut col_w = 0.0
    for j in c..<(c + col_span) {
      col_w = col_w + col_sizes[j]
    }
    if col_span > 1 {
      col_w = col_w + col_gap * (col_span - 1).to_double()
    }
    let row_gap_total = row_gap * (row_span - 1).to_double()
    let resolved_margin = resolve_rect_width_basis(
      child.style.margin,
      Size::new(width=AvailDefinite(col_w), height=AvailMaxContent),
    )
    let margin_left_auto = child.style.margin.left is DimAuto
    let margin_right_auto = child.style.margin.right is DimAuto
    let has_auto_margin_x = margin_left_auto || margin_right_auto
    let justify = match child.style.justify_self {
      Some(v) => v
      None => default_justify_items_for_contrib
    }
    let available_w_for_item = max_double(
      col_w - resolved_margin.left - resolved_margin.right,
      0.0,
    )
    let mut known_w_for_contrib = resolve_optional_dimension(
      child.style.size.width,
      AvailDefinite(col_w),
    )
    if known_w_for_contrib is None &&
      child.style.size.width is DimAuto &&
      justify is ItemsStretch &&
      !has_auto_margin_x {
      known_w_for_contrib = Some(available_w_for_item)
    }

    // Max-content contribution in the row axis under the column width constraint.
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=known_w_for_contrib, height=None),
      Size::new(width=AvailDefinite(col_w), height=AvailMaxContent),
      Point::zero(),
      measure_function,
      false,
    )
    let max_h = tree.nodes[child_id].layout.size.height
    let max_needed = max_double(
      max_h + resolved_margin.top + resolved_margin.bottom - row_gap_total,
      0.0,
    )
    let max_share = max_needed / row_span.to_double()
    for j in r..<(r + row_span) {
      if max_share > row_max_contrib[j] {
        row_max_contrib[j] = max_share
      }
    }

    // Min-content contribution in the row axis under the column width constraint.
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=known_w_for_contrib, height=None),
      Size::new(width=AvailDefinite(col_w), height=AvailMinContent),
      Point::zero(),
      measure_function,
      false,
    )
    let min_h_raw = tree.nodes[child_id].layout.size.height
    let min_h = match (child.style.overflow.x, child.style.overflow.y) {
      (OverflowVisible, OverflowVisible) => min_h_raw
      _ => 0.0
    }
    let min_needed = max_double(
      min_h + resolved_margin.top + resolved_margin.bottom - row_gap_total,
      0.0,
    )
    let min_share = min_needed / row_span.to_double()
    for j in r..<(r + row_span) {
      if min_share > row_min_contrib[j] {
        row_min_contrib[j] = min_share
      }
    }
  }
  let row_min_basis = axis_min_content_basis(
    row_tracks, row_min_contrib, row_max_contrib, row_gap,
  )
  let row_max_basis = axis_max_content_basis(
    row_tracks, row_min_contrib, row_max_contrib, row_gap,
  )
  let row_available = match specified_height {
    Some(_) => content_height
    None =>
      available_inset_or_basis(
        available_space.height,
        vert_inset,
        row_min_basis,
        row_max_basis,
      )
  }
  let row_available_base = row_available
  let mut row_sizes : Array[Double] = compute_grid_track_sizes_with_contributions(
    row_tracks,
    row_available,
    row_gap,
    row_min_contrib,
    row_max_contrib,
    specified_height is Some(_),
  )
  let mut used_cols = 0.0
  for w in col_sizes {
    used_cols = used_cols + w
  }
  if col_count > 1 {
    used_cols = used_cols + col_gap * (col_count - 1).to_double()
  }
  let mut used_rows = 0.0
  for h in row_sizes {
    used_rows = used_rows + h
  }
  if row_count > 1 {
    used_rows = used_rows + row_gap * (row_count - 1).to_double()
  }

  // Container sizing (border-box). If width/height are not specified, size to tracks.
  if specified_width is None {
    // Don't force-fill definite available space for auto-sized containers.
    // Stretch behavior should be expressed via `known_dimensions` from the parent.
    let intrinsic_cols = match available_space.width {
      AvailMaxContent => col_max_basis
      AvailMinContent => col_min_basis
      AvailDefinite(_) => used_cols
    }
    border_box_width = max_double(
      clamp_dimension(
        max_double(intrinsic_cols + horiz_inset, horiz_inset),
        node.style.min_size.width,
        node.style.max_size.width,
        available_space.width,
      ),
      horiz_non_scroll_inset,
    )
    content_width = max_double(border_box_width - horiz_inset, 0.0)
  }
  if specified_height is None {
    let intrinsic_rows = match available_space.height {
      AvailMaxContent => row_max_basis
      AvailMinContent => row_min_basis
      AvailDefinite(_) => used_rows
    }
    border_box_height = max_double(
      clamp_dimension(
        max_double(intrinsic_rows + vert_inset, vert_inset),
        node.style.min_size.height,
        node.style.max_size.height,
        available_space.height,
      ),
      vert_non_scroll_inset,
    )
    content_height = max_double(border_box_height - vert_inset, 0.0)
  }

  // Deferred percentage gaps: if the container inline size was unknown during intrinsic sizing,
  // re-resolve percentage gaps against the computed inline content size and recompute track sizes.
  let mut rerun_track_sizing = false
  match gap_width_percent {
    Some(p) =>
      if col_gap == 0.0 && content_width > 0.0 {
        col_gap = content_width * p
        rerun_track_sizing = true
      }
    None => ()
  }
  match gap_height_percent {
    Some(p) =>
      if row_gap == 0.0 && content_width > 0.0 {
        row_gap = content_width * p
        rerun_track_sizing = true
      }
    None => ()
  }
  if rerun_track_sizing {
    let rerun_col_contrib_available_height = match specified_height {
      Some(_) => AvailDefinite(content_height)
      None => AvailMaxContent
    }
    // Recompute contributions with the updated gap values.
    for i in 0..<col_count {
      col_min_contrib[i] = 0.0
      col_max_contrib[i] = 0.0
    }
    for i in 0..<row_count {
      row_min_contrib[i] = 0.0
      row_max_contrib[i] = 0.0
    }
    for i in 0..<placement_count {
      if not(placed[i]) {
        continue
      }
      let child_id = node.children[i]
      let child = match tree.nodes.get(child_id) {
        Some(c0) => c0
        None => raise InvalidNodeId(child_id)
      }
      let c = placed_col[i]
      let col_span = placed_col_span[i]
      let gap_total = col_gap * (col_span - 1).to_double()
      compute_node_layout_with_measure(
        tree,
        child_id,
        Size::new(width=None, height=None),
        Size::new(
          width=AvailMaxContent,
          height=rerun_col_contrib_available_height,
        ),
        Point::zero(),
        measure_function,
        false,
      )
      let max_sz = tree.nodes[child_id].layout.size
      let resolved_margin = resolve_rect_width_basis(
        child.style.margin,
        Size::new(width=AvailMaxContent, height=AvailMaxContent),
      )
      let max_needed = max_double(
        max_sz.width + resolved_margin.left + resolved_margin.right - gap_total,
        0.0,
      )
      apply_col_contribution(
        col_tracks, c, col_span, max_needed, col_max_contrib,
      )
      compute_node_layout_with_measure(
        tree,
        child_id,
        Size::new(width=None, height=None),
        Size::new(
          width=AvailMinContent,
          height=rerun_col_contrib_available_height,
        ),
        Point::zero(),
        measure_function,
        false,
      )
      let min_col_raw = tree.nodes[child_id].layout.size.width
      let min_col = match (child.style.overflow.x, child.style.overflow.y) {
        (OverflowVisible, OverflowVisible) => min_col_raw
        _ => 0.0
      }
      let min_needed = max_double(
        min_col + resolved_margin.left + resolved_margin.right - gap_total,
        0.0,
      )
      apply_col_contribution(
        col_tracks, c, col_span, min_needed, col_min_contrib,
      )
    }
    col_sizes = compute_grid_track_sizes_with_contributions(
      col_tracks,
      col_available_base,
      col_gap,
      col_min_contrib,
      col_max_contrib,
      specified_width is Some(_),
    )
    for i in 0..<placement_count {
      if not(placed[i]) {
        continue
      }
      let child_id = node.children[i]
      let child = match tree.nodes.get(child_id) {
        Some(c0) => c0
        None => raise InvalidNodeId(child_id)
      }
      let c = placed_col[i]
      let col_span = placed_col_span[i]
      let r = placed_row[i]
      let row_span = placed_row_span[i]
      let mut col_w = 0.0
      for j in c..<(c + col_span) {
        col_w = col_w + col_sizes[j]
      }
      if col_span > 1 {
        col_w = col_w + col_gap * (col_span - 1).to_double()
      }
      let row_gap_total = row_gap * (row_span - 1).to_double()
      let resolved_margin = resolve_rect_width_basis(
        child.style.margin,
        Size::new(width=AvailDefinite(col_w), height=AvailMaxContent),
      )
      let margin_left_auto = child.style.margin.left is DimAuto
      let margin_right_auto = child.style.margin.right is DimAuto
      let has_auto_margin_x = margin_left_auto || margin_right_auto
      let justify = match child.style.justify_self {
        Some(v) => v
        None => default_justify_items_for_contrib
      }
      let available_w_for_item = max_double(
        col_w - resolved_margin.left - resolved_margin.right,
        0.0,
      )
      let mut known_w_for_contrib = resolve_optional_dimension(
        child.style.size.width,
        AvailDefinite(col_w),
      )
      if known_w_for_contrib is None &&
        child.style.size.width is DimAuto &&
        justify is ItemsStretch &&
        !has_auto_margin_x {
        known_w_for_contrib = Some(available_w_for_item)
      }
      compute_node_layout_with_measure(
        tree,
        child_id,
        Size::new(width=known_w_for_contrib, height=None),
        Size::new(width=AvailDefinite(col_w), height=AvailMaxContent),
        Point::zero(),
        measure_function,
        false,
      )
      let max_h = tree.nodes[child_id].layout.size.height
      let max_needed = max_double(
        max_h + resolved_margin.top + resolved_margin.bottom - row_gap_total,
        0.0,
      )
      let max_share = max_needed / row_span.to_double()
      for j in r..<(r + row_span) {
        if max_share > row_max_contrib[j] {
          row_max_contrib[j] = max_share
        }
      }
      compute_node_layout_with_measure(
        tree,
        child_id,
        Size::new(width=known_w_for_contrib, height=None),
        Size::new(width=AvailDefinite(col_w), height=AvailMinContent),
        Point::zero(),
        measure_function,
        false,
      )
      let min_h_raw = tree.nodes[child_id].layout.size.height
      let min_h = match (child.style.overflow.x, child.style.overflow.y) {
        (OverflowVisible, OverflowVisible) => min_h_raw
        _ => 0.0
      }
      let min_needed = max_double(
        min_h + resolved_margin.top + resolved_margin.bottom - row_gap_total,
        0.0,
      )
      let min_share = min_needed / row_span.to_double()
      for j in r..<(r + row_span) {
        if min_share > row_min_contrib[j] {
          row_min_contrib[j] = min_share
        }
      }
    }
    row_sizes = compute_grid_track_sizes_with_contributions(
      row_tracks,
      row_available_base,
      row_gap,
      row_min_contrib,
      row_max_contrib,
      specified_height is Some(_),
    )
    used_cols = 0.0
    for w in col_sizes {
      used_cols = used_cols + w
    }
    if col_count > 1 {
      used_cols = used_cols + col_gap * (col_count - 1).to_double()
    }
    used_rows = 0.0
    for h in row_sizes {
      used_rows = used_rows + h
    }
    if row_count > 1 {
      used_rows = used_rows + row_gap * (row_count - 1).to_double()
    }
  }
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: Size::new(width=border_box_width, height=border_box_height),
  }

  // Track alignment within the container's content box.
  let align_content = match node.style.align_content {
    Some(v) => v
    None => AlignStart
  }
  let justify_content = match node.style.justify_content {
    Some(v) => v
    None => AlignStart
  }

  // `repeat(auto-fit, ...)` collapses empty tracks.
  if has_auto_fit_cols || has_auto_fit_rows {
    let mut max_row_used = 0
    let mut max_col_used = 0
    for i in 0..<placement_count {
      if not(placed[i]) {
        continue
      }
      let row = placed_row[i]
      let col = placed_col[i]
      let row_end = row + placed_row_span[i] - 1
      let col_end = col + placed_col_span[i] - 1
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
  let base_x = absolute_origin.x + border.left + padding.left
  let base_y = absolute_origin.y + border.top + padding.top
  let default_align_items = match node.style.align_items {
    Some(v) => v
    None => ItemsStretch
  }
  let default_justify_items = match node.style.justify_items {
    Some(v) => v
    None => ItemsStretch
  }
  let row_baseline_before_max : Array[Double] = Array::make(row_count, 0.0)
  let row_baseline_after_max : Array[Double] = Array::make(row_count, 0.0)
  let item_baseline_offsets : Array[Double] = Array::make(placement_count, 0.0)
  for i in 0..<placement_count {
    if not(placed[i]) {
      continue
    }
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => continue
      _ => ()
    }
    match child.style.position {
      PosAbsolute => continue
      PosRelative => ()
    }
    let row = placed_row[i]
    let col = placed_col[i]
    let row_span = placed_row_span[i]
    let col_span = placed_col_span[i]
    let row_end = row + row_span - 1
    let col_end = col + col_span - 1
    if row < 0 || col < 0 || row_end >= row_count || col_end >= col_count {
      continue
    }
    let align = match child.style.align_self {
      Some(v) => v
      None => default_align_items
    }
    if row_span != 1 {
      continue
    }
    match align {
      ItemsBaseline => ()
      _ => continue
    }
    let mut cell_w = 0.0
    for c in col..<(col + col_span) {
      cell_w = cell_w + col_sizes[c]
    }
    if col_span > 1 {
      cell_w = cell_w + col_gap_effective * (col_span - 1).to_double()
    }
    let mut cell_h = 0.0
    for r in row..<(row + row_span) {
      cell_h = cell_h + row_sizes[r]
    }
    if row_span > 1 {
      cell_h = cell_h + row_gap_effective * (row_span - 1).to_double()
    }
    let child_available = Size::new(
      width=AvailDefinite(cell_w),
      height=AvailDefinite(cell_h),
    )
    let resolved_margin = resolve_rect_width_basis(
      child.style.margin,
      child_available,
    )
    let margin_left_auto = child.style.margin.left is DimAuto
    let margin_right_auto = child.style.margin.right is DimAuto
    let margin_top_auto = child.style.margin.top is DimAuto
    let margin_bottom_auto = child.style.margin.bottom is DimAuto
    let has_auto_margin_x = margin_left_auto || margin_right_auto
    let has_auto_margin_y = margin_top_auto || margin_bottom_auto
    if has_auto_margin_y {
      continue
    }
    let available_w_for_item = max_double(
      cell_w - resolved_margin.left - resolved_margin.right,
      0.0,
    )
    let available_h_for_item = max_double(
      cell_h - resolved_margin.top - resolved_margin.bottom,
      0.0,
    )
    let item_available = Size::new(
      width=AvailDefinite(available_w_for_item),
      height=AvailDefinite(available_h_for_item),
    )
    let justify = match child.style.justify_self {
      Some(v) => v
      None => default_justify_items
    }
    let stretch_fit_limit_w = if col_span == 1 {
      match child.style.overflow.x {
        OverflowVisible => None
        _ =>
          match col_tracks[col] {
            DimFitContent(limit) =>
              resolve_optional_dimension(limit, AvailDefinite(content_width))
            _ => None
          }
      }
    } else {
      None
    }
    let known_w = match justify {
      ItemsStretch =>
        if child.style.size.width is DimAuto && !has_auto_margin_x {
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
    // Percent sizes resolve against the containing block size (the grid area), not the
    // remaining space after subtracting margins.
    let known_w = match (known_w, child.style.size.width) {
      (None, DimPercent(p)) => Some(cell_w * p)
      _ => known_w
    }
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=known_w, height=None),
      item_available,
      Point::zero(),
      measure_function,
      false,
    )
    let baseline = grid_item_baseline_offset_y(tree, child_id)
    let intrinsic = tree.nodes[child_id].layout.size
    item_baseline_offsets[i] = baseline
    let before = resolved_margin.top + baseline
    let after = resolved_margin.bottom +
      max_double(intrinsic.height - baseline, 0.0)
    row_baseline_before_max[row] = max_double(
      row_baseline_before_max[row],
      before,
    )
    row_baseline_after_max[row] = max_double(row_baseline_after_max[row], after)
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
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => compute_hidden_layout(tree, child_id, Point::zero())
      _ => {
        if not(placed[i]) {
          continue
        } else {
          ()
        }
        match child.style.position {
          PosAbsolute => continue
          PosRelative => ()
        }
        let row = placed_row[i]
        let col = placed_col[i]
        let row_span = placed_row_span[i]
        let col_span = placed_col_span[i]
        let row_end = row + row_span - 1
        let col_end = col + col_span - 1
        if row < 0 || col < 0 || row_end >= row_count || col_end >= col_count {
          continue
        }
        let mut x = start_x
        for c in 0..<col {
          x = x + col_sizes[c] + col_gap_effective
        }
        let mut y = start_y
        for r in 0..<row {
          y = y + row_sizes[r] + row_gap_effective
        }
        let mut cell_w = 0.0
        for c in col..<(col + col_span) {
          cell_w = cell_w + col_sizes[c]
        }
        if col_span > 1 {
          cell_w = cell_w + col_gap_effective * (col_span - 1).to_double()
        }
        let mut cell_h = 0.0
        for r in row..<(row + row_span) {
          cell_h = cell_h + row_sizes[r]
        }
        if row_span > 1 {
          cell_h = cell_h + row_gap_effective * (row_span - 1).to_double()
        }
        let child_available = Size::new(
          width=AvailDefinite(cell_w),
          height=AvailDefinite(cell_h),
        )
        // Grid item margins apply inside the cell and contribute to track sizing.
        let resolved_margin = resolve_rect_width_basis(
          child.style.margin,
          child_available,
        )
        let margin_left_auto = child.style.margin.left is DimAuto
        let margin_right_auto = child.style.margin.right is DimAuto
        let margin_top_auto = child.style.margin.top is DimAuto
        let margin_bottom_auto = child.style.margin.bottom is DimAuto
        let has_auto_margin_x = margin_left_auto || margin_right_auto
        let has_auto_margin_y = margin_top_auto || margin_bottom_auto
        let available_w_for_item = max_double(
          cell_w - resolved_margin.left - resolved_margin.right,
          0.0,
        )
        let available_h_for_item = max_double(
          cell_h - resolved_margin.top - resolved_margin.bottom,
          0.0,
        )
        let item_available = Size::new(
          width=AvailDefinite(available_w_for_item),
          height=AvailDefinite(available_h_for_item),
        )
        let justify = match child.style.justify_self {
          Some(v) => v
          None => default_justify_items
        }
        let align = match child.style.align_self {
          Some(v) => v
          None => default_align_items
        }
        let stretch_fit_limit_w = if col_span == 1 {
          match child.style.overflow.x {
            OverflowVisible => None
            _ =>
              match col_tracks[col] {
                DimFitContent(limit) =>
                  resolve_optional_dimension(
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
            if child.style.size.width is DimAuto && !has_auto_margin_x {
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
            if child.style.size.height is DimAuto &&
              !has_auto_margin_y &&
              child.style.aspect_ratio is None {
              Some(available_h_for_item)
            } else {
              None
            }
          _ => None
        }
        // Percent sizes resolve against the containing block size (the grid area), not the
        // remaining space after subtracting margins.
        match (known_w, child.style.size.width) {
          (None, DimPercent(p)) => known_w = Some(cell_w * p)
          _ => ()
        }
        match (known_h, child.style.size.height) {
          (None, DimPercent(p)) => known_h = Some(cell_h * p)
          _ => ()
        }

        // First pass: compute the item's intrinsic size within the cell constraints.
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size::new(width=known_w, height=known_h),
          child_available,
          Point::zero(),
          measure_function,
          false,
        )
        match (align, child.style.aspect_ratio, child.style.size.height) {
          (ItemsStretch, Some(ratio), DimAuto) =>
            if ratio > 0.0 &&
              known_w is Some(_) &&
              known_h is None &&
              !has_auto_margin_y {
              let intrinsic_after_stretch = tree.nodes[child_id].layout.size
              let max_height = resolve_optional_dimension(
                child.style.max_size.height,
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
              compute_node_layout_with_measure(
                tree,
                child_id,
                Size::new(width=known_w, height=known_h),
                child_available,
                Point::zero(),
                measure_function,
                false,
              )
            } else {
              ()
            }
          _ => ()
        }
        let intrinsic = tree.nodes[child_id].layout.size
        let free_x = max_double(available_w_for_item - intrinsic.width, 0.0)
        let free_y = max_double(available_h_for_item - intrinsic.height, 0.0)
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
            free_y / 2.0
          } else {
            free_y
          }
        } else {
          resolved_margin.top
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
            ItemsBaseline =>
              if row_span == 1 {
                row_baseline_before_max[row] -
                resolved_margin.top -
                item_baseline_offsets[i]
              } else {
                0.0
              }
            _ => 0.0
          }
        }

        // Second pass: position the item within the cell.
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size::new(width=known_w, height=known_h),
          child_available,
          Point::new(
            x=(base_x + x + margin_left + offset_x).round(),
            y=(base_y + y + margin_top + offset_y).round(),
          ),
          measure_function,
          false,
        )
      }
    }
  }
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
  let content_start_x = padding.left + start_x
  let content_start_y = padding.top + start_y
  let explicit_col_lines : Array[Double] = [content_start_x]
  let explicit_row_lines : Array[Double] = [content_start_y]
  let mut col_line_pos = content_start_x
  let mut row_line_pos = content_start_y
  for i in 0..<explicit_col_count {
    let track_idx = negative_cols + i
    if track_idx >= 0 && track_idx < col_sizes.length() {
      col_line_pos = col_line_pos + col_sizes[track_idx]
    }
    if i + 1 < explicit_col_count {
      col_line_pos = col_line_pos + col_gap_effective
    }
    explicit_col_lines.push(col_line_pos)
  }
  for i in 0..<explicit_row_count {
    let track_idx = negative_rows + i
    if track_idx >= 0 && track_idx < row_sizes.length() {
      row_line_pos = row_line_pos + row_sizes[track_idx]
    }
    if i + 1 < explicit_row_count {
      row_line_pos = row_line_pos + row_gap_effective
    }
    explicit_row_lines.push(row_line_pos)
  }
  fn resolve_grid_abs_line_position(
    lines : Array[Double],
    line : Int,
  ) -> Double {
    let last = lines.length() - 1
    if last <= 0 {
      lines[0]
    } else {
      let raw = if line > 0 { line - 1 } else { last + line + 1 }
      let idx = if raw < 0 { 0 } else if raw > last { last } else { raw }
      lines[idx]
    }
  }

  fn resolve_grid_abs_axis_containing_block(
    placement : Line[GridPlacement],
    lines : Array[Double],
    padding_box_size : Double,
  ) -> (Double, Double) {
    let start_line = match placement.start {
      PlaceLine(v) => Some(resolve_grid_abs_line_position(lines, v))
      _ => None
    }
    let end_line = match placement.end {
      PlaceLine(v) => Some(resolve_grid_abs_line_position(lines, v))
      _ => None
    }
    let start_pos = match (start_line, end_line) {
      (Some(s), _) => s
      (None, Some(_)) => 0.0
      (None, None) => 0.0
    }
    let end_pos = match (start_line, end_line) {
      (_, Some(e)) => e
      (Some(_), None) => padding_box_size
      (None, None) => padding_box_size
    }
    if end_pos >= start_pos {
      (start_pos, end_pos)
    } else {
      (end_pos, start_pos)
    }
  }

  let default_abs_align = match node.style.align_items {
    Some(v) => v
    None => ItemsStretch
  }
  let default_abs_justify = match node.style.justify_items {
    Some(v) => v
    None => ItemsStretch
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
            let abs_available = Size::new(
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
            compute_node_layout_with_measure(
              tree,
              child_id,
              Size::new(
                width=Some(final_size.width),
                height=Some(final_size.height),
              ),
              abs_available,
              Point::new(
                x=padding_origin.x + x_in_padding,
                y=padding_origin.y + y_in_padding,
              ),
              measure_function,
              false,
            )
          }
        }
    }
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
