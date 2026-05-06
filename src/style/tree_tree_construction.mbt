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
pub fn[C] TaffyTree::TaffyTree() -> TaffyTree[C] {
  { nodes: [] }
}

///|
pub fn[C] TaffyTree::with_capacity(_capacity : Int) -> TaffyTree[C] {
  // Array capacity is backend-dependent; keep API surface but ignore the hint for now.
  TaffyTree()
}

///|
pub fn[C] TaffyTree::new_leaf(self : TaffyTree[C], style : Style) -> NodeId {
  let id = self.nodes.length()
  self.nodes.append([
    Node::{
      style,
      children: [],
      parent: None,
      layout: Layout::zero(),
      context: None,
      leaf_measure_cache: [],
      node_layout_cache: [],
      effective_margin_top: 0.0,
      effective_margin_bottom: 0.0,
      effective_margin_top_max_pos: 0.0,
      effective_margin_top_min_neg: 0.0,
      effective_margin_bottom_max_pos: 0.0,
      effective_margin_bottom_min_neg: 0.0,
      alive: true,
      dirty: true,
    },
  ])
  id
}

///|
pub fn[C] TaffyTree::new_leaf_with_context(
  self : TaffyTree[C],
  style : Style,
  context : C,
) -> NodeId {
  let id = self.nodes.length()
  self.nodes.append([
    Node::{
      style,
      children: [],
      parent: None,
      layout: Layout::zero(),
      context: Some(context),
      leaf_measure_cache: [],
      node_layout_cache: [],
      effective_margin_top: 0.0,
      effective_margin_bottom: 0.0,
      effective_margin_top_max_pos: 0.0,
      effective_margin_top_min_neg: 0.0,
      effective_margin_bottom_max_pos: 0.0,
      effective_margin_bottom_min_neg: 0.0,
      alive: true,
      dirty: true,
    },
  ])
  id
}

///|
pub fn[C] TaffyTree::new_with_children(
  self : TaffyTree[C],
  style : Style,
  children : Array[NodeId],
) -> NodeId {
  let id = self.nodes.length()
  self.nodes.append([
    Node::{
      style,
      children,
      parent: None,
      layout: Layout::zero(),
      context: None,
      leaf_measure_cache: [],
      node_layout_cache: [],
      effective_margin_top: 0.0,
      effective_margin_bottom: 0.0,
      effective_margin_top_max_pos: 0.0,
      effective_margin_top_min_neg: 0.0,
      effective_margin_bottom_max_pos: 0.0,
      effective_margin_bottom_min_neg: 0.0,
      alive: true,
      dirty: true,
    },
  ])
  for child_id in children {
    match self.nodes.get(child_id) {
      Some(_) => {
        if !self.nodes[child_id].alive {
          continue
        }
        match self.nodes[child_id].parent {
          Some(old_parent) =>
            if old_parent != id {
              let old_children = self.nodes[old_parent].children
              match old_children.search_by(fn(x) { x == child_id }) {
                Some(idx) => ignore(old_children.remove(idx))
                None => ()
              }
            } else {
              ()
            }
          None => ()
        }
        self.nodes[child_id].parent = Some(id)
      }
      None => ()
    }
  }
  id
}
