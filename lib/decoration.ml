type position = { line : int; character : int }

type properties = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}

type t = { start : position; end_ : position; properties : properties }

let pos line character = { line; character }

let make ?class_ ?style ?(data = []) ~start ~end_ () =
  { start; end_; properties = { class_; style; data } }

(* Build a line-length array from source for resolving negative positions *)
let line_lengths source =
  let lines = String.split_on_char '\n' source in
  Array.of_list (List.map String.length lines)

(* Resolve a position to a non-negative character offset within a line.
   Negative characters count from end of line: -1 = line end, -2 = one before end, etc. *)
let resolve_character lengths pos =
  let len =
    if pos.line >= 0 && pos.line < Array.length lengths then lengths.(pos.line)
    else 0
  in
  if pos.character >= 0 then pos.character else max 0 (len + 1 + pos.character)

(* Merge two decoration_properties, with later (b) overriding earlier (a)
   for style; classes are space-concatenated; data is merged (b wins keys). *)
let merge_properties (a : Token.decoration_properties)
    (b : Token.decoration_properties) : Token.decoration_properties =
  let class_ =
    match (a.class_, b.class_) with
    | None, None -> None
    | Some c, None | None, Some c -> Some c
    | Some a, Some b -> Some (a ^ " " ^ b)
  in
  let style =
    match (a.style, b.style) with
    | None, None -> None
    | Some s, None | None, Some s -> Some s
    | Some a, Some b -> Some (a ^ ";" ^ b)
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
    | None -> Some dp
    | Some existing -> Some (merge_properties existing dp)
  in
  { tok with decoration }

(* Apply decorations to a single line's tokens.
   line_idx: 0-based line number
   lengths: line-length array for negative position resolution
   decorations: all decorations (we filter to those affecting this line)
   tokens: the line's tokens *)
let apply_to_line ~line_idx ~lengths decorations tokens =
  (* Collect decorations that overlap this line, with resolved char positions *)
  let relevant =
    List.filter_map
      (fun (d : t) ->
        let start_line = d.start.line in
        let end_line = d.end_.line in
        if line_idx < start_line || line_idx > end_line then None
        else
          let start_char =
            if line_idx > start_line then 0
            else resolve_character lengths d.start
          in
          let end_char =
            if line_idx < end_line then
              (* decoration continues past this line -- cover entire line *)
              if line_idx < Array.length lengths then
                lengths.(line_idx)
                + 1 (* +1 to include trailing newline token *)
              else 1000000
            else resolve_character lengths d.end_
          in
          Some (start_char, end_char, d.properties))
      decorations
  in
  if relevant = [] then tokens
  else
    (* Walk tokens, tracking character offset within the line.
       For each token, check all relevant decorations and split if needed. *)
    let rec process offset tokens =
      match tokens with
      | [] -> []
      | (tok : Token.styled_token) :: rest ->
          let tok_len = String.length tok.text in
          let tok_start = offset in
          let tok_end = offset + tok_len in
          (* Collect all decorations that overlap this token *)
          let overlapping =
            List.filter (fun (s, e, _) -> s < tok_end && e > tok_start) relevant
          in
          if overlapping = [] then
            (* No decorations touch this token *)
            tok :: process tok_end rest
          else
            (* Find all split points within this token *)
            let split_points = ref [] in
            List.iter
              (fun (s, e, _) ->
                if s > tok_start && s < tok_end then
                  split_points := (s - tok_start) :: !split_points;
                if e > tok_start && e < tok_end then
                  split_points := (e - tok_start) :: !split_points)
              overlapping;
            (* Deduplicate and sort *)
            let points = List.sort_uniq compare !split_points in
            (* Split the token text at these points *)
            let rec split_text text prev_cut points =
              match points with
              | [] ->
                  if prev_cut < String.length text then
                    [ String.sub text prev_cut (String.length text - prev_cut) ]
                  else []
              | p :: rest ->
                  if p > prev_cut then
                    String.sub text prev_cut (p - prev_cut)
                    :: split_text text p rest
                  else split_text text prev_cut rest
            in
            let fragments = split_text tok.text 0 points in
            (* Build tokens for each fragment *)
            let rec build_fragments frag_offset frags =
              match frags with
              | [] -> []
              | frag :: rest_frags ->
                  let frag_len = String.length frag in
                  let frag_start = frag_offset in
                  let frag_end = frag_offset + frag_len in
                  (* Find decorations that cover this fragment *)
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
  if decorations = [] then tokens
  else
    let lengths = line_lengths source in
    List.mapi
      (fun line_idx line -> apply_to_line ~line_idx ~lengths decorations line)
      tokens
