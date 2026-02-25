Plain token with no styling
  $ ./test_render_html.exe plain
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code>hello world</code></pre>

Token with foreground color
  $ ./test_render_html.exe colored
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code><span style="color:#ff0000">red text</span></code></pre>

Token with foreground color and font styles
  $ ./test_render_html.exe styled
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code><span style="font-weight:bold;font-style:italic;color:#00ff00">styled</span></code></pre>

HTML special characters are escaped
  $ ./test_render_html.exe escaping
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code>&lt;div class=&quot;test&quot;&gt;&amp;amp;&lt;/div&gt;</code></pre>

Multiple tokens across multiple lines
  $ ./test_render_html.exe multi-line
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code><span style="color:#569cd6">let</span> x = <span style="color:#b5cea8">42</span>
  <span style="color:#569cd6">let</span> y = <span style="color:#b5cea8">10</span></code></pre>

Token with both foreground and background colors
  $ ./test_render_html.exe background
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code><span style="background-color:#f00;color:#fff">highlighted</span></code></pre>

Empty line
  $ ./test_render_html.exe empty
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code></code></pre>

All four font styles combined
  $ ./test_render_html.exe all-styles
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code><span style="font-weight:bold;font-style:italic;text-decoration:underline;text-decoration:line-through;color:#abc">everything</span></code></pre>
