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
fn margin_collapse_state_add_margin(
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
fn margin_collapse_state_from(margin : Double) -> (Double, Double) {
  margin_collapse_state_add_margin((0.0, 0.0), margin)
}

///|
fn margin_collapse_state_value(state : (Double, Double)) -> Double {
  state.0 + state.1
}

///|
fn[C] set_effective_margin_states(
  tree : TaffyTree[C],
  node_id : NodeId,
  top_state : (Double, Double),
  bottom_state : (Double, Double),
) -> Unit {
  tree.nodes[node_id].effective_margin_top_max_pos = top_state.0
  tree.nodes[node_id].effective_margin_top_min_neg = top_state.1
  tree.nodes[node_id].effective_margin_bottom_max_pos = bottom_state.0
  tree.nodes[node_id].effective_margin_bottom_min_neg = bottom_state.1
  tree.nodes[node_id].effective_margin_top = margin_collapse_state_value(
    top_state,
  )
  tree.nodes[node_id].effective_margin_bottom = margin_collapse_state_value(
    bottom_state,
  )
}
