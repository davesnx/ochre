let render_token (t : Token.styled_token) =
  let base = Printf.sprintf "{%s}[%s]" t.text (String.concat "," t.scopes) in
  match t.decoration with
  | None ->
      base
  | Some dec ->
      let parts = [] in
      let parts =
        match dec.class_ with
        | Some c ->
            ("class=" ^ c) :: parts
        | None ->
            parts
      in
      let parts =
        match dec.style with Some s -> ("style=" ^ s) :: parts | None -> parts
      in
      let parts =
        List.fold_left (fun acc (k, v) -> (k ^ "=" ^ v) :: acc) parts dec.data
      in
      base ^ "<" ^ String.concat "," (List.rev parts) ^ ">"

let render_line line = String.concat "" (List.map render_token line)
let render _theme code = String.concat "\n" (List.map render_line code)
