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
