CLI end-to-end tests. All commands use a fixed theme to keep output
independent of the terminal environment.

Bundled grammar with zero flags

  $ printf 'let x = 1\n' | ochre ocaml --theme nord
  <pre class="ochre" style="background-color:var(--ochre-bg,#2e3440);color:var(--ochre,#d8dee9)" tabindex="0"><code><span class="line"><span style="color:var(--ochre,#81a1c1)">let</span><span style="color:var(--ochre,#d8dee9)"> </span><span style="color:var(--ochre,#88c0d0)">x</span><span style="color:var(--ochre,#d8dee9)"> </span><span style="color:var(--ochre,#81a1c1)">=</span><span style="color:var(--ochre,#d8dee9)"> </span><span style="color:var(--ochre,#b48ead)">1</span><span style="color:var(--ochre,#d8dee9)">
  </span></span></code></pre>

File input instead of stdin

  $ printf 'let x = 1\n' > input.ml
  $ ochre ocaml input.ml --theme nord --format tokens
  line 1:
    "let"  keyword.ocaml, source.ocaml
    " "  source.ocaml
    "x"  entity.name.function.binding.ocaml, source.ocaml
    " "  source.ocaml
    "="  keyword.operator.ocaml, source.ocaml
    " "  source.ocaml
    "1"  constant.numeric.decimal.integer.ocaml, source.ocaml
    "\n"  source.ocaml

Plaintext works without any grammar

  $ printf 'no grammar here\n' | ochre plaintext --theme nord --format tokens
  line 1:
    "no grammar here\n"  
  $ printf 'hello\n' | ochre text --theme nord
  <pre class="ochre" style="background-color:var(--ochre-bg,#2e3440);color:var(--ochre,#d8dee9)" tabindex="0"><code><span class="line"><span style="color:var(--ochre,#d8dee9)">hello
  </span></span></code></pre>

ANSI output

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --format ansi | cat -v
  ^[[38;2;129;161;193mlet^[[0m^[[38;2;216;222;233m ^[[0m^[[38;2;136;192;208mx^[[0m^[[38;2;216;222;233m ^[[0m^[[38;2;129;161;193m=^[[0m^[[38;2;216;222;233m ^[[0m^[[38;2;180;142;173m1^[[0m^[[38;2;216;222;233m
  ^[[0m

LaTeX output

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --format latex
  \begin{ochrehighlight}{2E3440}{D8DEE9}
  \textcolor[HTML]{81A1C1}{let}\textcolor[HTML]{D8DEE9}{\ }\textcolor[HTML]{88C0D0}{x}\textcolor[HTML]{D8DEE9}{\ }\textcolor[HTML]{81A1C1}{=}\textcolor[HTML]{D8DEE9}{\ }\textcolor[HTML]{B48EAD}{1}\textcolor[HTML]{D8DEE9}{}
  \end{ochrehighlight}

SVG output (header only)

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --format svg | head -2
  <svg xmlns="http://www.w3.org/2000/svg" width="96" height="38" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#2e3440"/>

Dual-theme HTML emits light-dark() colors and no inline color-scheme

  $ printf 'let x = 1\n' | ochre ocaml --theme-light light --theme-dark nord | grep -o 'background-color:light-dark([^)]*)' | sort -u
  background-color:light-dark(#ffffff,#2e3440)
  $ printf 'let x = 1\n' | ochre ocaml --theme-light light --theme-dark nord | grep -c 'color-scheme'
  0
  [1]

Custom CSS variable prefix

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --css-var-prefix=--hl- | grep -o 'var(--hl[a-z-]*,' | sort -u
  var(--hl,
  var(--hl-bg,

No default color keeps light-dark() for light and dark themes

  $ printf 'let x = 1\n' | ochre ocaml --theme-light light --theme-dark nord --no-default-color | head -1
  <pre class="ochre ochre-themes light nord" style="background-color:light-dark(#ffffff,#2e3440);color:light-dark(#000000,#d8dee9)" tabindex="0"><code><span class="line"><span style="color:light-dark(#0000ff,#81a1c1)">let</span><span style="color:light-dark(#000000,#d8dee9)"> </span><span style="color:light-dark(#795e26,#88c0d0)">x</span><span style="color:light-dark(#000000,#d8dee9)"> </span><span style="color:light-dark(#000000,#81a1c1)">=</span><span style="color:light-dark(#000000,#d8dee9)"> </span><span style="color:light-dark(#098658,#b48ead)">1</span><span style="color:light-dark(#000000,#d8dee9)">

CSS classes mode

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --html-css-classes
  <pre class="ochre" style="background-color:var(--ochre-bg,#2e3440);color:var(--ochre,#d8dee9)" tabindex="0"><code><span class="line"><span class="ochre-9a8a30435004f273">let</span><span class="ochre-8cb1d293426df23a"> </span><span class="ochre-0b0ee024c14d67d9">x</span><span class="ochre-8cb1d293426df23a"> </span><span class="ochre-9a8a30435004f273">=</span><span class="ochre-8cb1d293426df23a"> </span><span class="ochre-799c82f6d6c7331b">1</span><span class="ochre-8cb1d293426df23a">
  </span></span></code></pre>

Line numbers

  $ printf 'let x = 1\nlet y = 2\n' | ochre ocaml --theme nord --line-numbers | grep -o 'data-line="[0-9]*"'
  data-line="1"
  data-line="2"

Scope data attributes

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --scopes-data | grep -o 'data-scope="[^"]*"' | head -3
  data-scope="keyword.ocaml source.ocaml"
  data-scope="source.ocaml"
  data-scope="entity.name.function.binding.ocaml source.ocaml"

Include a bundled grammar by name

  $ printf '<b>hi</b>\n' | ochre html --include css --theme nord --format tokens
  line 1:
    "<"  punctuation.definition.tag.begin.html, meta.tag.inline.b.start.html, text.html.basic
    "b"  entity.name.tag.html, meta.tag.inline.b.start.html, text.html.basic
    ">"  punctuation.definition.tag.end.html, meta.tag.inline.b.start.html, text.html.basic
    "hi"  text.html.basic
    "</"  punctuation.definition.tag.begin.html, meta.tag.inline.b.end.html, text.html.basic
    "b"  entity.name.tag.html, meta.tag.inline.b.end.html, text.html.basic
    ">"  punctuation.definition.tag.end.html, meta.tag.inline.b.end.html, text.html.basic
    "\n"  text.html.basic

Unknown language reports an error

  $ printf 'x\n' | ochre notareallang 2>error.log; echo "exit: $?"
  exit: 1
  $ head -1 error.log | cut -c1-42
  ochre: No bundled grammar for 'notareallan

Invalid format is a usage error

  $ printf 'x\n' | ochre ocaml --format bogus 2>usage.log; echo "exit: $?"
  exit: 124
  $ head -1 usage.log
  Usage: ochre [--help] [OPTION]… LANG [FILE]

A valid --theme file works

  $ cat > good-theme.json <<'EOF'
  > {
  >   "name": "good",
  >   "colors": { "editor.foreground": "#111111", "editor.background": "#222222" },
  >   "tokenColors": [
  >     { "scope": "keyword", "settings": { "foreground": "#ff0000" } }
  >   ]
  > }
  > EOF
  $ printf 'let x = 1\n' | ochre ocaml --theme good-theme.json --format tokens
  line 1:
    "let"  keyword.ocaml, source.ocaml
    " "  source.ocaml
    "x"  entity.name.function.binding.ocaml, source.ocaml
    " "  source.ocaml
    "="  keyword.operator.ocaml, source.ocaml
    " "  source.ocaml
    "1"  constant.numeric.decimal.integer.ocaml, source.ocaml
    "\n"  source.ocaml

A malformed --theme file is a clean error, not a crash

  $ printf '{not valid json' > bad-theme.json
  $ printf 'let x = 1\n' | ochre ocaml --theme bad-theme.json 2>theme-malformed.log; echo "exit: $?"
  exit: 1
  $ cat theme-malformed.log
  ochre: bad-theme.json: invalid JSON: Line 1, bytes 5-15: Expected ':' but
         found 'valid json'

A missing --theme file reports it is not a built-in name or a file

  $ printf 'let x = 1\n' | ochre ocaml --theme ./does-not-exist-theme.json 2>theme-missing.log; echo "exit: $?"
  exit: 1
  $ cat theme-missing.log
  ochre: Unknown theme './does-not-exist-theme.json': not a built-in name and
         not a file. Available: dark, light, tokyonight, everforest, ayu,
         catppuccin, catppuccin-macchiato, gruvbox, kanagawa, nord, matrix,
         one-dark

A typo'd built-in --theme name lists the available names

  $ printf 'let x = 1\n' | ochre ocaml --theme not-a-real-theme 2>theme-typo.log; echo "exit: $?"
  exit: 1
  $ cat theme-typo.log
  ochre: Unknown theme 'not-a-real-theme': not a built-in name and not a file.
         Available: dark, light, tokyonight, everforest, ayu, catppuccin,
         catppuccin-macchiato, gruvbox, kanagawa, nord, matrix, one-dark

A valid --grammar file matching LANG works

  $ cat > foo.tmLanguage.json <<'EOF'
  > { "scopeName": "source.foo", "name": "foo", "patterns": [] }
  > EOF
  $ printf 'let x = 1\n' | ochre foo --grammar foo.tmLanguage.json --format tokens
  line 1:
    "let x = 1\n"  source.foo

A --grammar file whose filename-derived id does not match LANG explains the rule

  $ printf 'let x = 1\n' | ochre javascript --grammar foo.tmLanguage.json 2>grammar-mismatch.log; echo "exit: $?"
  exit: 1
  $ cat grammar-mismatch.log
  ochre: LANG is 'javascript' but none of the --grammar files register under
         that id. A --grammar file's id comes from its filename (e.g.
         'ocaml.tmLanguage.json' registers as 'ocaml'); rename the file or
         change LANG to match.

A malformed --grammar file is a clean error, not a crash

  $ printf '{not valid json' > bad.tmLanguage.json
  $ printf 'let x = 1\n' | ochre bad --grammar bad.tmLanguage.json 2>grammar-malformed.log; echo "exit: $?"
  exit: 1
  $ cat grammar-malformed.log
  ochre: grammar 'bad': invalid JSON: Line 1, bytes 5-15: Expected ':' but
         found 'valid json'

A missing input file is a clean error

  $ ochre ocaml does-not-exist.ml 2>missing-input.log; echo "exit: $?"
  exit: 1
  $ cat missing-input.log
  ochre: does-not-exist.ml: No such file or directory

A missing LANG is a user/input error (not a parse-time value error)

  $ printf 'x\n' | ochre 2>missing-lang.log; echo "exit: $?"
  exit: 1
  $ head -2 missing-lang.log | tail -1
  ochre: required argument LANG is missing

No default color on one theme emits that theme as variables

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --no-default-color | grep -o -- '--ochre-[a-z-]*:#[0-9A-Fa-f]*' | sort -u
  --ochre-nord-bg:#2e3440
  --ochre-nord:#81a1c1
  --ochre-nord:#88c0d0
  --ochre-nord:#b48ead
  --ochre-nord:#d8dee9

COLORFGBG picks the default theme from the background colour: 0-6 and 8 are dark, 7 and 9-15 light, anything else is unknown and gives dark
  $ for value in '15;0' '15;6' '0;7' '0;8' '0;9' '0;15' '15;default;7' '0;250' 'x'; do
  >   printf '%s ' "$value"
  >   printf 'x\n' | env -u OCHRE_THEME_MODE -u TERM_THEME COLORFGBG="$value" ochre plaintext --format svg | sed -n '2s/.*fill="\(#[0-9A-Fa-f]*\)".*/\1/p'
  > done
  15;0 #1e1e1e
  15;6 #1e1e1e
  0;7 #ffffff
  0;8 #1e1e1e
  0;9 #ffffff
  0;15 #ffffff
  15;default;7 #ffffff
  0;250 #1e1e1e
  x #1e1e1e
