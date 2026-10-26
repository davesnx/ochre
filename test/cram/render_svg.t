Keyword and number coloring in SVG output
  $ ./test_render_svg.exe keyword-and-number
  <svg xmlns="http://www.w3.org/2000/svg" width="104" height="38" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> x = </tspan><tspan fill="#0000ff">42</tspan></text>
  </svg>

Comment with italic styling in SVG
  $ ./test_render_svg.exe comment
  <svg xmlns="http://www.w3.org/2000/svg" width="112" height="38" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-style="italic" fill="#888888"># a comment</tspan></text>
  </svg>

String coloring in SVG
  $ ./test_render_svg.exe string
  <svg xmlns="http://www.w3.org/2000/svg" width="146" height="38" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> s = </tspan><tspan fill="#00ff00">&quot;hello&quot;</tspan></text>
  </svg>

Multiple lines of highlighted SVG
  $ ./test_render_svg.exe multi-line
  <svg xmlns="http://www.w3.org/2000/svg" width="104" height="56" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> x = </tspan><tspan fill="#0000ff">42</tspan></text>
    <text x="10" y="42.2" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> y = </tspan><tspan fill="#0000ff">10</tspan></text>
  </svg>

XML entities are escaped in SVG output
  $ ./test_render_svg.exe escaping
  <svg xmlns="http://www.w3.org/2000/svg" width="171" height="38" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" font-family="ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace" font-size="14px" fill="#d4d4d4" xml:space="preserve"><tspan font-style="italic" fill="#888888"># &lt;div&gt;&amp;amp;&lt;/div&gt;</tspan></text>
  </svg>

Emoji and CJK take two cells, combining marks none
  $ for text in 'ab' '漢字' '한글' 'ＡＢ' '🚀🚀' '✅⭐' '🩷' 'e'"$(printf '\314\201')"; do
  >   printf '%s\n' "$text" | ochre plaintext --format svg | sed -n '1s/.* width="\([0-9]*\)".*/\1/p'
  > done
  37
  54
  54
  54
  54
  54
  37
  28
