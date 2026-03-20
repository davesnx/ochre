let render_decoration (dec : Token.decoration_properties) =
  let parts = [] in
  let parts =
    match dec.class_ with Some c -> ("class=" ^ c) :: parts | None -> parts
  in
  let parts =
    match dec.style with Some s -> ("style=" ^ s) :: parts | None -> parts
  in
  let parts =
    List.fold_left (fun acc (k, v) -> (k ^ "=" ^ v) :: acc) parts dec.data
  in
  " <" ^ String.concat ", " (List.rev parts) ^ ">"

let render_token (t : Token.styled_token) =
  let scopes = String.concat ", " t.scopes in
  let dec =
    match t.decoration with None -> "" | Some d -> render_decoration d
  in
  Printf.sprintf "  %s  %s%s" (Printf.sprintf "%S" t.text) scopes dec

let render_line line = String.concat "\n" (List.map render_token line)

let render _theme code =
  let lines =
    List.mapi
      (fun i line -> Printf.sprintf "line %d:\n%s" (i + 1) (render_line line))
      code
  in
  String.concat "\n" lines
