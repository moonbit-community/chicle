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

///|
fn collapse_state_value(state : (Double, Double)) -> Double {
  state.0 + state.1
}

///|
fn collapse_state_from(margin : Double) -> (Double, Double) {
  collapse_state_add((0.0, 0.0), margin)
}

///|
fn collapse_state_merge(
  a : (Double, Double),
  b : (Double, Double),
) -> (Double, Double) {
  (if a.0 > b.0 { a.0 } else { b.0 }, if a.1 < b.1 { a.1 } else { b.1 })
}

///|
fn[C] has_in_flow_children(
  tree : ChicleTree[C],
  children : Array[NodeId],
) -> Bool raise ChicleError {
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

///|
fn[C] can_collapse_through_child(
  tree : ChicleTree[C],
  child_id : NodeId,
  child : NodeData,
  child_size : Size[Double],
) -> Bool raise ChicleError {
  match child.style.display {
    DisplayBlock => ()
    _ => return false
  }
  if child_size.height != 0.0 {
    return false
  } else {
    ()
  }
  match tree.node_context_data[child_id] {
    Some(_) => return false
    None => ()
  }
  let overflow_visible = match
    (child.style.overflow.x, child.style.overflow.y) {
    (OverflowVisible, OverflowVisible) => true
    _ => false
  }
  if !overflow_visible {
    return false
  } else {
    ()
  }
  if has_in_flow_children(tree, tree.children[child_id]) {
    return false
  } else {
    ()
  }
  true
}
