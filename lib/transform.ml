type token = Token.styled_token
type line = token list
type document = line list

type t = {
  name : string;
  before_line : (line_index:int -> line -> line) option;
  after_line : (line_index:int -> line -> line) option;
  before_render : (document -> document) option;
  after_render : (document -> document) option;
}

let make ?before_line ?after_line ?before_render ?after_render name =
  { name; before_line; after_line; before_render; after_render }

let apply_before_line transforms ~line_index line =
  List.fold_left
    (fun acc t ->
      match t.before_line with Some f -> f ~line_index acc | None -> acc)
    line transforms

let apply_after_line transforms ~line_index line =
  List.fold_left
    (fun acc t ->
      match t.after_line with Some f -> f ~line_index acc | None -> acc)
    line transforms

let apply_before_render transforms doc =
  List.fold_left
    (fun acc t -> match t.before_render with Some f -> f acc | None -> acc)
    doc transforms

let apply_after_render transforms doc =
  List.fold_left
    (fun acc t -> match t.after_render with Some f -> f acc | None -> acc)
    doc transforms

let run transforms doc =
  let doc = apply_before_render transforms doc in
  let doc =
    List.mapi
      (fun line_index line ->
        let line = apply_before_line transforms ~line_index line in
        apply_after_line transforms ~line_index line)
      doc
  in
  apply_after_render transforms doc
