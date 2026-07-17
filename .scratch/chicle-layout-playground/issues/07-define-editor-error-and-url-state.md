# Define editor, error, and URL state

Type: grilling
Status: resolved
Blocked by: 02, 03

## Question

How should initial loading, debounced refresh, parse and computation errors, the last valid preview, Base64URL encoding, history navigation, and fallback examples interact as one deterministic browser state machine?

## Answer

The editor recomputes 150 ms after input. Only a valid successful result replaces the preview and `#layout=<base64url>` via `history.replaceState`; errors leave the last valid preview and URL intact. Initial load and hash navigation decode the fragment, while an absent fragment loads the Flex example.
