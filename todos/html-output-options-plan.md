# Advanced HTML Output Options Plan

## Goal
Expand HTML rendering from a single inline-style mode to configurable output suitable for docs, apps, and design systems.

## Milestones
1. Introduce `Html_options` in the public API.
2. Support class-based rendering and richer HTML structure.
3. Add optional helpers for CSS generation.
4. Ensure backward compatibility with current `to_html` output.
5. Add snapshot coverage for option matrix.

## API Design
- Add `module Html_options` in `lib/ochre.mli`.
- Add `to_html_with : t -> options:Html_options.t -> theme:Theme.theme -> lang:string -> string -> string`.
- Keep `to_html` as wrapper using default options.

Proposed options:
- `style_mode`: `Inline_styles | Css_classes`
- `pre_class`: `string option`
- `code_class`: `string option`
- `line_wrapping`: `bool`
- `line_numbers`: `bool`
- `include_background`: `bool`
- `include_scopes_as_data_attrs`: `bool`
- `tab_width`: `int`

## Implementation Steps
1. Create `lib/html_options.ml` and `lib/html_options.mli`.
2. Refactor `lib/render_html.ml` to accept options and emit:
   - per-line wrappers,
   - deterministic token classes,
   - optional `data-line` and `data-scope` attributes.
3. Add optional CSS helper:
   - `render_theme_css : theme:Theme.theme -> string`.
4. Wire through `lib/ochre.ml` and `lib/ochre.mli`.
5. Add CLI flags in `cli/cli.ml`:
   - `--html-css-classes`,
   - `--line-numbers`,
   - `--wrap-lines`.

## Testing
- Snapshot tests for combinations of options.
- Cases: empty lines, tabs, long lines, mixed styles.
- Regression test: default `to_html` output unchanged.

## Risks
- Option interactions can produce inconsistent markup.
- Large HTML output size when using metadata attributes.

## Mitigations
- Keep a strict default option set.
- Validate incompatible flag combos.
- Document tradeoffs in API docs.

## Done Criteria
- `to_html` remains backward compatible.
- `to_html_with` covers both inline and class-based modes.
- Snapshot suite validates stable output structure.
