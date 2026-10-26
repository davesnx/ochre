let split_on_spaces text =
  String.split_on_char ' ' text
  |> List.map String.trim
  |> List.filter (fun s -> s <> "")

let split_selector = split_on_spaces
let normalize_scopes scopes = List.concat_map split_on_spaces scopes

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

let position_weight = 1000

let match_selector scopes selector =
  let parts = split_selector selector in
  let scopes = Array.of_list (normalize_scopes scopes) in
  let scope_count = Array.length scopes in
  let rec go parts idx score =
    match parts with
    | [] ->
        Some score
    | part :: rest ->
        if idx >= scope_count then
          None
        else if scope_matches_selector_part scopes.(idx) part then
          go rest (idx + 1)
            (score
            + ((scope_count - idx) * position_weight)
            + String.length part
            )
        else
          go parts (idx + 1) score
  in
  go parts 0 0

type compiled = {
  rules : Theme.token_color_rule array;
  unconditional : int list;
  selector_rule : int array;
  selector_length : int array;
  selector_specificity : int array;
  part_selector : int array;
  part_index : int array;
  parts_by_name : (string, int list) Hashtbl.t;
}

let compile (rules : Theme.token_color_rule list) =
  let rules = Array.of_list rules in
  let unconditional = ref [] in
  let selectors = ref [] in
  Array.iteri
    (fun idx (rule : Theme.token_color_rule) ->
      if rule.scope = [] then
        unconditional := idx :: !unconditional
      else
        List.iter
          (fun selector ->
            match split_selector selector with
            | [] ->
                ()
            | parts ->
                selectors := (idx, parts) :: !selectors
          )
          (List.concat_map split_selector_group rule.scope)
    )
    rules;
  let selectors = Array.of_list (List.rev !selectors) in
  let part_count =
    Array.fold_left (fun acc (_, parts) -> acc + List.length parts) 0 selectors
  in
  let part_selector = Array.make part_count 0 in
  let part_index = Array.make part_count 0 in
  let parts_by_name = Hashtbl.create 256 in
  let next = ref 0 in
  Array.iteri
    (fun sel (_, parts) ->
      List.iteri
        (fun local part ->
          let g = !next in
          incr next;
          part_selector.(g) <- sel;
          part_index.(g) <- local;
          let existing =
            Option.value (Hashtbl.find_opt parts_by_name part) ~default:[]
          in
          Hashtbl.replace parts_by_name part (g :: existing)
        )
        parts
    )
    selectors;
  {
    rules;
    unconditional = List.rev !unconditional;
    selector_rule = Array.map fst selectors;
    selector_length = Array.map (fun (_, parts) -> List.length parts) selectors;
    selector_specificity =
      Array.map
        (fun (_, parts) ->
          List.fold_left (fun acc part -> acc + String.length part) 0 parts
        )
        selectors;
    part_selector;
    part_index;
    parts_by_name;
  }

let cache_capacity = 16
let compiled_cache : (Theme.token_color_rule list * compiled) list Atomic.t =
  Atomic.make []

let compiled_for rules =
  match
    List.find_opt (fun (key, _) -> key == rules) (Atomic.get compiled_cache)
  with
  | Some (_, compiled) ->
      compiled
  | None ->
      let compiled = compile rules in
      let rec update () =
        let current = Atomic.get compiled_cache in
        let kept = List.filteri (fun i _ -> i < cache_capacity - 1) current in
        if
          not
            (Atomic.compare_and_set compiled_cache current
               ((rules, compiled) :: kept)
            )
        then
          update ()
      in
      update ();
      compiled

module Stack_table = Hashtbl.Make (struct
  type t = string list

  let equal = List.equal String.equal

  let hash scopes =
    List.fold_left (fun acc scope -> (acc * 31) + Hashtbl.hash scope) 17 scopes
    land max_int
end)

type resolver = {
  compiled : compiled;
  memo : Theme.token_color_settings option Stack_table.t;
  scope_parts : (string, int list) Hashtbl.t;
  state : int array;
  index_sum : int array;
}

let resolver rules =
  let compiled = compiled_for rules in
  let selector_count = Array.length compiled.selector_rule in
  {
    compiled;
    memo = Stack_table.create 64;
    scope_parts = Hashtbl.create 64;
    state = Array.make selector_count 0;
    index_sum = Array.make selector_count 0;
  }

let parts_matching_scope resolver scope =
  match Hashtbl.find_opt resolver.scope_parts scope with
  | Some parts ->
      parts
  | None ->
      let by_name = resolver.compiled.parts_by_name in
      let found = ref [] in
      let collect name =
        match Hashtbl.find_opt by_name name with
        | Some parts ->
            found := List.rev_append parts !found
        | None ->
            ()
      in
      String.iteri
        (fun i c -> if c = '.' then collect (String.sub scope 0 i))
        scope;
      collect scope;
      let parts = List.sort (fun a b -> compare b a) !found in
      Hashtbl.add resolver.scope_parts scope parts;
      parts

let better_candidate current ((score, idx) as rank) value =
  match current with
  | None ->
      Some (rank, value)
  | Some ((best_score, best_idx), _) ->
      if score > best_score || (score = best_score && idx > best_idx) then
        Some (rank, value)
      else
        current

let resolve_uncached resolver scopes =
  let compiled = resolver.compiled in
  let scopes = Array.of_list (normalize_scopes scopes) in
  let scope_count = Array.length scopes in
  let touched = ref [] in
  Array.iteri
    (fun idx scope ->
      List.iter
        (fun g ->
          let sel = compiled.part_selector.(g) in
          let state = resolver.state.(sel) in
          if state = compiled.part_index.(g) then (
            if state = 0 then touched := sel :: !touched;
            resolver.state.(sel) <- state + 1;
            resolver.index_sum.(sel) <- resolver.index_sum.(sel) + idx
          )
        )
        (parts_matching_scope resolver scope)
    )
    scopes;
  let has_any = ref (compiled.unconditional <> []) in
  let fg_best = ref None in
  let bg_best = ref None in
  let font_best = ref None in
  let apply_rule idx score =
    has_any := true;
    let rank = (score, idx) in
    let settings = compiled.rules.(idx).settings in
    ( match settings.foreground with
    | Some color ->
        fg_best := better_candidate !fg_best rank color
    | None ->
        ()
    );
    ( match settings.background with
    | Some color ->
        bg_best := better_candidate !bg_best rank color
    | None ->
        ()
    );
    match settings.font_style with
    | Some styles ->
        font_best := better_candidate !font_best rank styles
    | None ->
        ()
  in
  List.iter (fun idx -> apply_rule idx 0) compiled.unconditional;
  List.iter
    (fun sel ->
      ( if resolver.state.(sel) = compiled.selector_length.(sel) then
          let score =
            (compiled.selector_length.(sel) * scope_count * position_weight)
            - (resolver.index_sum.(sel) * position_weight)
            + compiled.selector_specificity.(sel)
          in
          apply_rule compiled.selector_rule.(sel) score
      );
      resolver.state.(sel) <- 0;
      resolver.index_sum.(sel) <- 0
    )
    !touched;
  if not !has_any then
    None
  else
    Some
      {
        Theme.foreground = Option.map snd !fg_best;
        background = Option.map snd !bg_best;
        font_style = Option.map snd !font_best;
      }

let resolve resolver scopes =
  match Stack_table.find_opt resolver.memo scopes with
  | Some settings ->
      settings
  | None ->
      let settings = resolve_uncached resolver scopes in
      Stack_table.add resolver.memo scopes settings;
      settings

let find_best_match scopes rules = resolve (resolver rules) scopes
