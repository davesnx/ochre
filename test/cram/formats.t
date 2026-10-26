A translucent background is blended over the theme background in ANSI
  $ ./test_formats.exe ansi-alpha
  \e[1m\e[48;2;60;60;60m\e[38;2;255;0;0mlet\e[0m\e[48;2;60;60;60m\e[38;2;212;212;212m x\n\e[0m\e[1m\e[38;2;255;0;0mlet\e[0m\e[38;2;212;212;212m y\e[0m

Diff markers are visible in ANSI
  $ ./test_formats.exe ansi-diff
  \e[1m\e[48;2;31;44;33m\e[38;2;255;0;0mlet\e[0m\e[48;2;31;44;33m\e[38;2;212;212;212m x\n\e[0m\e[1m\e[48;2;44;31;31m\e[38;2;255;0;0mlet\e[0m\e[48;2;44;31;31m\e[38;2;212;212;212m y\n\e[0m

Line highlight is a rectangle behind the text in SVG
  $ ./test_formats.exe svg-alpha
  <svg xmlns="http://www.w3.org/2000/svg" width="62" height="56" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <rect x="10.0" y="10.0" width="25.2" height="18.2" fill="#FFFFFF" fill-opacity="0.133"/>
    <rect x="35.2" y="10.0" width="16.8" height="18.2" fill="#FFFFFF" fill-opacity="0.133"/>
    <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> x</tspan></text>
    <text x="10" y="42.2" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> y</tspan></text>
  </svg>

Diff markers are rectangles in SVG
  $ ./test_formats.exe svg-diff
  <svg xmlns="http://www.w3.org/2000/svg" width="62" height="56" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <rect x="10.0" y="10.0" width="25.2" height="18.2" fill="#228833" fill-opacity="0.133"/>
    <rect x="35.2" y="10.0" width="16.8" height="18.2" fill="#228833" fill-opacity="0.133"/>
    <rect x="10.0" y="28.2" width="25.2" height="18.2" fill="#882222" fill-opacity="0.133"/>
    <rect x="35.2" y="28.2" width="16.8" height="18.2" fill="#882222" fill-opacity="0.133"/>
    <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> x</tspan></text>
    <text x="10" y="42.2" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> y</tspan></text>
  </svg>

Line highlight is a colorbox in LaTeX
  $ ./test_formats.exe latex-alpha
  \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  {\setlength{\fboxsep}{0pt}\colorbox[HTML]{3C3C3C}{\textcolor[HTML]{FF0000}{\textbf{let}}}}{\setlength{\fboxsep}{0pt}\colorbox[HTML]{3C3C3C}{\textcolor[HTML]{D4D4D4}{\ x}}}\\
  \textcolor[HTML]{FF0000}{\textbf{let}}\textcolor[HTML]{D4D4D4}{\ y}
  \end{ochrehighlight}

Diff markers are colorboxes in LaTeX
  $ ./test_formats.exe latex-diff
  \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  {\setlength{\fboxsep}{0pt}\colorbox[HTML]{1F2C21}{\textcolor[HTML]{FF0000}{\textbf{let}}}}{\setlength{\fboxsep}{0pt}\colorbox[HTML]{1F2C21}{\textcolor[HTML]{D4D4D4}{\ x}}}\\
  {\setlength{\fboxsep}{0pt}\colorbox[HTML]{2C1F1F}{\textcolor[HTML]{FF0000}{\textbf{let}}}}{\setlength{\fboxsep}{0pt}\colorbox[HTML]{2C1F1F}{\textcolor[HTML]{D4D4D4}{\ y}}}
  \end{ochrehighlight}

ANSI keeps a carriage return before a line feed, even across two tokens
  $ ./test_formats.exe ansi-crlf
  \e[3m\e[38;2;136;136;136m# one\r\e[0m\e[38;2;212;212;212m\n\e[0m\e[1m\e[38;2;255;0;0mlet\e[0m\e[38;2;212;212;212m\r\n\e[0m

ANSI shows a lone carriage return in caret notation
  $ ./test_formats.exe ansi-lone-cr
  \e[38;2;212;212;212ma^Mb\n\e[0m

HTML keeps a carriage return and a line feed in one element
  $ ./test_formats.exe html-crlf
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="font-style:var(--ochre-font-style,italic);color:var(--ochre,#888888)"># one</span><span style="color:var(--ochre,#d4d4d4)">\r\n</span></span><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)">\r\n</span></span></code></pre>

HTML writes a lone carriage return as a character reference
  $ ./test_formats.exe html-lone-cr
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="color:var(--ochre,#d4d4d4)">a&#13;b\n</span></span></code></pre>

LaTeX expands tabs, drops carriage returns and shows control characters in caret notation
  $ ./test_formats.exe latex-controls
  \begin{ochrehighlight}{1E1E1E}{D4D4D4}\n\textcolor[HTML]{D4D4D4}{a\ \ \ \ \ \ \ b}\\\n\textcolor[HTML]{D4D4D4}{\ \ \ \ \ \ \ \ c\textasciicircum{}A\textasciicircum{}[d\textasciicircum{}?}\n\end{ochrehighlight}

SVG expands tabs
  $ ./test_formats.exe svg-tabs
  <svg xmlns="http://www.w3.org/2000/svg" width="163" height="56" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">\n <rect width="100%" height="100%" fill="#1e1e1e"/>\n  <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan fill="#d4d4d4">        </tspan><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4">     x</tspan></text>\n  <text x="10" y="42.2" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan fill="#d4d4d4">        </tspan><tspan fill="#0000ff">1</tspan></text>\n</svg>

SVG width counts display cells
  $ ./test_formats.exe svg-width
  "abcd" -> width 54
  "\195\169\195\169\195\169\195\169" -> width 54
  "\230\151\165\230\156\172\232\170\158\230\151\165" -> width 87
  "a\tb" -> width 96
  "ab\r\n" -> width 37
  "\240\159\152\128" -> width 37

SVG text has the theme foreground as fill
  $ ./test_formats.exe svg-fill
  <svg xmlns="http://www.w3.org/2000/svg" width="62" height="38" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-weight="bold">let</tspan> x</text>
  </svg>

Underline and strikethrough share one text-decoration
  $ ./test_formats.exe html-underline-strike
  <pre class="ochre" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4)" tabindex="0"><code><span class="line"><span style="text-decoration:var(--ochre-text-decoration,underline line-through);color:var(--ochre,#ff0000)">let</span><span style="color:var(--ochre,#d4d4d4)"> x</span></span></code></pre>
  $ ./test_formats.exe html-underline-strike-dual
  <pre class="ochre ochre-themes test-theme" style="background-color:var(--ochre-bg,#1e1e1e);color:var(--ochre,#d4d4d4);--ochre-dark-bg:#1e1e1e;--ochre-dark:#d4d4d4" tabindex="0"><code><span class="line"><span style="font-weight:var(--ochre-font-weight,bold);color:var(--ochre,#ff0000);text-decoration:var(--ochre-text-decoration,none);--ochre-dark-font-weight:normal;--ochre-dark-text-decoration:underline line-through;--ochre-dark:#ff0000">let</span><span style="color:var(--ochre,#d4d4d4);--ochre-dark:#d4d4d4"> x</span></span></code></pre>

ANSI and LaTeX read every hex form, alpha included
  $ ./test_formats.exe colors-ansi
  #f00 on #00f: \e[48;2;0;0;255m\e[38;2;255;0;0mx\e[0m
  #f008 on #00f8: \e[48;2;14;14;150m\e[38;2;143;7;70mx\e[0m
  #ff0000 on #0000ff: \e[48;2;0;0;255m\e[38;2;255;0;0mx\e[0m
  #ff000080 on #0000ff80: \e[48;2;15;15;143m\e[38;2;135;7;71mx\e[0m
  #ff000000 on #0000ff00: \e[38;2;30;30;30mx\e[0m
  $ ./test_formats.exe colors-latex
  #f00 on #00f: \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  {\setlength{\fboxsep}{0pt}\colorbox[HTML]{0000FF}{\textcolor[HTML]{FF0000}{x}}}
  \end{ochrehighlight}
  #f008 on #00f8: \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  {\setlength{\fboxsep}{0pt}\colorbox[HTML]{0E0E96}{\textcolor[HTML]{8F0746}{x}}}
  \end{ochrehighlight}
  #ff0000 on #0000ff: \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  {\setlength{\fboxsep}{0pt}\colorbox[HTML]{0000FF}{\textcolor[HTML]{FF0000}{x}}}
  \end{ochrehighlight}
  #ff000080 on #0000ff80: \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  {\setlength{\fboxsep}{0pt}\colorbox[HTML]{0F0F8F}{\textcolor[HTML]{870747}{x}}}
  \end{ochrehighlight}

The theme stylesheet uses the configured variable prefix
  $ ./test_formats.exe theme-css-prefix
  class defined: true
  class defined: true
  class defined: true
  class defined: true
  .ochre { background-color:#1e1e1e; color:#d4d4d4 }
  .c-26ca7c872e3d26f5 { font-weight:var(--hl-font-weight,bold);color:var(--hl,#ff0000) }
  .c-052b9abb0d1fa589 { color:var(--hl,#d4d4d4) }
  .c-efdfb8891fbe432e { color:var(--hl,#0000ff) }
  .c-df49164ff9ddda0d { font-style:var(--hl-font-style,italic);color:var(--hl,#888888) }
  $ ./test_formats.exe theme-css-variables
  .ochre,
  .ochre span {
    --hl: var(--hl-dark);
    --hl-bg: var(--hl-dark-bg);
    --hl-font-style: var(--hl-dark-font-style);
    --hl-font-weight: var(--hl-dark-font-weight);
    --hl-text-decoration: var(--hl-dark-text-decoration);
    --hl-token-bg: var(--hl-dark-token-bg);
  }

Transform hooks run phase by phase
  $ ./test_formats.exe transform-order
  a before 0
  b before 0
  a before 1
  b before 1
  a before 2
  b before 2
  a after 0
  b after 0
  a after 1
  b after 1
  a after 2
  b after 2

A label used twice is an error
  $ ./test_formats.exe duplicate-labels
  primary and extra share a label: Invalid_argument Render_html.render: the theme label "test-theme" is used twice (after replacing characters outside A-Za-z0-9_-); each theme needs its own label, and the default theme is labelled by ?label or its name when default_color is No_default_color
  default color, same label is fine: rendered
  two extras: Invalid_argument Render_html.render: the theme label "a_b" is used twice (after replacing characters outside A-Za-z0-9_-); each theme needs its own label, and the default theme is labelled by ?label or its name when default_color is No_default_color
