
# Module `Ochre.Scope_spans`

```ocaml
type span = {
  offset : int; (* Byte offset of the first byte in the source. *)
  length : int; (* Number of bytes, at least 1. *)
  scope : string; (* TextMate scope, for example entity.name.namespace. *)
}
```
```ocaml
type t
```
Spans checked against one source.

```ocaml
val make : source:string -> span list -> (t, Error.t) Stdlib.result
```
`make ~source spans` checks `spans` against `source`, in any order. Returns [`Error.t.Invalid_scope_span`](./Ochre-Error.md#type-t.Invalid_scope_span) for the first span that is empty, ends outside `source`, starts or ends inside a UTF-8 sequence, overlaps another span, or has a scope that is empty or holds a blank.

Give the result to [`highlight`](./Ochre.md#val-highlight) with the same `source`. Spans apply only to tokens that a grammar scoped: a token with no scopes, such as a token of [`Lang.plaintext`](./Ochre-Lang.md#val-plaintext), stays as it is. For each other token that spans cover, the token is split at the span boundaries that fall inside it, and each covered piece gets the span's scope as its innermost scope, the head of [`Token.t.scopes`](./Ochre-Token.md#type-t.scopes). This happens only when at least one piece then has a different style under at least one theme. Otherwise the token stays exactly as it is without spans: same text, scopes and style.

```ocaml
let themed =
  match
    Ochre.Scope_spans.make ~source:code
      [ { offset = 0; length = 3; scope = "entity.name.namespace" } ]
  with
  | Ok scopes ->
      Ochre.highlight ~scopes ~theme ~lang code
  | Error _ ->
      Ochre.highlight ~theme ~lang code
```