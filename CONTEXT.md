# Chicle Showcase

Terms used to describe the interactive documentation experience for Chicle.

## Language

**Layout Document**:
A JSON document that describes one layout tree and its constraints without presenting executable MoonBit source code.
_Avoid_: Layout DSL, code, source code

**Layout Preview**:
The visual result automatically recomputed from the current Layout Document as it changes.
_Avoid_: Output pane, renderer

**Layout Result**:
A JSON-serializable collection of computed geometry and metadata for every node in a Layout Document.
_Avoid_: DOM output, preview data

**JSON Layout API**:
The backend-independent Chicle API that parses a Layout Document, computes its layout, and serializes a Layout Result.
_Avoid_: Wasm API, playground API

**Wasm Adapter**:
A thin browser-facing package that exports the JSON Layout API without owning its schema or layout behavior.
_Avoid_: Wasm layout engine, JSON implementation

**DOM Projection**:
The browser-only transformation from a Layout Result into visual DOM boxes. It does not contribute measurements to Chicle.
_Avoid_: Layout computation, DOM layout engine

**Share URL**:
A page URL that contains an encoded Layout Document and restores the same document and preview when opened.
_Avoid_: Saved example, permalink
