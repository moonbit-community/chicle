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
fn[C] compute_block_layout(
  view : TaffyView[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  is_layout_root : Bool,
) -> Unit raise TaffyError {
  let tree = view.tree
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
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
  let width_definite = match specified_width {
    Some(_) => true
    None =>
      match available_space.width {
        AvailDefinite(_) => true
        _ => false
      }
  }

  // Minimal block sizing: border-box.
  let raw_width = match specified_width {
    Some(w) => w
    None =>
      match available_space.width {
        AvailDefinite(v) => v
        _ => horiz_inset
      }
  }
  let raw_height = match specified_height {
    Some(h) => h
    None =>
      match available_space.height {
        AvailDefinite(v) => v
        _ => vert_inset
      }
  }
  let border_box_width = max_double(
    clamp_dimension(
      raw_width,
      node.style.min_size.width,
      node.style.max_size.width,
      available_space.width,
    ),
    horiz_non_scroll_inset,
  )
  let border_box_height = max_double(
    clamp_dimension(
      raw_height,
      node.style.min_size.height,
      node.style.max_size.height,
      available_space.height,
    ),
    vert_non_scroll_inset,
  )
  tree.set_unrounded_layout(node_id, {
    ..Layout::zero(),
    location: absolute_origin,
    size: Size(width=border_box_width, height=border_box_height),
  })

  // Containing block for in-flow positioning: content box (padding box minus padding).
  let padding_origin = Point(
    x=absolute_origin.x + border.left,
    y=absolute_origin.y + border.top,
  )
  let content_origin = Point(
    x=padding_origin.x + padding.left,
    y=padding_origin.y + padding.top,
  )
  let content_width = max_double(border_box_width - horiz_inset, 0.0)
  let content_height = max_double(border_box_height - vert_inset, 0.0)
  let flow_available = Size(
    width=match width_definite {
      true => AvailDefinite(content_width)
      false => available_space.width
    },
    height=match specified_height {
      Some(_) => AvailDefinite(content_height)
      None => AvailMaxContent
    },
  )
  let margin_basis_width = match available_space.width {
    AvailDefinite(v) => v
    _ =>
      match specified_width {
        Some(w) => max_double(w - horiz_inset, 0.0)
        None => 0.0
      }
  }
  let margin_basis_available = Size(
    width=AvailDefinite(margin_basis_width),
    height=flow_available.height,
  )

  let resolved_own_margin = resolve_rect_width_basis(
    node.style.margin,
    available_space,
  )
  let own_margin_top = resolved_own_margin.top
  let own_margin_bottom = resolved_own_margin.bottom
  let parent_overflow_visible = match
    (node.style.overflow.x, node.style.overflow.y) {
    (OverflowVisible, OverflowVisible) => true
    _ => false
  }
  let mut first_in_flow_child : NodeId? = None
  let mut last_in_flow_child : NodeId? = None
  for child_id in tree.children[node_id] {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => ()
      _ =>
        match child.style.position {
          PosRelative => {
            match first_in_flow_child {
              None => first_in_flow_child = Some(child_id)
              Some(_) => ()
            }
            last_in_flow_child = Some(child_id)
          }
          PosAbsolute => ()
        }
    }
  }
  let collapse_with_children = !is_layout_root &&
    parent_overflow_visible &&
    specified_height is None
  let first_child_allows_parent_child_collapse = match first_in_flow_child {
    Some(child_id) => {
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      child.style.display is DisplayBlock
    }
    None => false
  }
  let last_child_allows_parent_child_collapse = match last_in_flow_child {
    Some(child_id) => {
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      child.style.display is DisplayBlock
    }
    None => false
  }
  let collapse_top_with_child = collapse_with_children &&
    padding.top == 0.0 &&
    border.top == 0.0 &&
    first_child_allows_parent_child_collapse
  let collapse_bottom_with_child = collapse_with_children &&
    padding.bottom == 0.0 &&
    border.bottom == 0.0 &&
    last_child_allows_parent_child_collapse
  let abs_child_ids : Array[NodeId] = []
  let abs_child_static_y : Array[Double] = []
  let mut flow_anchor_border_bottom : Double = 0.0
  let mut flow_margin_collapse : (Double, Double) = (0.0, 0.0)
  let mut max_flow_child_width = 0.0
  let content_width_definite = match flow_available.width {
    AvailDefinite(_) => true
    _ => false
  }
  let content_width_for_flow = match flow_available.width {
    AvailDefinite(v) => v
    _ => 0.0
  }
  let mut is_first_in_flow = true
  for child_id in tree.children[node_id] {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => compute_hidden_layout(tree, child_id, Point::zero())
      _ =>
        match child.style.position {
          PosAbsolute => {
            abs_child_ids.push(child_id)
            abs_child_static_y.push(
              flow_anchor_border_bottom +
              collapse_state_value(flow_margin_collapse),
            )
          }
          PosRelative => {
            // Minimal normal flow: stack children vertically.
            let margin = child.style.margin
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
            let resolved_margin = resolve_rect_width_basis(
              margin, margin_basis_available,
            )
            let fixed_margin_left = if margin_left_auto {
              0.0
            } else {
              resolved_margin.left
            }
            let fixed_margin_right = if margin_right_auto {
              0.0
            } else {
              resolved_margin.right
            }
            let fixed_margin_top = if margin_top_auto {
              0.0
            } else {
              resolved_margin.top
            }
            let child_width_auto = match child.style.size.width {
              DimAuto => true
              _ => false
            }
            let aspect_ratio = child.style.aspect_ratio
            let width_from_aspect = match
              (aspect_ratio, child.style.size.width) {
              (Some(ratio), DimAuto) =>
                match
                  resolve_optional_dimension(
                    child.style.size.height,
                    flow_available.height,
                  ) {
                  Some(h) if ratio > 0.0 => Some((h * ratio).round())
                  _ => None
                }
              _ => None
            }
            let mut target_width = match width_from_aspect {
              Some(w) => Some(w)
              None =>
                if content_width_definite && child_width_auto {
                  Some(
                    max_double(
                      content_width_for_flow -
                      fixed_margin_left -
                      fixed_margin_right,
                      0.0,
                    ),
                  )
                } else {
                  None
                }
            }
            match target_width {
              Some(w) => {
                let mut min_width = resolve_optional_dimension(
                  child.style.min_size.width,
                  flow_available.width,
                )
                let mut max_width = resolve_optional_dimension(
                  child.style.max_size.width,
                  flow_available.width,
                )
                match aspect_ratio {
                  Some(ratio) =>
                    if ratio > 0.0 {
                      match
                        (
                          min_width,
                          resolve_optional_dimension(
                            child.style.min_size.height,
                            flow_available.height,
                          ),
                        ) {
                        (None, Some(h)) => min_width = Some((h * ratio).round())
                        _ => ()
                      }
                      match
                        (
                          max_width,
                          resolve_optional_dimension(
                            child.style.max_size.height,
                            flow_available.height,
                          ),
                        ) {
                        (None, Some(h)) => max_width = Some((h * ratio).round())
                        _ => ()
                      }
                    } else {
                      ()
                    }
                  None => ()
                }
                let mut clamped = w
                match min_width {
                  Some(m) => clamped = max_double(clamped, m)
                  None => ()
                }
                match max_width {
                  Some(m) => if clamped > m { clamped = m } else { () }
                  None => ()
                }
                target_width = Some(clamped)
              }
              None => ()
            }
            let is_last_in_flow = match last_in_flow_child {
              Some(v) => v == child_id
              None => false
            }
            let top_used_base = if collapse_top_with_child && is_first_in_flow {
              0.0
            } else {
              fixed_margin_top
            }
            let used_before_base = collapse_state_value(
              collapse_state_add(flow_margin_collapse, top_used_base),
            )
            let mut child_y_rel_static = flow_anchor_border_bottom +
              used_before_base
            view.perform_child_layout(
              child_id,
              Size(width=target_width, height=None),
              margin_basis_available,
              Point(
                x=content_origin.x + fixed_margin_left,
                y=content_origin.y + child_y_rel_static,
              ),
              false,
            )
            let child_size = tree.nodes[child_id].unrounded_layout.size
            let effective_top = tree.nodes[child_id].effective_margin_top
            let top_used_effective = if collapse_top_with_child &&
              is_first_in_flow {
              0.0
            } else {
              effective_top
            }
            let used_before_effective = collapse_state_value(
              collapse_state_add(flow_margin_collapse, top_used_effective),
            )
            let delta_y = used_before_effective - used_before_base
            if delta_y != 0.0 {
              offset_subtree(tree, child_id, 0.0, delta_y)
              child_y_rel_static = child_y_rel_static + delta_y
            } else {
              ()
            }
            let remaining = if content_width_definite {
              content_width_for_flow -
              fixed_margin_left -
              fixed_margin_right -
              child_size.width
            } else {
              0.0
            }
            let mut auto_left = 0.0
            let mut auto_right = 0.0
            if content_width_definite {
              if margin_left_auto && margin_right_auto {
                if remaining > 0.0 {
                  auto_left = remaining / 2.0
                  auto_right = remaining / 2.0
                } else {
                  auto_left = 0.0
                  auto_right = 0.0
                }
              } else if margin_left_auto {
                auto_left = if remaining > 0.0 { remaining } else { 0.0 }
              } else if margin_right_auto {
                auto_right = if remaining > 0.0 { remaining } else { 0.0 }
              } else {
                ()
              }
              if auto_left != 0.0 {
                offset_subtree(tree, child_id, auto_left, 0.0)
              } else {
                ()
              }
            } else {
              ()
            }
            let effective_bottom_raw = tree.nodes[child_id].effective_margin_bottom
            let bottom_used_effective = if collapse_bottom_with_child &&
              is_last_in_flow {
              0.0
            } else {
              effective_bottom_raw
            }
            let through = can_collapse_through_child(
              tree, child_id, child, child_size,
            )
            if through {
              flow_margin_collapse = collapse_state_add(
                collapse_state_add(flow_margin_collapse, top_used_effective),
                bottom_used_effective,
              )
            } else {
              flow_anchor_border_bottom = child_y_rel_static + child_size.height
              flow_margin_collapse = collapse_state_from(bottom_used_effective)
            }
            is_first_in_flow = false
            let child_outer_width = fixed_margin_left +
              auto_left +
              child_size.width +
              fixed_margin_right +
              auto_right
            if child_outer_width > max_flow_child_width {
              max_flow_child_width = child_outer_width
            } else {
              ()
            }
          }
        }
    }
  }

  // Auto sizing from in-flow children.
  let final_border_box_width = match width_definite {
    true => border_box_width
    false =>
      max_double(
        clamp_dimension(
          horiz_inset + max_flow_child_width,
          node.style.min_size.width,
          node.style.max_size.width,
          available_space.width,
        ),
        horiz_non_scroll_inset,
      )
  }
  let mut final_border_box_height = match specified_height {
    Some(_) => border_box_height
    None =>
      max_double(
        clamp_dimension(
          vert_inset +
          flow_anchor_border_bottom +
          collapse_state_value(flow_margin_collapse),
          node.style.min_size.height,
          node.style.max_size.height,
          available_space.height,
        ),
        vert_non_scroll_inset,
      )
  }
  // Taffy block layout computes container width first, then performs final in-flow layout with that width.
  // When this container's width is auto, do a second layout pass so that in-flow children can stretch
  // (e.g. auto-width block children) and so that absolute children's static y positions are correct.
  if !width_definite {
    let final_content_width_for_flow = max_double(
      final_border_box_width - horiz_inset,
      0.0,
    )
    let final_content_height_for_flow = max_double(
      final_border_box_height - vert_inset,
      0.0,
    )
    let flow_available2 = Size(
      width=AvailDefinite(final_content_width_for_flow),
      height=match specified_height {
        Some(_) => AvailDefinite(final_content_height_for_flow)
        None => AvailMaxContent
      },
    )
    let margin_basis_available2 = Size(
      width=AvailDefinite(final_content_width_for_flow),
      height=flow_available2.height,
    )
    abs_child_ids.clear()
    abs_child_static_y.clear()
    flow_anchor_border_bottom = 0.0
    flow_margin_collapse = (0.0, 0.0)
    max_flow_child_width = 0.0
    let content_width_for_flow2 = final_content_width_for_flow
    let mut is_first_in_flow2 = true
    for child_id in tree.children[node_id] {
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      match child.style.display {
        DisplayNone => compute_hidden_layout(tree, child_id, Point::zero())
        _ =>
          match child.style.position {
            PosAbsolute => {
              abs_child_ids.push(child_id)
              abs_child_static_y.push(
                flow_anchor_border_bottom +
                collapse_state_value(flow_margin_collapse),
              )
            }
            PosRelative => {
              let margin = child.style.margin
              let margin_left_auto = margin.left is DimAuto
              let margin_right_auto = margin.right is DimAuto
              let margin_top_auto = margin.top is DimAuto
              let resolved_margin = resolve_rect_width_basis(
                margin, margin_basis_available2,
              )
              let fixed_margin_left = if margin_left_auto {
                0.0
              } else {
                resolved_margin.left
              }
              let fixed_margin_right = if margin_right_auto {
                0.0
              } else {
                resolved_margin.right
              }
              let fixed_margin_top = if margin_top_auto {
                0.0
              } else {
                resolved_margin.top
              }
              let child_width_auto = child.style.size.width is DimAuto
              let aspect_ratio = child.style.aspect_ratio
              let width_from_aspect = match
                (aspect_ratio, child.style.size.width) {
                (Some(ratio), DimAuto) =>
                  match
                    resolve_optional_dimension(
                      child.style.size.height,
                      flow_available2.height,
                    ) {
                    Some(h) if ratio > 0.0 => Some((h * ratio).round())
                    _ => None
                  }
                _ => None
              }
              let mut target_width = match width_from_aspect {
                Some(w) => Some(w)
                None =>
                  if child_width_auto {
                    Some(
                      max_double(
                        content_width_for_flow2 -
                        fixed_margin_left -
                        fixed_margin_right,
                        0.0,
                      ),
                    )
                  } else {
                    None
                  }
              }
              match target_width {
                Some(w) => {
                  let mut min_width = resolve_optional_dimension(
                    child.style.min_size.width,
                    flow_available2.width,
                  )
                  let mut max_width = resolve_optional_dimension(
                    child.style.max_size.width,
                    flow_available2.width,
                  )
                  match aspect_ratio {
                    Some(ratio) =>
                      if ratio > 0.0 {
                        match
                          (
                            min_width,
                            resolve_optional_dimension(
                              child.style.min_size.height,
                              flow_available2.height,
                            ),
                          ) {
                          (None, Some(h)) =>
                            min_width = Some((h * ratio).round())
                          _ => ()
                        }
                        match
                          (
                            max_width,
                            resolve_optional_dimension(
                              child.style.max_size.height,
                              flow_available2.height,
                            ),
                          ) {
                          (None, Some(h)) =>
                            max_width = Some((h * ratio).round())
                          _ => ()
                        }
                      } else {
                        ()
                      }
                    None => ()
                  }
                  let mut clamped = w
                  match min_width {
                    Some(m) => clamped = max_double(clamped, m)
                    None => ()
                  }
                  match max_width {
                    Some(m) => if clamped > m { clamped = m } else { () }
                    None => ()
                  }
                  target_width = Some(clamped)
                }
                None => ()
              }
              let is_last_in_flow = match last_in_flow_child {
                Some(v) => v == child_id
                None => false
              }
              let top_used_base = if collapse_top_with_child &&
                is_first_in_flow2 {
                0.0
              } else {
                fixed_margin_top
              }
              let used_before_base = collapse_state_value(
                collapse_state_add(flow_margin_collapse, top_used_base),
              )
              let mut child_y_rel_static = flow_anchor_border_bottom +
                used_before_base
              view.perform_child_layout(
                child_id,
                Size(width=target_width, height=None),
                flow_available2,
                Point(
                  x=content_origin.x + fixed_margin_left,
                  y=content_origin.y + child_y_rel_static,
                ),
                false,
              )
              let child_size = tree.nodes[child_id].unrounded_layout.size
              let effective_top = tree.nodes[child_id].effective_margin_top
              let top_used_effective = if collapse_top_with_child &&
                is_first_in_flow2 {
                0.0
              } else {
                effective_top
              }
              let used_before_effective = collapse_state_value(
                collapse_state_add(flow_margin_collapse, top_used_effective),
              )
              let delta_y = used_before_effective - used_before_base
              if delta_y != 0.0 {
                offset_subtree(tree, child_id, 0.0, delta_y)
                child_y_rel_static = child_y_rel_static + delta_y
              } else {
                ()
              }
              let remaining = content_width_for_flow2 -
                fixed_margin_left -
                fixed_margin_right -
                child_size.width
              let mut auto_left = 0.0
              let mut auto_right = 0.0
              if margin_left_auto && margin_right_auto {
                if remaining > 0.0 {
                  auto_left = remaining / 2.0
                  auto_right = remaining / 2.0
                } else {
                  auto_left = 0.0
                  auto_right = 0.0
                }
              } else if margin_left_auto {
                auto_left = if remaining > 0.0 { remaining } else { 0.0 }
              } else if margin_right_auto {
                auto_right = if remaining > 0.0 { remaining } else { 0.0 }
              } else {
                ()
              }
              if auto_left != 0.0 {
                offset_subtree(tree, child_id, auto_left, 0.0)
              } else {
                ()
              }
              let effective_bottom_raw = tree.nodes[child_id].effective_margin_bottom
              let bottom_used_effective = if collapse_bottom_with_child &&
                is_last_in_flow {
                0.0
              } else {
                effective_bottom_raw
              }
              let through = can_collapse_through_child(
                tree, child_id, child, child_size,
              )
              if through {
                flow_margin_collapse = collapse_state_add(
                  collapse_state_add(flow_margin_collapse, top_used_effective),
                  bottom_used_effective,
                )
              } else {
                flow_anchor_border_bottom = child_y_rel_static +
                  child_size.height
                flow_margin_collapse = collapse_state_from(
                  bottom_used_effective,
                )
              }
              is_first_in_flow2 = false
              let child_outer_width = fixed_margin_left +
                auto_left +
                child_size.width +
                fixed_margin_right +
                auto_right
              if child_outer_width > max_flow_child_width {
                max_flow_child_width = child_outer_width
              } else {
                ()
              }
            }
          }
      }
    }
    // Update auto height after reflow.
    final_border_box_height = match specified_height {
      Some(_) => final_border_box_height
      None =>
        max_double(
          clamp_dimension(
            vert_inset +
            flow_anchor_border_bottom +
            collapse_state_value(flow_margin_collapse),
            node.style.min_size.height,
            node.style.max_size.height,
            available_space.height,
          ),
          vert_non_scroll_inset,
        )
    }
  }
  tree.set_unrounded_layout(node_id, {
    ..Layout::zero(),
    location: absolute_origin,
    size: Size(width=final_border_box_width, height=final_border_box_height),
  })

  compute_block_absolute_children(
    view, abs_child_ids, abs_child_static_y, padding_origin, padding, border, final_border_box_width,
    final_border_box_height, scrollbar_x, scrollbar_y,
  )
  let effective_top_state = if collapse_top_with_child {
    let first_id = match first_in_flow_child {
      Some(v) => v
      None => node_id
    }
    collapse_state_merge(
      collapse_state_from(own_margin_top),
      (
        tree.nodes[first_id].effective_margin_top_max_pos,
        tree.nodes[first_id].effective_margin_top_min_neg,
      ),
    )
  } else {
    collapse_state_from(own_margin_top)
  }
  let effective_bottom_state = if collapse_bottom_with_child {
    let last_id = match last_in_flow_child {
      Some(v) => v
      None => node_id
    }
    collapse_state_merge(
      collapse_state_from(own_margin_bottom),
      (
        tree.nodes[last_id].effective_margin_bottom_max_pos,
        tree.nodes[last_id].effective_margin_bottom_min_neg,
      ),
    )
  } else {
    collapse_state_from(own_margin_bottom)
  }
  set_effective_margin_states(
    tree, node_id, effective_top_state, effective_bottom_state,
  )
}
