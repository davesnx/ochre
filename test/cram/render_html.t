Keyword and number coloring in HTML output
  $ ./test_render_html.exe keyword-and-number
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code style="display:block;padding:20px"><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span></code></pre>

Comment with italic styling in HTML
  $ ./test_render_html.exe comment
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code style="display:block;padding:20px"><span class="line"><span style="font-style:italic;color:#888888"># a comment</span><span style="color:#d4d4d4">
  </span></span></code></pre>

String coloring in HTML
  $ ./test_render_html.exe string
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code style="display:block;padding:20px"><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> s = </span><span style="color:#00ff00">&quot;hello&quot;</span><span style="color:#d4d4d4">
  </span></span></code></pre>

Multiple lines of highlighted HTML
  $ ./test_render_html.exe multi-line
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code style="display:block;padding:20px"><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span>
  <span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> y = </span><span style="color:#0000ff">10</span><span style="color:#d4d4d4">
  </span></span></code></pre>

HTML entities are escaped in output
  $ ./test_render_html.exe escaping
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code style="display:block;padding:20px"><span class="line"><span style="font-style:italic;color:#888888"># &lt;div&gt;&amp;amp;&lt;/div&gt;</span><span style="color:#d4d4d4">
  </span></span></code></pre>
