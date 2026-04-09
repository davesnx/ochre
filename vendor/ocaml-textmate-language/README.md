A fork of https://github.com/alan-j-hu/ocaml-textmate-language to fit ochre's needs with the following changes:

- Fix \G-anchored end patterns closing relative to the parent begin anchor
- Fix zero-width regex loops in the tokenizer
- Deterministic overlap-capture ordering by sorting equal-range captures by index
- Delimiter captures inherit the enclosing rule's content scope
- While-begin rules continue tokenizing child patterns on the same line
- While-line continuations preserve the active scope stack across lines
- Space-separated scope names are split into individual scopes
- Named capture keys (non-numeric) are ignored, matching vscode-textmate behavior
- Captures with `patterns` are recursively tokenized using the full engine
- Nested captures inherit scope from the enclosing capture on the stack
- A vscode-textmate compatibility test suite under `test/vscode/`
