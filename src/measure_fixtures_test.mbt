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
enum WritingMode {
  Horizontal
  Vertical
}

///|
struct TextMeasure {
  text_content : String
  writing_mode : WritingMode
}

///|
fn[T] unwrap_or_else(x : T?, fallback : () -> T) -> T {
  match x {
    Some(v) => v
    None => fallback()
  }
}

///|
fn to_int_floor(x : Double) -> Int {
  x.floor().to_int()
}

///|
fn measure_text(
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  _node_id : NodeId,
  node_context : TextMeasure?,
  _style : Style,
) -> Size[Double] {
  let h_width = 10.0
  let h_height = 10.0
  // U+200B ZERO WIDTH SPACE
  let zws = "\u{200B}"
  match (known_dimensions.width, known_dimensions.height) {
    (Some(w), Some(h)) => return Size(width=w, height=h)
    _ => ()
  }
  let ctx = match node_context {
    Some(c) => c
    None => return Size::zero()
  }
  let is_horizontal = match ctx.writing_mode {
    Horizontal => true
    Vertical => false
  }
  let mut saw_any = false
  let mut min_line_length = 0
  let mut max_line_length = 0
  for seg in ctx.text_content.split(zws) {
    saw_any = true
    let len = seg.length()
    if len > min_line_length {
      min_line_length = len
    }
    max_line_length = max_line_length + len
  }
  if !saw_any {
    return Size::zero()
  }
  let inline_known = if is_horizontal {
    known_dimensions.width
  } else {
    known_dimensions.height
  }
  let block_known = if is_horizontal {
    known_dimensions.height
  } else {
    known_dimensions.width
  }
  let inline_avail = if is_horizontal {
    available_space.width
  } else {
    available_space.height
  }
  let min_inline = min_line_length.to_double() * h_width
  let max_inline = max_line_length.to_double() * h_width
  let inline_size = unwrap_or_else(inline_known, fn() {
    match inline_avail {
      AvailMinContent => min_inline
      AvailMaxContent => max_inline
      AvailDefinite(v) => if v < max_inline { v } else { max_inline }
    }
  })
  let inline_size = if inline_size > min_inline {
    inline_size
  } else {
    min_inline
  }
  let block_size = unwrap_or_else(block_known, fn() {
    match _style.aspect_ratio {
      Some(ratio) =>
        if ratio > 0.0 {
          if is_horizontal {
            inline_size / ratio
          } else {
            inline_size * ratio
          }
        } else {
          let inline_line_length = to_int_floor(inline_size / h_width)
          let mut line_count = 1
          let mut current_line_length = 0
          for seg in ctx.text_content.split(zws) {
            let len = seg.length()
            if current_line_length + len > inline_line_length {
              if current_line_length > 0 {
                line_count = line_count + 1
              }
              current_line_length = len
            } else {
              current_line_length = current_line_length + len
            }
          }
          line_count.to_double() * h_height
        }
      None => {
        let inline_line_length = to_int_floor(inline_size / h_width)
        let mut line_count = 1
        let mut current_line_length = 0
        for seg in ctx.text_content.split(zws) {
          let len = seg.length()
          if current_line_length + len > inline_line_length {
            if current_line_length > 0 {
              line_count = line_count + 1
            }
            current_line_length = len
          } else {
            current_line_length = current_line_length + len
          }
        }
        line_count.to_double() * h_height
      }
    }
  })
  if is_horizontal {
    Size(width=inline_size, height=block_size)
  } else {
    Size(width=block_size, height=inline_size)
  }
}

///|
test "measure_text_vertical_smoke" {
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf_with_context(Style::default(), {
    text_content: "H\u{200B}H\u{200B}H\u{200B}H\u{200B}H",
    writing_mode: Vertical,
  })
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 10.0)
  assert_eq(layout.size.height, 50.0)
}
