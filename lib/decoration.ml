type position = { line : int; character : int }

type properties = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}

type t = { start : position; end_ : position; properties : properties }

let pos line character = { line; character }

let valid_data_key_char = function
  | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '-' | '_' ->
      true
  | _ ->
      false

let invalid_data_key key =
  invalid_arg
    (Printf.sprintf
       "Decoration.make: invalid data key %S (must be non-empty and contain \
        only letters, digits, '-', or '_', since it becomes part of a data-* \
        attribute name)"
       key
    )

let make ?class_ ?style ?(data = []) ~start ~end_ () =
  List.iter
    (fun (key, _) ->
      if key = "" || not (String.for_all valid_data_key_char key) then
        invalid_data_key key
    )
    data;
  { start; end_; properties = { class_; style; data } }

let scalar_length source offset =
  match Utf8.scalar_length source offset with 0 -> 1 | n -> n

let line_boundaries source line_start =
  let length = String.length source in
  let line_end =
    match String.index_from_opt source line_start '\n' with
    | Some index ->
        index
    | None ->
        length
  in
  let rec scan offset boundaries =
    if offset >= line_end then
      Array.of_list (List.rev boundaries)
    else
      let next = offset + scalar_length source offset in
      scan next ((next - line_start) :: boundaries)
  in
  scan line_start [ 0 ]

let line_starts source =
  let rec scan from acc =
    match String.index_from_opt source from '\n' with
    | Some index ->
        scan (index + 1) ((index + 1) :: acc)
    | None ->
        Array.of_list (List.rev acc)
  in
  scan 0 [ 0 ]

let boundaries_lookup source =
  let starts = line_starts source in
  let cache = Hashtbl.create 16 in
  let source_lines = Array.length starts in
  ( source_lines,
    fun line ->
      if line < 0 || line >= Array.length starts then
        [| 0 |]
      else
        match Hashtbl.find_opt cache line with
        | Some boundaries ->
            boundaries
        | None ->
            let boundaries = line_boundaries source starts.(line) in
            Hashtbl.add cache line boundaries;
            boundaries
  )

let resolve_character boundaries_of pos =
  let line_boundaries = boundaries_of pos.line in
  let scalar_count = Array.length line_boundaries - 1 in
  let character =
    if pos.character >= 0 then
      min pos.character scalar_count
    else
      max 0 (scalar_count + 1 + pos.character)
  in
  line_boundaries.(character)

(* Merge two decoration_properties, with later (b) overriding earlier (a)
   for style; classes are space-concatenated; data is merged (b wins keys). *)
let merge_properties (a : Token.decoration_properties)
    (b : Token.decoration_properties) : Token.decoration_properties =
  let class_ =
    match (a.class_, b.class_) with
    | None, None ->
        None
    | Some c, None | None, Some c ->
        Some c
    | Some a, Some b ->
        Some (a ^ " " ^ b)
  in
  let style =
    match (a.style, b.style) with
    | None, None ->
        None
    | Some s, None | None, Some s ->
        Some s
    | Some a, Some b ->
        Some (a ^ ";" ^ b)
  in
  let data =
    let tbl = Hashtbl.create 8 in
    List.iter (fun (k, v) -> Hashtbl.replace tbl k v) a.data;
    List.iter (fun (k, v) -> Hashtbl.replace tbl k v) b.data;
    Hashtbl.fold (fun k v acc -> (k, v) :: acc) tbl []
  in
  { class_; style; data }

let props_to_decoration (p : properties) : Token.decoration_properties =
  { class_ = p.class_; style = p.style; data = p.data }

let set_decoration (tok : Token.styled_token) (props : properties) :
    Token.styled_token =
  let dp = props_to_decoration props in
  let decoration =
    match tok.decoration with
    | None ->
        Some dp
    | Some existing ->
        Some (merge_properties existing dp)
  in
  { tok with decoration }

let apply_to_line ~line_idx ~source_lines ~boundaries_of decorations tokens =
  let relevant =
    List.filter_map
      (fun (d : t) ->
        let start_line = d.start.line in
        let end_line = d.end_.line in
        if line_idx < start_line || line_idx > end_line then
          None
        else
          let start_char =
            if line_idx > start_line then
              0
            else
              resolve_character boundaries_of d.start
          in
          let end_char =
            if line_idx < end_line then
              if line_idx < source_lines then
                let line_boundaries = boundaries_of line_idx in
                line_boundaries.(Array.length line_boundaries - 1) + 1
              else
                1000000
            else
              resolve_character boundaries_of d.end_
          in
          Some (start_char, end_char, d.properties)
      )
      decorations
  in
  if relevant = [] then
    tokens
  else
    let rec process offset tokens =
      match tokens with
      | [] ->
          []
      | (tok : Token.styled_token) :: rest ->
          let tok_len = String.length tok.text in
          let tok_start = offset in
          let tok_end = offset + tok_len in
          (* Collect all decorations that overlap this token *)
          let overlapping =
            List.filter (fun (s, e, _) -> s < tok_end && e > tok_start) relevant
          in
          if overlapping = [] then
            tok :: process tok_end rest
          else
            let split_points = ref [] in
            List.iter
              (fun (s, e, _) ->
                if s > tok_start && s < tok_end then
                  split_points := (s - tok_start) :: !split_points;
                if e > tok_start && e < tok_end then
                  split_points := (e - tok_start) :: !split_points
              )
              overlapping;
            let points = List.sort_uniq compare !split_points in
            let rec split_text text prev_cut points =
              match points with
              | [] ->
                  if prev_cut < String.length text then
                    [ String.sub text prev_cut (String.length text - prev_cut) ]
                  else
                    []
              | p :: rest ->
                  if p > prev_cut then
                    String.sub text prev_cut (p - prev_cut)
                    :: split_text text p rest
                  else
                    split_text text prev_cut rest
            in
            let fragments = split_text tok.text 0 points in
            let rec build_fragments frag_offset frags =
              match frags with
              | [] ->
                  []
              | frag :: rest_frags ->
                  let frag_len = String.length frag in
                  let frag_start = frag_offset in
                  let frag_end = frag_offset + frag_len in
                  let covering =
                    List.filter
                      (fun (s, e, _) -> s <= frag_start && e >= frag_end)
                      overlapping
                  in
                  let new_tok = { tok with text = frag } in
                  let decorated =
                    List.fold_left
                      (fun t (_, _, props) -> set_decoration t props)
                      new_tok covering
                  in
                  decorated :: build_fragments frag_end rest_frags
            in
            build_fragments tok_start fragments @ process tok_end rest
    in
    process 0 tokens

let apply ~source decorations tokens =
  if decorations = [] then
    tokens
  else
    let source_lines, boundaries_of = boundaries_lookup source in
    let line_count = List.length tokens in
    let by_line = Array.make line_count [] in
    List.iter
      (fun (d : t) ->
        for line = max 0 d.start.line to min (line_count - 1) d.end_.line do
          by_line.(line) <- d :: by_line.(line)
        done
      )
      (List.rev decorations);
    List.mapi
      (fun line_idx line ->
        match by_line.(line_idx) with
        | [] ->
            line
        | relevant ->
            apply_to_line ~line_idx ~source_lines ~boundaries_of relevant line
      )
      tokens
