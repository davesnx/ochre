type token = Token.t
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

type never = |

let run_checked ~check transforms doc =
  let ( let* ) = Result.bind in
  let check_line t line =
    match List.find_map (check t) line with
    | Some error ->
        Error error
    | None ->
        Ok line
  in
  let check_doc t doc =
    List.fold_left
      (fun acc line ->
        let* () = acc in
        Result.map ignore (check_line t line)
      )
      (Ok ()) doc
    |> Result.map (fun () -> doc)
  in
  let fold hook check value =
    List.fold_left
      (fun acc t ->
        let* value = acc in
        match hook t with None -> Ok value | Some f -> check t (f value)
      )
      (Ok value) transforms
  in
  let each_line hook doc =
    List.fold_left
      (fun acc line ->
        let* index, lines = acc in
        let* line =
          fold
            (fun t -> Option.map (fun f -> f ~line_index:index) (hook t))
            check_line line
        in
        Ok (index + 1, line :: lines)
      )
      (Ok (0, []))
      doc
    |> Result.map (fun (_, lines) -> List.rev lines)
  in
  let* doc = fold (fun t -> t.before_render) check_doc doc in
  let* doc = each_line (fun t -> t.before_line) doc in
  let* doc = each_line (fun t -> t.after_line) doc in
  fold (fun t -> t.after_render) check_doc doc

let run transforms doc =
  match
    run_checked ~check:(fun _ _ -> (None : never option)) transforms doc
  with
  | Ok doc ->
      doc
  | Error _ ->
      .
