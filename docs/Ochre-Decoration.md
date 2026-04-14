
# Module `Ochre.Decoration`


### position

```ocaml
type position = {
  line : int;
  character : int;
}
```
0-indexed position in source code.

Negative `character` values count from the end of the line: `-1` means the line end, `-2` means one character before the end, etc.


### properties

```ocaml
type properties = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}
```
Properties to attach to a decorated range.


### t

```ocaml
type t = {
  start : position;
  end_ : position;
  properties : properties;
}
```
A decoration targeting a range from `start` (inclusive) to `end_` (exclusive).


### pos

```ocaml
val pos : int -> int -> position
```
`pos line character` creates a position.


### make

```ocaml
val make : 
  ?class_:string ->
  ?style:string ->
  ?data:(string * string) list ->
  start:position ->
  end_:position ->
  unit ->
  t
```
Create a decoration.

```ocaml
  let d =
    Ochre.Decoration.make ~class_:"highlighted"
      ~start:(Ochre.Decoration.pos 0 0)
      ~end_:(Ochre.Decoration.pos 0 11)
      ()
```

### apply

```ocaml
val apply : 
  source:string ->
  t list ->
  Token.highlighted_code ->
  Token.highlighted_code
```
`apply ~source decorations tokens` maps decoration ranges onto tokens, splitting tokens at boundaries and attaching properties.

Overlapping decorations are merged: classes are space-concatenated, styles are semicolon-concatenated, data attributes are merged (later wins).
