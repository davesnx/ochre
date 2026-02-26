# Advanced Theme and Composition UX Plan

## Goal
Improve ergonomics for multi-theme and multi-language setups with aliases, fallbacks, and layered theme composition.

## Milestones
1. Add a high-level highlighter config type.
2. Support theme layering and merge precedence.
3. Add language alias and fallback resolution.
4. Expose runtime theme selection.
5. Add strict validation and caching.

## API Design
- Add `Highlighter_config` module in `lib/ochre.mli`.
- Add `create_with_config : config:Highlighter_config.t -> t`.
- Add runtime render selection:
  - `to_html ... ~theme_name:string option`
  - same for `to_string` and other output functions.

Proposed config fields:
- `grammars : (string * string) list`
- `aliases : (string * string) list`
- `fallback_chain : (string * string list) list`
- `themes : (string * Theme.theme) list`
- `default_theme : string option`
- `strict : bool`

## Implementation Steps
1. Add config module and internal resolver state.
2. Extend `lib/grammar_loader.ml`:
   - alias resolution,
   - fallback chain lookup.
3. Extend `lib/theme.ml`:
   - `merge : base:theme -> override:theme -> theme`.
4. Update `lib/ochre.ml` to resolve theme by name at render-time.
5. Add caching for parsed/merged themes in highlighter state.
6. Add CLI support in `cli/cli.ml`:
   - repeatable `--theme`,
   - `--theme-name`,
   - repeatable `--alias`.

## Testing
- Theme merge precedence tests.
- Alias + fallback resolution tests.
- Strict vs non-strict behavior tests.
- CLI tests for unresolved alias/fallback errors.

## Risks
- Ambiguous alias or fallback cycles.
- More complex state can obscure errors.

## Mitigations
- Validate configuration at creation time.
- Detect cycles in fallback graph.
- Emit actionable error messages with resolved path.

## Done Criteria
- One highlighter can render multiple themes/languages ergonomically.
- Alias/fallback behavior is deterministic and tested.
- Misconfigurations fail early with clear diagnostics.
