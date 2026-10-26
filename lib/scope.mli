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
    matched greedily against the scope stack, in time linear in the stack depth.
    Among all ways to match the parts, the one using the outermost scopes scores
    highest, and greedy left-to-right matching finds it.

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

type resolver
(** {2 resolver}

    Resolves the style of many scope stacks against one rule list. Selectors are
    parsed once, and each distinct scope stack is resolved once. A resolver
    holds mutable state: do not share one between domains. *)

val resolver : Theme.token_color_rule list -> resolver
(** {2 resolver}

    [resolver rules] creates a resolver. The parsed selectors are cached per
    rule list (compared by physical equality) in a domain-safe cache, so
    creating many resolvers for the same theme parses its selectors once. *)

val resolve : resolver -> string list -> Theme.token_color_settings option
(** {2 resolve}

    [resolve r scopes] returns the same result as {!find_best_match}
    [scopes rules], where [rules] is the list given to {!resolver}. *)
