# vscode-textmate side-by-side gap roadmap

This document captures the current side-by-side baseline between:

- OCaml engine: `textmate-language` in this repository
- Reference engine: `vscode-textmate` + `vscode-oniguruma`

Baseline command:

```sh
make test-vscode-compat
```

Current baseline: **1 mismatch** (`cpp-simple`).

Historical baseline at roadmap creation: **12 mismatches**.

## Progress status

- F1 Delimiter capture scope inheritance: done
- F2 While stack propagation: done
- F3 Boundary normalization in harness: done
- F4 Capture-segmentation parity (named capture-key handling): done
- F5 C++ meta-scope parity: pending

## Full side-by-side baseline

### 1) `a-basic` line 2: `"a(a)"`

```text
OCaml : [1,2) "(" :: source.a > punctuation.paren.open
VSCode: [1,2) "(" :: source.a > expression.group > punctuation.paren.open

OCaml : [3,4) ")" :: source.a > punctuation.paren.close
VSCode: [3,4) ")" :: source.a > expression.group > punctuation.paren.close
```

### 2) `a-basic` line 3: `"a("`

```text
OCaml : [1,2) "(" :: source.a > punctuation.paren.open
VSCode: [1,2) "(" :: source.a > expression.group > punctuation.paren.open
```

### 3) `a-basic` line 4: `"a)"`

```text
OCaml : [1,2) ")" :: source.a > punctuation.paren.close
VSCode: [1,2) ")" :: source.a > expression.group > punctuation.paren.close
```

### 4) `while-state` line 1: `"ac"`

```text
OCaml : [0,1) "a" :: source.while > begin
VSCode: [0,1) "a" :: source.while > expression.group > begin

OCaml : [1,2) "c" :: source.while > expression.group
VSCode: [1,2) "c" :: source.while > expression.group > keyword.letter
```

### 5) `while-state` line 2: `"bc"`

```text
OCaml : [0,1) "b" :: source.while > while
VSCode: [0,1) "b" :: source.while > expression.group > while
```

### 6) `multiwhile-state` line 1: `"X"`

```text
OCaml : [0,1) "X" :: source.multiwhile > xbegin
VSCode: [0,1) "X" :: source.multiwhile > xlist > xbegin
```

### 7) `multiwhile-state` line 2: `"xY"`

```text
OCaml : [0,1) "x" :: source.multiwhile > xwhile
VSCode: [0,1) "x" :: source.multiwhile > xlist > xwhile

OCaml : [1,2) "Y" :: source.multiwhile > xlist > ybegin
VSCode: [1,2) "Y" :: source.multiwhile > xlist > ylist > ybegin
```

### 8) `multiwhile-state` line 3: `"yxy"`

```text
OCaml : [0,1) "y" :: source.multiwhile
VSCode: [0,1) "y" :: source.multiwhile > xlist

OCaml : [1,2) "x" :: source.multiwhile > xwhile
VSCode: [1,2) "x" :: source.multiwhile > xlist > xwhile

OCaml : [2,3) "y" :: source.multiwhile > xlist > ywhile
VSCode: [2,3) "y" :: source.multiwhile > xlist > ylist > ywhile
```

### 9) `multiwhile-state` line 4: `"xy"`

```text
OCaml : [0,1) "x" :: source.multiwhile > xwhile
VSCode: [0,1) "x" :: source.multiwhile > xlist > xwhile

OCaml : [1,2) "y" :: source.multiwhile > xlist > ywhile
VSCode: [1,2) "y" :: source.multiwhile > xlist > ylist > ywhile
```

### 10) `multiwhile-state` line 5: `"y"`

```text
OCaml : [0,1) "y" :: source.multiwhile
VSCode: [0,2) <out of line range in harness> :: source.multiwhile
```

### 11) `groups-single-line` line 1: `"({#aaff59})"`

```text
OCaml : [0,1) "(" :: source.groups > punctuation.paren.open
OCaml : [1,2) "{" :: source.groups > punctuation.paren.open.groups
VSCode: [0,2) "({" :: source.groups > expression.group > punctuation.paren.open

OCaml : [2,3) "#" :: source.groups > expression.group > keyword.operator
OCaml : [3,9) "aaff59" :: source.groups > expression.group > constant.numeric
VSCode: [2,9) "#aaff59" :: source.groups > expression.group > keyword.operator

OCaml : [9,10) "}" :: source.groups > punctuation.paren.close.groups
OCaml : [10,11) ")" :: source.groups > punctuation.paren.close
VSCode: [9,11) "})" :: source.groups > expression.group > punctuation.paren.close
```

### 12) `cpp-simple` line 1: `"int main()"`

```text
OCaml : [0,3) "int" :: source.cpp > meta.qualified_type.cpp
VSCode: [0,3) "int" :: source.cpp > meta.function.definition.cpp > meta.qualified_type.cpp > storage.type.primitive.cpp > storage.type.built-in.primitive.cpp

OCaml : [3,4) " " :: source.cpp
VSCode: [3,4) " " :: source.cpp > meta.function.definition.cpp

OCaml : [4,8) "main" :: source.cpp > entity.name.function.definition.cpp
VSCode: [4,8) "main" :: source.cpp > meta.function.definition.cpp > meta.head.function.definition.cpp > entity.name.function.definition.cpp
```

## Missing feature plans

## F1 - Delimiter tokens should inherit active `contentName` scopes

Evidence: mismatches 1-5.

Plan:

1. Audit delimiter token emission paths in `src/tokenizer.ml` (`emit_capture_scoped_tokens`, `emit_delim_end_captures`, `try_delim_end`) and identify where delimiter scopes are built from `frame_scopes` vs `child_scopes`.
2. Align begin/end/while delimiter punctuation emission with vscode behavior by including active content scopes when delimiter is emitted inside a delimiter region.
3. Add focused regressions in `test/test_tokenize.ml` for `a-basic` and `while-state` lines.
4. Re-run `test_vscode_compat` and confirm mismatches 1-5 disappear.

Exit criteria:

- `a-basic` and `while-state` cases fully match vscode scopes.

## F2 - While-scope stack propagation across lines

Evidence: mismatches 6-9 (missing `xlist`/`ylist` on while lines and nested tokens).

Plan:

1. Trace `try_while_rules` and stack restoration logic in `tokenize_exn` to confirm the scope frame used when re-entering while delimiters.
2. Ensure line-start while continuation preserves full nested content scope stack (for example `xlist`, `ylist`) before matching new candidates.
3. Add multi-line regression tests mirroring `multiwhile-state` lines 1-4.
4. Re-run side-by-side suite and verify these four mismatches close.

Exit criteria:

- `multiwhile-state` lines 1-4 match vscode exactly.

## F3 - End-of-line/token-boundary parity for while continuations

Evidence: mismatch 10 (`multiwhile-state` line 5 shows out-of-range end index vs line length).

Plan:

1. Instrument both engines for this case to inspect raw token boundaries and whether newline handling differs.
2. Confirm precondition alignment (`tokenize_exn` single-line contract vs vscode `tokenizeLine`) and normalize test input strategy if needed.
3. If OCaml tokenizer is wrong, fix boundary computation to guarantee end index <= line length.
4. Add assertion in compat harness to surface raw boundary values for this case.

Exit criteria:

- No boundary overruns and line 5 tokens match vscode or the harness proves an input-normalization difference explicitly.

## F4 - Capture coalescing and delimiter segmentation parity

Evidence: mismatch 11 (OCaml splits `({`, `#aaff59`, `})` into finer tokens than vscode).

Plan:

1. Compare capture traversal and token splitting in `handle_captures` with vscode behavior for overlapping begin/end capture groups.
2. Decide parity strategy: either coalesce same-scope adjacent tokens to match vscode output, or mirror vscode capture folding order directly.
3. Add a grammar-specific regression (from `groups.json`) that asserts vscode-equivalent spans.
4. Validate no regressions in existing overlap-capture tests.

Exit criteria:

- `groups-single-line` spans/scopes match reference output.

## F5 - Parent meta-scope propagation for complex grammars (C++)

Evidence: mismatch 12 (missing `meta.function.definition.cpp` and storage scopes around `int main()`).

Plan:

1. Trace include/repository candidate resolution (`collect_candidates` + selected `candidate_grammar`) to ensure parent meta scopes are retained when deeper patterns match.
2. Verify whether scope stack ordering/attachment omits outer meta scopes for matched tokens in function definitions.
3. Add targeted C++ regression case with expected parent meta scopes (based on vscode output).
4. Re-run compat suite and ensure this mismatch closes without regressing simpler grammars.

Exit criteria:

- `cpp-simple` case matches vscode scopes for all tokens.

## Suggested execution order

1. F1 (delimiter/content scopes)
2. F2 (while stack propagation)
3. F3 (line-boundary parity)
4. F4 (capture coalescing)
5. F5 (meta-scope propagation in complex grammars)
