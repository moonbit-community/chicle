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
suberror TaffyError {
  InvalidNodeId(Int)
  CycleDetected(parent~ : Int, child~ : Int)
  ChildNotFound(parent~ : Int, child~ : Int)
  DuplicateChild(parent~ : Int, child~ : Int)
}

///|
pub type NodeId = Int

///|
pub struct Layout {
  order : Int
  location : Point[Double]
  size : Size[Double]
  content_size : Size[Double]
  scrollbar_size : Size[Double]
  border : Rect[Double]
  padding : Rect[Double]
}

///|
pub fn Layout::zero() -> Layout {
  {
    order: 0,
    location: Point::zero(),
    size: Size::zero(),
    content_size: Size::zero(),
    scrollbar_size: Size::zero(),
    border: Rect(left=0.0, right=0.0, top=0.0, bottom=0.0),
    padding: Rect(left=0.0, right=0.0, top=0.0, bottom=0.0),
  }
}

///|
priv enum RunMode {
  PerformLayout
  ComputeSize
  PerformHiddenLayout
}

///|
priv enum SizingMode {
  ContentSize
  InherentSize
}

///|
priv enum RequestedAxis {
  RequestedHorizontal
  RequestedVertical
  RequestedBoth
}

///|
priv struct LayoutInput {
  run_mode : RunMode
  sizing_mode : SizingMode
  axis : RequestedAxis
  known_dimensions : Size[Double?]
  parent_size : Size[Double?]
  available_space : Size[AvailableSpace]
  vertical_margins_are_collapsible : Line[Bool]
}

///|
fn LayoutInput::hidden() -> LayoutInput {
  {
    run_mode: PerformHiddenLayout,
    sizing_mode: InherentSize,
    axis: RequestedBoth,
    known_dimensions: Size(width=None, height=None),
    parent_size: Size(width=None, height=None),
    available_space: Size(width=AvailMaxContent, height=AvailMaxContent),
    vertical_margins_are_collapsible: Line(start=false, end=false),
  }
}

///|
fn layout_input_for_perform_layout(
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
) -> LayoutInput {
  {
    run_mode: PerformLayout,
    sizing_mode: InherentSize,
    axis: RequestedBoth,
    known_dimensions,
    parent_size: known_dimensions,
    available_space,
    vertical_margins_are_collapsible: Line(start=false, end=false),
  }
}

///|
fn layout_input_for_compute_size(
  known_dimensions : Size[Double?],
  parent_size : Size[Double?],
  available_space : Size[AvailableSpace],
  sizing_mode : SizingMode,
  axis : RequestedAxis,
  vertical_margins_are_collapsible : Line[Bool],
) -> LayoutInput {
  {
    run_mode: ComputeSize,
    sizing_mode,
    axis,
    known_dimensions,
    parent_size,
    available_space,
    vertical_margins_are_collapsible,
  }
}

///|
fn requested_axis_from_absolute(axis : AbsoluteAxis) -> RequestedAxis {
  match axis {
    Horizontal => RequestedHorizontal
    Vertical => RequestedVertical
  }
}

///|
priv struct CacheEntry[T] {
  known_dimensions : Size[Double?]
  available_space : Size[AvailableSpace]
  content : T
}

///|
type LeafMeasureCacheEntry = CacheEntry[Size[Double]]

///|
priv struct NodeLayoutCacheEntry {
  known_dimensions : Size[Double?]
  available_space : Size[AvailableSpace]
  absolute_origin : Point[Double]
  is_layout_root : Bool
  location : Point[Double]
  size : Size[Double]
  effective_margin_top : Double
  effective_margin_bottom : Double
  effective_margin_top_max_pos : Double
  effective_margin_top_min_neg : Double
  effective_margin_bottom_max_pos : Double
  effective_margin_bottom_min_neg : Double
}

///|
priv struct Cache {
  mut final_layout_entry : NodeLayoutCacheEntry?
  measure_entries : Array[LeafMeasureCacheEntry?]
}

///|
fn Cache::Cache() -> Cache {
  {
    final_layout_entry: None,
    measure_entries: [None, None, None, None, None, None, None, None, None],
  }
}

///|
struct Node[C] {
  mut style : Style
  children : Array[NodeId]
  mut parent : NodeId?
  mut layout : Layout
  mut context : C?
  cache : Cache
  mut effective_margin_top : Double
  mut effective_margin_bottom : Double
  mut effective_margin_top_max_pos : Double
  mut effective_margin_top_min_neg : Double
  mut effective_margin_bottom_max_pos : Double
  mut effective_margin_bottom_min_neg : Double
  mut alive : Bool
  mut dirty : Bool
}

///|
pub struct TaffyTree[C] {
  priv nodes : Array[Node[C]]
}
