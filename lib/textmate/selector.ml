open Common

let is_word_char = function
  | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' | '.' | ':' ->
      true
  | _ ->
      false

let tokenize s =
  let n = String.length s in
  let rec ident_end i =
    if i < n && (is_word_char s.[i] || s.[i] = '-') then
      ident_end (i + 1)
    else
      i
  in
  let rec go i acc =
    if i >= n then
      List.rev acc
    else
      match s.[i] with
      | ('L' | 'R') when i + 1 < n && s.[i + 1] = ':' ->
          go (i + 2) (String.sub s i 2 :: acc)
      | c when is_word_char c ->
          let j = ident_end (i + 1) in
          go j (String.sub s i (j - i) :: acc)
      | (',' | '|' | '-' | '(' | ')') as c ->
          go (i + 1) (String.make 1 c :: acc)
      | _ ->
          go (i + 1) acc
  in
  go 0 []

let is_identifier tok = not (List.mem tok [ ","; "|"; "-"; "("; ")" ])

let parse raw =
  let toks = ref (tokenize raw) in
  let peek () = match !toks with [] -> None | t :: _ -> Some t in
  let advance () = match !toks with [] -> () | _ :: r -> toks := r in
  let rec operand () =
    match peek () with
    | Some "-" ->
        advance ();
        Some (match operand () with Some e -> Not e | None -> Any [])
    | Some "(" ->
        advance ();
        let e = inner () in
        if peek () = Some ")" then advance ();
        Some e
    | Some t when is_identifier t ->
        let rec ids acc =
          match peek () with
          | Some t when is_identifier t ->
              advance ();
              ids (t :: acc)
          | _ ->
              List.rev acc
        in
        Some (Names (ids []))
    | _ ->
        None
  and conjunction () =
    let rec go acc =
      match operand () with Some e -> go (e :: acc) | None -> List.rev acc
    in
    All (go [])
  and inner () =
    let rec skip_separators () =
      match peek () with
      | Some ("|" | ",") ->
          advance ();
          skip_separators ()
      | _ ->
          ()
    in
    let rec go acc =
      let acc = conjunction () :: acc in
      match peek () with
      | Some ("|" | ",") ->
          skip_separators ();
          go acc
      | _ ->
          List.rev acc
    in
    Any (go [])
  in
  let rec alternatives acc =
    match peek () with
    | None ->
        List.rev acc
    | Some t ->
        let priority =
          if String.length t = 2 && t.[1] = ':' then begin
            advance ();
            match t.[0] with 'R' -> 1 | 'L' -> -1 | _ -> 0
          end else
            0
        in
        let expr = conjunction () in
        let acc = { priority; expr } :: acc in
        if peek () = Some "," then begin
          advance ();
          alternatives acc
        end else
          List.rev acc
  in
  alternatives []

let scope_matches scope name =
  scope = name
  ||
  let len = String.length name in
  String.length scope > len
  && String.starts_with ~prefix:name scope
  && scope.[len] = '.'

let names_match names scopes =
  List.length scopes >= List.length names
  &&
  let rec find name = function
    | [] ->
        None
    | s :: tl ->
        if scope_matches s name then
          Some tl
        else
          find name tl
  in
  let rec go names scopes =
    match names with
    | [] ->
        true
    | name :: rest -> (
        match find name scopes with Some tl -> go rest tl | None -> false
      )
  in
  go names scopes

let rec matches expr scopes =
  match expr with
  | Names names ->
      names_match names scopes
  | Not e ->
      not (matches e scopes)
  | All es ->
      List.for_all (fun e -> matches e scopes) es
  | Any es ->
      List.exists (fun e -> matches e scopes) es
