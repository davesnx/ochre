Keyword and number coloring in HTML output
  $ ./test_render_html.exe keyword-and-number
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span></code></pre>

Comment with italic styling in HTML
  $ ./test_render_html.exe comment
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-style:italic;color:#888888"># a comment</span><span style="color:#d4d4d4">
  </span></span></code></pre>

String coloring in HTML
  $ ./test_render_html.exe string
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> s = </span><span style="color:#00ff00">&quot;hello&quot;</span><span style="color:#d4d4d4">
  </span></span></code></pre>

Multiple lines of highlighted HTML
  $ ./test_render_html.exe multi-line
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span>
  <span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> y = </span><span style="color:#0000ff">10</span><span style="color:#d4d4d4">
  </span></span></code></pre>

HTML entities are escaped in output
  $ ./test_render_html.exe escaping
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-style:italic;color:#888888"># &lt;div&gt;&amp;amp;&lt;/div&gt;</span><span style="color:#d4d4d4">
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
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
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

Line numbers add data-line attributes
  $ ./test_render_html.exe line-numbers
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line" data-line="1"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span>
  <span class="line" data-line="2"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> y = </span><span style="color:#0000ff">10</span><span style="color:#d4d4d4">
  </span></span></code></pre>

No default color suppresses inline color/background
  $ ./test_render_html.exe no-default-color
  <pre class="ochre" tabindex="0"><code><span class="line">let x = 42
  </span></code></pre>

No default color with multi-theme (only CSS vars, no inline color)
  $ ./test_render_html.exe no-default-color-multi
  <pre class="ochre ochre-themes test-light test-theme" style="--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="--ochre-dark-font-weight:bold;--ochre-dark:#ff0000">let</span><span style="--ochre-dark:#d4d4d4"> x = </span><span style="--ochre-dark:#0000ff">42</span><span style="--ochre-dark:#d4d4d4">
  </span></span></code></pre>

CSS classes mode replaces inline styles with class names
  $ ./test_render_html.exe css-classes
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span class="s-4288c4f">let</span><span class="s-35a658e9"> x = </span><span class="s-3bf521ed">42</span><span class="s-35a658e9">
  </span></span></code></pre>

Custom CSS variable prefix
  $ ./test_render_html.exe custom-prefix
  <pre class="ochre ochre-themes test-light test-theme" style="background-color:#ffffff;color:#24292e;--shiki-dark-bg:#1e1e1e;--shiki-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#d73a49;--shiki-dark-font-weight:bold;--shiki-dark:#ff0000">let</span><span style="color:#24292e;--shiki-dark:#d4d4d4"> x = </span><span style="color:#005cc5;--shiki-dark:#0000ff">42</span><span style="color:#24292e;--shiki-dark:#d4d4d4">
  </span></span></code></pre>

Scopes as data attributes
  $ ./test_render_html.exe scopes-data
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000" data-scope="keyword.control.test source.test">let</span><span style="color:#d4d4d4" data-scope="source.test"> x = </span><span style="color:#0000ff" data-scope="constant.numeric.test source.test">42</span><span style="color:#d4d4d4" data-scope="source.test">
  </span></span></code></pre>

Custom pre class
  $ ./test_render_html.exe pre-class
  <pre class="ochre my-code" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span></code></pre>

Custom code class
  $ ./test_render_html.exe code-class
  <pre class="ochre" style="background-color:#1e1e1e;color:#d4d4d4" tabindex="0"><code class="language-test"><span class="line"><span style="font-weight:bold;color:#ff0000">let</span><span style="color:#d4d4d4"> x = </span><span style="color:#0000ff">42</span><span style="color:#d4d4d4">
  </span></span></code></pre>
