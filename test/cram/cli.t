CLI end-to-end tests. All commands use a fixed theme to keep output
independent of the terminal environment.

Bundled grammar with zero flags

  $ printf 'let x = 1\n' | ochre ocaml --theme nord
  <pre class="ochre" style="background-color:var(--ochre-bg,#2e3440);color:var(--ochre,#d8dee9)" tabindex="0"><code><span class="line"><span style="background-color:var(--ochre-bg,#2e3440ff);color:var(--ochre,#81A1C1)">let</span><span style="background-color:var(--ochre-bg,#2e3440ff);color:var(--ochre,#d8dee9ff)"> </span><span style="background-color:var(--ochre-bg,#2e3440ff);color:var(--ochre,#88C0D0)">x</span><span style="background-color:var(--ochre-bg,#2e3440ff);color:var(--ochre,#d8dee9ff)"> </span><span style="background-color:var(--ochre-bg,#2e3440ff);color:var(--ochre,#81A1C1)">=</span><span style="background-color:var(--ochre-bg,#2e3440ff);color:var(--ochre,#d8dee9ff)"> </span><span style="background-color:var(--ochre-bg,#2e3440ff);color:var(--ochre,#B48EAD)">1</span><span style="background-color:var(--ochre-bg,#2e3440ff);color:var(--ochre,#d8dee9ff)">
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
  <pre class="ochre" style="background-color:var(--ochre-bg,#2e3440);color:var(--ochre,#d8dee9)" tabindex="0"><code><span class="line"><span style="background-color:var(--ochre-bg,#2e3440ff);color:var(--ochre,#d8dee9ff)">hello
  </span></span></code></pre>

ANSI output

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --format ansi | cat -v
  ^[[48;2;46;52;64m^[[38;2;129;161;193mlet^[[0m^[[48;2;46;52;64m^[[38;2;216;222;233m ^[[0m^[[48;2;46;52;64m^[[38;2;136;192;208mx^[[0m^[[48;2;46;52;64m^[[38;2;216;222;233m ^[[0m^[[48;2;46;52;64m^[[38;2;129;161;193m=^[[0m^[[48;2;46;52;64m^[[38;2;216;222;233m ^[[0m^[[48;2;46;52;64m^[[38;2;180;142;173m1^[[0m^[[48;2;46;52;64m^[[38;2;216;222;233m
  ^[[0m

LaTeX output

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --format latex
  \begin{ochrehighlight}{2E3440}{D8DEE9}
  \textcolor[HTML]{81A1C1}{let}\textcolor[HTML]{D8DEE9}{\ }\textcolor[HTML]{88C0D0}{x}\textcolor[HTML]{D8DEE9}{\ }\textcolor[HTML]{81A1C1}{=}\textcolor[HTML]{D8DEE9}{\ }\textcolor[HTML]{B48EAD}{1}\textcolor[HTML]{D8DEE9}{}
  \end{ochrehighlight}

SVG output (header only)

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --format svg | head -2
  <svg xmlns="http://www.w3.org/2000/svg" width="104" height="38" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#2e3440"/>

Dual-theme HTML emits dark CSS custom properties with light as default

  $ printf 'let x = 1\n' | ochre ocaml --theme-light light --theme-dark nord | grep -o -- '--ochre-dark-bg:[^;"]*' | sort -u
  --ochre-dark-bg:#2e3440
  --ochre-dark-bg:#2e3440ff
  $ printf 'let x = 1\n' | ochre ocaml --theme-light light --theme-dark nord | grep -o 'background-color:var(--ochre-bg,#[0-9A-Fa-f]*)' | sort -u
  background-color:var(--ochre-bg,#FFFFFF)

Custom CSS variable prefix

  $ printf 'let x = 1\n' | ochre ocaml --theme-light light --theme-dark nord --css-var-prefix=--hl- | grep -o -- '--hl-dark-bg:[^;"]*' | sort -u
  --hl-dark-bg:#2e3440
  --hl-dark-bg:#2e3440ff

No default color suppresses inline colors

  $ printf 'let x = 1\n' | ochre ocaml --theme-light light --theme-dark nord --no-default-color | head -1
  <pre class="ochre ochre-themes light nord" style="--ochre-dark-bg:#2e3440;--ochre-dark:#d8dee9" tabindex="0"><code><span class="line"><span style="--ochre-dark-bg:#2e3440ff;--ochre-dark:#81A1C1">let</span><span style="--ochre-dark-bg:#2e3440ff;--ochre-dark:#d8dee9ff"> </span><span style="--ochre-dark-bg:#2e3440ff;--ochre-dark:#88C0D0">x</span><span style="--ochre-dark-bg:#2e3440ff;--ochre-dark:#d8dee9ff"> </span><span style="--ochre-dark-bg:#2e3440ff;--ochre-dark:#81A1C1">=</span><span style="--ochre-dark-bg:#2e3440ff;--ochre-dark:#d8dee9ff"> </span><span style="--ochre-dark-bg:#2e3440ff;--ochre-dark:#B48EAD">1</span><span style="--ochre-dark-bg:#2e3440ff;--ochre-dark:#d8dee9ff">

CSS classes mode

  $ printf 'let x = 1\n' | ochre ocaml --theme nord --html-css-classes
  <pre class="ochre" style="background-color:var(--ochre-bg,#2e3440);color:var(--ochre,#d8dee9)" tabindex="0"><code><span class="line"><span class="ochre-6afa81a">let</span><span class="ochre-6e5998fa"> </span><span class="ochre-17276d42">x</span><span class="ochre-6e5998fa"> </span><span class="ochre-6afa81a">=</span><span class="ochre-6e5998fa"> </span><span class="ochre-edd9683">1</span><span class="ochre-6e5998fa">
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
    "<"  punctuation.definition.tag.begin.html, meta.tag.inline.$2.start.html, text.html.basic
    "b"  entity.name.tag.html, meta.tag.inline.$2.start.html, text.html.basic
    ">"  punctuation.definition.tag.end.html, meta.tag.inline.$2.start.html, text.html.basic
    "hi"  text.html.basic
    "</"  punctuation.definition.tag.begin.html, meta.tag.inline.$2.end.html, text.html.basic
    "b"  entity.name.tag.html, meta.tag.inline.$2.end.html, text.html.basic
    ">"  punctuation.definition.tag.end.html, meta.tag.inline.$2.end.html, text.html.basic
    "\n"  text.html.basic

Unknown language reports an error

  $ printf 'x\n' | ochre notareallang 2>error.log; echo "exit: $?"
  exit: 124
  $ head -1 error.log | cut -c1-42
  ochre: No bundled grammar for 'notareallan

Invalid format is a usage error

  $ printf 'x\n' | ochre ocaml --format bogus 2>usage.log; echo "exit: $?"
  exit: 124
  $ head -1 usage.log
  Usage: ochre [--help] [OPTION]… LANG [FILE]
