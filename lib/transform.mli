(** Transform pipeline for post-tokenization rewrites.

    Transforms run after tokenization and theming, but before rendering. They
    can modify tokens, lines, or the entire document in a composable and
    deterministic way.

    Transforms are applied in list order (stable ordering by position). *)

type token = Token.styled_token
(** Alias for a styled token. *)

type line = token list
(** A line of styled tokens. *)

type document = line list
(** The full highlighted document (list of lines). *)

type t = {
  name : string;
  before_line : (line_index:int -> line -> line) option;
  after_line : (line_index:int -> line -> line) option;
  before_render : (document -> document) option;
  after_render : (document -> document) option;
}
(** A transform with named hooks.

    Each hook is optional. The pipeline calls them in this order:
    + [before_render] on the full document
    + [before_line] for each line (by index)
    + [after_line] for each line (by index)
    + [after_render] on the full document

    When multiple transforms are provided, each hook phase folds over all
    transforms in list order before moving to the next phase. *)

val make :
  ?before_line:(line_index:int -> line -> line) ->
  ?after_line:(line_index:int -> line -> line) ->
  ?before_render:(document -> document) ->
  ?after_render:(document -> document) ->
  string ->
  t
(** [make ?before_line ?after_line ?before_render ?after_render name] creates a
    transform with the given hooks.

    {[
      let my_transform =
        Transform.make "bold-keywords" ~after_line:(fun ~line_index:_ line ->
            List.map
              (fun (tok : Token.styled_token) ->
                if List.exists (fun s -> String.length s > 7) tok.scopes then
                  { tok with font_style = Token.Bold :: tok.font_style }
                else tok)
              line)
    ]} *)

val run : t list -> document -> document
(** [run transforms document] applies all transforms to the document.

    Transforms are applied in list order. The execution order is: 1. All
    [before_render] hooks (fold left over transforms) 2. For each line: all
    [before_line] hooks, then all [after_line] hooks 3. All [after_render] hooks
    (fold left over transforms)

    An empty transform list returns the document unchanged. *)
