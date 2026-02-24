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
fn[C] compute_block_layout_with_measure(
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
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: Size::new(width=border_box_width, height=border_box_height),
  }

  // Containing block for in-flow positioning: content box (padding box minus padding).
  let padding_origin = Point::new(
    x=absolute_origin.x + border.left,
    y=absolute_origin.y + border.top,
  )
  let content_origin = Point::new(
    x=padding_origin.x + padding.left,
    y=padding_origin.y + padding.top,
  )
  let content_width = max_double(border_box_width - horiz_inset, 0.0)
  let content_height = max_double(border_box_height - vert_inset, 0.0)
  let flow_available = Size::new(
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
  let margin_basis_available = Size::new(
    width=AvailDefinite(margin_basis_width),
    height=flow_available.height,
  )
  fn collapse_state_add(
    state : (Double, Double),
    margin : Double,
  ) -> (Double, Double) {
    let mut max_pos = state.0
    let mut min_neg = state.1
    if margin > 0.0 {
      if margin > max_pos {
        max_pos = margin
      } else {
        ()
      }
    } else if margin < 0.0 {
      if margin < min_neg {
        min_neg = margin
      } else {
        ()
      }
    } else {
      ()
    }
    (max_pos, min_neg)
  }

  fn collapse_state_value(state : (Double, Double)) -> Double {
    state.0 + state.1
  }

  fn collapse_state_from(margin : Double) -> (Double, Double) {
    collapse_state_add((0.0, 0.0), margin)
  }

  fn collapse_state_merge(
    a : (Double, Double),
    b : (Double, Double),
  ) -> (Double, Double) {
    (if a.0 > b.0 { a.0 } else { b.0 }, if a.1 < b.1 { a.1 } else { b.1 })
  }

  fn has_in_flow_children(
    tree : TaffyTree[C],
    children : Array[NodeId],
  ) -> Bool raise TaffyError {
    for child_id in children {
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      match child.style.display {
        DisplayNone => ()
        _ =>
          match child.style.position {
            PosRelative => return true
            PosAbsolute => ()
          }
      }
    }
    false
  }

  fn can_collapse_through_child(
    tree : TaffyTree[C],
    child : Node[C],
    child_size : Size[Double],
  ) -> Bool raise TaffyError {
    match child.style.display {
      DisplayBlock => ()
      _ => return false
    }
    if child_size.height != 0.0 {
      return false
    } else {
      ()
    }
    match child.context {
      Some(_) => return false
      None => ()
    }
    let overflow_visible = match
      (child.style.overflow.x, child.style.overflow.y) {
      (OverflowVisible, OverflowVisible) => true
      _ => false
    }
    if not(overflow_visible) {
      return false
    } else {
      ()
    }
    if has_in_flow_children(tree, child.children) {
      return false
    } else {
      ()
    }
    true
  }

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
  for child_id in node.children {
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
  let collapse_with_children = not(is_layout_root) &&
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
  for child_id in node.children {
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
            compute_node_layout_with_measure(
              tree,
              child_id,
              Size::new(width=target_width, height=None),
              margin_basis_available,
              Point::new(
                x=content_origin.x + fixed_margin_left,
                y=content_origin.y + child_y_rel_static,
              ),
              measure_function,
              false,
            )
            let child_size = tree.nodes[child_id].layout.size
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
            let through = can_collapse_through_child(tree, child, child_size)
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
  if not(width_definite) {
    let final_content_width_for_flow = max_double(
      final_border_box_width - horiz_inset,
      0.0,
    )
    let final_content_height_for_flow = max_double(
      final_border_box_height - vert_inset,
      0.0,
    )
    let flow_available2 = Size::new(
      width=AvailDefinite(final_content_width_for_flow),
      height=match specified_height {
        Some(_) => AvailDefinite(final_content_height_for_flow)
        None => AvailMaxContent
      },
    )
    let margin_basis_available2 = Size::new(
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
    for child_id in node.children {
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
              compute_node_layout_with_measure(
                tree,
                child_id,
                Size::new(width=target_width, height=None),
                flow_available2,
                Point::new(
                  x=content_origin.x + fixed_margin_left,
                  y=content_origin.y + child_y_rel_static,
                ),
                measure_function,
                false,
              )
              let child_size = tree.nodes[child_id].layout.size
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
              let through = can_collapse_through_child(tree, child, child_size)
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
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: Size::new(
      width=final_border_box_width,
      height=final_border_box_height,
    ),
  }

  // Absolute children: positioned relative to the final padding box.
  let final_padding_box_width = max_double(
    final_border_box_width - border.left - border.right - scrollbar_y,
    0.0,
  )
  let final_padding_box_height = max_double(
    final_border_box_height - border.top - border.bottom - scrollbar_x,
    0.0,
  )
  let abs_available = Size::new(
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
