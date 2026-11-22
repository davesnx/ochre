## Unreleased

- `tokenize_exn` no longer raises on any line, including invalid UTF-8, and no
  longer loops or overflows the stack on grammars whose includes lead back to
  themselves.
- Capture handling follows vscode-textmate: captures are visited in group order,
  one that starts after the end of the match is dropped, and one with `patterns`
  is retokenized together with the captures nested in it. This fixes token
  endings that went backwards (zero-width begin matches with captures past the
  match, captures nested in a capture with patterns).
- Expand `$N` and `${N:/downcase}` / `${N:/upcase}` in `name`, `contentName` and
  capture names.
- Fix back-references to the last group of a `begin` pattern in an `end` or
  `while` pattern being dropped.
- A malformed `end` or `while` regex without back-references is now reported
  when the grammar is read. One with back-references that cannot be built from
  the matched text never matches instead of raising.
- Bound the time spent on a line: `?max_line_length` (default 10000 bytes) and
  `?time_limit` (default 0.25 s) on `tokenize_exn`. The rest of a line past
  either limit is one token with the scopes in force.
- Speed up tokenization: candidates are collected once per stack frame and line,
  first-byte tests are computed when the grammar is read, nested includes no
  longer lengthen repository lookups, and injections are matched with a scope
  set.
- Prevent tokenizer hangs from zero-width regex loops by enforcing progress in
  `match`, `while`, and `begin`/`end` transitions.
- Add regression tests for zero-width begin/end and zero-width match loop
  grammars.
- Make overlap capture handling deterministic by sorting equal-range captures by
  capture index, fixing missing opening quote string scopes in some grammars.
- Behavior change: zero-width rules that do not consume input are treated as
  non-progress and skipped/advanced for safety, so they no longer emit tokens.

## 0.5.0 (February 28, 2026)

- Merge PR "Fix OCaml grammar compatibility" (#1) by @davesnx
- Handle captures specified as lists instead of dictionaries

## 0.4.0 (January 3, 2024)

- Rewrite handling of captures, previous version returned indices out of order

## 0.3.4 (March 14, 2023)

- Update the test dependency `plist-xml` to version 0.5.

## 0.3.3 (October 27, 2022)

- Support named capture groups.
- Fix mapping scopes to captures.

## 0.3.2 (September 28, 2022)

- Fix bug of incorrect, non-increasing string indices being returned.

## 0.3.1 (July 15, 2021)

- Add `find_by_filetype` function.

## 0.3.0 (July 4, 2021)

- Fix handling of while
- Fix handling of end-delimiter scopes
- Add type definitions for [Ezjsonm](https://opam.ocaml.org/packages/ezjsonm/)
  and [Yojson](https://opam.ocaml.org/packages/yojson/) JSON values
- Add functions for reading JSON-format grammars into Ezjsonm or Yojson
  values
- Add tests

## 0.2.1 (April 9, 2021)

- Check capture index bounds and ignore out-of-bounds captures indices in
  rules. Previously the underlying Oniguruma bindings would throw an
  `Invalid_argument` exception.

## 0.2.0 (November 26, 2020)

- Switch from PCRE to Oniguruma.
- Substitute captures from `begin` pattern for backreferences in `end` and
  `while` patterns.

## 0.1.0 (August 30, 2020)

Initial release.
