Keyword and number coloring in SVG output
  $ ./test_render_svg.exe keyword-and-number
  <svg xmlns="http://www.w3.org/2000/svg" width="112" height="40" font-family="monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> x = </tspan><tspan fill="#0000ff">42</tspan><tspan fill="#d4d4d4">
  </tspan></text>
  </svg>

Comment with italic styling in SVG
  $ ./test_render_svg.exe comment
  <svg xmlns="http://www.w3.org/2000/svg" width="121" height="40" font-family="monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" xml:space="preserve"><tspan font-style="italic" fill="#888888"># a comment</tspan><tspan fill="#d4d4d4">
  </tspan></text>
  </svg>

String coloring in SVG
  $ ./test_render_svg.exe string
  <svg xmlns="http://www.w3.org/2000/svg" width="154" height="40" font-family="monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> s = </tspan><tspan fill="#00ff00">&quot;hello&quot;</tspan><tspan fill="#d4d4d4">
  </tspan></text>
  </svg>

Multiple lines of highlighted SVG
  $ ./test_render_svg.exe multi-line
  <svg xmlns="http://www.w3.org/2000/svg" width="112" height="59" font-family="monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> x = </tspan><tspan fill="#0000ff">42</tspan><tspan fill="#d4d4d4">
  </tspan></text>
    <text x="10" y="43.6" xml:space="preserve"><tspan font-weight="bold" fill="#ff0000">let</tspan><tspan fill="#d4d4d4"> y = </tspan><tspan fill="#0000ff">10</tspan><tspan fill="#d4d4d4">
  </tspan></text>
  </svg>

XML entities are escaped in SVG output
  $ ./test_render_svg.exe escaping
  <svg xmlns="http://www.w3.org/2000/svg" width="180" height="40" font-family="monospace" font-size="14px">
   <rect width="100%" height="100%" fill="#1e1e1e"/>
    <text x="10" y="24.0" xml:space="preserve"><tspan font-style="italic" fill="#888888"># &lt;div&gt;&amp;amp;&lt;/div&gt;</tspan><tspan fill="#d4d4d4">
  </tspan></text>
  </svg>
