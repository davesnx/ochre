(** Type information and compiler diagnostics for OCaml snippets, as
    {!Ochre.Decoration.t} values.

    {@ocaml[
    let source = "let x = List.map succ [1]" in
    let { Ochre_merlin.decorations; _ } = Ochre_merlin.analyze source in
    Ochre.to_html highlighter ~decorations ~lang:"ocaml" source
    ]}

    Render the HTML with {!css} on the page to show the types and diagnostics on
    hover, without JavaScript. *)

type severity = Error | Warning

type diagnostic = {
  severity : severity;
  start : Ochre.Decoration.position;
  end_ : Ochre.Decoration.position;
  message : string;
}
(** A lexer, parser or type error, or a warning, as Merlin reports it. Positions
    use the same convention as {!Ochre.Decoration.position}. *)

type t = {
  decorations : Ochre.Decoration.t list;
  diagnostics : diagnostic list;
}

val analyze : ?load_path:string list -> string -> t
(** [analyze ?load_path source] types [source] as an implementation ([.ml]) with
    Merlin and returns:

    - one decoration per value, constructor and record field access ([r.name])
      with a known type, with its printed type in the [ochre-type] data
      attribute. Values show their generic type (for [List.map]:
      [('a -> 'b) -> 'a list -> 'b list]);
    - one decoration per diagnostic, with its message in the [ochre-diagnostic]
      data attribute and the class [ochre-error] or [ochre-warning];
    - the diagnostics themselves.

    [load_path] lists directories with compiled interfaces ([.cmi]) to resolve
    modules other than the standard library. It defaults to [[]]. The
    configuration is built from these arguments only: no [dune] or [.merlin]
    file is read.

    Invalid source gives diagnostics, not exceptions.

    Merlin keeps global state: calls must not run in parallel from several
    domains or threads. *)

val css : string
(** CSS that shows the [ochre-type] and [ochre-diagnostic] data attributes as
    tooltips on hover and underlines [ochre-error] and [ochre-warning] ranges.
    The tooltip colors can be changed with the [--ochre-tooltip-fg] and
    [--ochre-tooltip-bg] custom properties. *)
