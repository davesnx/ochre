let get_ok = function
  | Ok value ->
      value
  | Error error ->
      failwith (Ochre.Error.to_string error)

let color s = Option.get (Ochre.Color.of_hex s)
let hex = Ochre.Color.to_hex

let font_style_names (style : Ochre.Style.font_style) =
  List.filter_map
    (fun (on, name) ->
      if on then
        Some name
      else
        None
    )
    [
      (style.bold, "bold");
      (style.italic, "italic");
      (style.underline, "underline");
      (style.strikethrough, "strikethrough");
    ]

let print_token (tok : Ochre.Token.t) =
  let text = String.trim tok.text in
  if text <> "" then begin
    let style = Ochre.Token.style tok in
    Printf.printf "text: %S\n" text;
    Printf.printf "  fg: %s\n" (hex style.foreground);
    Option.iter (fun c -> Printf.printf "  bg: %s\n" (hex c)) style.background;
    ( match font_style_names style.font_style with
    | [] ->
        ()
    | names ->
        Printf.printf "  styles: [%s]\n" (String.concat ", " names)
    );
    Printf.printf "  scopes: [%s]\n" (String.concat ", " tok.scopes)
  end
