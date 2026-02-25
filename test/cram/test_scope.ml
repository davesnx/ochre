let print_match result =
  match result with
  | Some specificity -> Printf.printf "match (specificity: %d)\n" specificity
  | None -> Printf.printf "no match\n"

let () =
  match Sys.argv.(1) with
  | "exact" ->
    print_match
      (Ochre.Scope.match_selector
         [ "source.js"; "comment.line" ] "comment.line")
  | "prefix" ->
    print_match
      (Ochre.Scope.match_selector
         [ "source.js"; "string.quoted.double.js" ] "string.quoted")
  | "no-match" ->
    print_match
      (Ochre.Scope.match_selector
         [ "source.js"; "keyword.control" ] "comment")
  | "multi-part" ->
    print_match
      (Ochre.Scope.match_selector
         [ "source.js"; "meta.function.js"; "variable.parameter.js" ]
         "source.js variable.parameter")
  | "prefix-boundary" ->
    print_match
      (Ochre.Scope.match_selector [ "source.js"; "stringy" ] "string")
  | "specificity" ->
    let scopes = [ "source.js"; "string.quoted.double.js" ] in
    Printf.printf "string: ";
    print_match (Ochre.Scope.match_selector scopes "string");
    Printf.printf "string.quoted: ";
    print_match (Ochre.Scope.match_selector scopes "string.quoted");
    Printf.printf "string.quoted.double: ";
    print_match (Ochre.Scope.match_selector scopes "string.quoted.double")
  | "find-best" ->
    let scopes = [ "source.js"; "string.quoted.double.js" ] in
    let rules : Ochre.Theme.token_color_rule list =
      [
        {
          scope = [ "string" ];
          settings =
            { foreground = Some "#aa0000"; background = None; font_style = [] };
        };
        {
          scope = [ "string.quoted" ];
          settings =
            { foreground = Some "#bb0000"; background = None; font_style = [] };
        };
        {
          scope = [ "comment" ];
          settings =
            { foreground = Some "#cc0000"; background = None; font_style = [] };
        };
      ]
    in
    (match Ochre.Scope.find_best_match scopes rules with
     | Some s ->
       Printf.printf "fg: %s\n"
         (Option.value ~default:"none" s.foreground)
     | None -> Printf.printf "no match\n")
  | "empty-scopes" ->
    print_match (Ochre.Scope.match_selector [] "comment")
  | s -> Printf.eprintf "unknown: %s\n" s; exit 1
