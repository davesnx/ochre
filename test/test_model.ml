let grammar_json =
  {|{
  "scopeName": "source.test",
  "name": "test",
  "patterns": [
    { "match": "#.*", "name": "comment.line.test" },
    { "match": "\\b(let|if|then|else|fun)\\b", "name": "keyword.control.test" },
    { "match": "\\b[0-9]+\\b", "name": "constant.numeric.test" }
  ]
}|}

let get_ok = function
  | Ok value ->
      value
  | Error error ->
      Alcotest.fail (Ochre.Error.to_string error)

let load_theme json = fst (get_ok (Ochre.Theme.load json))

let highlighter () = get_ok (Ochre.load [ ("test", grammar_json) ])

let error_testable =
  Alcotest.testable (Fmt.of_to_string Ochre.Error.to_string) ( = )

let test_unknown_language () =
  let hl = highlighter () in
  match Ochre.lang hl "nope" with
  | Ok _ ->
      Alcotest.fail "expected Unknown_language"
  | Error error ->
      Alcotest.check error_testable "unknown language"
        (Ochre.Error.Unknown_language "nope") error

let test_known_languages () =
  let hl = highlighter () in
  List.iter
    (fun name ->
      Alcotest.(check string)
        name name
        (Ochre.Lang.name (get_ok (Ochre.lang hl name)))
    )
    [ "test"; "plaintext"; "text"; "txt" ];
  Alcotest.(check string)
    "constant" "plaintext"
    (Ochre.Lang.name Ochre.Lang.plaintext)

let check_error label expected = function
  | Ok _ ->
      Alcotest.failf "%s: expected an error" label
  | Error error ->
      Alcotest.(check bool)
        (label ^ ": " ^ Ochre.Error.to_string error)
        true (expected error)

let test_invalid_regexes () =
  let grammar body =
    Printf.sprintf {|{ "scopeName": "source.r", "patterns": [ %s ] }|} body
  in
  List.iter
    (fun (label, body) ->
      check_error label
        (function
          | Ochre.Error.Grammar_error { lang = "r"; path = None; _ } ->
              true
          | _ ->
              false
          )
        (Ochre.load [ ("r", grammar body) ])
    )
    [
      ("malformed match", {|{ "match": "(unclosed", "name": "x" }|});
      ("malformed begin", {|{ "begin": "[", "end": "x", "name": "x" }|});
      ("malformed static end", {|{ "begin": "a", "end": "(", "name": "x" }|});
    ];
  let hl =
    get_ok
      (Ochre.load
         [
           ( "r",
             grammar
               {|{ "begin": "<(\\w+)>", "end": "</\\1(>", "name": "meta.tag" }|}
           );
         ]
      )
  in
  let lang = get_ok (Ochre.lang hl "r") in
  let source = "<a>x</a>\ny\n" in
  let lines =
    (Ochre.highlight ~theme:(load_theme Tm_themes.dark_plus) ~lang source).lines
  in
  Alcotest.(check string)
    "tokens keep the source" source
    (String.concat ""
       (List.map (fun (tok : Ochre.Token.t) -> tok.text) (List.concat lines))
    );
  Alcotest.(check bool)
    "an end that is not a valid regex leaves the rule open" true
    (List.for_all
       (fun (tok : Ochre.Token.t) -> List.mem "meta.tag" tok.scopes)
       (List.nth lines 1)
    );
  ignore
    (get_ok
       (Ochre.highlight_themes
          ~theme:(load_theme Tm_themes.dark_plus)
          ~extra_themes:[ ("n", load_theme Tm_themes.nord) ]
          ~lang source
       )
    )

let write path contents =
  Out_channel.with_open_bin path (fun oc -> output_string oc contents)

let test_grammar_errors () =
  check_error "malformed grammar JSON"
    (function
      | Ochre.Error.Grammar_error { lang = "bad"; path = None; _ } ->
          true
      | _ ->
          false
      )
    (Ochre.load [ ("bad", "{not json") ]);
  check_error "duplicate id"
    (function
      | Ochre.Error.Grammar_error { lang = "dup"; path = None; _ } ->
          true
      | _ ->
          false
      )
    (Ochre.load [ ("dup", grammar_json); ("dup", grammar_json) ]);
  check_error "missing file"
    (function
      | Ochre.Error.Grammar_error
          { lang = "missing"; path = Some "missing.tmLanguage.json"; _ } ->
          true
      | _ ->
          false
      )
    (Ochre.load_from_files [ "missing.tmLanguage.json" ]);
  write "dup.tmLanguage.json" grammar_json;
  write "dup.json" grammar_json;
  check_error "duplicate id from files names the file"
    (function
      | Ochre.Error.Grammar_error { lang = "dup"; path = Some "dup.json"; _ } ->
          true
      | _ ->
          false
      )
    (Ochre.load_from_files [ "dup.tmLanguage.json"; "dup.json" ]);
  Sys.remove "dup.tmLanguage.json";
  Sys.remove "dup.json"

let test_theme_errors () =
  check_error "malformed theme JSON"
    (function Ochre.Error.Theme_error { path = None; _ } -> true | _ -> false)
    (Ochre.Theme.load "{not json");
  check_error "include without base_dir"
    (function Ochre.Error.Theme_error { path = None; _ } -> true | _ -> false)
    (Ochre.Theme.load {|{ "include": "./base.json" }|});
  List.iter
    (fun key ->
      check_error
        (key ^ " file without base_dir")
        (function
          | Ochre.Error.Theme_error { path = None; _ } -> true | _ -> false
          )
        (Ochre.Theme.load (Printf.sprintf {|{ %S: "./rules.json" }|} key))
    )
    [ "tokenColors"; "settings" ];
  write "cycle-a.json" {|{ "include": "./cycle-b.json" }|};
  write "cycle-b.json" {|{ "include": "./cycle-a.json" }|};
  check_error "include cycle"
    (function
      | Ochre.Error.Include_cycle
          [ "cycle-a.json"; "cycle-b.json"; "cycle-a.json" ] ->
          true
      | _ ->
          false
      )
    (Ochre.Theme.load_from_file "cycle-a.json");
  Sys.remove "cycle-a.json";
  Sys.remove "cycle-b.json"

let hex color = Ochre.Color.to_hex color

let test_color_of_hex () =
  List.iter
    (fun (input, expected) ->
      Alcotest.(check (option string))
        input (Some expected)
        (Option.map hex (Ochre.Color.of_hex input))
    )
    [
      ("#FFF", "#ffffff");
      ("#abc", "#aabbcc");
      ("#AbCd", "#aabbccdd");
      ("#A1B2C3", "#a1b2c3");
      ("#a1b2c3D4", "#a1b2c3d4");
      ("#A1B2C3FF", "#a1b2c3");
    ];
  List.iter
    (fun input ->
      Alcotest.(check (option string))
        input None
        (Option.map hex (Ochre.Color.of_hex input))
    )
    [
      "";
      "#";
      "fff";
      "#12";
      "#12345";
      "#1234567";
      "#123456789";
      "#ggg";
      "red";
      "rgb(1, 2, 3)";
      " #fff";
      "#fff ";
    ]

let test_color_constructors () =
  Alcotest.(check string) "rgb" "#0a141e" (hex (Ochre.Color.rgb 10 20 30));
  Alcotest.(check string)
    "rgb clips" "#ff0080"
    (hex (Ochre.Color.rgb 300 (-5) 128));
  Alcotest.(check string) "rgba" "#00000080" (hex (Ochre.Color.rgba 0 0 0 128));
  Alcotest.(check string)
    "rgba clips alpha" "#000000"
    (hex (Ochre.Color.rgba 0 0 0 999));
  Alcotest.(check string)
    "oklch white" "#ffffff"
    (hex (Ochre.Color.oklch 1. 0. 0.));
  Alcotest.(check string)
    "oklch black" "#000000"
    (hex (Ochre.Color.oklch 0. 0. 0.));
  Alcotest.(check string)
    "oklch red" "#ff0000"
    (hex (Ochre.Color.oklch 0.627955 0.257683 29.2339));
  Alcotest.(check string)
    "oklch blue-ish" "#32669a"
    (hex (Ochre.Color.oklch 0.5 0.1 250.));
  Alcotest.(check string)
    "oklch outside sRGB is clipped" "#00d600"
    (hex (Ochre.Color.oklch 0.7 0.4 150.))

let color s = Option.get (Ochre.Color.of_hex s)
let color_testable = Alcotest.testable (Fmt.of_to_string hex) Ochre.Color.equal

let test_theme_drops_invalid_colors () =
  let theme, warnings =
    get_ok
      (Ochre.Theme.load
         {|{
           "colors": { "editor.foreground": "#ABC", "editor.background": "white" },
           "tokenColors": [
             { "scope": "keyword", "settings": { "foreground": "red", "background": "#12" } },
             { "scope": "string", "settings": { "foreground": "#00FF00" } }
           ]
         }|}
      )
  in
  Alcotest.(check (list string))
    "warnings name the dropped values"
    [
      "colors.editor.background: invalid color \"white\" dropped";
      "tokenColors[0].settings.foreground: invalid color \"red\" dropped";
      "tokenColors[0].settings.background: invalid color \"#12\" dropped";
    ]
    (List.map Ochre.Theme.warning_to_string warnings);
  Alcotest.check color_testable "editor foreground" (color "#aabbcc") theme.fg;
  Alcotest.(check (list string))
    "colors keep the valid entries" [ "editor.foreground" ]
    (List.map fst theme.colors);
  match theme.token_colors with
  | [ keyword; string ] ->
      Alcotest.(check (option color_testable))
        "dropped foreground" None keyword.settings.foreground;
      Alcotest.(check (option color_testable))
        "dropped background" None keyword.settings.background;
      Alcotest.(check (option color_testable))
        "valid foreground"
        (Some (color "#00ff00"))
        string.settings.foreground
  | _ ->
      Alcotest.fail "expected two rules"

let test_theme_without_invalid_colors_has_no_warnings () =
  let _, warnings =
    get_ok
      (Ochre.Theme.load
         {|{ "tokenColors": [ { "scope": "a", "settings": { "foreground": "#fff" } } ] }|}
      )
  in
  Alcotest.(check int) "no warnings" 0 (List.length warnings)

let test_legacy_colors_fall_through () =
  let theme, warnings =
    get_ok
      (Ochre.Theme.load
         {|{ "fg": "nope", "foreground": "#123456", "bg": "#zz", "background": "#654321" }|}
      )
  in
  Alcotest.check color_testable "foreground" (color "#123456") theme.fg;
  Alcotest.check color_testable "background" (color "#654321") theme.bg;
  Alcotest.(check (list string))
    "the invalid keys are reported"
    [
      {|fg: invalid color "nope" dropped|}; {|bg: invalid color "#zz" dropped|};
    ]
    (List.map Ochre.Theme.warning_to_string warnings)

let test_legacy_colors_of_wrong_type () =
  let theme, warnings =
    get_ok
      (Ochre.Theme.load
         {|{ "fg": { "color": "#111111" }, "foreground": "#123456",
             "bg": 42, "background": null }|}
      )
  in
  Alcotest.check color_testable "foreground" (color "#123456") theme.fg;
  Alcotest.check color_testable "background falls back" (color "#ffffff")
    theme.bg;
  Alcotest.(check (list string))
    "present keys of the wrong type are reported, null is absent"
    [
      "fg: expected a string, found an object; ignored";
      "bg: expected a string, found a number; ignored";
    ]
    (List.map Ochre.Theme.warning_to_string warnings)

let test_malformed_token_color_entries () =
  let theme, warnings =
    get_ok
      (Ochre.Theme.load
         {|{ "tokenColors": [
               null,
               "comment",
               { "scope": "keyword", "settings": { "foreground": "#ff0000" } },
               3,
               [ { "scope": "string" } ]
             ] }|}
      )
  in
  Alcotest.(check (list (list string)))
    "only the object entry becomes a rule" [ [ "keyword" ] ]
    (List.map
       (fun (rule : Ochre.Theme.token_color_rule) -> rule.scope)
       theme.token_colors
    );
  Alcotest.(check (list string))
    "every non-null entry that is not an object is reported by index"
    [
      "tokenColors[1]: expected an object, found a string; ignored";
      "tokenColors[3]: expected an object, found a number; ignored";
      "tokenColors[4]: expected an object, found an array; ignored";
    ]
    (List.map Ochre.Theme.warning_to_string warnings)

let test_unused_workbench_colors () =
  let theme, warnings =
    get_ok
      (Ochre.Theme.load
         {|{ "colors": {
               "editor.foreground": "nope",
               "list.hoverBackground": "transparent",
               "statusBar.background": "#ABC" } }|}
      )
  in
  Alcotest.(check (list string))
    "only colors that ochre uses are reported"
    [ {|colors.editor.foreground: invalid color "nope" dropped|} ]
    (List.map Ochre.Theme.warning_to_string warnings);
  Alcotest.(check (list (pair string color_testable)))
    "valid colors are kept, invalid ones are dropped"
    [ ("statusBar.background", color "#aabbcc") ]
    theme.colors

let font_style_testable =
  Alcotest.testable
    (fun fmt (s : Ochre.Style.font_style) ->
      Format.fprintf fmt "{bold=%b; italic=%b; underline=%b; strikethrough=%b}"
        s.bold s.italic s.underline s.strikethrough
    )
    ( = )

let test_rule_font_style () =
  let theme, _ =
    get_ok
      (Ochre.Theme.load
         {|{ "tokenColors": [
              { "scope": "a", "settings": { "fontStyle": "bold underline" } },
              { "scope": "b", "settings": { "fontStyle": "" } },
              { "scope": "c", "settings": { "fontStyle": "none" } },
              { "scope": "d", "settings": { "foreground": "#fff" } } ] }|}
      )
  in
  Alcotest.(check (list (option font_style_testable)))
    "rule font styles"
    [
      Some { Ochre.Style.plain with bold = true; underline = true };
      Some Ochre.Style.plain;
      Some Ochre.Style.plain;
      None;
    ]
    (List.map
       (fun (rule : Ochre.Theme.token_color_rule) -> rule.settings.font_style)
       theme.token_colors
    )

let test_lang () = get_ok (Ochre.lang (highlighter ()) "test")

let tokens ?decorations ?transforms source =
  (Ochre.highlight ?decorations ?transforms
     ~theme:(load_theme Tm_themes.dark_plus)
     ~lang:(test_lang ()) source
  )
    .lines

let describe (tok : Ochre.Token.t) =
  Printf.sprintf "%S@%d:%d:%d+%d" tok.text tok.position.offset tok.position.line
    tok.position.column tok.position.length

let check_positions label expected lines =
  Alcotest.(check (list string))
    label expected
    (List.map describe (List.concat lines))

let test_token_positions () =
  check_positions "byte offset, line and byte column"
    [
      {|"let"@0:0:0+3|};
      {|" x\n"@3:0:3+3|};
      {|"if"@6:1:0+2|};
      {|" "@8:1:2+1|};
      {|"42"@9:1:3+2|};
    ]
    (tokens "let x\nif 42");
  check_positions "columns count bytes"
    [ {|"\195\169 "@0:0:0+3|}; {|"let"@3:0:3+3|} ]
    (tokens "\195\169 let")

let test_decoration_positions () =
  let decorations =
    [
      get_ok
        (Ochre.Decoration.make ~class_:"d" ~start:(Ochre.Decoration.pos 0 2)
           ~end_:(Ochre.Decoration.pos 0 4) ()
        );
    ]
  in
  check_positions "Unicode scalar range becomes byte positions"
    [ {|"\195\169 "@0:0:0+3|}; {|"le"@3:0:3+2|}; {|"t"@5:0:5+1|} ]
    (tokens ~decorations "\195\169 let")

let test_removed_text_keeps_positions () =
  let transforms = [ Ochre.Transform_builtin.notation_highlight () ] in
  check_positions "kept tokens keep their source position"
    [
      {|"let"@0:0:0+3|};
      {|" x = "@3:0:3+5|};
      {|"1"@8:0:8+1|};
      {|"\n"@22:0:22+1|};
      {|"let"@23:1:0+3|};
      {|" y"@26:1:3+2|};
    ]
    (tokens ~transforms "let x = 1 # [!code hl]\nlet y");
  let lines =
    (Ochre.highlight
       ~transforms:[ Ochre.Transform_builtin.diff_markers ]
       ~theme:(load_theme Tm_themes.dark_plus)
       ~lang:Ochre.Lang.plaintext "+add\n-del"
    )
      .lines
  in
  check_positions "a stripped marker moves the start"
    [ {|"add\n"@1:0:1+4|}; {|"del"@6:1:1+3|} ]
    lines

let test_inserted_token_position () =
  let insert =
    Ochre.Transform.make "insert" ~after_line:(fun ~line_index:_ line ->
        List.concat_map
          (fun (tok : Ochre.Token.t) ->
            if tok.text = "let" then
              [
                Ochre.Token.insert_before tok "<";
                tok;
                Ochre.Token.insert_after tok ">";
              ]
            else
              [ tok ]
          )
          line
    )
  in
  check_positions "inserted tokens have zero length at the insert point"
    [ {|"<"@0:0:0+0|}; {|"let"@0:0:0+3|}; {|">"@3:0:3+0|}; {|" x"@3:0:3+2|} ]
    (tokens ~transforms:[ insert ] "let x")

let test_sub_range () =
  let token = List.hd (List.hd (tokens "let x")) in
  Alcotest.(check (list (option string)))
    "sub gives None outside the text"
    [ Some {|"et"@1:0:1+2|}; Some {|""@3:0:3+0|}; None; None; None ]
    (List.map
       (fun (pos, len) -> Option.map describe (Ochre.Token.sub token ~pos ~len))
       [ (1, 2); (3, 0); (2, 5); (-1, 1); (0, -1) ]
    );
  Alcotest.(check (option string))
    "a huge position does not overflow" None
    (Option.map describe (Ochre.Token.sub token ~pos:max_int ~len:1))

let test_decoration_outside_lines () =
  let source = "ab\ncd\n" in
  let lines = tokens source in
  let token = List.hd (List.hd lines) in
  let decoration =
    get_ok
      (Ochre.Decoration.make ~class_:"d" ~start:(Ochre.Decoration.pos 0 0)
         ~end_:(Ochre.Decoration.pos 5 0) ()
      )
  in
  List.iter
    (fun line ->
      let moved =
        [ [ { token with position = { token.position with line } } ] ]
      in
      Alcotest.(check (list string))
        (Printf.sprintf "token on line %d is left alone" line)
        (List.map describe (List.concat moved))
        (List.map describe
           (List.concat (Ochre.Decoration.apply ~source [ decoration ] moved))
        )
    )
    [ -1; 7 ]

let theme_with ~name ~fg ~bg =
  Ochre.Theme.make ~name
    ~colors:[ ("editor.foreground", color fg); ("editor.background", color bg) ]
    ~token_colors:
      [ Ochre.Theme.rule ~scope:[ "keyword" ] ~foreground:(color fg) () ]
    ()

let light = theme_with ~name:"a" ~fg:"#111111" ~bg:"#eeeeee"
let dark = theme_with ~name:"b" ~fg:"#dddddd" ~bg:"#222222"

let two_themes ?transforms ?label ~extra_themes () =
  Ochre.highlight_themes ?transforms ?label ~theme:light ~extra_themes
    ~lang:(test_lang ()) "let x = 1\n"

let test_duplicate_labels () =
  List.iter
    (fun (label, extra_themes, duplicate) ->
      match two_themes ?label ~extra_themes () with
      | Ok _ ->
          Alcotest.failf "expected %S to be a duplicate" duplicate
      | Error error ->
          Alcotest.check error_testable duplicate
            (Ochre.Error.Duplicate_theme_label duplicate) error
    )
    [
      (None, [ ("x", dark); ("x", dark) ], "x");
      (None, [ ("a.b", dark); ("a_b", dark) ], "a_b");
      (Some "x", [ ("x", dark) ], "x");
      (None, [ ("a", dark) ], "a");
    ];
  ignore (get_ok (two_themes ~extra_themes:[ ("b", dark) ] ()))

let test_tokenize_once_and_style_per_theme () =
  let runs = ref 0 in
  let background_is_theme_fg =
    Ochre.Transform.make "per-theme"
      ~before_render:(fun doc ->
        incr runs;
        doc
      )
      ~after_line:(fun ~line_index:_ line ->
        List.map
          (Ochre.Token.map_style (fun (theme : Ochre.Theme.theme) style ->
               { style with Ochre.Style.background = Some theme.fg }
           )
          )
          line
      )
  in
  let themed =
    get_ok
      (two_themes
         ~transforms:
           [
             background_is_theme_fg;
             Ochre.Transform_builtin.line_highlight [ 0 ];
           ]
         ~extra_themes:[ ("b", dark) ]
         ()
      )
  in
  Alcotest.(check int) "transform runs once" 1 !runs;
  let first = List.hd (List.hd themed.lines) in
  Alcotest.(check (list (option color_testable)))
    "built-in transform sets one color under every theme"
    [ Some (color "#8888883a"); Some (color "#8888883a") ]
    (List.map
       (fun (style : Ochre.Style.t) -> style.background)
       (Ochre.Token.all_styles first)
    );
  let themed =
    get_ok
      (two_themes ~transforms:[ background_is_theme_fg ]
         ~extra_themes:[ ("b", dark) ]
         ()
      )
  in
  Alcotest.(check (list (option color_testable)))
    "map_style runs with each theme"
    [ Some (color "#111111"); Some (color "#dddddd") ]
    (List.map
       (fun (style : Ochre.Style.t) -> style.background)
       (Ochre.Token.all_styles (List.hd (List.hd themed.lines)))
    )

let test_split_transform_with_many_themes () =
  let split =
    Ochre.Transform.make "split" ~after_line:(fun ~line_index:_ line ->
        List.concat_map
          (fun (tok : Ochre.Token.t) ->
            let n = String.length tok.text in
            match
              ( Ochre.Token.sub tok ~pos:0 ~len:1,
                Ochre.Token.sub tok ~pos:1 ~len:(n - 1)
              )
            with
            | Some first, Some rest when n > 1 ->
                [ first; rest ]
            | _ ->
                [ tok ]
          )
          line
    )
  in
  let themed =
    get_ok (two_themes ~transforms:[ split ] ~extra_themes:[ ("b", dark) ] ())
  in
  let keyword_pieces =
    List.filter
      (fun (tok : Ochre.Token.t) -> tok.text = "l" || tok.text = "et")
      (List.concat themed.lines)
  in
  Alcotest.(check (list (pair string (list color_testable))))
    "each piece keeps the keyword style of every theme"
    [
      ("l", [ color "#111111"; color "#dddddd" ]);
      ("et", [ color "#111111"; color "#dddddd" ]);
    ]
    (List.map
       (fun (tok : Ochre.Token.t) ->
         ( tok.text,
           List.map
             (fun (style : Ochre.Style.t) -> style.foreground)
             (Ochre.Token.all_styles tok)
         )
       )
       keyword_pieces
    );
  let html = Ochre.to_html themed in
  List.iter
    (fun span ->
      let n = String.length span in
      let rec scan i =
        i + n <= String.length html
        && (String.sub html i n = span || scan (i + 1))
      in
      Alcotest.(check bool) span true (scan 0)
    )
    [
      {|<span style="color:var(--ochre,#111111);--ochre-b:#dddddd">l</span>|};
      {|<span style="color:var(--ochre,#111111);--ochre-b:#dddddd">et</span>|};
    ]

let labels (themed : Ochre.Themed.t) =
  let (label, _), extras = themed.themes in
  label :: List.map fst extras

let test_theme_labels () =
  let lang = test_lang () in
  Alcotest.(check (list string))
    "default label is the theme name" [ "a" ]
    (labels (Ochre.highlight ~theme:light ~lang "x"));
  Alcotest.(check (list string))
    "?label names the default theme" [ "x" ]
    (labels (Ochre.highlight ~label:"x" ~theme:light ~lang "x"));
  Alcotest.(check (list string))
    "default first, then the extra themes" [ "a"; "b" ]
    (labels (get_ok (two_themes ~extra_themes:[ ("b", dark) ] ())))

let test_select () =
  let lang = test_lang () in
  let source = "let x = 1\n" in
  let single theme = Ochre.highlight ~theme ~lang source in
  let themed = get_ok (two_themes ~extra_themes:[ ("b", dark) ] ()) in
  let selected = get_ok (Ochre.Themed.select "b" themed) in
  Alcotest.(check (list string))
    "the selected theme becomes the default" [ "b"; "a" ] (labels selected);
  List.iter
    (fun (name, render) ->
      Alcotest.(check string)
        (name ^ " default")
        (render (single light))
        (render themed);
      Alcotest.(check string)
        (name ^ " selected")
        (render (single dark))
        (render selected);
      Alcotest.(check string)
        (name ^ " default label")
        (render (single light))
        (render (get_ok (Ochre.Themed.select "a" themed)))
    )
    [
      ("ansi", Ochre.to_ansi); ("latex", Ochre.to_latex); ("svg", Ochre.to_svg);
    ];
  Alcotest.(check string)
    "html of the selected value"
    (Ochre.to_html
       (get_ok
          (Ochre.highlight_themes ~label:"b" ~theme:dark
             ~extra_themes:[ ("a", light) ]
             ~lang source
          )
       )
    )
    (Ochre.to_html selected);
  match Ochre.Themed.select "nope" themed with
  | Ok _ ->
      Alcotest.fail "expected Unknown_theme_label"
  | Error error ->
      Alcotest.check error_testable "unknown label"
        (Ochre.Error.Unknown_theme_label "nope") error

let test_latex_uppercase_hex () =
  let theme = theme_with ~name:"a" ~fg:"#abcdef" ~bg:"#fedcba" in
  let latex =
    Ochre.to_latex (Ochre.highlight ~theme ~lang:(test_lang ()) "let")
  in
  Alcotest.(check string)
    "xcolor HTML colors in uppercase"
    "\\begin{ochrehighlight}{FEDCBA}{ABCDEF}\n\
     \\textcolor[HTML]{ABCDEF}{let}\n\
     \\end{ochrehighlight}"
    latex

let test_foreign_token () =
  let lang = test_lang () in
  let foreign =
    List.hd
      (List.hd
         (Ochre.highlight ~theme:(load_theme Tm_themes.nord) ~lang "x").lines
      )
  in
  let append =
    Ochre.Transform.make "append-foreign" ~after_render:(fun doc ->
        doc @ [ [ foreign ] ]
    )
  in
  match
    Ochre.highlight_themes ~transforms:[ append ]
      ~theme:(load_theme Tm_themes.light_plus)
      ~extra_themes:[ ("dark", load_theme Tm_themes.nord) ]
      ~lang "let x\n"
  with
  | Ok themed ->
      Alcotest.failf "expected an error, rendered %d bytes"
        (String.length (Ochre.to_html themed))
  | Error error ->
      Alcotest.check error_testable "names the transform"
        (Ochre.Error.Foreign_token { transform = "append-foreign" })
        error

let formerly_builtin =
  [
    "dark-plus";
    "light-plus";
    "tokyo-night";
    "everforest-dark";
    "ayu-dark";
    "catppuccin-mocha";
    "catppuccin-macchiato";
    "gruvbox-dark-medium";
    "kanagawa-wave";
    "nord";
    "one-dark-pro";
  ]

let test_tm_themes_load () =
  List.iter
    (fun (name, json) ->
      let _, warnings = get_ok (Ochre.Theme.load json) in
      if List.mem name formerly_builtin then
        Alcotest.(check (list string))
          (name ^ " has no warnings")
          []
          (List.map Ochre.Theme.warning_to_string warnings)
    )
    Tm_themes.all;
  Alcotest.(check (list string))
    "every formerly built-in theme is in tm-themes" formerly_builtin
    (List.filter
       (fun name -> List.mem name Tm_themes.available)
       formerly_builtin
    )

let () =
  Alcotest.run "Ochre model"
    [
      ( "errors",
        [
          Alcotest.test_case "Unknown language is an error" `Quick
            test_unknown_language;
          Alcotest.test_case "Known and plaintext languages resolve" `Quick
            test_known_languages;
          Alcotest.test_case "Grammar load errors" `Quick test_grammar_errors;
          Alcotest.test_case "Invalid regexes fail at load, never at highlight"
            `Quick test_invalid_regexes;
          Alcotest.test_case "Theme load errors" `Quick test_theme_errors;
        ]
      );
      ( "color",
        [
          Alcotest.test_case "Hex parsing" `Quick test_color_of_hex;
          Alcotest.test_case "Constructors convert and clip" `Quick
            test_color_constructors;
        ]
      );
      ( "theme",
        [
          Alcotest.test_case "Invalid colors are dropped with warnings" `Quick
            test_theme_drops_invalid_colors;
          Alcotest.test_case "Valid themes have no warnings" `Quick
            test_theme_without_invalid_colors_has_no_warnings;
          Alcotest.test_case "Default colors of the wrong type are reported"
            `Quick test_legacy_colors_of_wrong_type;
          Alcotest.test_case "Malformed tokenColors entries are reported" `Quick
            test_malformed_token_color_entries;
          Alcotest.test_case "Rule font styles" `Quick test_rule_font_style;
          Alcotest.test_case "Legacy colors use the first valid key" `Quick
            test_legacy_colors_fall_through;
          Alcotest.test_case "Unused workbench colors are not reported" `Quick
            test_unused_workbench_colors;
          Alcotest.test_case
            "tm-themes themes load; former built-ins without warnings" `Quick
            test_tm_themes_load;
        ]
      );
      ( "positions",
        [
          Alcotest.test_case "Token positions" `Quick test_token_positions;
          Alcotest.test_case "Decorations convert scalars to bytes" `Quick
            test_decoration_positions;
          Alcotest.test_case "Removed text keeps positions" `Quick
            test_removed_text_keeps_positions;
          Alcotest.test_case "Inserted tokens have zero length" `Quick
            test_inserted_token_position;
          Alcotest.test_case "sub checks its range" `Quick test_sub_range;
          Alcotest.test_case "Decorations skip tokens outside the lines" `Quick
            test_decoration_outside_lines;
        ]
      );
      ( "themed",
        [
          Alcotest.test_case "Duplicate labels are rejected" `Quick
            test_duplicate_labels;
          Alcotest.test_case "Tokenize once, style per theme" `Quick
            test_tokenize_once_and_style_per_theme;
          Alcotest.test_case "Splitting transforms work with many themes" `Quick
            test_split_transform_with_many_themes;
          Alcotest.test_case "The default theme carries its label" `Quick
            test_theme_labels;
          Alcotest.test_case "select makes a theme the default" `Quick
            test_select;
          Alcotest.test_case "A token from another value is an error" `Quick
            test_foreign_token;
          Alcotest.test_case "LaTeX writes uppercase hex" `Quick
            test_latex_uppercase_hex;
        ]
      );
    ]
