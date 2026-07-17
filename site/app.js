const dim = (value) => ({ Length: value });
const fr = (value) => ({ Fr: value });
const line = (value) => ({ Line: value });

const examples = {
  "flex-dashboard": {
    version: 1,
    available_space: { width: 960, height: 640 },
    root: {
      id: "dashboard",
      label: "Dashboard",
      style: {
        display: "Flex",
        size: { width: dim(760), height: dim(480) },
        padding: {
          left: dim(24),
          right: dim(24),
          top: dim(24),
          bottom: dim(24),
        },
        gap: { width: dim(18) },
        align_items: "Stretch",
      },
      children: [
        {
          id: "sidebar",
          label: "Sidebar",
          style: {
            flex_direction: "Column",
            size: { width: dim(190) },
            padding: {
              left: dim(16),
              right: dim(16),
              top: dim(16),
              bottom: dim(16),
            },
            gap: { height: dim(12) },
          },
          children: [
            {
              id: "logo",
              label: "Logo",
              style: { size: { height: dim(52) } },
            },
            {
              id: "nav-primary",
              label: "Primary nav",
              style: { size: { height: dim(44) } },
            },
            {
              id: "nav-secondary",
              label: "Secondary nav",
              style: { size: { height: dim(44) } },
            },
            {
              id: "sidebar-spacer",
              label: "Flexible space",
              style: { flex_grow: 1 },
            },
            {
              id: "profile",
              label: "Profile",
              style: { size: { height: dim(58) } },
            },
          ],
        },
        {
          id: "content",
          label: "Content",
          style: {
            flex_direction: "Column",
            flex_grow: 1,
            gap: { height: dim(16) },
          },
          children: [
            {
              id: "toolbar",
              label: "Toolbar",
              style: { size: { height: dim(74) } },
            },
            {
              id: "cards",
              label: "Cards",
              style: {
                flex_grow: 1,
                gap: { width: dim(14) },
              },
              children: [
                {
                  id: "card-a",
                  label: "Card A",
                  style: { flex_grow: 1 },
                },
                {
                  id: "card-b",
                  label: "Card B",
                  style: { flex_grow: 1.35 },
                },
                {
                  id: "card-c",
                  label: "Card C",
                  style: { flex_grow: 0.8 },
                },
              ],
            },
            {
              id: "activity",
              label: "Recent activity",
              style: { size: { height: dim(128) } },
            },
          ],
        },
      ],
    },
  },
  "grid-workspace": {
    version: 1,
    available_space: { width: 960, height: 640 },
    root: {
      id: "workspace",
      label: "Grid workspace",
      style: {
        display: "Grid",
        size: { width: dim(760), height: dim(480) },
        padding: {
          left: dim(22),
          right: dim(22),
          top: dim(22),
          bottom: dim(22),
        },
        gap: { width: dim(14), height: dim(14) },
        grid_template_columns: [dim(180), fr(1), fr(1)],
        grid_template_rows: [dim(70), fr(1), dim(92)],
      },
      children: [
        {
          id: "grid-header",
          label: "Header · columns 1–3",
          style: {
            grid_column: { start: line(1), end: line(4) },
            grid_row: { start: line(1), end: line(2) },
          },
        },
        {
          id: "grid-sidebar",
          label: "Sidebar · rows 2–3",
          style: {
            grid_column: { start: line(1), end: line(2) },
            grid_row: { start: line(2), end: line(4) },
          },
        },
        {
          id: "grid-chart",
          label: "Chart · columns 2–3",
          style: {
            grid_column: { start: line(2), end: line(4) },
            grid_row: { start: line(2), end: line(3) },
          },
        },
        {
          id: "grid-stat-a",
          label: "Stat A",
          style: {
            grid_column: { start: line(2), end: line(3) },
            grid_row: { start: line(3), end: line(4) },
          },
        },
        {
          id: "grid-stat-b",
          label: "Stat B",
          style: {
            grid_column: { start: line(3), end: line(4) },
            grid_row: { start: line(3), end: line(4) },
          },
        },
      ],
    },
  },
  "absolute-overlay": {
    version: 1,
    available_space: { width: 960, height: 640 },
    root: {
      id: "page",
      label: "Product page",
      style: {
        flex_direction: "Column",
        size: { width: dim(760), height: dim(480) },
        padding: {
          left: dim(24),
          right: dim(24),
          top: dim(24),
          bottom: dim(24),
        },
        gap: { height: dim(16) },
      },
      children: [
        {
          id: "page-header",
          label: "Header",
          style: { size: { height: dim(58) } },
        },
        {
          id: "hero",
          label: "Relative hero",
          style: {
            flex_grow: 1,
            padding: {
              left: dim(28),
              right: dim(28),
              top: dim(28),
              bottom: dim(28),
            },
          },
          children: [
            {
              id: "hero-copy",
              label: "Hero copy",
              style: {
                size: { width: dim(360), height: dim(170) },
              },
            },
            {
              id: "badge",
              label: "Absolute badge",
              style: {
                position: "Absolute",
                size: { width: dim(148), height: dim(48) },
                inset: { right: dim(22), top: dim(22) },
              },
            },
            {
              id: "floating-action",
              label: "Floating action",
              style: {
                position: "Absolute",
                size: { width: dim(172), height: dim(48) },
                inset: { right: dim(22), bottom: dim(22) },
              },
            },
          ],
        },
        {
          id: "page-footer",
          label: "Footer",
          style: { size: { height: dim(54) } },
        },
      ],
    },
  },
};

const palette = [
  "#d8ff62",
  "#8db2ff",
  "#ff8bb0",
  "#8ce6b2",
  "#f5bd57",
  "#bd9cff",
];

const editor = document.querySelector("#layout-editor");
const exampleSelect = document.querySelector("#example-select");
const formatButton = document.querySelector("#format-button");
const shareButton = document.querySelector("#share-button");
const editorMessage = document.querySelector("#editor-message");
const runtimeStatus = document.querySelector("#runtime-status");
const viewport = document.querySelector("#preview-viewport");
const surface = document.querySelector("#preview-surface");
const emptyState = document.querySelector("#empty-state");
const nodeCount = document.querySelector("#node-count");
const rootSize = document.querySelector("#root-size");
const previewScale = document.querySelector("#preview-scale");
const selection = document.querySelector("#selection");

let computeLayoutJson = null;
let computeTimer = null;
let lastResult = null;

function encodeBase64Url(text) {
  const bytes = new TextEncoder().encode(text);
  let binary = "";
  const chunkSize = 0x8000;
  for (let offset = 0; offset < bytes.length; offset += chunkSize) {
    binary += String.fromCharCode(...bytes.subarray(offset, offset + chunkSize));
  }
  return btoa(binary)
    .replaceAll("+", "-")
    .replaceAll("/", "_")
    .replace(/=+$/u, "");
}

function decodeBase64Url(value) {
  const normalized = value.replaceAll("-", "+").replaceAll("_", "/");
  const padded = normalized + "=".repeat((4 - (normalized.length % 4)) % 4);
  const binary = atob(padded);
  const bytes = Uint8Array.from(binary, (character) => character.charCodeAt(0));
  return new TextDecoder().decode(bytes);
}

function readSharedDocument() {
  const parameters = new URLSearchParams(location.hash.slice(1));
  const encoded = parameters.get("layout");
  if (!encoded) return null;
  try {
    return decodeBase64Url(encoded);
  } catch {
    return null;
  }
}

function updateShareUrl(text) {
  const url = new URL(location.href);
  url.hash = "layout=" + encodeBase64Url(text);
  history.replaceState(null, "", url);
}

function setMessage(text, kind = "") {
  editorMessage.textContent = text;
  editorMessage.className = "message" + (kind ? " " + kind : "");
}

function loadExample(name) {
  const example = examples[name] || examples["flex-dashboard"];
  editor.value = JSON.stringify(example, null, 2);
  scheduleCompute();
}

function scheduleCompute() {
  clearTimeout(computeTimer);
  setMessage("Waiting for a valid Layout Document…");
  computeTimer = setTimeout(runCompute, 150);
}

function runCompute() {
  if (!computeLayoutJson) return;
  let response;
  try {
    response = JSON.parse(computeLayoutJson(editor.value));
  } catch (error) {
    setMessage("Wasm response error: " + error.message, "error");
    return;
  }

  if (!response.ok) {
    const detail = response.error?.message || "Unknown layout error";
    setMessage(detail, "error");
    return;
  }

  lastResult = response.result;
  renderLayout(lastResult);
  updateShareUrl(editor.value);
  setMessage(
    "Layout updated · " + response.result.nodes.length + " nodes",
    "success",
  );
}

function renderLayout(result) {
  surface.replaceChildren();
  emptyState.classList.add("hidden");
  selection.textContent = "Select a box to inspect it.";

  const elements = new Map();
  const nodes = new Map(result.nodes.map((node) => [node.id, node]));

  for (const node of result.nodes) {
    const element = document.createElement("div");
    const layout = node.layout;
    const color = palette[node.depth % palette.length];
    element.className = "layout-node";
    element.dataset.nodeId = node.id;
    element.style.setProperty("--node-color", color);
    element.style.left = layout.location.x + "px";
    element.style.top = layout.location.y + "px";
    element.style.width = Math.max(0, layout.size.width) + "px";
    element.style.height = Math.max(0, layout.size.height) + "px";
    element.title =
      node.label +
      " · x " +
      formatNumber(layout.location.x) +
      ", y " +
      formatNumber(layout.location.y) +
      ", " +
      formatNumber(layout.size.width) +
      " × " +
      formatNumber(layout.size.height);

    const label = document.createElement("span");
    label.className = "layout-label";
    label.textContent = node.label;
    element.append(label);
    element.addEventListener("click", (event) => {
      event.stopPropagation();
      selectNode(node.id, nodes);
    });

    elements.set(node.id, element);
    if (node.parent_id === null) {
      surface.append(element);
    } else {
      elements.get(node.parent_id)?.append(element);
    }
  }

  const root = nodes.get(result.root_id);
  if (!root) return;
  surface.style.width = Math.max(1, root.layout.size.width) + "px";
  surface.style.height = Math.max(1, root.layout.size.height) + "px";
  nodeCount.textContent = String(result.nodes.length);
  rootSize.textContent =
    formatNumber(root.layout.size.width) +
    " × " +
    formatNumber(root.layout.size.height);
  fitPreview();
}

function selectNode(nodeId, nodes) {
  for (const element of surface.querySelectorAll(".layout-node")) {
    element.classList.toggle("selected", element.dataset.nodeId === nodeId);
  }
  const node = nodes.get(nodeId);
  if (!node) return;
  const layout = node.layout;
  selection.textContent =
    node.label +
    " · (" +
    formatNumber(layout.location.x) +
    ", " +
    formatNumber(layout.location.y) +
    ") · " +
    formatNumber(layout.size.width) +
    " × " +
    formatNumber(layout.size.height);
}

function fitPreview() {
  if (!lastResult) return;
  const root = lastResult.nodes.find((node) => node.id === lastResult.root_id);
  if (!root) return;
  const bounds = viewport.getBoundingClientRect();
  const width = Math.max(1, root.layout.size.width);
  const height = Math.max(1, root.layout.size.height);
  const padding = bounds.width < 560 ? 28 : 54;
  const scale = Math.min(
    Math.max(0.08, (bounds.width - padding * 2) / width),
    Math.max(0.08, (bounds.height - padding * 2) / height),
    1.25,
  );
  const left = Math.max(18, (bounds.width - width * scale) / 2);
  const top = Math.max(18, (bounds.height - height * scale) / 2);
  surface.style.left = left + "px";
  surface.style.top = top + "px";
  surface.style.transform = "scale(" + scale + ")";
  previewScale.textContent = Math.round(scale * 100) + "%";
}

function formatNumber(value) {
  return Number.isInteger(value) ? String(value) : value.toFixed(1);
}

async function copyShareUrl() {
  try {
    await navigator.clipboard.writeText(location.href);
    const original = shareButton.textContent;
    shareButton.textContent = "Copied";
    setTimeout(() => {
      shareButton.textContent = original;
    }, 1200);
  } catch {
    setMessage("Copy failed; select the URL from the address bar.", "error");
  }
}

async function start() {
  const shared = readSharedDocument();
  if (shared) {
    editor.value = shared;
    exampleSelect.value = "";
  } else {
    editor.value = JSON.stringify(examples["flex-dashboard"], null, 2);
  }

  try {
    const wasmResponse = await fetch("./chicle.wasm");
    if (!wasmResponse.ok) {
      throw new Error("Unable to fetch chicle.wasm");
    }
    const bytes = await wasmResponse.arrayBuffer();
    const { instance } = await WebAssembly.instantiate(
      bytes,
      {},
      {
        builtins: ["js-string"],
        importedStringConstants: "_",
      },
    );
    computeLayoutJson = instance.exports.compute_layout_json;
    if (typeof computeLayoutJson !== "function") {
      throw new Error("compute_layout_json export is missing");
    }
    runtimeStatus.className = "runtime-status ready";
    runtimeStatus.innerHTML = '<i aria-hidden="true"></i> WebAssembly ready';
    runCompute();
  } catch (error) {
    runtimeStatus.className = "runtime-status error";
    runtimeStatus.innerHTML =
      '<i aria-hidden="true"></i> WebAssembly unavailable';
    emptyState.querySelector("strong").textContent = "Unable to start Chicle";
    emptyState.querySelector("span:last-child").textContent = error.message;
    setMessage(error.message, "error");
  }
}

editor.addEventListener("input", scheduleCompute);
exampleSelect.addEventListener("change", () => loadExample(exampleSelect.value));
formatButton.addEventListener("click", () => {
  try {
    editor.value = JSON.stringify(JSON.parse(editor.value), null, 2);
    scheduleCompute();
  } catch {
    setMessage("The document must be valid JSON before formatting.", "error");
  }
});
shareButton.addEventListener("click", copyShareUrl);
window.addEventListener("resize", fitPreview);
window.addEventListener("hashchange", () => {
  const shared = readSharedDocument();
  if (shared && shared !== editor.value) {
    editor.value = shared;
    runCompute();
  }
});

new ResizeObserver(fitPreview).observe(viewport);
start();
