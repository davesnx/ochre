# Transformer Pipeline Plan

## Goal
Add a typed, composable transform pipeline that runs after tokenization and before rendering, so users can implement line highlights, word highlights, diff marks, and custom token/line rewrites.

## Milestones
1. Define a transform IR and hook system.
2. Integrate transform execution into the main render flow.
3. Ship core built-in transforms.
4. Expose transforms in CLI and docs.
5. Add golden tests for ordering and determinism.

## API Design
- Add `Ochre.Transform` module in `lib/ochre.mli`.
- Add transform-aware entry points:
  - `to_tokens_with`
  - `to_html_with`
  - `to_string_with`
- Keep existing APIs as wrappers with `~transforms:[]` for backward compatibility.

Proposed shape:

```ocaml
module Transform : sig
  type token = Token.styled_token
  type line = token list
  type document = line list

  type t = {
    name : string;
    before_line : (line_index:int -> line -> line) option;
    after_line : (line_index:int -> line -> line) option;
    before_render : (document -> document) option;
    after_render : (document -> document) option;
  }
end
```

## Implementation Steps
1. Add `lib/transform.ml` and `lib/transform.mli`.
2. Update `lib/ochre.ml` to:
   - build token document from tokenizer,
   - apply transforms in deterministic order,
   - pass transformed tokens to renderers.
3. Add built-in transforms in `lib/transform_builtin.ml`:
   - line ranges highlight,
   - word match highlight,
   - diff markers (`+`, `-`),
   - scope-based marker.
4. Add CLI parsing in `cli/cli.ml`:
   - repeatable `--transform`.
5. Extend docs in `docs/Ochre.md` with examples.

## Testing
- Unit tests for transform order in `test/test_ochre.ml`.
- Snapshot tests for transformed HTML output.
- CLI cram tests for `--transform` combinations.

## Risks
- Transform order conflicts across plugins.
- Performance regressions for large files.

## Mitigations
- Stable ordering by list position.
- Keep transforms pure and avoid reparsing.
- Add simple benchmark test for large inputs.

## Done Criteria
- Existing APIs still behave the same with no transforms.
- Combined transforms produce deterministic output.
- New tests pass for ordering and snapshots.
