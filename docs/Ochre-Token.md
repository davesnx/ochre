
# Module `Ochre.Token`

```ocaml
type position = {
  offset : int; (* Byte offset in the source. *)
  line : int; (* Line, from 0. *)
  column : int; (* Byte offset in the line. *)
  length : int; (* Number of source bytes the token covers. *)
}
```
Where a token comes from in the original source. Transforms never change the position of the text they keep: a token keeps the position of its source text when a transform removes other text, and a piece of a split token gets the position of its own bytes. A token that a transform inserts has a `length` of `0` at the insert point.

```ocaml
type decoration_properties = private {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}
```
Format-agnostic properties attached by a decoration. Only the HTML and SVG renderers apply them, mapping `class_`/`style`/`data` to HTML/SVG attributes; the ANSI and LaTeX renderers ignore decorations.

```ocaml
type styles
```
One [`Style.t`](./Ochre-Style.md#type-t) per theme of the [`Themed`](./Ochre-Themed.md) value the token belongs to.

```ocaml
type t = {
  text : string;
  position : position;
  scopes : string list;
  styles : styles;
  decoration : decoration_properties option;
}
```
A token. Build new tokens from existing ones, with `{ token with ... }`, [`sub`](./#val-sub), [`insert_before`](./#val-insert_before) or [`insert_after`](./#val-insert_after), so that they keep one style per theme.

```ocaml
type line = t list
```
A line of tokens. The last token of every line but the last ends with `"\n"`.

```ocaml
val style : t -> Style.t
```
The style of the token under the default theme.

```ocaml
val all_styles : t -> Style.t list
```
The styles of the token, one per theme, in the order of [`Themed.t.themes`](./Ochre-Themed.md#type-t.themes): the default theme first, then the extra themes.

```ocaml
val map_style : (Theme.theme -> Style.t -> Style.t) -> t -> t
```
`map_style f token` applies `f` once per theme to the style of `token` under that theme.

```ocaml
let underline token =
  Ochre.Token.map_style
    (fun _theme style ->
      {
        style with
        font_style = { style.font_style with underline = true };
      }
    )
    token
```
```ocaml
val sub : t -> pos:int -> len:int -> t option
```
`sub token ~pos ~len` is the token for the `len` bytes of `token.text` from byte `pos`, with the position of those bytes. Returns `None` when the range is not inside `token.text`.

```ocaml
val insert_before : t -> string -> t
```
`insert_before token text` is a new token with `text`, the scopes and styles of `token`, no decoration, and a zero-length position at the start of `token`.

```ocaml
val insert_after : t -> string -> t
```
Like [`insert_before`](./#val-insert_before), at the end of `token`.
