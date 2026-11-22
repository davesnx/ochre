let grammar_json =
  {|{
  "scopeName": "source.test",
  "name": "test",
  "patterns": [
    { "match": "#.*", "name": "comment.line.test" },
    { "match": "\\b(let|if|then|else|fun)\\b", "name": "keyword.control.test" },
    { "match": "\"[^\"]*\"", "name": "string.quoted.double.test" },
    { "match": "\\b[0-9]+\\b", "name": "constant.numeric.test" }
  ]
}|}

let theme_json =
  {|{
  "name": "test-theme",
  "colors": {
    "editor.foreground": "#d4d4d4",
    "editor.background": "#1e1e1e"
  },
  "tokenColors": [
    { "scope": "comment", "settings": { "foreground": "#888888", "fontStyle": "italic" } },
    { "scope": "keyword", "settings": { "foreground": "#ff0000", "fontStyle": "bold" } },
    { "scope": "string", "settings": { "foreground": "#00ff00" } },
    { "scope": "constant.numeric", "settings": { "foreground": "#0000ff" } }
  ]
}|}

let light_theme_json =
  {|{
  "name": "test-light",
  "colors": {
    "editor.foreground": "#24292e",
    "editor.background": "#ffffff"
  },
  "tokenColors": [
    { "scope": "comment", "settings": { "foreground": "#6a737d", "fontStyle": "italic" } },
    { "scope": "keyword", "settings": { "foreground": "#d73a49", "fontStyle": "bold" } },
    { "scope": "string", "settings": { "foreground": "#032f62" } },
    { "scope": "constant.numeric", "settings": { "foreground": "#005cc5" } }
  ]
}|}

let dim_theme_json =
  {|{
  "name": "test-dim",
  "colors": {
    "editor.foreground": "#999999",
    "editor.background": "#111111"
  },
  "tokenColors": [
    { "scope": "comment", "settings": { "foreground": "#555555", "fontStyle": "italic" } },
    { "scope": "keyword", "settings": { "foreground": "#aa5555", "fontStyle": "bold" } },
    { "scope": "string", "settings": { "foreground": "#55aa55" } },
    { "scope": "constant.numeric", "settings": { "foreground": "#5555aa" } }
  ]
}|}

let setup () =
  let path = "test.tmLanguage.json" in
  let oc = open_out path in
  output_string oc grammar_json;
  close_out oc;
  let hl = Ochre.load_from_files_exn [ path ] in
  Sys.remove path;
  let theme = Ochre.Theme.load_exn theme_json in
  let light_theme = Ochre.Theme.load_exn light_theme_json in
  let dim_theme = Ochre.Theme.load_exn dim_theme_json in
  (hl, theme, light_theme, dim_theme)

let print_class_coverage ?(transforms = []) ?(inline = []) themes =
  let hl =
    Ochre.load_exn [ ("ocaml", Option.get (Tm_grammars.find "ocaml")) ]
  in
  let source =
    {|(* A module with a (* nested *) comment *)
module Shape : sig
  type t = Circle of float | Rect of { w : float; h : float }
  val area : t -> float
end = struct
  type t = Circle of float | Rect of { w : float; h : float }

  (** [area s] is the area of [s]. *)
  let area = function
| Circle r -> Float.pi *. r *. r
| Rect { w; h } -> w *. h
end

let () =
  let shapes = [ Shape.Circle 1.0; Rect { w = 2.; h = 3. } ] in
  List.iter (fun s -> Printf.printf "%s: %.2f\n%!" "area" (Shape.area s)) shapes;
  assert ('a' <> '\n' && 0x1F land 3 >= 1 || not true)
|}
  in
  let options =
    Ochre.Html_options.make
      ~style_mode:(Ochre.Html_options.Css_classes { class_prefix = "oc-" })
      ()
  in
  let class_re = Str.regexp "oc-[0-9a-f]+" in
  let rec classes html start acc =
    match Str.search_forward class_re html start with
    | exception Not_found ->
        List.sort_uniq String.compare acc
    | _ ->
        classes html (Str.match_end ()) (Str.matched_string html :: acc)
  in
  List.iter
    (fun (name, theme) ->
      let html =
        Ochre.to_html hl ~transforms ~options ~theme ~lang:"ocaml" source
      in
      let css = Ochre.html_render_theme_css ~class_prefix:"oc-" theme in
      let used = classes html 0 [] in
      let missing =
        List.filter
          (fun cls ->
            match
              Str.search_forward (Str.regexp_string ("." ^ cls ^ " {")) css 0
            with
            | exception Not_found ->
                true
            | _ ->
                false
          )
          used
      in
      Printf.printf "%s: %s\n" name
        ( if used = [] then
            "no classes"
          else if missing = [] then
            "every class has a rule"
          else
            "missing " ^ String.concat " " missing
        );
      List.iter
        (fun value ->
          let in_style =
            Str.regexp_string ("style=\"" ^ value) |> fun re ->
            match Str.search_forward re html 0 with
            | exception Not_found ->
                false
            | _ ->
                true
          in
          Printf.printf "%s: %s %s\n" name value
            ( if in_style then
                "kept inline"
              else
                "not inline"
            )
        )
        inline
    )
    (List.map (fun (name, json) -> (name, Ochre.Theme.load_exn json)) themes)

let () =
  let hl, theme, light_theme, dim_theme = setup () in
  match Sys.argv.(1) with
  | "keyword-and-number" ->
      print_endline (Ochre.to_html hl ~theme ~lang:"test" "let x = 42")
  | "comment" ->
      print_endline (Ochre.to_html hl ~theme ~lang:"test" "# a comment")
  | "string" ->
      print_endline (Ochre.to_html hl ~theme ~lang:"test" {|let s = "hello"|})
  | "multi-line" ->
      print_endline
        (Ochre.to_html hl ~theme ~lang:"test" "let x = 42\nlet y = 10")
  | "escaping" ->
      print_endline (Ochre.to_html hl ~theme ~lang:"test" "# <div>&amp;</div>")
  | "themes-one-extra" ->
      print_endline
        (Ochre.to_html hl ~theme:light_theme
           ~extra_themes:[ ("dark", theme) ]
           ~lang:"test" "let x = 42"
        )
  | "themes-multi-line" ->
      print_endline
        (Ochre.to_html hl ~theme:light_theme
           ~extra_themes:[ ("dark", theme) ]
           ~lang:"test" "let x = 42\nlet y = 10"
        )
  | "themes-light-dark-vars" ->
      print_endline
        (Ochre.to_html hl ~theme:light_theme
           ~extra_themes:[ ("light", light_theme); ("dark", theme) ]
           ~lang:"test" "let x = 42"
        )
  | "themes-no-default" ->
      print_endline
        (Ochre.to_html hl
           ~extra_themes:[ ("dark", theme) ]
           ~lang:"test" "let x = 42"
        )
  | "themes-two-extras" ->
      print_endline
        (Ochre.to_html hl ~theme:light_theme
           ~extra_themes:[ ("dark", theme); ("dim", dim_theme) ]
           ~lang:"test" "let x = 42"
        )
  | "theme-css" ->
      print_endline (Ochre.html_theme_css "dim")
  | "line-numbers" ->
      let options = Ochre.Html_options.make ~line_numbers:true () in
      print_endline
        (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42\nlet y = 10")
  | "no-default-color" ->
      let options =
        Ochre.Html_options.make
          ~default_color:Ochre.Html_options.No_default_color ()
      in
      print_endline (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42")
  | "no-default-color-multi" ->
      let options =
        Ochre.Html_options.make
          ~default_color:Ochre.Html_options.No_default_color ()
      in
      print_endline
        (Ochre.to_html hl ~options ~theme:light_theme
           ~extra_themes:[ ("dark", theme) ]
           ~lang:"test" "let x = 42"
        )
  | "css-classes" ->
      let options =
        Ochre.Html_options.make
          ~style_mode:(Ochre.Html_options.Css_classes { class_prefix = "s-" })
          ()
      in
      print_endline (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42")
  | "custom-prefix" ->
      let options =
        Ochre.Html_options.make ~css_variable_prefix:"--shiki-" ()
      in
      print_endline
        (Ochre.to_html hl ~options ~theme:light_theme
           ~extra_themes:[ ("dark", theme) ]
           ~lang:"test" "let x = 42"
        )
  | "scopes-data" ->
      let options = Ochre.Html_options.make ~scopes_as_data_attrs:true () in
      print_endline (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42")
  | "pre-class" ->
      let options = Ochre.Html_options.make ~pre_class:"my-code" () in
      print_endline (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42")
  | "code-class" ->
      let options = Ochre.Html_options.make ~code_class:"language-test" () in
      print_endline (Ochre.to_html hl ~options ~theme ~lang:"test" "let x = 42")
  | "theme-css-covers-ocaml" ->
      print_class_coverage Tm_themes.all
  | "theme-css-covers-transforms" ->
      print_class_coverage
        ~transforms:
          Ochre.Transform_builtin.
            [ line_highlight [ 1; 3 ]; word_highlight [ "area"; "shapes" ] ]
        ~inline:
          [
            "font-weight:var(--ochre-font-weight,bold)";
            "background-color:var(--ochre-token-bg,#8888883a)";
          ]
        [ ("dark-plus", Tm_themes.dark_plus); ("nord", Tm_themes.nord) ]
  | "theme-css-combined-rule" ->
      let combined =
        Ochre.Theme.make ~name:"combined"
          ~colors:
            [
              ("editor.foreground", "#d4d4d4"); ("editor.background", "#1e1e1e");
            ]
          ~token_colors:
            [
              Ochre.Theme.rule ~scope:[ "comment" ] ~foreground:"#112233" ();
              Ochre.Theme.rule ~scope:[ "comment.line" ] ~font_style:[ Italic ]
                ();
            ]
          ()
      in
      let options =
        Ochre.Html_options.make
          ~style_mode:(Ochre.Html_options.Css_classes { class_prefix = "s-" })
          ()
      in
      print_endline
        (Ochre.to_html hl ~options ~theme:combined ~lang:"test" "# c");
      print_string (Ochre.html_render_theme_css ~class_prefix:"s-" combined)
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1
