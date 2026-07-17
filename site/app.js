const examples = {
  "flex-dashboard": `space: [960, 640]
layout:
  Dashboard:
    size: [760, 480]
    padding: 24
    gap: { column: 18 }
    align: stretch
    children:
      - Sidebar:
          flow: column
          width: 190
          padding: 16
          gap: { row: 12 }
          children:
            - Logo: { height: 52 }
            - Primary nav: { height: 44 }
            - Secondary nav: { height: 44 }
            - Flexible space: { grow: 1 }
            - Profile: { height: 58 }
      - Content:
          flow: column
          grow: 1
          padding: 18
          gap: { row: 16 }
          children:
            - Toolbar: { height: 74 }
            - Cards:
                grow: 1
                padding: 18
                gap: { column: 14 }
                children:
                  - Card A: { grow: 1 }
                  - Card B: { grow: 1.35 }
                  - Card C: { grow: 0.8 }
            - Recent activity: { height: 128 }`,
  "grid-workspace": `space: [960, 640]
layout:
  Grid workspace:
    size: [760, 480]
    padding: 22
    gap: 14
    grid:
      columns: [180, 1fr, 1fr]
      rows: [70, 1fr, 92]
    children:
      - Header · columns 1–3:
          place: { column: [1, 4], row: [1, 2] }
      - Sidebar · rows 2–3:
          place: { column: [1, 2], row: [2, 4] }
      - Chart · columns 2–3:
          place: { column: [2, 4], row: [2, 3] }
      - Stat A:
          place: { column: [2, 3], row: [3, 4] }
      - Stat B:
          place: { column: [3, 4], row: [3, 4] }`,
  "absolute-overlay": `space: [960, 640]
layout:
  Product page:
    flow: column
    size: [760, 480]
    padding: 24
    gap: { row: 16 }
    children:
      - Header: { height: 58 }
      - Relative hero:
          grow: 1
          padding: 28
          children:
            - Hero copy: { size: [360, 170] }
            - Absolute badge:
                size: [148, 48]
                absolute: { right: 22, top: 22 }
            - Floating action:
                size: [172, 48]
                absolute: { right: 22, bottom: 22 }
      - Footer: { height: 54 }`,
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

let computeLayoutYaml = null;
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
  editor.value = example + "\n";
  scheduleCompute();
}

function scheduleCompute() {
  clearTimeout(computeTimer);
  setMessage("Waiting for a valid Layout Document…");
  computeTimer = setTimeout(runCompute, 150);
}

function runCompute() {
  if (!computeLayoutYaml) return;
  let response;
  try {
    response = JSON.parse(computeLayoutYaml(editor.value));
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
    editor.value = examples["flex-dashboard"] + "\n";
  }

  try {
    const wasmResponse = await fetch("./chicle.wasm");
    if (!wasmResponse.ok) {
      throw new Error("Unable to fetch chicle.wasm");
    }
    const bytes = await wasmResponse.arrayBuffer();
    const { instance } = await WebAssembly.instantiate(
      bytes,
      { console: { log: console.log } },
      {
        builtins: ["js-string"],
        importedStringConstants: "_",
      },
    );
    computeLayoutYaml = instance.exports.compute_layout_yaml;
    if (typeof computeLayoutYaml !== "function") {
      throw new Error("compute_layout_yaml export is missing");
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
