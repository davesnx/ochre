
# Module `Ochre.Decoration`


### position

```ocaml
type position = {
  line : int;
  character : int;
}
```
0-indexed position in source code. `character` counts Unicode scalar values, not UTF-8 bytes.

Negative `character` values count Unicode scalar values from the end of the line: `-1` means the line end, `-2` means one scalar before the end, etc.


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
type t = private {
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
  (t, Error.t) Stdlib.result
```
Create a decoration. Returns [`Error.t.Invalid_data_key`](./Ochre-Error.md#type-t.Invalid_data_key) when a key of `~data` is empty or holds a byte outside `A-Za-z0-9_-`.

```ocaml
let d =
  Ochre.Decoration.make ~class_:"highlighted"
    ~start:(Ochre.Decoration.pos 0 0)
    ~end_:(Ochre.Decoration.pos 0 11)
    ()
```

### apply

```ocaml
val apply : source:string -> t list -> Token.line list -> Token.line list
```
`apply ~source decorations lines` maps decoration ranges onto tokens, splitting tokens at boundaries and attaching properties. A token is matched by its [`Token.position`](./Ochre-Token.md#type-position), so `source` must be the source the tokens come from.

Overlapping decorations are merged: classes are space-concatenated, styles are semicolon-concatenated, data attributes are merged (later wins).

Character positions are Unicode scalar positions; they are converted to the byte positions of the tokens once per line. Never raises: each byte that is not part of a valid UTF-8 sequence counts as one character. [`highlight`](./Ochre.md#val-highlight) applies `~decorations` with this function, before transforms.
