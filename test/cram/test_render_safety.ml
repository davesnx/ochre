let grammar_json =
  {|{
  "scopeName": "source.test",
  "name": "test",
  "patterns": [
    { "match": "#.*", "name": "comment.line.test" },
    { "match": "\\b(let|if|then|else|fun)\\b", "name": "keyword.control.test" },
    { "match": "\"[^\"]*\"", "name": "string.quoted.double.test" }
  ]
}|}

let json_string s =
  let buf = Buffer.create (String.length s + 2) in
  Buffer.add_char buf '"';
  String.iter
    (function
      | '"' ->
          Buffer.add_string buf "\\\""
      | '\\' ->
          Buffer.add_string buf "\\\\"
      | c ->
          Buffer.add_char buf c
      )
    s;
  Buffer.add_char buf '"';
  Buffer.contents buf

let make_theme ?(name = "t") ?(fg = "#d4d4d4") ?(bg = "#1e1e1e")
    ?(keyword = "#ff0000") ?keyword_bg ?(string_ = "#00ff00") ?string_bg () =
  let keyword_settings =
    Printf.sprintf {|"foreground": %s%s|} (json_string keyword)
      ( match keyword_bg with
      | Some b ->
          Printf.sprintf {|, "background": %s|} (json_string b)
      | None ->
          ""
      )
  in
  let string_settings =
    Printf.sprintf {|"foreground": %s%s|} (json_string string_)
      ( match string_bg with
      | Some b ->
          Printf.sprintf {|, "background": %s|} (json_string b)
      | None ->
          ""
      )
  in
  Ochre.Theme.load_exn
    (Printf.sprintf
       {|{ "name": %s,
  "colors": { "editor.foreground": %s, "editor.background": %s },
  "tokenColors": [
    { "scope": "keyword", "settings": { %s } },
    { "scope": "string", "settings": { %s } }
  ] }|}
       (json_string name) (json_string fg) (json_string bg) keyword_settings
       string_settings
    )

let hl () =
  let path = "test.tmLanguage.json" in
  let oc = open_out path in
  output_string oc grammar_json;
  close_out oc;
  let hl = Ochre.load_from_files_exn [ path ] in
  Sys.remove path;
  hl

let class_names ~prefix html =
  let n = String.length prefix in
  let rec go i acc =
    if i + n > String.length html then
      List.rev acc
    else if String.sub html i n = prefix && html.[i - 1] = '"' then
      let j = String.index_from html i '"' in
      go j (String.sub html i (j - i) :: acc)
    else
      go (i + 1) acc
  in
  List.sort_uniq compare (go 1 [])

let no_forbidden_xml_bytes s =
  String.for_all
    (fun c ->
      let n = Char.code c in
      n >= 0x20 || c = '\t' || c = '\n' || c = '\r'
    )
    s

let escaped f s = String.escaped (Ochre__Escape.to_string f s)

let escape_case = function
  | "escape-html-invalid-utf8" ->
      print_endline
        (escaped Ochre__Escape.html
           "a\xe9b\xc3(c\xf0\x9f\x98d\x00e<f>&\xe2\x82\xac"
        );
      print_endline (escaped Ochre__Escape.html "caf\xc3\xa9 \xf0\x9f\x98\x80")
  | "escape-xml" ->
      print_endline
        (escaped Ochre__Escape.xml
           "\x01\x08\x0b\x0c\x0e\x1f\t\n\
            \r\xef\xbf\xbe\xef\xbf\xbf\xe9<&\"'>\xef\xbf\xbd\xf0\x9f\x98\x80"
        )
  | "escape-css-ident" ->
      let once = Ochre__Escape.css_ident "a b;}\"<x>-_9\xc3\xa9" in
      print_endline once;
      Printf.printf "idempotent: %b\n" (Ochre__Escape.css_ident once = once)
  | "escape-css-color" ->
      List.iter
        (fun c ->
          Printf.printf "%-34s %s\n" (String.escaped c)
            ( match Ochre__Escape.css_color c with
            | Some c ->
                "accepted"
            | None ->
                "rejected"
            )
        )
        [
          "#fff";
          "#FFFF";
          "#1e1e1e";
          "#1e1e1eff";
          "#1e1e1";
          "#ggg";
          "red";
          "rebeccapurple";
          "rgb(1, 2, 3)";
          "RGB(1 2 3 / 50%)";
          "hsl(10deg 20% 30%)";
          "oklch(0.5 0.1 200)";
          "url(x)";
          "var(--x)";
          "red;";
          "red}";
          "\"><b>";
          "red\n";
          "#fff;color:red";
          "rgb(1,2,3));x";
          "rgb(1,2,3)x";
          "rgb(a;b)";
          "";
          "#";
        ]
  | s ->
      Printf.eprintf "unknown: %s\n" s;
      exit 1

let () =
  if String.starts_with ~prefix:"escape-" Sys.argv.(1) then
    escape_case Sys.argv.(1)
  else
    let hl = hl () in
    let theme = make_theme () in
    let dark = make_theme ~name:"dark" () in
    match Sys.argv.(1) with
    | "html-theme-name" ->
        let evil = make_theme ~name:{|"><img src=x onerror=alert(1)>|} () in
        print_endline
          (Ochre.to_html hl ~theme:evil
             ~extra_themes:[ ("dark", dark) ]
             ~lang:"test" "let x"
          )
    | "html-extra-theme-name" ->
        let evil = make_theme ~name:{|"><img src=x onerror=alert(1)>|} () in
        print_endline
          (Ochre.to_html hl ~theme
             ~extra_themes:[ ("dark", evil) ]
             ~lang:"test" "let x"
          )
    | "html-colors" ->
        let evil =
          make_theme ~name:"evil" ~fg:{|"><b>|} ~bg:{|red;}</style><script>|}
            ~keyword:{|"><i>|} ~keyword_bg:{|url(javascript:alert(1))|}
            ~string_:{|#00ff00;position:fixed|} ()
        in
        print_endline (Ochre.to_html hl ~theme:evil ~lang:"test" {|let x = "s"|});
        print_endline
          (Ochre.to_html hl ~theme
             ~extra_themes:[ ("dark", evil) ]
             ~lang:"test" {|let x = "s"|}
          )
    | "html-valid-colors" ->
        let t =
          make_theme ~name:"ok" ~fg:"rgb(1, 2, 3)" ~bg:"hsl(10 20% 30% / 0.5)"
            ~keyword:"tomato" ~string_:"#0f08" ()
        in
        print_endline (Ochre.to_html hl ~theme:t ~lang:"test" {|let x = "s"|})
    | "html-options" ->
        let options =
          Ochre.Html_options.make ~pre_class:{|a"><u>|} ~code_class:{|b"><s>|}
            ~css_variable_prefix:{|--x;}</style>|} ()
        in
        print_endline
          (Ochre.to_html hl ~options ~theme
             ~extra_themes:[ ("d\"><i>;}", dark) ]
             ~lang:"test" "let x"
          )
    | "html-class-prefix" ->
        let options =
          Ochre.Html_options.make
            ~style_mode:
              (Ochre.Html_options.Css_classes { class_prefix = {|a"><b>{}|} })
            ()
        in
        let html = Ochre.to_html hl ~options ~theme ~lang:"test" "let x" in
        print_endline html;
        let tokens = Ochre.to_tokens hl ~theme ~lang:"test" "let x" in
        print_endline
          (Ochre.html_render_theme_css ~class_prefix:{|a"><b>{}|} theme tokens)
    | "css-classes-prefix-start" ->
        List.iter
          (fun class_prefix ->
            let options =
              Ochre.Html_options.make
                ~style_mode:(Ochre.Html_options.Css_classes { class_prefix })
                ()
            in
            let html = Ochre.to_html hl ~options ~theme ~lang:"test" "let" in
            let tokens = Ochre.to_tokens hl ~theme ~lang:"test" "let" in
            let css = Ochre.html_render_theme_css ~class_prefix theme tokens in
            Printf.printf "prefix %S\n" class_prefix;
            List.iter
              (fun line ->
                if String.starts_with ~prefix:"." line then
                  print_endline (String.sub line 0 (String.index line ' '))
              )
              (String.split_on_char '\n' css);
            let marker = "<span class=\"" in
            let n = String.length marker in
            let rec scan i =
              if i + n <= String.length html then
                if String.sub html i n = marker then (
                  let j = i + n in
                  let k = String.index_from html j '"' in
                  let c = String.sub html j (k - j) in
                  if c <> "line" then print_endline ("class " ^ c);
                  scan k
                ) else
                  scan (i + 1)
            in
            scan 0
          )
          [ ""; "1"; "-"; "ochre-" ]
    | "svg-decoration-whitespace" ->
        let decorations =
          [
            Ochre.Decoration.make ~class_:"a\tb\nc" ~style:"x:1;\ty:2\r\nz:3"
              ~start:(Ochre.Decoration.pos 0 0) ~end_:(Ochre.Decoration.pos 0 3)
              ();
          ]
        in
        let svg = Ochre.to_svg hl ~decorations ~theme ~lang:"test" "let" in
        print_endline (String.escaped svg |> fun s -> s)
    | "theme-css-label" ->
        print_endline (Ochre.html_theme_css {|dark;}</style><script>|})
    | "theme-css-colors" ->
        let evil = make_theme ~fg:"red;}" ~bg:{|"><b>|} () in
        let tokens = Ochre.to_tokens hl ~theme:evil ~lang:"test" "let x" in
        print_endline
          (Ochre.html_render_theme_css ~class_prefix:"c-" evil tokens)
    | "svg-colors" ->
        let evil =
          make_theme ~name:"evil" ~bg:{|"><b>|} ~keyword:{|"/><script>|}
            ~string_:{|#00ff00" onload="x|} ()
        in
        print_endline (Ochre.to_svg hl ~theme:evil ~lang:"test" {|let x = "s"|})
    | "svg-control-chars" ->
        let svg =
          Ochre.to_svg hl ~theme ~lang:"test"
            "# a\x01b\x08c\x0bd\x0ce\x0ef\x1bg\x1fh\ti\r\n"
        in
        print_endline (String.escaped svg);
        Printf.printf "no forbidden control characters: %b\n"
          (no_forbidden_xml_bytes svg)
    | "ansi-control-chars" ->
        let ansi =
          Ochre.to_ansi hl ~theme ~lang:"plaintext"
            "a\x1b[2Jb\x07c\x7fd\te\rf\r\ng\xc2\x9bh\n"
        in
        print_endline (String.escaped ansi)
    | "css-classes-decoration-style" ->
        let options =
          Ochre.Html_options.make
            ~style_mode:(Ochre.Html_options.Css_classes { class_prefix = "c-" })
            ()
        in
        let decorations =
          [
            Ochre.Decoration.make ~style:"border-bottom:2px solid red"
              ~class_:"focus" ~start:(Ochre.Decoration.pos 0 4)
              ~end_:(Ochre.Decoration.pos 0 5) ();
          ]
        in
        print_endline
          (Ochre.to_html hl ~options ~decorations ~theme ~lang:"test" "let x")
    | "css-classes-collision" ->
        (* The 31-bit DJB2 class naming gave one class to the keyword style
         (background b6e40d, foreground 3e9765) and to the string style
         (background 9f019e, foreground a851b9). *)
        let options =
          Ochre.Html_options.make
            ~style_mode:(Ochre.Html_options.Css_classes { class_prefix = "c-" })
            ()
        in
        let t =
          make_theme ~keyword:"#3e9765" ~keyword_bg:"#b6e40d" ~string_:"#a851b9"
            ~string_bg:"#9f019e" ()
        in
        let source = {|let "s"|} in
        let html = Ochre.to_html hl ~options ~theme:t ~lang:"test" source in
        let tokens = Ochre.to_tokens hl ~theme:t ~lang:"test" source in
        let css = Ochre.html_render_theme_css ~class_prefix:"c-" t tokens in
        let used = class_names ~prefix:"c-" html in
        let defined =
          List.filter_map
            (fun line ->
              if String.starts_with ~prefix:".c-" line then
                Some (String.sub line 1 (String.index line ' ' - 1))
              else
                None
            )
            (String.split_on_char '\n' css)
        in
        Printf.printf "distinct classes in html: %d\n" (List.length used);
        Printf.printf "every class defined in the stylesheet: %b\n"
          (List.for_all (fun c -> List.mem c defined) used)
    | s ->
        Printf.eprintf "unknown: %s\n" s;
        exit 1
