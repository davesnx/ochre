Keyword and number coloring in HTML output
  $ ./test_render_html.exe keyword-and-number
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> x = </span><span style="color:var(--ochre,#0000ff)">42</span></span></code></pre>

Comment with italic styling in HTML
  $ ./test_render_html.exe comment
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-style:var(--ochre-font-style,italic);color:var(--ochre,#888888)"># a comment</span></span></code></pre>

String coloring in HTML
  $ ./test_render_html.exe string
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> s = </span><span style="color:var(--ochre,#00ff00)">&quot;hello&quot;</span></span></code></pre>

Multiple lines of highlighted HTML
  $ ./test_render_html.exe multi-line
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> x = </span><span style="color:var(--ochre,#0000ff)">42</span><span style="color:var(--ochre,#d4d4d4)">
  </span></span><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> y = </span><span style="color:var(--ochre,#0000ff)">10</span></span></code></pre>

HTML entities are escaped in output
  $ ./test_render_html.exe escaping
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-style:var(--ochre-font-style,italic);color:var(--ochre,#888888)"># &lt;div&gt;&amp;amp;&lt;/div&gt;</span></span></code></pre>

Multi-theme HTML with one extra theme (light default, dark extra)
  $ ./test_render_html.exe themes-one-extra
  <pre class="ochre ochre-themes test-light test-theme" style="background-color:var(--ochre-bg,#ffffff);color:var(--ochre,#24292e);--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#d73a49);--ochre-dark-font-weight:bold;--ochre-dark:#ff0000">let</span><span style="color:var(--ochre,#24292e);--ochre-dark:#d4d4d4"> x = </span><span style="color:var(--ochre,#005cc5);--ochre-dark:#0000ff">42</span></span></code></pre>

Multi-theme HTML with multiple lines
  $ ./test_render_html.exe themes-multi-line
  <pre class="ochre ochre-themes test-light test-theme" style="background-color:var(--ochre-bg,#ffffff);color:var(--ochre,#24292e);--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#d73a49);--ochre-dark-font-weight:bold;--ochre-dark:#ff0000">let</span><span style="color:var(--ochre,#24292e);--ochre-dark:#d4d4d4"> x = </span><span style="color:var(--ochre,#005cc5);--ochre-dark:#0000ff">42</span><span style="color:var(--ochre,#24292e);--ochre-dark:#d4d4d4">
  </span></span><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#d73a49);--ochre-dark-font-weight:bold;--ochre-dark:#ff0000">let</span><span style="color:var(--ochre,#24292e);--ochre-dark:#d4d4d4"> y = </span><span style="color:var(--ochre,#005cc5);--ochre-dark:#0000ff">10</span></span></code></pre>

Multi-theme HTML with explicit light+dark labels uses variables consistently
  $ ./test_render_html.exe themes-light-dark-vars
  <pre class="ochre ochre-themes test-light test-theme" style="background-color:var(--ochre-bg,#ffffff);color:var(--ochre,#24292e);--ochre-light-bg:#ffffff;--ochre-light:#24292e;--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#d73a49);--ochre-light-font-weight:bold;--ochre-light:#d73a49;--ochre-dark-font-weight:bold;--ochre-dark:#ff0000">let</span><span style="color:var(--ochre,#24292e);--ochre-light:#24292e;--ochre-dark:#d4d4d4"> x = </span><span style="color:var(--ochre,#005cc5);--ochre-light:#005cc5;--ochre-dark:#0000ff">42</span></span></code></pre>

Multi-theme HTML with two extra themes (dark + dim)
  $ ./test_render_html.exe themes-two-extras
  <pre class="ochre ochre-themes test-light test-theme test-dim" style="background-color:var(--ochre-bg,#ffffff);color:var(--ochre,#24292e);--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4;--ochre-dim-bg:#111111;--ochre-dim:#999999" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#d73a49);--ochre-dark-font-weight:bold;--ochre-dark:#ff0000;--ochre-dim-font-weight:bold;--ochre-dim:#aa5555">let</span><span style="color:var(--ochre,#24292e);--ochre-dark:#d4d4d4;--ochre-dim:#999999"> x = </span><span style="color:var(--ochre,#005cc5);--ochre-dark:#0000ff;--ochre-dim:#5555aa">42</span></span></code></pre>

CSS for a custom theme label
  $ ./test_render_html.exe theme-css
  .ochre,
  .ochre span {
    --ochre: var(--ochre-dim);
    --ochre-bg: var(--ochre-dim-bg);
    --ochre-font-style: var(--ochre-dim-font-style);
    --ochre-font-weight: var(--ochre-dim-font-weight);
    --ochre-text-decoration: var(--ochre-dim-text-decoration);
    --ochre-token-bg: var(--ochre-dim-token-bg);
  }

Line numbers add data-line attributes
  $ ./test_render_html.exe line-numbers
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line" data-line="1"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> x = </span><span style="color:var(--ochre,#0000ff)">42</span><span style="color:var(--ochre,#d4d4d4)">
  </span></span><span class="line" data-line="2"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> y = </span><span style="color:var(--ochre,#0000ff)">10</span></span></code></pre>

No default color suppresses inline color/background
  $ ./test_render_html.exe no-default-color
  <pre class="ochre" style="--ochre-test-theme-bg:#1e1e1e;--ochre-test-theme:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight);--ochre-test-theme-font-weight:bold;--ochre-test-theme:#ff0000">let</span><span style="--ochre-test-theme:#d4d4d4"> x = </span><span style="--ochre-test-theme:#0000ff">42</span></span></code></pre>

No default color with multi-theme (only CSS vars, no inline color)
  $ ./test_render_html.exe no-default-color-multi
  <pre class="ochre ochre-themes test-light test-theme" style="--ochre-test-light-bg:#ffffff;--ochre-test-light:#24292e;--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight);--ochre-test-light-font-weight:bold;--ochre-test-light:#d73a49;--ochre-dark-font-weight:bold;--ochre-dark:#ff0000">let</span><span style="--ochre-test-light:#24292e;--ochre-dark:#d4d4d4"> x = </span><span style="--ochre-test-light:#005cc5;--ochre-dark:#0000ff">42</span></span></code></pre>

CSS classes mode replaces inline styles with class names
  $ ./test_render_html.exe css-classes
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span class="s-d97b062dc4187f8e s-0f188c0cf325ded1">let</span><span class="s-232033c531ff619a"> x = </span><span class="s-125f486d4472df11">42</span></span></code></pre>

Custom CSS variable prefix
  $ ./test_render_html.exe custom-prefix
  <pre class="ochre ochre-themes test-light test-theme" style="background-color:var(--shiki-bg,#ffffff);color:var(--shiki,#24292e);--shiki-dark-bg:#1e1e1e;--shiki-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:var(--shiki-font-weight,bold);color:var(--shiki,#d73a49);--shiki-dark-font-weight:bold;--shiki-dark:#ff0000">let</span><span style="color:var(--shiki,#24292e);--shiki-dark:#d4d4d4"> x = </span><span style="color:var(--shiki,#005cc5);--shiki-dark:#0000ff">42</span></span></code></pre>

Scopes as data attributes
  $ ./test_render_html.exe scopes-data
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)" data-scope="keyword.control.test source.test">let</span><span style="color:var(--ochre,#d4d4d4)" data-scope="source.test"> x = </span><span style="color:var(--ochre,#0000ff)" data-scope="constant.numeric.test source.test">42</span></span></code></pre>

Custom pre class
  $ ./test_render_html.exe pre-class
  <pre class="ochre my-code" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> x = </span><span style="color:var(--ochre,#0000ff)">42</span></span></code></pre>

Custom code class
  $ ./test_render_html.exe code-class
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code class="language-test"><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> x = </span><span style="color:var(--ochre,#0000ff)">42</span></span></code></pre>

Without tokens, the theme stylesheet has a rule for every class that
CSS-class rendering of real OCaml uses
  $ ./test_render_html.exe theme-css-covers-ocaml
  andromeeda: every class has a rule
  aurora-x: every class has a rule
  ayu-dark: every class has a rule
  ayu-light: every class has a rule
  ayu-mirage: every class has a rule
  catppuccin-frappe: every class has a rule
  catppuccin-latte: every class has a rule
  catppuccin-macchiato: every class has a rule
  catppuccin-mocha: every class has a rule
  dark-plus: every class has a rule
  dracula: every class has a rule
  dracula-soft: every class has a rule
  everforest-dark: every class has a rule
  everforest-light: every class has a rule
  github-dark: every class has a rule
  github-dark-default: every class has a rule
  github-dark-dimmed: every class has a rule
  github-dark-high-contrast: every class has a rule
  github-light: every class has a rule
  github-light-default: every class has a rule
  github-light-high-contrast: every class has a rule
  gruvbox-dark-hard: every class has a rule
  gruvbox-dark-medium: every class has a rule
  gruvbox-dark-soft: every class has a rule
  gruvbox-light-hard: every class has a rule
  gruvbox-light-medium: every class has a rule
  gruvbox-light-soft: every class has a rule
  horizon: every class has a rule
  horizon-bright: every class has a rule
  houston: every class has a rule
  kanagawa-dragon: every class has a rule
  kanagawa-lotus: every class has a rule
  kanagawa-wave: every class has a rule
  laserwave: every class has a rule
  light-plus: every class has a rule
  material-theme: every class has a rule
  material-theme-darker: every class has a rule
  material-theme-lighter: every class has a rule
  material-theme-ocean: every class has a rule
  material-theme-palenight: every class has a rule
  min-dark: every class has a rule
  min-light: every class has a rule
  monokai: every class has a rule
  night-owl: every class has a rule
  night-owl-light: every class has a rule
  nord: every class has a rule
  one-dark-pro: every class has a rule
  one-light: every class has a rule
  plastic: every class has a rule
  poimandres: every class has a rule
  red: every class has a rule
  rose-pine: every class has a rule
  rose-pine-dawn: every class has a rule
  rose-pine-moon: every class has a rule
  slack-dark: every class has a rule
  slack-ochin: every class has a rule
  snazzy-light: every class has a rule
  solarized-dark: every class has a rule
  solarized-light: every class has a rule
  synthwave-84: every class has a rule
  tokyo-night: every class has a rule
  vesper: every class has a rule
  vitesse-black: every class has a rule
  vitesse-dark: every class has a rule
  vitesse-light: every class has a rule

Without tokens, a style that takes its colour from one rule and its font
style from another gets a class
  $ ./test_render_html.exe theme-css-combined-rule
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span class="s-ae2cf74260356c77 s-b15f3da5ff0399f1"># c</span></span></code></pre>
  .ochre { background-color:#1e1e1e; color:#d4d4d4 }
  .s-ae2cf74260356c77 { font-style:var(--ochre-font-style,italic) }
  .s-b15f3da5ff0399f1 { color:var(--ochre,#112233) }
  .s-232033c531ff619a { color:var(--ochre,#d4d4d4) }

Without tokens, the theme stylesheet also has a rule for every class of code
changed by transforms
  $ ./test_render_html.exe theme-css-covers-transforms
  dark-plus: every class has a rule
  dark-plus: font-weight:var(--ochre-font-weight,bold) kept inline
  dark-plus: background-color:var(--ochre-token-bg,#8888883a) kept inline
  nord: every class has a rule
  nord: font-weight:var(--ochre-font-weight,bold) kept inline
  nord: background-color:var(--ochre-token-bg,#8888883a) kept inline
