## Unreleased

- Fix an uncaught `Invalid_argument "String.sub / Bytes.sub"` when a grammar has a simple capture followed by a sibling capture with nested patterns, which crashed ordinary Markdown, CSS, Go, dotenv, and shellsession input.
- Fix quadratic tokenization time on long lines. Tokenizing a line now takes time proportional to its length.
- Fix the remaining `Invalid_argument "String.sub / Bytes.sub"` crashes on valid input: a zero-width match with captures past its end (JavaScript/TypeScript `export const`, `declare const`) and a capture nested inside a capture with patterns (Swift regex literals, C++ function definitions). Captures are now handled as vscode-textmate does, and `$N` references in rule and capture names are expanded.
- Highlight source that is not valid UTF-8 instead of raising. Invalid bytes are kept byte for byte in token texts; the tokenizer sees each one as `_`. `Decoration.apply` counts each invalid byte as one character.
- Fix crashes when an Oniguruma match ends past the end of the line, and when a back-referenced `end`/`while` pattern contains an invalid byte (heredocs in shell, Perl, Ruby, PHP; C++ raw strings).
- Reject a grammar with a malformed static `end` or `while` regex when it loads, instead of raising while highlighting.
- Fix grammars whose includes form a loop (`$self`, `$base`, own scope name, self or mutually recursive repository entries, captures including `$self`) hanging or overflowing the stack, and diamond-shaped includes taking exponential time.
- Bound the work per line: only the first 10,000 bytes of a line are matched, and matching stops after 0.25 s. The rest of the line becomes one token with the scopes in force at the cut.
- Fix theme matching taking quadratic time in scope depth and exponential time in selector parts (JSON nested 1,600 deep: 170 s to under 1 s).
- Fix nested include lookup taking quadratic time in nesting depth, and tokens splitting a UTF-8 character.
- Fix the Oniguruma bindings reading a moved subject string after a minor GC, which produced wrong tokens, and a double free in regex sets.
- Escape theme names, theme colours, extra-theme labels, `css_variable_prefix`, `pre_class`, `code_class` and `class_prefix` in HTML and SVG output.
- Make SVG output well-formed XML when the source has control characters or invalid UTF-8, and neutralise control characters in ANSI output.
- Keep decoration styles inline in `Css_classes` mode, where they were lost, and derive class names from an MD5 hash so different styles never share a class.
- Exit with code `3` and a message when the output cannot be written (full disk, closed standard output), instead of a fatal uncaught exception. Name the path when an input is a directory.
- Check the committed HTML, SVG, LaTeX, ANSI, and token previews in `dune build @runtest`, so that output changes are visible as test failures.
- Escape decoration-supplied `class_`, `style`, and `data` values (and grammar scope names) before writing them into HTML/SVG attributes, closing an HTML/SVG injection hole for decorations built from untrusted strings.
- Reject `Decoration.make ~data` keys that are not valid `data-*` attribute-name characters, instead of writing them unescaped into the attribute name.
- Normalize `Html_options.make ~css_variable_prefix` to always end with `-`.
- Stop counting a line's trailing newline towards SVG output width.
- Document that decorations are applied by the HTML and SVG renderers only; ANSI and LaTeX output ignore them.
- Fix `Ochre.load_exn`, `Ochre.load_from_files_exn`, `Ochre.Theme.load_exn`, and `Ochre.Theme.load_from_file_exn` raising a raw `Yojson`/`Sys_error`/etc. exception instead of the documented `Failure` on malformed input; the CLI's own exception handler now also catches any other exception as a defense-in-depth measure.
- Fix the CLI crashing with an uncaught-exception backtrace and exit code 2 on a malformed `--theme` JSON file; it now reports a clean `ochre: ...` message.
- Fix `--theme <typo>` reporting a raw filesystem error; it now reports that the name is not a built-in or a file and lists the built-in theme names.
- Fix `--grammar <file>` whose filename-derived language id does not match `LANG` reporting a generic "Grammar not found" error; it now explains the filename-id rule.
- Reject duplicate language ids passed to `Ochre.load`/`Ochre.load_exn`/`Ochre.load_from_files`/`Ochre.load_from_files_exn` instead of silently keeping the first one.
- Unify the CLI's exit code for user/input errors on `1` (unknown language, unresolvable theme/grammar, malformed JSON, missing files, a missing required argument) via cmdliner's `~term_err:1`. `124` is now reserved for an option given a malformed or missing value (e.g. `--format bogus`, `--theme` with no argument); `125` stays reserved for an internal bug. Document the CLI's exit codes (`0`, `1`, `3`, `124`, `125`) in `--help`, `docs/cli.md`, and `docs/cli.mld`.
- Fix malformed theme/grammar JSON reporting a raw `Yojson__Common.Json_error(...)` exception constructor name; the message is now a single readable line naming the file path (or the grammar's language id, for in-memory grammar sources), e.g. `ochre: ./bad.json: invalid JSON: Line 1, bytes 5-15: Expected ':' but found 'valid json'`.
- Fix a missing theme/grammar file reporting a raw `Sys_error("...")` exception constructor name (including through a theme's `"include"` chain); the message now reads `<path>: No such file or directory`. `Out_of_memory`, `Stack_overflow`, and `Sys.Break` are no longer caught and turned into `Failure`/`Error` by any loader; they propagate as-is.
- Set Oniguruma's regex engine limits once per process instead of on every `Ochre.load`/`Ochre.load_exn`/`Ochre.load_from_files`/`Ochre.load_from_files_exn` call.
- Export `Ochre.Theme.themes` and document the "Raises `Failure`" contract on `Ochre.to_html` and all `_exn` loaders.
- Fix 9 bundled grammars (`blade`, `codeql`, `d`, `move`, `racket`, `stata`, `wikitext`, `xml`, `swift`) that failed to load via `Ochre.load`/`Ochre.load_exn`. Each has a rule shape vscode-textmate tolerates but the vendored TextMate parser rejected outright: a `begin` rule with neither `end` nor `while`, a rule with both `match` and `begin`, a `patterns`-less repository entry, a `patterns`-less grammar, a non-dict capture/repository-entry value (bare string, array, or `null`), and a non-string `name`/`contentName`. The parser now degrades the same way vscode-textmate does instead of failing to load. `swift` additionally needed the vendored Oniguruma binding to compile regexes with `ONIG_OPTION_CAPTURE_GROUP`, matching vscode-oniguruma, so that a numbered regex subroutine call next to a named group doesn't reject compilation.

## 1.1.0

- Add built-in `plaintext`/`text`/`txt` languages that produce unstyled tokens without a grammar, in both the library and the CLI.
- Add `?options` and `?extra_themes` to `Ochre.to_string`, giving the runtime-format API the same HTML capabilities as `Ochre.to_html`.
- Report the real package version from `ochre --version` instead of a hardcoded string.
- Preserve source line endings across tokenization, CLI input, and rendered output.
- Reject multi-theme transforms that produce incompatible token structures.
- Count decoration positions as Unicode scalar values instead of UTF-8 bytes.
- Report CLI input and theme loading failures without uncaught exceptions.
- Document all CLI flags, bundled grammars, and dual-theme HTML output in the CLI reference.
- Deploy API documentation and dual-theme/ANSI/tokens previews to GitHub Pages.

## 1.0.0

- Initial release of ochre, a syntax highlighter inspired by Shiki, using TextMate grammars and themes to produce accurate, beautiful syntax highlighting. It supports HTML output with inline styles, ANSI terminal colors, and raw token output
- Initial release of ochre-cli, a CLI tool for highlighting source code using TextMate grammars and themes
