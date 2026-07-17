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
fn[C] baseline_offset_y(
  tree : ChicleTree[C],
  node_id : NodeId,
) -> Double raise ChicleError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let node_layout = node.unrounded_layout
  match node.style.display {
    DisplayBlock | DisplayGrid => node_layout.size.height
    _ =>
      if tree.children[node_id].length() == 0 {
        node_layout.size.height
      } else {
        if node.style.display is DisplayFlex &&
          !is_column(node.style.flex_direction) {
          let default_align = match node.style.align_items {
            Some(v) => v
            None => ItemsStretch
          }
          let mut first_line_top : Double? = None
          for child_id in tree.children[node_id] {
            let child = match tree.nodes.get(child_id) {
              Some(c) => c
              None => raise InvalidNodeId(child_id)
            }
            match (child.style.display, child.style.position) {
              (DisplayNone, _) | (_, PosAbsolute) => ()
              _ => {
                let rel_top = child.unrounded_layout.location.y -
                  node_layout.location.y
                first_line_top = match first_line_top {
                  Some(v) => Some(@util.min_double(v, rel_top))
                  None => Some(rel_top)
                }
              }
            }
          }
          match first_line_top {
            Some(first_line_top) => {
              let mut first_candidate : NodeId? = None
              let mut baseline_candidate : NodeId? = None
              for child_id in tree.children[node_id] {
                let child = match tree.nodes.get(child_id) {
                  Some(c) => c
                  None => raise InvalidNodeId(child_id)
                }
                match (child.style.display, child.style.position) {
                  (DisplayNone, _) | (_, PosAbsolute) => ()
                  _ => {
                    let rel_top = child.unrounded_layout.location.y -
                      node_layout.location.y
                    if @util.abs_double(rel_top - first_line_top) < 0.0001 {
                      if first_candidate is None {
                        first_candidate = Some(child_id)
                      }
                      let align = match child.style.align_self {
                        Some(v) => v
                        None => default_align
                      }
                      if baseline_candidate is None && align is ItemsBaseline {
                        baseline_candidate = Some(child_id)
                      }
                    }
                  }
                }
              }
              let chosen = match baseline_candidate {
                Some(id) => Some(id)
                None => first_candidate
              }
              match chosen {
                Some(chosen_id) => {
                  let chosen_layout = tree.nodes[chosen_id].unrounded_layout
                  return chosen_layout.location.y -
                    node_layout.location.y +
                    baseline_offset_y(tree, chosen_id)
                }
                None => ()
              }
            }
            None => ()
          }
        }
        for child_id in tree.children[node_id] {
          let child = match tree.nodes.get(child_id) {
            Some(c) => c
            None => raise InvalidNodeId(child_id)
          }
          match child.style.display {
            DisplayNone => ()
            _ =>
              match child.style.position {
                PosAbsolute => ()
                PosRelative => {
                  let child_layout = child.unrounded_layout
                  let child_margin_top = if node.style.display is DisplayFlex &&
                    is_column(node.style.flex_direction) {
                    match child.style.margin.top {
                      DimPercent(_) =>
                        @util.resolve_dimension_width_basis(
                          child.style.margin.top,
                          node_layout.size.width,
                        )
                      _ => 0.0
                    }
                  } else {
                    0.0
                  }
                  return child_layout.location.y -
                    node_layout.location.y +
                    baseline_offset_y(tree, child_id) -
                    child_margin_top
                }
              }
          }
        }
        node_layout.size.height
      }
  }
}

///|
fn[C] grid_item_baseline_offset_y(
  tree : ChicleTree[C],
  node_id : NodeId,
) -> Double raise ChicleError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let node_layout = node.unrounded_layout
  if tree.children[node_id].length() == 0 {
    node_layout.size.height
  } else {
    for child_id in tree.children[node_id] {
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      match child.style.display {
        DisplayNone => ()
        _ =>
          match child.style.position {
            PosAbsolute => ()
            PosRelative => {
              let child_layout = child.unrounded_layout
              return child_layout.location.y -
                node_layout.location.y +
                grid_item_baseline_offset_y(tree, child_id)
            }
          }
      }
    }
    node_layout.size.height
  }
}
