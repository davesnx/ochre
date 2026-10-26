(** TextMate scope matching with specificity-based resolution.

    Matches a token's scope stack against theme rules to find the best styling.
    Used internally by the highlighter; exposed for advanced use cases like
    custom renderers or scope debugging. *)

val match_selector : string list -> string -> int option
(** {2 match_selector}

    Match a token's scope stack (innermost scope first) against a selector
    string.

    Returns [Some specificity] if some scope of the stack matches the last part
    of the selector and the earlier parts match its ancestors, [None] otherwise.
    Parts are separated by spaces, and a [>] part requires the next part to
    match the direct parent. Higher specificity means longer parts.

    {[
    let scopes = [ "variable.name"; "meta.let"; "source.ocaml" ] in
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

    Returns the settings resolved as vscode-textmate does: for each scope of the
    stack from the outermost to the innermost, the best matching rule decides
    the attributes it sets, and the other attributes keep the value of the
    enclosing scope. Returns [None] if no rule sets any attribute.

    {[
    let scopes = [ "comment.line"; "source.ocaml" ] in
    match Scope.find_best_match scopes theme.token_colors with
    | Some settings ->
        settings.foreground
    | None ->
        Some theme.fg
    ]} *)

type resolver
(** {2 resolver}

    Resolves the style of many scope stacks against one rule list. Selectors are
    parsed once, and each distinct scope stack prefix is resolved once. A
    resolver holds mutable state: do not share one between domains. *)

val resolver : Theme.token_color_rule list -> resolver
(** {2 resolver}

    [resolver rules] creates a resolver. The parsed selectors are cached per
    rule list (compared by physical equality) in a domain-safe cache, so
    creating many resolvers for the same theme parses its selectors once. *)

val resolve : resolver -> string list -> Theme.token_color_settings option
(** {2 resolve}

    [resolve r scopes] returns the same result as {!find_best_match}
    [scopes rules], where [rules] is the list given to {!resolver}. *)
