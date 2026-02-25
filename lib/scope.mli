(** TextMate scope matching with specificity-based resolution. *)

(** Match a token's scope stack against a selector string.

    Returns [Some specificity] if the selector matches, [None] otherwise.
    Higher specificity indicates a more specific match.

    A selector like ["source.js variable.parameter"] is split into parts
    and matched greedily against the scope stack. *)
val match_selector : string list -> string -> int option

(** Find the best-matching theme rule for a token's scope stack.

    Returns the settings from the highest-specificity match,
    or [None] if no rule matches. *)
val find_best_match :
  string list -> Theme.token_color_rule list -> Theme.token_color_settings option
