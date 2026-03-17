Keyword and number coloring in LaTeX output
  $ ./test_render_latex.exe keyword-and-number
  \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  \textcolor[HTML]{FF0000}{\textbf{let}}\textcolor[HTML]{D4D4D4}{\ x\ =\ }\textcolor[HTML]{0000FF}{42}\textcolor[HTML]{D4D4D4}{}
  \end{ochrehighlight}

Comment with italic styling in LaTeX
  $ ./test_render_latex.exe comment
  \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  \textcolor[HTML]{888888}{\textit{\#\ a\ comment}}\textcolor[HTML]{D4D4D4}{}
  \end{ochrehighlight}

String coloring in LaTeX
  $ ./test_render_latex.exe string
  \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  \textcolor[HTML]{FF0000}{\textbf{let}}\textcolor[HTML]{D4D4D4}{\ s\ =\ }\textcolor[HTML]{00FF00}{"hello"}\textcolor[HTML]{D4D4D4}{}
  \end{ochrehighlight}

Multiple lines of highlighted LaTeX
  $ ./test_render_latex.exe multi-line
  \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  \textcolor[HTML]{FF0000}{\textbf{let}}\textcolor[HTML]{D4D4D4}{\ x\ =\ }\textcolor[HTML]{0000FF}{42}\textcolor[HTML]{D4D4D4}{}\\
  \textcolor[HTML]{FF0000}{\textbf{let}}\textcolor[HTML]{D4D4D4}{\ y\ =\ }\textcolor[HTML]{0000FF}{10}\textcolor[HTML]{D4D4D4}{}
  \end{ochrehighlight}

LaTeX special characters are escaped
  $ ./test_render_latex.exe escaping
  \begin{ochrehighlight}{1E1E1E}{D4D4D4}
  \textcolor[HTML]{888888}{\textit{\#\ 100\%\ of\ \$x\ \&\ y\_\{z\}}}\textcolor[HTML]{D4D4D4}{}
  \end{ochrehighlight}
