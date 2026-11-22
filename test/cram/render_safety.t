A theme name is HTML-escaped in the class attribute of the primary theme
  $ ./test_render_safety.exe html-theme-name
  <pre class="ochre ochre-themes &quot;&gt;&lt;img src=x onerror=alert(1)&gt; dark" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4);--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="color:var(--ochre,#ff0000);--ochre-dark:#ff0000">let</span><span style="color:var(--ochre,#d4d4d4);--ochre-dark:#d4d4d4"> x</span></span></code></pre>

A theme name is HTML-escaped in the class attribute of an extra theme
  $ ./test_render_safety.exe html-extra-theme-name
  <pre class="ochre ochre-themes t &quot;&gt;&lt;img src=x onerror=alert(1)&gt;" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4);--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="color:var(--ochre,#ff0000);--ochre-dark:#ff0000">let</span><span style="color:var(--ochre,#d4d4d4);--ochre-dark:#d4d4d4"> x</span></span></code></pre>

Theme colours that are not hex are dropped when the theme loads, never written
  $ ./test_render_safety.exe html-colors
  <pre class="ochre" style="background-color:var(--ochre-bg,#ffffff);color:var(--ochre,#000000)" tabindex="0"><code><span class="line"><span style="color:var(--ochre,#000000)">let</span><span style="color:var(--ochre,#000000)"> x = </span><span style="color:var(--ochre,#000000)">&quot;s&quot;</span></span></code></pre>
  <pre class="ochre ochre-themes t evil" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4);--ochre-dark-bg:#ffffff;--ochre-dark:#000000" tabindex="0"><code><span class="line"><span style="color:var(--ochre,#ff0000);--ochre-dark:#000000">let</span><span style="color:var(--ochre,#d4d4d4);--ochre-dark:#000000"> x = </span><span style="color:var(--ochre,#00ff00);--ochre-dark:#000000">&quot;s&quot;</span></span></code></pre>

Only hex colours are kept: CSS names, rgb() and hsl() are dropped, hex is normalized
  $ ./test_render_safety.exe html-valid-colors
  <pre class="ochre" style="background-color:var(--ochre-bg,#ffffff);color:var(--ochre,#000000)" tabindex="0"><code><span class="line"><span style="color:var(--ochre,#000000)">let</span><span style="color:var(--ochre,#000000)"> x = </span><span style="color:var(--ochre,#00ff0088)">&quot;s&quot;</span></span></code></pre>

Options and labels are made safe for HTML attributes and CSS names
  $ ./test_render_safety.exe html-options
  <pre class="ochre ochre-themes t dark a&quot;&gt;&lt;u&gt;" style="background-color:var(--x____style_-bg,#1e1e1e);color:var(--x____style_,#d4d4d4);--x____style_-d___i___-bg:#1e1e1e;--x____style_-d___i___:#d4d4d4" tabindex="0"><code class="b&quot;&gt;&lt;s&gt;"><span class="line"><span style="color:var(--x____style_,#ff0000);--x____style_-d___i___:#ff0000">let</span><span style="color:var(--x____style_,#d4d4d4);--x____style_-d___i___:#d4d4d4"> x</span></span></code></pre>

A class prefix is made safe for CSS selectors
  $ ./test_render_safety.exe html-class-prefix
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span class="a___b___0f188c0cf325ded1">let</span><span class="a___b___232033c531ff619a"> x</span></span></code></pre>
  .ochre { background-color:#1e1e1e; color:#d4d4d4 }
  .a___b___0f188c0cf325ded1 { color:var(--ochre,#ff0000) }
  .a___b___232033c531ff619a { color:var(--ochre,#d4d4d4) }
  

A theme_css label is made safe for CSS names
  $ ./test_render_safety.exe theme-css-label
  .ochre,
  .ochre span {
    --ochre: var(--ochre-dark____style__script_);
    --ochre-bg: var(--ochre-dark____style__script_-bg);
    --ochre-font-style: var(--ochre-dark____style__script_-font-style);
    --ochre-font-weight: var(--ochre-dark____style__script_-font-weight);
    --ochre-text-decoration: var(--ochre-dark____style__script_-text-decoration);
    --ochre-token-bg: var(--ochre-dark____style__script_-token-bg);
  }

Stylesheet colours that are not hex are dropped when the theme loads
  $ ./test_render_safety.exe theme-css-colors
  .ochre { background-color:#ffffff; color:#000000 }
  .c-0f188c0cf325ded1 { color:var(--ochre,#ff0000) }
  .c-99e599976e1971d9 { color:var(--ochre,#000000) }
  

SVG colours that are not hex are dropped when the theme loads
  $ ./test_render_safety.exe svg-colors
  <svg xmlns="http://www.w3.org/2000/svg" width="112" height="38" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#ffffff"/>
    <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan fill="#d4d4d4">let</tspan><tspan fill="#d4d4d4"> x = </tspan><tspan fill="#d4d4d4">&quot;s&quot;</tspan></text>
  </svg>

SVG replaces characters that XML 1.0 forbids by U+FFFD
  $ ./test_render_safety.exe svg-control-chars
  <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"230\" height=\"38\" font-family=\"ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace\" font-size=\"14px\">\n <rect width=\"100%\" height=\"100%\" fill=\"#1e1e1e\"/>\n  <text x=\"10\" y=\"24.0\" font-family=\"ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace\" font-size=\"14px\" fill=\"#d4d4d4\" xml:space=\"preserve\"><tspan fill=\"#d4d4d4\"># a\239\191\189b\239\191\189c\239\191\189d\239\191\189e\239\191\189f\239\191\189g\239\191\189h       i&#13;</tspan></text>\n</svg>
  no forbidden control characters: true

ANSI output neutralises control characters from the source
  $ ./test_render_safety.exe ansi-control-chars
  \027[38;2;212;212;212ma^[[2Jb^Gc^?d\te^Mf\r\n\027[0m\027[38;2;212;212;212mg\239\191\189h\n\027[0m

A decoration style stays in effect in CSS class mode
  $ ./test_render_safety.exe css-classes-decoration-style
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span class="c-0f188c0cf325ded1">let</span><span class="c-232033c531ff619a"> </span><span style="border-bottom:2px solid red" class="focus c-232033c531ff619a">x</span></span></code></pre>

Different styles never share a CSS class
  $ ./test_render_safety.exe css-classes-collision
  distinct classes in html: 5
  every class defined in the stylesheet: true

HTML escaping replaces invalid UTF-8 and NUL by U+FFFD
  $ ./test_render_safety.exe escape-html-invalid-utf8
  a\239\191\189b\239\191\189(c\239\191\189d\239\191\189e&lt;f&gt;&amp;\226\130\172
  caf\195\169 \240\159\152\128

XML escaping replaces every character XML 1.0 forbids
  $ ./test_render_safety.exe escape-xml
  \239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\t\n&#13;\239\191\189\239\191\189\239\191\189&lt;&amp;&quot;&apos;&gt;\239\191\189\240\159\152\128

css_ident keeps only A-Za-z0-9_-
  $ ./test_render_safety.exe escape-css-ident
  a_b____x_-_9__
  idempotent: true

A class name always starts with a letter or an underscore

  $ ./test_render_safety.exe css-classes-prefix-start
  prefix ""
  .ochre
  ._0f188c0cf325ded1
  class _0f188c0cf325ded1
  prefix "1"
  .ochre
  ._10f188c0cf325ded1
  class _10f188c0cf325ded1
  prefix "-"
  .ochre
  ._-0f188c0cf325ded1
  class _-0f188c0cf325ded1
  prefix "ochre-"
  .ochre
  .ochre-0f188c0cf325ded1
  class ochre-0f188c0cf325ded1

SVG decoration attributes keep tab and line feed as character references

  $ ./test_render_safety.exe svg-decoration-whitespace
  <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"45\" height=\"38\" font-family=\"ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace\" font-size=\"14px\">\n <rect width=\"100%\" height=\"100%\" fill=\"#1e1e1e\"/>\n  <text x=\"10\" y=\"24.0\" font-family=\"ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace\" font-size=\"14px\" fill=\"#d4d4d4\" xml:space=\"preserve\"><tspan style=\"x:1;&#9;y:2&#13;&#10;z:3\" class=\"a&#9;b&#10;c\" fill=\"#ff0000\">let</tspan></text>\n</svg>

