(* Theme resolution follows vscode-textmate 9.2.0 [src/theme.ts]
   (https://github.com/microsoft/vscode-textmate/blob/v9.2.0/src/theme.ts):
   rules go into a trie keyed by scope segments, and a token's style is
   folded from the outermost scope to the innermost one, each level keeping
   the attributes its own match leaves unset. *)

let split_on_spaces text =
  String.split_on_char ' ' text |> List.filter (fun s -> s <> "")

type path = { name : string; up : path option }

let scope_matches_selector_part scope selector_part =
  if scope = selector_part then
    true
  else
    String.length selector_part < String.length scope
    && String.starts_with ~prefix:selector_part scope
    && scope.[String.length selector_part] = '.'

(* [parents] lists the selector's ancestor parts nearest first. A [">"] entry
   follows the part it constrains and requires the next part to be the direct
   parent. *)
let rec parents_match up = function
  | [] ->
      true
  | [ ">" ] ->
      false
  | ">" :: part :: rest ->
      ancestor_matches up part true rest
  | part :: rest ->
      ancestor_matches up part false rest

and ancestor_matches up part direct rest =
  match up with
  | None ->
      false
  | Some node ->
      if scope_matches_selector_part node.name part then
        parents_match node.up rest
      else if direct then
        false
      else
        ancestor_matches node.up part direct rest

type rule = {
  mutable depth : int;
  parents : string list;
  mutable font_style : Theme.font_style list option;
  mutable foreground : Theme.color option;
  mutable background : Theme.color option;
}

type element = {
  main : rule;
  mutable with_parents : rule list;
  children : (string, element) Hashtbl.t;
  mutable candidates : rule list;
}

let clone_rule rule = { rule with depth = rule.depth }

let new_element ~main ~with_parents =
  {
    main = clone_rule main;
    with_parents = List.map clone_rule with_parents;
    children = Hashtbl.create 4;
    candidates = [];
  }

let split_first_dot scope =
  match String.index_opt scope '.' with
  | None ->
      (scope, "")
  | Some i ->
      ( String.sub scope 0 i,
        String.sub scope (i + 1) (String.length scope - i - 1)
      )

let accept_overwrite rule depth font_style foreground background =
  rule.depth <- depth;
  if font_style <> None then rule.font_style <- font_style;
  if foreground <> None then rule.foreground <- foreground;
  if background <> None then rule.background <- background

let insert_here element depth parents font_style foreground background =
  match parents with
  | [] ->
      accept_overwrite element.main depth font_style foreground background
  | _ -> (
      match
        List.find_opt (fun rule -> rule.parents = parents) element.with_parents
      with
      | Some rule ->
          accept_overwrite rule depth font_style foreground background
      | None ->
          let inherit_ current main =
            if current = None then
              main
            else
              current
          in
          element.with_parents <-
            element.with_parents
            @ [
                {
                  depth;
                  parents;
                  font_style = inherit_ font_style element.main.font_style;
                  foreground = inherit_ foreground element.main.foreground;
                  background = inherit_ background element.main.background;
                };
              ]
    )

let rec insert element depth scope parents font_style foreground background =
  if scope = "" then
    insert_here element depth parents font_style foreground background
  else
    let head, rest = split_first_dot scope in
    let child =
      match Hashtbl.find_opt element.children head with
      | Some child ->
          child
      | None ->
          let child =
            new_element ~main:element.main ~with_parents:element.with_parents
          in
          Hashtbl.add element.children head child;
          child
    in
    insert child (depth + 1) rest parents font_style foreground background

let compare_by_specificity a b =
  if a.depth <> b.depth then
    b.depth - a.depth
  else
    let skip = function ">" :: rest -> rest | parents -> parents in
    let rec go a_parents b_parents =
      match (skip a_parents, skip b_parents) with
      | [], _ | _, [] ->
          List.length b.parents - List.length a.parents
      | a_part :: a_rest, b_part :: b_rest ->
          let order = String.length b_part - String.length a_part in
          if order <> 0 then
            order
          else
            go a_rest b_rest
    in
    go a.parents b.parents

let rec freeze element =
  element.candidates <-
    List.stable_sort compare_by_specificity
      (element.with_parents @ [ element.main ]);
  Hashtbl.iter (fun _ child -> freeze child) element.children

let rec lookup element name =
  if name = "" then
    element
  else
    let head, rest = split_first_dot name in
    match Hashtbl.find_opt element.children head with
    | Some child ->
        lookup child rest
    | None ->
        element

type entry = {
  scope : string;
  entry_parents : string list;
  index : int;
  entry_font_style : Theme.font_style list option;
  entry_foreground : Theme.color option;
  entry_background : Theme.color option;
}

let compare_parents a b =
  match (a, b) with
  | [], [] ->
      0
  | [], _ ->
      -1
  | _, [] ->
      1
  | _ ->
      let a_length = List.length a and b_length = List.length b in
      if a_length = b_length then
        List.fold_left2
          (fun order x y ->
            if order <> 0 then
              order
            else
              String.compare x y
          )
          0 a b
      else
        a_length - b_length

let compare_entries a b =
  let order = String.compare a.scope b.scope in
  if order <> 0 then
    order
  else
    let order = compare_parents a.entry_parents b.entry_parents in
    if order <> 0 then
      order
    else
      a.index - b.index

let entries_of_rules rules =
  List.mapi
    (fun index (rule : Theme.token_color_rule) ->
      let valid = function
        | Some c when Theme.is_valid_color c ->
            Some c
        | _ ->
            None
      in
      let selectors =
        if rule.scope = [] then
          [ "" ]
        else
          rule.scope
      in
      List.map
        (fun selector ->
          let reversed =
            List.rev (String.split_on_char ' ' (String.trim selector))
          in
          {
            scope = List.hd reversed;
            entry_parents = List.tl reversed;
            index;
            entry_font_style = rule.settings.font_style;
            entry_foreground = valid rule.settings.foreground;
            entry_background = valid rule.settings.background;
          }
        )
        selectors
    )
    rules
  |> List.concat

type compiled = { trie : element; defaults : Theme.token_color_settings }

let compile rules =
  let entries = List.stable_sort compare_entries (entries_of_rules rules) in
  let globals, scoped = List.partition (fun e -> e.scope = "") entries in
  let defaults =
    List.fold_left
      (fun (acc : Theme.token_color_settings) entry ->
        {
          Theme.font_style =
            ( if entry.entry_font_style <> None then
                entry.entry_font_style
              else
                acc.font_style
            );
          foreground =
            ( if entry.entry_foreground <> None then
                entry.entry_foreground
              else
                acc.foreground
            );
          background =
            ( if entry.entry_background <> None then
                entry.entry_background
              else
                acc.background
            );
        }
      )
      Theme.{ foreground = None; background = None; font_style = None }
      globals
  in
  let trie =
    new_element
      ~main:
        {
          depth = 0;
          parents = [];
          font_style = None;
          foreground = None;
          background = None;
        }
      ~with_parents:[]
  in
  List.iter
    (fun entry ->
      insert trie 0 entry.scope entry.entry_parents entry.entry_font_style
        entry.entry_foreground entry.entry_background
    )
    scoped;
  freeze trie;
  { trie; defaults }

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

type node = {
  path : path;
  settings : Theme.token_color_settings;
  next : (string, node) Hashtbl.t;
}

type resolver = {
  compiled : compiled;
  roots : (string, node) Hashtbl.t;
  mutable stack : (string list * node option) list;
}

let resolver rules =
  {
    compiled = compiled_for rules;
    roots = Hashtbl.create 64;
    stack = [ ([], None) ];
  }

let make_node compiled parent name (inherited : Theme.token_color_settings) =
  let up = Option.map (fun node -> node.path) parent in
  let element = lookup compiled.trie name in
  let settings =
    match
      List.find_opt
        (fun rule -> parents_match up rule.parents)
        element.candidates
    with
    | None ->
        inherited
    | Some rule ->
        {
          Theme.font_style =
            ( if rule.font_style <> None then
                rule.font_style
              else
                inherited.font_style
            );
          foreground =
            ( if rule.foreground <> None then
                rule.foreground
              else
                inherited.foreground
            );
          background =
            ( if rule.background <> None then
                rule.background
              else
                inherited.background
            );
        }
  in
  { path = { name; up }; settings; next = Hashtbl.create 4 }

let step resolver parent scope =
  List.fold_left
    (fun parent name ->
      let table =
        match parent with Some node -> node.next | None -> resolver.roots
      in
      let settings =
        match parent with
        | Some node ->
            node.settings
        | None ->
            resolver.compiled.defaults
      in
      match Hashtbl.find_opt table name with
      | Some node ->
          Some node
      | None ->
          let node = make_node resolver.compiled parent name settings in
          Hashtbl.add table name node;
          Some node
    )
    parent (split_on_spaces scope)

let alignment_budget = 16

let rec tails budget scopes =
  match scopes with
  | [] ->
      [ scopes ]
  | _ :: rest ->
      if budget = 0 then
        []
      else
        scopes :: tails (budget - 1) rest

let rec take_tails n scopes =
  match scopes with
  | _ :: rest when n > 0 ->
      scopes :: take_tails (n - 1) rest
  | _ ->
      []

let rec drop n stack =
  if n = 0 then
    stack
  else
    drop (n - 1) (List.tl stack)

(* Scope lists of consecutive tokens share their tails physically, so the
   previous list's chain of nodes is reused when the new list differs from it
   by at most [alignment_budget] elements on each side. Otherwise the whole
   list is resolved again. Returns the number of new elements and the number of
   stack entries to drop. *)
let align stack scopes =
  let rec over_stack tail j = function
    | (l, _) :: rest when j < alignment_budget ->
        if l == tail then
          Some j
        else
          over_stack tail (j + 1) rest
    | _ ->
        None
  in
  let rec over_new i = function
    | tail :: rest -> (
        match over_stack tail 0 stack with
        | Some j ->
            Some (i, j)
        | None ->
            over_new (i + 1) rest
      )
    | [] ->
        None
  in
  match over_new 0 (tails alignment_budget scopes) with
  | Some found ->
      found
  | None ->
      (List.length scopes, List.length stack - 1)

let resolve resolver scopes =
  let fresh, dropped = align resolver.stack scopes in
  let stack =
    List.fold_left
      (fun stack tail ->
        let parent = snd (List.hd stack) in
        (tail, step resolver parent (List.hd tail)) :: stack
      )
      (drop dropped resolver.stack)
      (List.rev (take_tails fresh scopes))
  in
  resolver.stack <- stack;
  let settings =
    match snd (List.hd stack) with
    | Some node ->
        node.settings
    | None ->
        resolver.compiled.defaults
  in
  match settings with
  | { Theme.foreground = None; background = None; font_style = None } ->
      None
  | _ ->
      Some settings

let find_best_match scopes rules = resolve (resolver rules) scopes

let match_selector scopes selector =
  let reversed = List.rev (String.split_on_char ' ' (String.trim selector)) in
  let last = List.hd reversed and parents = List.tl reversed in
  let path_of_stack =
    List.fold_left
      (fun up name -> Some { name; up })
      None
      (List.concat_map split_on_spaces (List.rev scopes))
  in
  let rec search = function
    | None ->
        None
    | Some node ->
        if
          scope_matches_selector_part node.name last
          && parents_match node.up parents
        then
          Some
            (List.fold_left
               (fun acc part -> acc + String.length part)
               (String.length last) parents
            )
        else
          search node.up
  in
  search path_of_stack
