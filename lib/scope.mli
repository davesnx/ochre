(** TextMate scope matching with specificity-based resolution.

    Matches a token's scope stack against theme rules to find the best styling.
    Used internally by the highlighter; exposed for advanced use cases like
    custom renderers or scope debugging. *)

val match_selector : string list -> string -> int option
(** {2 match_selector}

    Match a token's scope stack against a selector string.

    Returns [Some specificity] if the selector matches, [None] otherwise. Higher
    specificity indicates a more specific match.

    A selector like ["source.js variable.parameter"] is split into parts and
    matched greedily against the scope stack.

    {[
      let scopes = [ "source.ocaml"; "meta.let"; "variable.name" ] in
      match Scope.match_selector scopes "variable.name" with
      | Some specificity ->
          Printf.printf "matched with specificity %d\n" specificity
      | None ->
          print_endline "no match"
    ]} *)

val find_best_match :
  string list ->
  Theme.token_color_rule list ->
  Theme.token_color_settings option
(** {2 find_best_match}

    Find the best-matching theme rule for a token's scope stack.

    Returns the settings from the highest-specificity match, or [None] if no
    rule matches.

    {[
      let scopes = [ "source.ocaml"; "comment.line" ] in
      match Scope.find_best_match scopes theme.token_colors with
      | Some settings ->
          settings.foreground
      | None ->
          Some theme.fg
    ]} *)
