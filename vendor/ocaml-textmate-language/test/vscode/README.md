# vscode-textmate compatibility tests

This directory hosts an opt-in compatibility suite that compares token streams
from:

- `vscode-textmate` + `vscode-oniguruma` (Node.js)
- `textmate-language` (OCaml implementation in this repository)

## Run locally

From the workspace root:

```sh
npm ci --prefix vendor/ocaml-textmate-language/test/vscode
opam exec -- dune exec ./vendor/ocaml-textmate-language/test/test_vscode_compat.exe
```

The OCaml executable reads cases from `cases/suite.json`, runs both engines,
and fails with a side-by-side token diff on mismatch.

Current gap analysis and feature plans are tracked in `compat-roadmap.md`.
