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

let invalid_utf8 () = invalid_arg "Decoration.apply: source is not valid UTF-8"

let is_continuation_byte byte = byte >= 0x80 && byte <= 0xbf

let utf8_scalar_length source offset =
  let length = String.length source in
  let byte index = Char.code source.[index] in
  let has_continuation index =
    index < length && is_continuation_byte (byte index)
  in
  match byte offset with
  | byte when byte <= 0x7f ->
      1
  | byte when byte >= 0xc2 && byte <= 0xdf && has_continuation (offset + 1) ->
      2
  | 0xe0
    when offset + 2 < length
         && byte (offset + 1) >= 0xa0
         && byte (offset + 1) <= 0xbf
         && has_continuation (offset + 2) ->
      3
  | byte
    when ((byte >= 0xe1 && byte <= 0xec) || (byte >= 0xee && byte <= 0xef))
         && has_continuation (offset + 1)
         && has_continuation (offset + 2) ->
      3
  | 0xed
    when offset + 2 < length
         && byte (offset + 1) >= 0x80
         && byte (offset + 1) <= 0x9f
         && has_continuation (offset + 2) ->
      3
  | 0xf0
    when offset + 3 < length
         && byte (offset + 1) >= 0x90
         && byte (offset + 1) <= 0xbf
         && has_continuation (offset + 2)
         && has_continuation (offset + 3) ->
      4
  | byte
    when byte >= 0xf1 && byte <= 0xf3
         && has_continuation (offset + 1)
         && has_continuation (offset + 2)
         && has_continuation (offset + 3) ->
      4
  | 0xf4
    when offset + 3 < length
         && byte (offset + 1) >= 0x80
         && byte (offset + 1) <= 0x8f
         && has_continuation (offset + 2)
         && has_continuation (offset + 3) ->
      4
  | _ ->
      invalid_utf8 ()

let line_boundaries source =
  let length = String.length source in
  let rec scan offset line_start boundaries lines =
    if offset = length then
      Array.of_list (List.rev (Array.of_list (List.rev boundaries) :: lines))
    else
      let scalar_length = utf8_scalar_length source offset in
      if source.[offset] = '\n' then
        scan (offset + scalar_length) (offset + scalar_length) [ 0 ]
          (Array.of_list (List.rev boundaries) :: lines)
      else
        let boundary = offset + scalar_length - line_start in
        scan (offset + scalar_length) line_start (boundary :: boundaries) lines
  in
  scan 0 0 [ 0 ] []

let resolve_character boundaries pos =
  let line_boundaries =
    if pos.line >= 0 && pos.line < Array.length boundaries then
      boundaries.(pos.line)
    else
      [| 0 |]
  in
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

let apply_to_line ~line_idx ~boundaries decorations tokens =
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
              resolve_character boundaries d.start
          in
          let end_char =
            if line_idx < end_line then
              if line_idx < Array.length boundaries then
                boundaries.(line_idx).(Array.length boundaries.(line_idx) - 1)
                + 1
              else
                1000000
            else
              resolve_character boundaries d.end_
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
  let boundaries = line_boundaries source in
  if decorations = [] then
    tokens
  else
    List.mapi
      (fun line_idx line -> apply_to_line ~line_idx ~boundaries decorations line)
      tokens
