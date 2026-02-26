Keyword and number coloring in LaTeX output
  $ ./test_render_latex.exe keyword-and-number
  \begin{ochrehighlight}{1e1e1e}{d4d4d4}
  \textcolor[HTML]{ff0000}{\textbf{let}}\textcolor[HTML]{d4d4d4}{\ x\ =\ }\textcolor[HTML]{0000ff}{42}\textcolor[HTML]{d4d4d4}{}
  \end{ochrehighlight}

Comment with italic styling in LaTeX
  $ ./test_render_latex.exe comment
  \begin{ochrehighlight}{1e1e1e}{d4d4d4}
  \textcolor[HTML]{888888}{\textit{\#\ a\ comment}}\textcolor[HTML]{d4d4d4}{}
  \end{ochrehighlight}

String coloring in LaTeX
  $ ./test_render_latex.exe string
  \begin{ochrehighlight}{1e1e1e}{d4d4d4}
  \textcolor[HTML]{ff0000}{\textbf{let}}\textcolor[HTML]{d4d4d4}{\ s\ =\ }\textcolor[HTML]{00ff00}{"hello"}\textcolor[HTML]{d4d4d4}{}
  \end{ochrehighlight}

Multiple lines of highlighted LaTeX
  $ ./test_render_latex.exe multi-line
  \begin{ochrehighlight}{1e1e1e}{d4d4d4}
  \textcolor[HTML]{ff0000}{\textbf{let}}\textcolor[HTML]{d4d4d4}{\ x\ =\ }\textcolor[HTML]{0000ff}{42}\textcolor[HTML]{d4d4d4}{}\\
  \textcolor[HTML]{ff0000}{\textbf{let}}\textcolor[HTML]{d4d4d4}{\ y\ =\ }\textcolor[HTML]{0000ff}{10}\textcolor[HTML]{d4d4d4}{}
  \end{ochrehighlight}

LaTeX special characters are escaped
  $ ./test_render_latex.exe escaping
  \begin{ochrehighlight}{1e1e1e}{d4d4d4}
  \textcolor[HTML]{888888}{\textit{\#\ 100\%\ of\ \$x\ \&\ y\_\{z\}}}\textcolor[HTML]{d4d4d4}{}
  \end{ochrehighlight}
