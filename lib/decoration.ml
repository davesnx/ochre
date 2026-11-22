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

let make ?class_ ?style ?(data = []) ~start ~end_ () =
  match
    List.find_opt
      (fun (key, _) -> key = "" || not (String.for_all valid_data_key_char key))
      data
  with
  | Some (key, _) ->
      Error (Error.Invalid_data_key key)
  | None ->
      Ok { start; end_; properties = { class_; style; data } }

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

let merge_properties (a : Token.decoration_properties)
    (b : Token.decoration_properties) : Token.decoration_properties =
  let join sep a b =
    match (a, b) with
    | None, None ->
        None
    | Some c, None | None, Some c ->
        Some c
    | Some a, Some b ->
        Some (a ^ sep ^ b)
  in
  let data =
    let tbl = Hashtbl.create 8 in
    List.iter (fun (k, v) -> Hashtbl.replace tbl k v) a.data;
    List.iter (fun (k, v) -> Hashtbl.replace tbl k v) b.data;
    Hashtbl.fold (fun k v acc -> (k, v) :: acc) tbl []
  in
  {
    class_ = join " " a.class_ b.class_;
    style = join ";" a.style b.style;
    data;
  }

let set_decoration (tok : Token.t) (props : properties) : Token.t =
  let dp : Token.decoration_properties =
    { class_ = props.class_; style = props.style; data = props.data }
  in
  let decoration =
    match tok.decoration with
    | None ->
        Some dp
    | Some existing ->
        Some (merge_properties existing dp)
  in
  { tok with decoration }

let ranges_for_line ~line_idx ~source_lines ~boundaries_of decorations =
  List.map
    (fun (d : t) ->
      let start_char =
        if line_idx > d.start.line then
          0
        else
          resolve_character boundaries_of d.start
      in
      let end_char =
        if line_idx < d.end_.line then
          if line_idx < source_lines then
            let line_boundaries = boundaries_of line_idx in
            line_boundaries.(Array.length line_boundaries - 1) + 1
          else
            max_int
        else
          resolve_character boundaries_of d.end_
      in
      (start_char, end_char, d.properties)
    )
    decorations

let decorate_token ranges (tok : Token.t) =
  let tok_start = tok.position.column in
  let tok_end = tok_start + tok.position.length in
  let overlapping =
    List.filter (fun (s, e, _) -> s < tok_end && e > tok_start) ranges
  in
  if overlapping = [] then
    [ tok ]
  else
    let splittable = tok.position.length = String.length tok.text in
    let points =
      if splittable then
        List.sort_uniq compare
          (List.concat_map
             (fun (s, e, _) ->
               List.filter (fun p -> p > tok_start && p < tok_end) [ s; e ]
             )
             overlapping
          )
      else
        []
    in
    let rec pieces from = function
      | [] ->
          [ (from, tok_end) ]
      | p :: rest ->
          (from, p) :: pieces p rest
    in
    List.map
      (fun (piece_start, piece_end) ->
        let piece =
          if splittable then
            Token.slice tok ~pos:(piece_start - tok_start)
              ~len:(piece_end - piece_start)
          else
            tok
        in
        List.fold_left
          (fun t (s, e, props) ->
            if s <= piece_start && e >= piece_end then
              set_decoration t props
            else
              t
          )
          piece overlapping
      )
      (pieces tok_start points)

let line_of (line : Token.t list) =
  match line with [] -> None | first :: _ -> Some first.position.line

let apply ~source decorations (lines : Token.t list list) =
  if decorations = [] then
    lines
  else
    let source_lines, boundaries_of = boundaries_lookup source in
    let line_count =
      1
      + List.fold_left
          (fun acc line -> max acc (Option.value (line_of line) ~default:(-1)))
          (-1) lines
    in
    let by_line = Array.make line_count [] in
    List.iter
      (fun (d : t) ->
        for line = max 0 d.start.line to min (line_count - 1) d.end_.line do
          by_line.(line) <- d :: by_line.(line)
        done
      )
      (List.rev decorations);
    List.map
      (fun line ->
        match line_of line with
        | Some line_idx when line_idx >= 0 && by_line.(line_idx) <> [] ->
            let ranges =
              ranges_for_line ~line_idx ~source_lines ~boundaries_of
                by_line.(line_idx)
            in
            List.concat_map (decorate_token ranges) line
        | _ ->
            line
      )
      lines
