let grammar_json =
  {|{
  "scopeName": "source.test",
  "name": "test",
  "patterns": [
    { "match": "#.*", "name": "comment.line.test" },
    { "match": "\\b(let|if|then|else|fun)\\b", "name": "keyword.control.test" }
  ]
}|}

let get_ok = function
  | Ok value ->
      value
  | Error error ->
      Alcotest.fail (Ochre.Error.to_string error)

let lang () =
  get_ok (Ochre.lang (get_ok (Ochre.load [ ("test", grammar_json) ])) "test")
let color s = Option.get (Ochre.Color.of_hex s)

let theme ~name ~fg ~bg ~keyword =
  Ochre.Theme.make ~name
    ~colors:[ ("editor.foreground", color fg); ("editor.background", color bg) ]
    ~token_colors:
      [ Ochre.Theme.rule ~scope:[ "keyword" ] ~foreground:(color keyword) () ]
    ()

let light = theme ~name:"l" ~fg:"#111111" ~bg:"#eeeeee" ~keyword:"#aa0000"
let dark = theme ~name:"d" ~fg:"#dddddd" ~bg:"#222222" ~keyword:"#ff8888"

let test_page_embeds_to_jsx () =
  let themed = Ochre.highlight ~theme:light ~lang:(lang ()) "let x" in
  let page =
    JSX.node "main" [ ("id", `String "doc") ] [ Ochre.to_jsx themed ]
  in
  Alcotest.(check string)
    "page"
    {|<main id="doc"><pre class="ochre" style="background-color:var(--ochre-bg,#eeeeee);color:var(--ochre,#111111)" tabindex="0"><code><span class="line"><span style="color:var(--ochre,#aa0000)">let</span><span style="color:var(--ochre,#111111)"> x</span></span></code></pre></main>|}
    (JSX.render page);
  Alcotest.(check string)
    "to_html renders to_jsx"
    (JSX.render (Ochre.to_jsx themed))
    (Ochre.to_html themed)

let contains ~sub s =
  let n = String.length sub in
  let rec scan i =
    i + n <= String.length s && (String.sub s i n = sub || scan (i + 1))
  in
  scan 0

let occurrences ~sub s =
  let n = String.length sub in
  let rec scan i count =
    if i + n > String.length s then
      count
    else if String.sub s i n = sub then
      scan (i + n) (count + 1)
    else
      scan (i + 1) count
  in
  scan 0 0

let check_contains label ~sub s =
  if not (contains ~sub s) then Alcotest.failf "%s: %S not in %S" label sub s

let check_absent label ~sub s =
  if contains ~sub s then Alcotest.failf "%s: %S in %S" label sub s

let themes ?options ~label ~theme extra_themes =
  Ochre.to_html ?options
    (get_ok
       (Ochre.highlight_themes ~label ~theme ~extra_themes ~lang:(lang ())
          "let x"
       )
    )

let light_dark_html =
  {|<pre class="ochre ochre-themes l d" style="background-color:light-dark(#eeeeee,#222222);color:light-dark(#111111,#dddddd)" tabindex="0"><code><span class="line"><span style="color:light-dark(#aa0000,#ff8888)">let</span><span style="color:light-dark(#111111,#dddddd)"> x</span></span></code></pre>|}

let test_light_dark () =
  Alcotest.(check string)
    "light default" light_dark_html
    (themes ~label:"light" ~theme:light [ ("dark", dark) ]);
  Alcotest.(check string)
    "no default color" light_dark_html
    (themes
       ~options:(Ochre.Html_options.make ~default_color:No_default_color ())
       ~label:"light" ~theme:light
       [ ("dark", dark) ]
    );
  Alcotest.(check string)
    "dark default"
    {|<pre class="ochre ochre-themes d l" style="background-color:light-dark(#eeeeee,#222222);color:light-dark(#111111,#dddddd)" tabindex="0"><code><span class="line"><span style="color:light-dark(#aa0000,#ff8888)">let</span><span style="color:light-dark(#111111,#dddddd)"> x</span></span></code></pre>|}
    (themes ~label:"dark" ~theme:dark [ ("light", light) ])

let test_light_dark_css_classes () =
  let options =
    Ochre.Html_options.make ~style_mode:(Css_classes { class_prefix = "c-" }) ()
  in
  let themed =
    get_ok
      (Ochre.highlight_themes ~label:"light" ~theme:light
         ~extra_themes:[ ("dark", dark) ]
         ~lang:(lang ()) "let x"
      )
  in
  let html = Ochre.to_html ~options themed in
  let css = Ochre.html_render_theme_css ~class_prefix:"c-" themed in
  check_contains "pre colors" html
    ~sub:
      {|style="background-color:light-dark(#eeeeee,#222222);color:light-dark(#111111,#dddddd)"|};
  check_absent "no variables" html ~sub:"var(";
  check_absent "no inline token style" html ~sub:"<span style=";
  check_contains "page colors" css
    ~sub:
      ".ochre { background-color:light-dark(#eeeeee,#222222); \
       color:light-dark(#111111,#dddddd) }";
  check_contains "keyword class" css
    ~sub:"{ color:light-dark(#aa0000,#ff8888) }";
  check_absent "no variables in css" css ~sub:"var("

let test_three_themes_use_variables () =
  let contrast =
    theme ~name:"h" ~fg:"#000000" ~bg:"#ffffff" ~keyword:"#0000ff"
  in
  Alcotest.(check string)
    "variables"
    {|<pre class="ochre ochre-themes l d h" style="background-color:var(--ochre-bg,#eeeeee);color:var(--ochre,#111111);--ochre-dark-bg:#222222;--ochre-dark:#dddddd;--ochre-hc-bg:#ffffff;--ochre-hc:#000000" tabindex="0"><code><span class="line"><span style="color:var(--ochre,#aa0000);--ochre-dark:#ff8888;--ochre-hc:#0000ff">let</span><span style="color:var(--ochre,#111111);--ochre-dark:#dddddd;--ochre-hc:#000000"> x</span></span></code></pre>|}
    (themes ~label:"light" ~theme:light [ ("dark", dark); ("hc", contrast) ])

let attr name value attrs = attrs @ [ (name, `String value) ]

let test_user_hooks () =
  let note = {|a"<b>&'|} in
  let marker =
    Ochre.Transform.make "marker" ~attributes:(fun doc ->
        let lines = string_of_int (List.length doc) in
        {
          pre = Some (fun _ -> attr "data-lines" lines);
          line =
            Some
              (fun ~line_index line ->
                attr "data-note"
                  (Printf.sprintf "%s%d:%d" note line_index (List.length line))
              );
          span =
            Some
              (fun ~line_index ~column:_ (token : Ochre.Token.t) ->
                attr "data-token"
                  (Printf.sprintf "%d%s" line_index (String.trim token.text))
              );
        }
    )
  in
  let second =
    Ochre.Transform.make "second" ~attributes:(fun _ ->
        {
          pre = Some (fun _ -> attr "data-second" "2");
          line = None;
          span = None;
        }
    )
  in
  let themed =
    Ochre.highlight ~transforms:[ marker; second ] ~theme:light ~lang:(lang ())
      "let x\nfun"
  in
  Alcotest.(check string)
    "hooks in list order, values escaped"
    ({|<pre class="ochre" style="background-color:var(--ochre-bg,#eeeeee);color:var(--ochre,#111111)" tabindex="0" data-lines="2" data-second="2"><code><span class="line" data-note="a&quot;&lt;b&gt;&amp;&apos;0:2"><span style="color:var(--ochre,#aa0000)" data-token="0let">let</span><span style="color:var(--ochre,#111111)" data-token="0x"> x|}
   ^ "\n"
   ^ {|</span></span><span class="line" data-note="a&quot;&lt;b&gt;&amp;&apos;1:1"><span style="color:var(--ochre,#aa0000)" data-token="1fun">fun</span></span></code></pre>|}
    )
    (Ochre.to_html themed)

let render transforms source =
  Ochre.to_html (Ochre.highlight ~transforms ~theme:light ~lang:(lang ()) source)

let check_fragments label html fragments =
  List.iter (fun sub -> check_contains label ~sub html) fragments

let test_line_highlight_classes () =
  let html =
    render [ Ochre.Transform_builtin.line_highlight [ 1 ] ] "let a\nlet b"
  in
  check_fragments "line_highlight" html
    [
      {|<pre class="ochre has-highlighted" style=|};
      {|<code><span class="line"><span|};
      {|</span><span class="line highlighted"><span|};
    ];
  check_absent "no mark" ~sub:"highlighted"
    (render [ Ochre.Transform_builtin.line_highlight [ 5 ] ] "let a")

let test_diff_markers_classes () =
  let html =
    render [ Ochre.Transform_builtin.diff_markers ] "+let a\n-let b\nlet c"
  in
  check_fragments "diff_markers" html
    [
      {|<pre class="ochre has-diff" style=|};
      {|<code><span class="line diff add">|};
      {|</span><span class="line diff remove">|};
      {|</span><span class="line"><span|};
    ];
  check_absent "no diff" ~sub:"diff"
    (render [ Ochre.Transform_builtin.diff_markers ] "let a")

let test_word_highlight_classes () =
  let html =
    render [ Ochre.Transform_builtin.word_highlight [ "let" ] ] "let x"
  in
  check_contains "word" html ~sub:{|class="highlighted-word">let</span>|};
  check_absent "other token" html ~sub:{|class="highlighted-word"> x|}

let test_scope_marker_classes () =
  let html =
    render [ Ochre.Transform_builtin.scope_marker "keyword" ] "let x"
  in
  check_contains "keyword" html ~sub:{|class="highlighted-scope">let</span>|};
  check_absent "other token" html ~sub:{|class="highlighted-scope"> x|}

let line_classes html =
  let opening = {|<span class="line|} in
  let n = String.length opening in
  let rec scan i acc =
    if i + n > String.length html then
      List.rev acc
    else if String.sub html i n = opening then
      let stop = String.index_from html (i + n) '"' in
      scan stop (("line" ^ String.sub html (i + n) (stop - i - n)) :: acc)
    else
      scan (i + 1) acc
  in
  scan 0 []

let pre_class html =
  let start = String.length {|<pre class="|} in
  String.sub html start (String.index_from html start '"' - start)

let check_lines label ~pre ~lines html =
  Alcotest.(check string) (label ^ " pre") pre (pre_class html);
  Alcotest.(check (list string)) (label ^ " lines") lines (line_classes html)

let test_notation_highlight_classes () =
  check_lines "notation_highlight" ~pre:"ochre has-highlighted"
    ~lines:
      [ "line highlighted"; "line highlighted"; "line highlighted"; "line" ]
    (render
       [ Ochre.Transform_builtin.notation_highlight () ]
       "# [!code highlight]\nlet a\nlet b # [!code hl:2]\nlet c\nlet d"
    )

let test_notation_diff_classes () =
  check_lines "notation_diff" ~pre:"ochre has-diff"
    ~lines:[ "line diff add"; "line diff remove"; "line" ]
    (render
       [ Ochre.Transform_builtin.notation_diff () ]
       "let a # [!code ++]\n# [!code --]\nlet b\nlet c"
    )

let test_notation_word_highlight_classes () =
  let html =
    render
      [ Ochre.Transform_builtin.notation_word_highlight () ]
      "# [!code word:et]\nlet a\nlet b"
  in
  Alcotest.(check (list string)) "lines" [ "line"; "line" ] (line_classes html);
  Alcotest.(check string) "pre" "ochre" (pre_class html);
  Alcotest.(check int)
    "each line marks its piece" 2
    (occurrences ~sub:{|class="highlighted-word">et</span>|} html);
  Alcotest.(check int)
    "only those pieces" 2
    (occurrences ~sub:"highlighted-word" html)

let test_notation_combined () =
  let highlight = Ochre.Transform_builtin.notation_highlight () in
  let diff = Ochre.Transform_builtin.notation_diff () in
  check_lines "highlight then diff, same line"
    ~pre:"ochre has-highlighted has-diff"
    ~lines:[ "line highlighted diff add"; "line" ]
    (render [ highlight; diff ] "let a # [!code highlight] [!code ++]\nlet b");
  check_lines "diff sees the lines that highlight removed before it"
    ~pre:"ochre has-highlighted has-diff"
    ~lines:[ "line highlighted"; "line diff add" ]
    (render [ highlight; diff ] "# [!code highlight]\nlet a\nlet b # [!code ++]");
  check_lines "a later deletion leaves the earlier indices stale"
    ~pre:"ochre has-highlighted"
    ~lines:[ "line highlighted"; "line" ]
    (render [ diff; highlight ] "# [!code highlight]\nlet a\nlet b # [!code ++]")

let classes_with_prefix prefix html =
  let opening = {|class="|} in
  let n = String.length opening in
  let rec scan i acc =
    match String.index_from_opt html i 'c' with
    | None ->
        acc
    | Some i when i + n <= String.length html && String.sub html i n = opening
      ->
        let stop = String.index_from html (i + n) '"' in
        let names =
          List.filter
            (String.starts_with ~prefix)
            (String.split_on_char ' ' (String.sub html (i + n) (stop - i - n)))
        in
        scan stop (names @ acc)
    | Some i ->
        scan (i + 1) acc
  in
  List.sort_uniq compare (scan 0 [])

let test_css_classes_have_rules () =
  let bold_light =
    Ochre.Theme.make ~name:"l"
      ~colors:
        [
          ("editor.foreground", color "#111111");
          ("editor.background", color "#eeeeee");
        ]
      ~token_colors:
        [
          Ochre.Theme.rule ~scope:[ "keyword" ] ~foreground:(color "#aa0000")
            ~font_style:{ Ochre.Style.plain with bold = true }
            ();
        ]
      ()
  in
  let themed =
    get_ok
      (Ochre.highlight_themes ~label:"light" ~theme:bold_light
         ~extra_themes:[ ("dark", dark) ]
         ~lang:(lang ()) "let x"
      )
  in
  let css = Ochre.html_render_theme_css ~class_prefix:"c-" themed in
  List.iter
    (fun default_color ->
      let html =
        Ochre.to_html
          ~options:
            (Ochre.Html_options.make
               ~style_mode:(Css_classes { class_prefix = "c-" })
               ~default_color ()
            )
          themed
      in
      let used = classes_with_prefix "c-" html in
      Alcotest.(check bool) "classes are used" true (used <> []);
      List.iter
        (fun name ->
          check_contains "rule for class" css ~sub:("." ^ name ^ " {")
        )
        used
    )
    [ Ochre.Html_options.No_default_color; Default_color ]

let test_word_marks_inserted_text () =
  let insert =
    Ochre.Transform.make "insert" ~before_render:(fun doc ->
        List.mapi
          (fun index line ->
            match line with
            | first :: _ when index = 1 ->
                Ochre.Token.insert_before first "x + x " :: line
            | line ->
                line
          )
          doc
    )
  in
  let html =
    render
      [ insert; Ochre.Transform_builtin.notation_word_highlight () ]
      "# [!code word:x]\nlet a"
  in
  Alcotest.(check int)
    "the two x pieces" 2
    (occurrences ~sub:{|class="highlighted-word">x</span>|} html);
  Alcotest.(check int)
    "nothing else" 2
    (occurrences ~sub:"highlighted-word" html)

let test_bad_attribute_name () =
  let evil =
    Ochre.Transform.make "evil" ~attributes:(fun _ ->
        {
          pre = Some (fun _ -> attr "x onmouseover=alert(1) y" "");
          line = Some (fun ~line_index:_ _ -> attr "1bad" "v");
          span = Some (fun ~line_index:_ ~column:_ _ -> attr "" "v");
        }
    )
  in
  let html = render [ evil ] "let" in
  check_absent "no injected attribute" html ~sub:"onmouseover=";
  check_contains "pre" html ~sub:{| x_onmouseover_alert_1__y="">|};
  check_contains "line" html ~sub:{|<span class="line" _bad="v">|};
  check_contains "span" html ~sub:{| _="v">let</span>|}

let test_pre_class_follows_rendered_lines () =
  let drop_last =
    Ochre.Transform.make "drop-last" ~after_render:(fun doc ->
        List.filteri (fun i _ -> i < List.length doc - 1) doc
    )
  in
  let html =
    render
      [ Ochre.Transform_builtin.line_highlight [ 1 ]; drop_last ]
      "let a\nlet b"
  in
  Alcotest.(check string) "pre" "ochre" (pre_class html);
  Alcotest.(check (list string)) "lines" [ "line" ] (line_classes html)

let test_classes_not_repeated () =
  let html =
    render
      [
        Ochre.Transform_builtin.line_highlight [ 0 ];
        Ochre.Transform_builtin.line_highlight [ 0 ];
      ]
      "let a"
  in
  Alcotest.(check string) "pre" "ochre has-highlighted" (pre_class html);
  Alcotest.(check (list string))
    "lines" [ "line highlighted" ] (line_classes html)

let bold_theme name =
  Ochre.Theme.make ~name
    ~colors:
      [
        ("editor.foreground", color "#111111");
        ("editor.background", color "#eeeeee");
      ]
    ~token_colors:
      [
        Ochre.Theme.rule ~scope:[ "keyword" ] ~foreground:(color "#aa0000")
          ~font_style:{ Ochre.Style.plain with bold = true }
          ();
      ]
    ()

let test_light_dark_no_default_font () =
  let themed =
    get_ok
      (Ochre.highlight_themes ~label:"light" ~theme:(bold_theme "l")
         ~extra_themes:[ ("dark", bold_theme "d") ]
         ~lang:(lang ()) "let x"
      )
  in
  let html default_color =
    Ochre.to_html ~options:(Ochre.Html_options.make ~default_color ()) themed
  in
  check_contains "bold without extra CSS" (html No_default_color)
    ~sub:"font-weight:var(--ochre-font-weight,bold)";
  Alcotest.(check string)
    "same as with a default color" (html Default_color) (html No_default_color)

let span_with_class ~cls html =
  let marker = {|class="|} ^ cls ^ {|">|} in
  let rec find i =
    if i + String.length marker > String.length html then
      None
    else if String.sub html i (String.length marker) = marker then
      Some i
    else
      find (i + 1)
  in
  Option.map
    (fun stop ->
      let start =
        let rec back i =
          if String.sub html i 5 = "<span" then
            i
          else
            back (i - 1)
        in
        back stop
      in
      String.sub html start (stop - start)
    )
    (find 0)

let test_crlf_class_and_color_agree () =
  let html =
    render [ Ochre.Transform_builtin.word_highlight [ "# x" ] ] "# x\r\nlet"
  in
  match span_with_class ~cls:"highlighted-word" html with
  | None ->
      check_absent "no color without the class" html ~sub:"#ffff00"
  | Some span ->
      check_contains "the marked span has the word color" span ~sub:"#ffff00"

let test_scope_marker_crlf () =
  let html =
    render [ Ochre.Transform_builtin.scope_marker "comment" ] "# x\r\nlet"
  in
  match span_with_class ~cls:"highlighted-scope" html with
  | None ->
      Alcotest.fail "no marked span"
  | Some span ->
      check_contains "the marked span has the background" span ~sub:"#ffff0033"

let replace_class value attrs =
  List.map
    (fun (name, old) ->
      ( name,
        if name = "class" then
          value
        else
          old
      )
    )
    attrs

let test_add_class_to_odd_values () =
  let set value =
    Ochre.Transform.make "set-class" ~attributes:(fun _ ->
        { pre = Some (fun _ -> replace_class value); line = None; span = None }
    )
  in
  let pre value =
    pre_class
      (render
         [ set value; Ochre.Transform_builtin.line_highlight [ 0 ] ]
         "let a"
      )
  in
  Alcotest.(check string) "empty" "has-highlighted" (pre (`String ""));
  Alcotest.(check string) "int" "7 has-highlighted" (pre (`Int 7))

let test_duplicate_class_and_style_merge () =
  let extra =
    Ochre.Transform.make "extra" ~attributes:(fun _ ->
        {
          pre = None;
          line =
            Some
              (fun ~line_index:_ _ attrs ->
                attrs @ [ ("class", `String "line extra") ]
              );
          span =
            Some
              (fun ~line_index:_ ~column:_ _ attrs ->
                attrs @ [ ("style", `String "outline:0") ]
              );
        }
    )
  in
  let html = render [ extra ] "let" in
  check_contains "one class" html ~sub:{|<span class="line extra"><span|};
  check_contains "one style" html
    ~sub:{|<span style="color:var(--ochre,#aa0000);outline:0">let</span>|}

let field_grammar =
  {|{
  "scopeName": "source.fields",
  "name": "fields",
  "patterns": [
    { "match": "#.*", "name": "comment.line.fields" },
    { "match": "\\b(let|in)\\b", "name": "keyword.control.fields" },
    { "match": "\\b(and|or)\\b", "name": "keyword.operator.word.fields" },
    { "match": "\"[^\"]*\"", "name": "string.quoted.fields" },
    { "match": "@\\w+", "name": "markup.underline.fields" },
    {
      "begin": "\\[",
      "end": "\\]",
      "name": "invalid.illegal.fields",
      "patterns": [ { "include": "$self" } ]
    }
  ]
}|}

let field_lang () =
  get_ok
    (Ochre.lang (get_ok (Ochre.load [ ("fields", field_grammar) ])) "fields")

let field_theme =
  let open Ochre.Style in
  Ochre.Theme.make ~name:"fields"
    ~colors:
      [
        ("editor.foreground", color "#111111");
        ("editor.background", color "#eeeeee");
      ]
    ~token_colors:
      [
        Ochre.Theme.rule ~scope:[ "keyword.control" ]
          ~foreground:(color "#aa0000")
          ~font_style:{ plain with italic = true }
          ();
        Ochre.Theme.rule ~scope:[ "keyword.operator" ]
          ~foreground:(color "#aa0000") ~font_style:{ plain with bold = true }
          ();
        Ochre.Theme.rule ~scope:[ "comment" ] ~foreground:(color "#777777")
          ~font_style:{ plain with italic = true; underline = true }
          ();
        Ochre.Theme.rule ~scope:[ "string" ] ~foreground:(color "#00aa00") ();
        Ochre.Theme.rule ~scope:[ "invalid" ] ~foreground:(color "#ffffff")
          ~background:(color "#ff000033") ();
        Ochre.Theme.rule ~scope:[ "markup.underline" ]
          ~font_style:{ plain with underline = true }
          ();
      ]
    ()

let index_of ~sub s from =
  let n = String.length sub in
  let rec scan i =
    if i + n > String.length s then
      None
    else if String.sub s i n = sub then
      Some i
    else
      scan (i + 1)
  in
  scan from

let token_spans html =
  let rec attrs i acc =
    if html.[i] = '>' then
      (List.rev acc, i + 1)
    else
      let eq = String.index_from html i '=' in
      let stop = String.index_from html (eq + 2) '"' in
      attrs (stop + 1)
        (( String.sub html (i + 1) (eq - i - 1),
           String.sub html (eq + 2) (stop - eq - 2)
         )
        :: acc
        )
  in
  let rec scan i acc =
    match index_of ~sub:"<span" html i with
    | None ->
        List.rev acc
    | Some i ->
        let attributes, body = attrs (i + 5) [] in
        let next = String.index_from html body '<' in
        if
          index_of ~sub:"</span>" html next = Some next
          && List.assoc_opt "class" attributes <> Some "line"
        then
          scan next ((attributes, String.sub html body (next - body)) :: acc)
        else
          scan body acc
  in
  scan 0 []

let span_classes ~prefix attributes =
  List.filter
    (String.starts_with ~prefix)
    (String.split_on_char ' '
       (Option.value (List.assoc_opt "class" attributes) ~default:"")
    )

let stylesheet_rules css =
  List.filter_map
    (fun line ->
      match index_of ~sub:" { " line 0 with
      | Some i when String.length line > 0 && line.[0] = '.' ->
          Some
            ( String.sub line 1 (i - 1),
              String.sub line (i + 3) (String.length line - i - 5)
            )
      | _ ->
          None
    )
    (String.split_on_char '\n' css)

let declarations text = List.filter (( <> ) "") (String.split_on_char ';' text)

let class_options =
  Ochre.Html_options.make ~style_mode:(Css_classes { class_prefix = "c-" }) ()

let test_token_gets_one_class_per_field () =
  let themed =
    Ochre.highlight ~theme:field_theme ~lang:(field_lang ()) "let x"
  in
  let html = Ochre.to_html ~options:class_options themed in
  let rules =
    stylesheet_rules (Ochre.html_render_theme_css ~class_prefix:"c-" themed)
  in
  match List.find_opt (fun (_, text) -> text = "let") (token_spans html) with
  | None ->
      Alcotest.fail "no span for let"
  | Some (attributes, _) ->
      let classes = span_classes ~prefix:"c-" attributes in
      Alcotest.(check int) "two classes" 2 (List.length classes);
      Alcotest.(check (list string))
        "one rule for each class"
        [
          "color:var(--ochre,#aa0000)";
          "font-style:var(--ochre-font-style,italic)";
        ]
        (List.sort compare
           (List.map
              (fun cls ->
                match List.assoc_opt cls rules with
                | Some rule ->
                    rule
                | None ->
                    Alcotest.failf "no rule for %s" cls
              )
              classes
           )
        )

let test_tokens_share_field_classes () =
  let themed =
    Ochre.highlight ~theme:field_theme ~lang:(field_lang ()) "let x and y"
  in
  let html = Ochre.to_html ~options:class_options themed in
  let css = Ochre.html_render_theme_css ~class_prefix:"c-" themed in
  let classes text =
    match List.find_opt (fun (_, t) -> t = text) (token_spans html) with
    | Some (attributes, _) ->
        span_classes ~prefix:"c-" attributes
    | None ->
        Alcotest.failf "no span for %s" text
  in
  let shared =
    List.filter (fun cls -> List.mem cls (classes "and")) (classes "let")
  in
  Alcotest.(check int) "one shared class" 1 (List.length shared);
  let rules = stylesheet_rules css in
  Alcotest.(check (option string))
    "the shared class is the foreground" (Some "color:var(--ochre,#aa0000)")
    (List.assoc_opt (List.hd shared) rules);
  Alcotest.(check int)
    "no duplicate rule"
    (List.length (List.sort_uniq compare rules))
    (List.length rules);
  Alcotest.(check int)
    "foreground rule once" 1
    (occurrences ~sub:"{ color:var(--ochre,#aa0000) }" css)

let effective_declarations ~rules (attributes, text) =
  let classes =
    List.concat_map
      (fun cls ->
        match List.assoc_opt cls rules with
        | Some rule ->
            declarations rule
        | None ->
            Alcotest.failf "no rule for %s" cls
      )
      (span_classes ~prefix:"c-" attributes)
  in
  let inline =
    declarations (Option.value (List.assoc_opt "style" attributes) ~default:"")
  in
  (text, List.sort compare (classes @ inline))

let test_classes_keep_colors () =
  let source = "let x and y # note\n[let \"s\" or @u]\n\"str\" @w in [z # c]" in
  let check name ~default_color themed =
    let inline =
      Ochre.to_html ~options:(Ochre.Html_options.make ~default_color ()) themed
    in
    let classes =
      Ochre.to_html
        ~options:
          (Ochre.Html_options.make
             ~style_mode:(Css_classes { class_prefix = "c-" })
             ~default_color ()
          )
        themed
    in
    let rules =
      stylesheet_rules (Ochre.html_render_theme_css ~class_prefix:"c-" themed)
    in
    let expected =
      List.map (effective_declarations ~rules:[]) (token_spans inline)
    in
    Alcotest.(check bool) (name ^ ": tokens") true (List.length expected > 10);
    Alcotest.(check (list (pair string (list string))))
      name expected
      (List.map (effective_declarations ~rules) (token_spans classes))
  in
  let lang = field_lang () in
  let one theme = Ochre.highlight ~theme ~lang source in
  let several ~label extra_themes =
    get_ok
      (Ochre.highlight_themes ~label ~theme:field_theme ~extra_themes ~lang
         source
      )
  in
  List.iter
    (fun default_color ->
      check "fields" ~default_color (one field_theme);
      check "nord" ~default_color (one Ochre.Theme.nord);
      check "extra themes" ~default_color
        (several ~label:"base" [ ("nord", Ochre.Theme.nord) ]);
      check "light and dark" ~default_color
        (several ~label:"light" [ ("dark", Ochre.Theme.nord) ])
    )
    [ Ochre.Html_options.Default_color; No_default_color ]

let word_spans html =
  let marker = {|class="highlighted-word">|} in
  let n = String.length marker in
  let rec scan i acc =
    if i + n > String.length html then
      List.rev acc
    else if String.sub html i n = marker then
      let stop = String.index_from html (i + n) '<' in
      scan stop (String.sub html (i + n) (stop - i - n) :: acc)
    else
      scan (i + 1) acc
  in
  scan 0 []

let test_word_marks_with_diff_markers () =
  let word = Ochre.Transform_builtin.notation_word_highlight () in
  let source = "+let foo # [!code word:foo]\nlet b" in
  Alcotest.(check (list string))
    "diff_markers first: the word is marked" [ "foo" ]
    (word_spans (render [ Ochre.Transform_builtin.diff_markers; word ] source));
  Alcotest.(check (list string))
    "diff_markers after: its edit moves the marked columns" [ "\n" ]
    (word_spans (render [ word; Ochre.Transform_builtin.diff_markers ] source))

let test_pre_attribute_names_merge_ignoring_case () =
  let extra =
    Ochre.Transform.make "extra" ~attributes:(fun _ ->
        {
          pre =
            Some
              (fun _ attrs ->
                attrs @ [ ("tabindex", `Int (-1)); ("Class", `String "x") ]
              );
          line = None;
          span = None;
        }
    )
  in
  Alcotest.(check string)
    "pre"
    {|<pre class="ochre x" style="background-color:var(--ochre-bg,#eeeeee);color:var(--ochre,#111111)" tabindex="-1"><code>|}
    (let html = render [ extra ] "let" in
     String.sub html 0 (String.index html '>' + 7)
    )

let test_span_hook_gets_source_tokens () =
  let record =
    Ochre.Transform.make "record" ~attributes:(fun _ ->
        {
          pre = None;
          line = None;
          span =
            Some
              (fun ~line_index:_ ~column (token : Ochre.Token.t) ->
                attr "data-t"
                  (Printf.sprintf "%s@%d" (String.escaped token.text) column)
              );
        }
    )
  in
  let html = render [ record ] "#x\r\nlet" in
  check_contains "the token before the CRLF keeps its \\r" html
    ~sub:{|data-t="#x\r@0">#x</span>|};
  check_contains "the newline token keeps its column" html
    ~sub:"data-t=\"\\n@3\">\r\n</span>"

let () =
  Alcotest.run "Ochre HTML"
    [
      ( "to_jsx",
        [
          Alcotest.test_case "to_jsx output embeds in a page" `Quick
            test_page_embeds_to_jsx;
        ]
      );
      ( "hooks",
        [
          Alcotest.test_case "User hooks add escaped attributes in order" `Quick
            test_user_hooks;
          Alcotest.test_case "Attribute names merge ignoring case" `Quick
            test_pre_attribute_names_merge_ignoring_case;
          Alcotest.test_case "Span hooks get the source tokens with CRLF" `Quick
            test_span_hook_gets_source_tokens;
          Alcotest.test_case "Duplicate class and style merge" `Quick
            test_duplicate_class_and_style_merge;
          Alcotest.test_case "Bad attribute names are replaced" `Quick
            test_bad_attribute_name;
        ]
      );
      ( "built-in classes",
        [
          Alcotest.test_case "line_highlight" `Quick test_line_highlight_classes;
          Alcotest.test_case "diff_markers" `Quick test_diff_markers_classes;
          Alcotest.test_case "word_highlight" `Quick test_word_highlight_classes;
          Alcotest.test_case "scope_marker" `Quick test_scope_marker_classes;
          Alcotest.test_case "notation_highlight" `Quick
            test_notation_highlight_classes;
          Alcotest.test_case "notation_diff" `Quick test_notation_diff_classes;
          Alcotest.test_case "notation_word_highlight" `Quick
            test_notation_word_highlight_classes;
          Alcotest.test_case "notation_highlight with notation_diff" `Quick
            test_notation_combined;
          Alcotest.test_case "word marks skip inserted text" `Quick
            test_word_marks_inserted_text;
          Alcotest.test_case "pre class follows the rendered lines" `Quick
            test_pre_class_follows_rendered_lines;
          Alcotest.test_case "word class and color agree with CRLF" `Quick
            test_crlf_class_and_color_agree;
          Alcotest.test_case "scope class and color agree with CRLF" `Quick
            test_scope_marker_crlf;
          Alcotest.test_case "class added to empty and non-string values" `Quick
            test_add_class_to_odd_values;
          Alcotest.test_case "word marks and diff_markers order" `Quick
            test_word_marks_with_diff_markers;
          Alcotest.test_case "class names are not repeated" `Quick
            test_classes_not_repeated;
        ]
      );
      ( "themes",
        [
          Alcotest.test_case "Light and dark use light-dark()" `Quick
            test_light_dark;
          Alcotest.test_case "Light and dark CSS classes use light-dark()"
            `Quick test_light_dark_css_classes;
          Alcotest.test_case "Light and dark without default color keep fonts"
            `Quick test_light_dark_no_default_font;
          Alcotest.test_case "Every CSS class has a rule" `Quick
            test_css_classes_have_rules;
          Alcotest.test_case "Three themes use CSS variables" `Quick
            test_three_themes_use_variables;
          Alcotest.test_case "A token gets one class per field" `Quick
            test_token_gets_one_class_per_field;
          Alcotest.test_case "Tokens share field classes" `Quick
            test_tokens_share_field_classes;
          Alcotest.test_case "Classes keep the inline colors" `Quick
            test_classes_keep_colors;
        ]
      );
    ]
