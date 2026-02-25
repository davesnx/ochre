let split_selector selector =
  String.split_on_char ' ' selector
  |> List.map String.trim
  |> List.filter (fun s -> s <> "")

let scope_matches_selector_part scope selector_part =
  if scope = selector_part then true
  else
    String.length selector_part < String.length scope
    && String.starts_with ~prefix:selector_part scope
    && scope.[String.length selector_part] = '.'

let calculate_specificity selector_part = String.length selector_part

let match_selector scopes selector =
  let selector_parts = split_selector selector in
  let rec match_parts selector_parts scope_idx total_specificity =
    match selector_parts with
    | [] -> Some total_specificity
    | part :: rest ->
        let rec find_matching_scope idx =
          if idx >= List.length scopes then None
          else
            let scope = List.nth scopes idx in
            if scope_matches_selector_part scope part then
              let spec = calculate_specificity part in
              match_parts rest (idx + 1) (total_specificity + spec)
            else find_matching_scope (idx + 1)
        in
        find_matching_scope scope_idx
  in
  match_parts selector_parts 0 0

let find_best_match scopes (rules : Theme.token_color_rule list) =
  let matches =
    List.filter_map
      (fun (rule : Theme.token_color_rule) ->
        let best_match_in_rule =
          List.filter_map
            (fun selector -> match_selector scopes selector)
            rule.scope
          |> List.fold_left max 0
        in
        if best_match_in_rule > 0 then Some (best_match_in_rule, rule.settings)
        else None)
      rules
  in
  match matches with
  | [] -> None
  | _ ->
      let sorted = List.sort (fun (s1, _) (s2, _) -> compare s2 s1) matches in
      Some (snd (List.hd sorted))
