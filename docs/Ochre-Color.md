
# Module `Ochre.Color`

```ocaml
type t = private {
  r : int;
  g : int;
  b : int;
  a : int;
}
```
An sRGB color with an alpha channel. Each channel is a byte, from `0` to `255`; `a = 255` is opaque.

```ocaml
val rgb : int -> int -> int -> t
```
`rgb r g b` is an opaque color. Each value is clipped to `0`\-`255`.

```ocaml
val rgba : int -> int -> int -> int -> t
```
`rgba r g b a` is a color with alpha `a`. Each value is clipped to `0`\-`255`.

```ocaml
val oklch : float -> float -> float -> t
```
`oklch l c h` is the opaque sRGB color for the OKLCH lightness `l` (from `0.` to `1.`), chroma `c` and hue `h` in degrees. A color outside the sRGB gamut is clipped channel by channel.

```ocaml
val of_hex : string -> t option
```
`of_hex s` parses `#rgb`, `#rgba`, `#rrggbb` or `#rrggbbaa`, in any case, as vscode-textmate does. Returns `None` for any other string, such as a CSS color name or `rgb()`.

```ocaml
val to_hex : t -> string
```
`to_hex c` is `#rrggbb` in lowercase, or `#rrggbbaa` when `c` is not opaque. HTML and SVG write colors in this form; LaTeX writes uppercase `RRGGBB` for the xcolor `HTML` model.

```ocaml
val equal : t -> t -> bool
```