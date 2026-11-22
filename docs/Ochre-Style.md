
# Module `Ochre.Style`

```ocaml
type font_style = {
  bold : bool;
  italic : bool;
  underline : bool;
  strikethrough : bool;
}
```
The font style of a token.

```ocaml
val plain : font_style
```
No bold, italic, underline or strikethrough.

```ocaml
type t = {
  foreground : Color.t;
  background : Color.t option; (* None shows the theme background. A theme rule background equal to the theme background is None. *)
  font_style : font_style;
}
```
The style of a token under one theme.
