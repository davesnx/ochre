(** Syntax-only semantic classification of OCaml source.

    The classifier parses an OCaml implementation and returns spans for the
    identifiers whose role the syntax shows: modules, constructors, polymorphic
    variants, record fields, labels, types, type variables, and function or
    value bindings. Each span carries the TextMate scope that VS Code uses as
    the fallback for the matching semantic token type. *)

type span = {
  offset : int;  (** Byte offset of the first byte of the span. *)
  length : int;  (** Length of the span in bytes. *)
  scope : string;  (** TextMate scope, for example [entity.name.namespace]. *)
}

val classify : string -> (span list, string) result
(** [classify source] returns the spans of [source] in source order, or
    [Error message] when [source] does not parse as a sequence of OCaml toplevel
    phrases, as in a [.ml] file or a script. Toplevel directives such as
    [#require] are accepted and get no spans. A comment between the parts of a
    module path, or between a label and its argument, stops the classification
    of the rest of that path or label. Parser warnings are not printed. It uses
    the compiler's global lexer state, so do not call it from several domains at
    the same time. *)

val scope_spans : string -> (Ochre.Scope_spans.t, string) result
(** [scope_spans source] classifies [source] and checks the spans for
    {!Ochre.highlight}. Returns [Error message] when [source] does not parse.

    {@ocaml[
    let scopes = Result.to_option (Ochre_semantic.scope_spans code) in
    Ochre.highlight ?scopes ~theme ~lang code
    ]} *)
