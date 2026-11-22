(** Type information and compiler diagnostics for OCaml snippets, as
    {!Ochre.Decoration.t} values.

    {@ocaml[
    let source = "let x = List.map succ [1]" in
    let { Ochre_merlin.decorations; _ } = Ochre_merlin.analyze source in
    Ochre.to_html (Ochre.highlight ~decorations ~theme ~lang source)
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
(** A lexer, parser or type error, or a warning, as Merlin reports it, or an
    [Error] for a decoration that {!Ochre.Decoration.make} rejected, with
    {!Ochre.Error.to_string} as its message. Positions use the same convention
    as {!Ochre.Decoration.position}. *)

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
    - decorations for the diagnostics, with the message in the
      [ochre-diagnostic] data attribute and the class [ochre-error] or
      [ochre-warning]. Where diagnostics overlap, the range is split and each
      part carries all the messages that cover it, separated by a blank line,
      with [ochre-error] if any of them is an error. An empty diagnostic range
      is widened to the next character, or to the last character before it when
      the line ends there;
    - the diagnostics themselves, with Merlin's positions. Each message includes
      its sub-messages, such as hints, one per line.

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
