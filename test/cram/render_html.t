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

Multi-theme HTML with one extra theme (light default, dark extra)
  $ ./test_render_html.exe themes-one-extra
  <pre class="ochre ochre-themes test-light test-theme" style="background-color:#ffffff;color:#24292e;--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#d73a49;--ochre-dark-font-weight:bold;--ochre-dark:#ff0000">let</span><span style="color:#24292e;--ochre-dark:#d4d4d4"> x = </span><span style="color:#005cc5;--ochre-dark:#0000ff">42</span><span style="color:#24292e;--ochre-dark:#d4d4d4">
  </span></span></code></pre>

Multi-theme HTML with multiple lines
  $ ./test_render_html.exe themes-multi-line
  <pre class="ochre ochre-themes test-light test-theme" style="background-color:#ffffff;color:#24292e;--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#d73a49;--ochre-dark-font-weight:bold;--ochre-dark:#ff0000">let</span><span style="color:#24292e;--ochre-dark:#d4d4d4"> x = </span><span style="color:#005cc5;--ochre-dark:#0000ff">42</span><span style="color:#24292e;--ochre-dark:#d4d4d4">
  </span></span>
  <span class="line"><span style="font-weight:bold;color:#d73a49;--ochre-dark-font-weight:bold;--ochre-dark:#ff0000">let</span><span style="color:#24292e;--ochre-dark:#d4d4d4"> y = </span><span style="color:#005cc5;--ochre-dark:#0000ff">10</span><span style="color:#24292e;--ochre-dark:#d4d4d4">
  </span></span></code></pre>

When ~theme is omitted, first entry in ~themes becomes the default
  $ ./test_render_html.exe themes-no-default
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4"><code style="display:block;padding:20px"><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span></code></pre>

Multi-theme HTML with two extra themes (dark + dim)
  $ ./test_render_html.exe themes-two-extras
  <pre class="ochre ochre-themes test-light test-theme test-dim" style="background-color:#ffffff;color:#24292e;--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4;--ochre-dim-bg:#111111;--ochre-dim:#999999" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#d73a49;--ochre-dark-font-weight:bold;--ochre-dark:#ff0000;--ochre-dim-font-weight:bold;--ochre-dim:#aa5555">let</span><span style="color:#24292e;--ochre-dark:#d4d4d4;--ochre-dim:#999999"> x = </span><span style="color:#005cc5;--ochre-dark:#0000ff;--ochre-dim:#5555aa">42</span><span style="color:#24292e;--ochre-dark:#d4d4d4;--ochre-dim:#999999">
  </span></span></code></pre>

Dark mode CSS helper
  $ ./test_render_html.exe dark-mode-css
  @media (prefers-color-scheme: dark) {
    .ochre,
    .ochre span {
      color: var(--ochre-dark) !important;
      background-color: var(--ochre-dark-bg) !important;
      font-style: var(--ochre-dark-font-style) !important;
      font-weight: var(--ochre-dark-font-weight) !important;
      text-decoration: var(--ochre-dark-text-decoration) !important;
    }
  }

CSS for a custom theme label
  $ ./test_render_html.exe css-for-theme
  .ochre,
  .ochre span {
    color: var(--ochre-dim) !important;
    background-color: var(--ochre-dim-bg) !important;
    font-style: var(--ochre-dim-font-style) !important;
    font-weight: var(--ochre-dim-font-weight) !important;
    text-decoration: var(--ochre-dim-text-decoration) !important;
  }
