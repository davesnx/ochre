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

let theme ~name ~background ~foreground ~rules =
  Ochre.Theme.load_exn
    (Printf.sprintf
       {|{ "name": %S,
           "colors": { "editor.foreground": %S, "editor.background": %S },
           "tokenColors": [ %s ] }|}
       name foreground background
       (String.concat ","
          (List.map
             (fun (scope, settings) ->
               Printf.sprintf {|{ "scope": %S, "settings": { %s } }|} scope
                 settings
             )
             rules
          )
       )
    )

let light =
  theme ~name:"test-light" ~background:"#ffffff" ~foreground:"#222222"
    ~rules:
      [
        ("keyword", {|"foreground": "#d00000", "fontStyle": "italic underline"|});
        ("comment", {|"foreground": "#666666", "fontStyle": "italic"|});
        ( "constant.numeric",
          {|"foreground": "#0000d0", "background": "#eeeeff"|}
        );
      ]

let dark =
  theme ~name:"test-dark" ~background:"#101010" ~foreground:"#dddddd"
    ~rules:
      [
        ("keyword", {|"foreground": "#ff8080", "fontStyle": "bold"|});
        ( "string",
          {|"foreground": "#80ff80", "fontStyle": "underline strikethrough"|}
        );
        ( "constant.numeric",
          {|"foreground": "#8080ff", "fontStyle": "bold", "background": "#202040"|}
        );
      ]

let sepia =
  theme ~name:"test-sepia" ~background:"#f4ecd8" ~foreground:"#5b4636"
    ~rules:
      [ ("comment", {|"foreground": "#998877", "fontStyle": "strikethrough"|}) ]

let hl = Ochre.load_exn [ ("test", grammar_json) ]
let source = "let x = 42 # note\nif \"s\" then 7\n"

let strip s = String.trim s

let split_decls s =
  List.filter_map
    (fun decl ->
      match String.index_opt decl ':' with
      | Some i ->
          Some
            ( strip (String.sub decl 0 i),
              strip (String.sub decl (i + 1) (String.length decl - i - 1))
            )
      | None ->
          None
    )
    (String.split_on_char ';' s)

type env = (string, string) Hashtbl.t

let rec lookup (env : env) name =
  match Hashtbl.find_opt env name with
  | Some value ->
      resolve env value
  | None ->
      None

and resolve env value =
  if
    String.starts_with ~prefix:"var(" value
    && String.ends_with ~suffix:")" value
  then
    let inner = String.sub value 4 (String.length value - 5) in
    let name, fallback =
      match String.index_opt inner ',' with
      | Some i ->
          ( strip (String.sub inner 0 i),
            Some (strip (String.sub inner (i + 1) (String.length inner - i - 1)))
          )
      | None ->
          (strip inner, None)
    in
    match lookup env name with
    | Some _ as found ->
        found
    | None ->
        Option.bind fallback (resolve env)
  else
    Some value

let is_custom name = String.starts_with ~prefix:"--" name

let apply_declarations env decls =
  List.iter
    (fun (name, value) ->
      if is_custom name then
        match resolve env value with
        | Some v ->
            Hashtbl.replace env name v
        | None ->
            Hashtbl.remove env name
    )
    decls

let computed env decls =
  List.filter_map
    (fun (name, value) ->
      if is_custom name then
        None
      else
        Some (name, resolve env value)
    )
    decls

let theme_rule label =
  let css = Ochre.html_theme_css label in
  let body =
    let start = String.index css '{' + 1 in
    String.sub css start (String.index css '}' - start)
  in
  split_decls body

let tokens_of html =
  let re = Str.regexp "<span style=\"\\([^\"]*\\)\">" in
  let rec all pos acc =
    match Str.search_forward re html pos with
    | _ ->
        all (Str.match_end ()) (Str.matched_group 1 html :: acc)
    | exception Not_found ->
        List.rev acc
  in
  all 0 []

let pre_style html =
  let re = Str.regexp "<pre [^>]*style=\"\\([^\"]*\\)\"" in
  match Str.search_forward re html 0 with
  | _ ->
      Str.matched_group 1 html
  | exception Not_found ->
      ""

let tokens_with_class_styles html css =
  let re =
    Str.regexp
      "<span \\(style=\"\\([^\"]*\\)\" \\)?class=\"\\(c-[0-9a-f]+\\)\">"
  in
  let class_style cls =
    let marker = "." ^ cls ^ " { " in
    let start =
      Str.search_forward (Str.regexp_string marker) css 0 + String.length marker
    in
    String.sub css start (String.index_from css start '}' - start - 1)
  in
  let rec all pos acc =
    match Str.search_forward re html pos with
    | _ ->
        let inline = try Str.matched_group 2 html with Not_found -> "" in
        let cls = Str.matched_group 3 html in
        let next = Str.match_end () in
        all next ((class_style cls ^ ";" ^ inline) :: acc)
    | exception Not_found ->
        List.rev acc
  in
  all 0 []

let expected_weight (tok : Ochre.Token.styled_token) =
  if List.mem Ochre.Token.Bold tok.font_style then
    "bold"
  else
    "normal"

let expected_style (tok : Ochre.Token.styled_token) =
  if List.mem Ochre.Token.Italic tok.font_style then
    "italic"
  else
    "normal"

let expected_decoration (tok : Ochre.Token.styled_token) =
  match
    ( List.mem Ochre.Token.Underline tok.font_style,
      List.mem Ochre.Token.Strikethrough tok.font_style
    )
  with
  | true, true ->
      "underline line-through"
  | true, false ->
      "underline"
  | false, true ->
      "line-through"
  | false, false ->
      "none"

let lower = String.lowercase_ascii

let expectations (theme : Ochre.Theme.theme) (tok : Ochre.Token.styled_token) =
  [
    ("font-weight", expected_weight tok);
    ("font-style", expected_style tok);
    ("text-decoration", expected_decoration tok);
    ( "background-color",
      Option.value (Option.map lower tok.background) ~default:"transparent"
    );
    ("color", lower (Option.value tok.foreground ~default:theme.fg));
  ]

let neutral = function
  | "font-weight" | "font-style" ->
      "normal"
  | "text-decoration" ->
      "none"
  | "background-color" ->
      "transparent"
  | _ ->
      ""

let flatten code = List.concat code

let check ~title ~options ~primary_label (primary : Ochre.Theme.theme) extras =
  let html =
    Ochre.to_html hl ~options ~theme:primary ~extra_themes:extras ~lang:"test"
      source
  in
  let default_mode = options.Ochre.Html_options.default_color = Default_color in
  let primary_tokens = Ochre.to_tokens hl ~theme:primary ~lang:"test" source in
  let styles =
    match options.style_mode with
    | Css_classes { class_prefix } when default_mode ->
        tokens_with_class_styles html
          (Ochre.html_render_theme_css ~class_prefix primary primary_tokens)
    | _ ->
        tokens_of html
  in
  let pre_decls = split_decls (pre_style html) in
  let themes = (primary_label, primary) :: extras in
  let problems = ref [] in
  let token_count = List.length (flatten primary_tokens) in
  if List.length styles <> token_count then
    problems :=
      Printf.sprintf "%d style attributes for %d tokens" (List.length styles)
        token_count
      :: !problems
  else
    List.iteri
      (fun theme_index (label, (theme : Ochre.Theme.theme)) ->
        let active = theme_index > 0 || not default_mode in
        let rule =
          if active then
            theme_rule label
          else
            []
        in
        let pre_env : env = Hashtbl.create 16 in
        apply_declarations pre_env pre_decls;
        apply_declarations pre_env rule;
        let page_color = "var(--ochre-" ^ label ^ ")" in
        let page_token_bg = "var(--ochre-" ^ label ^ "-token-bg)" in
        let pre_color =
          match List.assoc_opt "color" pre_decls with
          | Some value ->
              resolve pre_env value
          | None ->
              resolve pre_env page_color
        in
        let tokens = flatten (Ochre.to_tokens hl ~theme ~lang:"test" source) in
        List.iteri
          (fun i (style, tok) ->
            let decls = split_decls style in
            let page =
              if default_mode then
                []
              else
                [ ("color", page_color); ("background-color", page_token_bg) ]
            in
            let env = Hashtbl.copy pre_env in
            apply_declarations env decls;
            apply_declarations env rule;
            let props = computed env (decls @ page) in
            List.iter
              (fun (prop, expected) ->
                let got =
                  match List.assoc_opt prop (List.rev props) with
                  | Some (Some value) ->
                      lower value
                  | Some None | None ->
                      if prop = "color" then
                        lower (Option.value pre_color ~default:"")
                      else
                        neutral prop
                in
                if got <> expected then
                  problems :=
                    Printf.sprintf "theme %s token %d %s: got %s, expected %s"
                      label i prop got expected
                    :: !problems
              )
              (expectations theme tok)
          )
          (List.combine styles tokens)
      )
      themes;
  match List.rev !problems with
  | [] ->
      Printf.printf "%s: ok, %d tokens in %d themes\n" title token_count
        (List.length themes)
  | problems ->
      Printf.printf "%s: %d problems\n" title (List.length problems);
      List.iter (Printf.printf "  %s\n") problems

let classes =
  Ochre.Html_options.make
    ~style_mode:(Ochre.Html_options.Css_classes { class_prefix = "c-" })
    ()

let no_default =
  Ochre.Html_options.make ~default_color:Ochre.Html_options.No_default_color ()

let () =
  check ~title:"inline" ~options:Ochre.Html_options.default
    ~primary_label:"test-light" light
    [ ("dark", dark) ];
  check ~title:"classes" ~options:classes ~primary_label:"test-light" light
    [ ("dark", dark) ];
  check ~title:"no default color" ~options:no_default
    ~primary_label:"test-light" light
    [ ("dark", dark) ];
  check ~title:"three themes" ~options:Ochre.Html_options.default
    ~primary_label:"test-dark" dark
    [ ("light", light); ("sepia", sepia) ];
  check ~title:"three themes, no default color" ~options:no_default
    ~primary_label:"test-dark" dark
    [ ("light", light); ("sepia", sepia) ]
