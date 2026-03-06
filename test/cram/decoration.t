Decoration with class on keyword token
  $ ./test_decoration.exe html-class
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000" class="highlighted-word">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span></code></pre>

Decoration with class and inline style
  $ ./test_decoration.exe html-class-and-style
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff;border-bottom:2px solid red" class="focus">42</span><span style="color:#d4d4d4">
  </span></span></code></pre>

Decoration with data attributes
  $ ./test_decoration.exe html-data-attrs
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000" data-tooltip="variable binding" class="annotated">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span></code></pre>

Decoration that splits a token mid-way
  $ ./test_decoration.exe html-split
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> </span><span style="color:#d4d4d4" class="target">x =</span><span style="color:#d4d4d4"> </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span></code></pre>

Decoration in debug tokens format
  $ ./test_decoration.exe debug-tokens
  {let}[keyword.control.test,source.test]<class=hl>{ x = }[source.test]{42}[constant.numeric.test,source.test]{
  }[source.test]

Decoration spanning multiple lines
  $ ./test_decoration.exe multiline-html
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> </span><span style="color:#d4d4d4" class="span">x = </span><span style="color:#0000ff" class="span">42</span><span style="color:#d4d4d4" class="span">
  </span></span>
  <span class="line"><span style="font-weight:bold;color:#ff0000" class="span">let</span><span style="color:#d4d4d4" class="span"> y</span><span style="color:#d4d4d4"> = </span><span style="color:#0000ff">10</span><span style="color:#d4d4d4">
  </span></span></code></pre>
