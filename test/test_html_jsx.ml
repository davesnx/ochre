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
          Alcotest.test_case "Every CSS class has a rule" `Quick
            test_css_classes_have_rules;
          Alcotest.test_case "Three themes use CSS variables" `Quick
            test_three_themes_use_variables;
        ]
      );
    ]
