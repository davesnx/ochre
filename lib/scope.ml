let split_selector selector =
  String.split_on_char ' ' selector
  |> List.map String.trim
  |> List.filter (fun s -> s <> "")

let split_compound_scope scope_entry =
  String.split_on_char ' ' scope_entry
  |> List.map String.trim
  |> List.filter (fun s -> s <> "")

let normalize_scopes scopes = List.concat_map split_compound_scope scopes

let split_selector_group selector =
  String.split_on_char ',' selector
  |> List.map String.trim
  |> List.filter (fun s -> s <> "")

let scope_matches_selector_part scope selector_part =
  if scope = selector_part then
    true
  else
    String.length selector_part < String.length scope
    && String.starts_with ~prefix:selector_part scope
    && scope.[String.length selector_part] = '.'

let calculate_specificity selector_part = String.length selector_part

let match_selector scopes selector =
  let scopes = normalize_scopes scopes in
  let selector_parts = split_selector selector in
  let scope_array = Array.of_list scopes in
  let scope_count = Array.length scope_array in
  let position_weight = 1000 in
  let position_score idx = (scope_count - idx) * position_weight in
  let max_opt a b =
    match (a, b) with None, x | x, None -> x | Some x, Some y -> Some (max x y)
  in
  let rec match_parts selector_parts scope_idx total_specificity =
    match selector_parts with
    | [] ->
        Some total_specificity
    | part :: rest ->
        let rec find_matching_scope idx best =
          if idx >= scope_count then
            best
          else
            let scope = scope_array.(idx) in
            let best =
              if scope_matches_selector_part scope part then
                let spec = calculate_specificity part in
                let total_score =
                  total_specificity + position_score idx + spec
                in
                let candidate = match_parts rest (idx + 1) total_score in
                max_opt best candidate
              else
                best
            in
            find_matching_scope (idx + 1) best
        in
        find_matching_scope scope_idx None
  in
  match_parts selector_parts 0 0

let find_best_match scopes (rules : Theme.token_color_rule list) =
  let better_candidate current ((score, idx) as rank) value =
    match current with
    | None ->
        Some (rank, value)
    | Some ((best_score, best_idx), _) ->
        if score > best_score || (score = best_score && idx > best_idx) then
          Some (rank, value)
        else
          current
  in
  let has_any = ref false in
  let fg_best = ref None in
  let bg_best = ref None in
  let font_best = ref None in
  List.iteri
    (fun idx (rule : Theme.token_color_rule) ->
      let best_match_in_rule =
        if rule.scope = [] then
          Some 0
        else
          List.concat_map split_selector_group rule.scope
          |> List.filter_map (fun selector -> match_selector scopes selector)
          |> List.fold_left max 0
          |> fun score ->
          if score > 0 then
            Some score
          else
            None
      in
      match best_match_in_rule with
      | None ->
          ()
      | Some score -> (
          has_any := true;
          let rank = (score, idx) in
          ( match rule.settings.foreground with
          | Some color ->
              fg_best := better_candidate !fg_best rank color
          | None ->
              ()
          );
          ( match rule.settings.background with
          | Some color ->
              bg_best := better_candidate !bg_best rank color
          | None ->
              ()
          );
          match rule.settings.font_style with
          | Some styles ->
              font_best := better_candidate !font_best rank styles
          | None ->
              ()
        )
    )
    rules;
  if not !has_any then
    None
  else
    Some
      {
        Theme.foreground = Option.map snd !fg_best;
        background = Option.map snd !bg_best;
        font_style = Option.map snd !font_best;
      }
