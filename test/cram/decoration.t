Decoration with class on keyword token
  $ ./test_decoration.exe html-class
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)" class="highlighted-word">let</span><span style="color:var(--ochre,#d4d4d4)"> x = </span><span style="color:var(--ochre,#0000ff)">42</span></span></code></pre>

Decoration with class and inline style
  $ ./test_decoration.exe html-class-and-style
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> x = </span><span style="color:var(--ochre,#0000ff);border-bottom:2px solid red" class="focus">42</span></span></code></pre>

Decoration with data attributes
  $ ./test_decoration.exe html-data-attrs
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)" data-tooltip="variable binding" class="annotated">let</span><span style="color:var(--ochre,#d4d4d4)"> x = </span><span style="color:var(--ochre,#0000ff)">42</span></span></code></pre>

Decoration that splits a token mid-way
  $ ./test_decoration.exe html-split
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> </span><span style="color:var(--ochre,#d4d4d4)" class="target">x =</span><span style="color:var(--ochre,#d4d4d4)"> </span><span style="color:var(--ochre,#0000ff)">42</span></span></code></pre>

Decoration in debug tokens format
  $ ./test_decoration.exe debug-tokens
  line 1:
    "let"  keyword.control.test, source.test <class=hl>
    " x = "  source.test
    "42"  constant.numeric.test, source.test

Decoration class, style, and data values are escaped in HTML output
  $ ./test_decoration.exe html-escape
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000);color:red;&quot;onmouseover=&quot;alert(1)" data-note="a&quot;&gt;&lt;script&gt;" class="dangerous&quot;&gt;&lt;script&gt;">let</span><span style="color:var(--ochre,#d4d4d4)"> x = </span><span style="color:var(--ochre,#0000ff)">42</span></span></code></pre>

Decoration class and style are escaped in SVG output
  $ ./test_decoration.exe svg-escape
  <svg xmlns="http://www.w3.org/2000/svg" width="104" height="38" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" xml:space="preserve"><tspan style="color:red;&quot;onmouseover=&quot;alert(1)" class="dangerous&quot;&gt;&lt;script&gt;" font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> x = </tspan><tspan fill="#0000ff">42</tspan></text>
  </svg>

Decoration spanning multiple lines
  $ ./test_decoration.exe multiline-html
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> </span><span style="color:var(--ochre,#d4d4d4)" class="span">x = </span><span style="color:var(--ochre,#0000ff)" class="span">42</span><span style="color:var(--ochre,#d4d4d4)" class="span">
  </span></span><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)" class="span">let</span><span style="color:var(--ochre,#d4d4d4)" class="span"> y</span><span style="color:var(--ochre,#d4d4d4)"> = </span><span style="color:var(--ochre,#0000ff)">10</span></span></code></pre>
