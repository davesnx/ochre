
# Module `Ochre.Themed`

```ocaml
type t = private {
  themes : (string * Theme.theme) * (string * Theme.theme) list; (* The labelled default theme, then the labelled extra themes. The default label is the ?label given to highlight or highlight_themes, or the theme name. *)
  lines : Token.line list;
}
```
Highlighted code. Each token has one style per theme, in the order of `themes`. Make one with [`highlight`](./Ochre.md#val-highlight) or [`highlight_themes`](./Ochre.md#val-highlight_themes).

```ocaml
val select : string -> t -> (t, Error.t) Stdlib.result
```
`select label themed` makes the theme labelled `label` the default theme, and keeps the others as extra themes in their order. Renderers that show one theme, such as [`to_ansi`](./Ochre.md#val-to_ansi), show the default theme. Returns [`Error.t.Unknown_theme_label`](./Ochre-Error.md#type-t.Unknown_theme_label) when no theme has `label`.

```ocaml
match Ochre.Themed.select "dark" themed with
| Ok dark ->
    print_string (Ochre.to_ansi dark)
| Error e ->
    prerr_endline (Ochre.Error.to_string e)
```