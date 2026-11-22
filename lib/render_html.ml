let css_var_foreground_name prefix =
  if String.length prefix > 0 && prefix.[String.length prefix - 1] = '-' then
    String.sub prefix 0 (String.length prefix - 1)
  else
    prefix

let css_var_background_name prefix = prefix ^ "bg"

type var_kind = Colour | Named of string

type prop = {
  css : string;
  kind : var_kind;
  value : Style.t -> string option;
  neutral : Theme.theme -> string;
}

let text_decoration (style : Style.font_style) =
  match (style.underline, style.strikethrough) with
  | true, true ->
      Some "underline line-through"
  | true, false ->
      Some "underline"
  | false, true ->
      Some "line-through"
  | false, false ->
      None

let when_set on value =
  if on then
    Some value
  else
    None

let props =
  [
    {
      css = "font-weight";
      kind = Named "font-weight";
      value = (fun style -> when_set style.font_style.bold "bold");
      neutral = (fun _ -> "normal");
    };
    {
      css = "font-style";
      kind = Named "font-style";
      value = (fun style -> when_set style.font_style.italic "italic");
      neutral = (fun _ -> "normal");
    };
    {
      css = "text-decoration";
      kind = Named "text-decoration";
      value = (fun style -> text_decoration style.font_style);
      neutral = (fun _ -> "none");
    };
    {
      css = "background-color";
      kind = Named "token-bg";
      value = (fun style -> Option.map Color.to_hex style.background);
      neutral = (fun _ -> "transparent");
    };
    {
      css = "color";
      kind = Colour;
      value = (fun style -> Some (Color.to_hex style.foreground));
      neutral = (fun (theme : Theme.theme) -> Color.to_hex theme.fg);
    };
  ]

let is_colour_prop prop = prop.kind = Colour || prop.css = "background-color"

let read_var ~prefix prop =
  match prop.kind with
  | Colour ->
      css_var_foreground_name prefix
  | Named name ->
      prefix ^ name

let theme_var ~prefix ~label prop =
  match prop.kind with
  | Colour ->
      prefix ^ label
  | Named name ->
      prefix ^ label ^ "-" ^ name

let token_style_to_css ~emit_default ~prefix style =
  if not emit_default then
    ""
  else
    String.concat ";"
      (List.filter_map
         (fun prop ->
           Option.map
             (fun value ->
               prop.css ^ ":var(" ^ read_var ~prefix prop ^ "," ^ value ^ ")"
             )
             (prop.value style)
         )
         props
      )

let token_theme_declarations ~prefix ~emit_default ~label (theme, style) extras
    =
  let themed = (label, theme, style) :: extras in
  let needed =
    List.filter
      (fun prop ->
        List.exists (fun (_, _, style) -> prop.value style <> None) themed
      )
      props
  in
  let reads =
    List.filter_map
      (fun prop ->
        let read = read_var ~prefix prop in
        if emit_default then
          if prop.value style = None then
            Some (prop.css ^ ":var(" ^ read ^ "," ^ prop.neutral theme ^ ")")
          else
            None
        else if is_colour_prop prop then
          None
        else
          Some (prop.css ^ ":var(" ^ read ^ ")")
      )
      needed
  in
  let defined =
    if emit_default then
      extras
    else
      themed
  in
  let definitions =
    List.concat_map
      (fun (label, theme, style) ->
        List.map
          (fun prop ->
            theme_var ~prefix ~label prop
            ^ ":"
            ^ Option.value (prop.value style) ~default:(prop.neutral theme)
          )
          needed
      )
      defined
  in
  reads @ definitions

let escape_text = Escape.to_string Escape.html

let escape_token_text text =
  let escaped = escape_text text in
  let length = String.length escaped in
  let buf = Buffer.create length in
  String.iteri
    (fun i c ->
      if c = '\r' && not (i + 1 < length && escaped.[i + 1] = '\n') then
        Buffer.add_string buf "&#13;"
      else
        Buffer.add_char buf c
    )
    escaped;
  Buffer.contents buf

let rec join_crlf = function
  | (first : Token.t) :: (second : Token.t) :: rest
    when String.ends_with ~suffix:"\r" first.text
         && String.starts_with ~prefix:"\n" second.text ->
      let length = String.length first.text in
      let kept = String.sub first.text 0 (length - 1) in
      let second = { second with text = "\r" ^ second.text } in
      if kept = "" then
        join_crlf (second :: rest)
      else
        { first with text = kept } :: join_crlf (second :: rest)
  | token :: rest ->
      token :: join_crlf rest
  | [] ->
      []

let style_hash s = String.sub (Digest.to_hex (Digest.string s)) 0 16

type class_registry = {
  table : (string, string) Hashtbl.t;
  mutable order : (string * string) list;
  prefix : string;
}

let create_registry prefix =
  let prefix =
    match prefix with
    | "" ->
        "_"
    | p
      when match p.[0] with 'a' .. 'z' | 'A' .. 'Z' | '_' -> false | _ -> true
      ->
        "_" ^ p
    | p ->
        p
  in
  { table = Hashtbl.create 16; order = []; prefix }

let class_for_style registry style =
  match Hashtbl.find_opt registry.table style with
  | Some cls ->
      cls
  | None ->
      let cls = registry.prefix ^ style_hash style in
      Hashtbl.add registry.table style cls;
      registry.order <- (style, cls) :: registry.order;
      cls

let join_styles parts = String.concat ";" (List.filter (( <> ) "") parts)

let render_span_attrs ~options ~registry ~style ~extra_style decoration scopes =
  let open Html_options in
  let attrs = [] in
  let attrs =
    if options.scopes_as_data_attrs && scopes <> [] then
      Printf.sprintf "data-scope=\"%s\"" (escape_text (String.concat " " scopes))
      :: attrs
    else
      attrs
  in
  let escaped = Option.map Render_decoration.escape decoration in
  let escaped_class =
    Option.bind escaped (fun (e : Render_decoration.escaped) -> e.class_)
  in
  let attrs, decoration_style =
    match escaped with
    | None ->
        (attrs, "")
    | Some (esc : Render_decoration.escaped) ->
        let a = attrs in
        let a =
          match esc.class_ with
          | Some c ->
              Printf.sprintf "class=\"%s\"" c :: a
          | None ->
              a
        in
        let a =
          List.fold_left
            (fun acc (k, v) -> Printf.sprintf "data-%s=\"%s\"" k v :: acc)
            a esc.data
        in
        (a, Option.value esc.style ~default:"")
  in
  let class_style, inline_style =
    match (options.style_mode, registry) with
    | Css_classes _, Some reg when style <> "" ->
        ( Some (class_for_style reg style),
          join_styles [ extra_style; decoration_style ]
        )
    | _ ->
        (None, join_styles [ style; extra_style; decoration_style ])
  in
  let attrs =
    match class_style with
    | None ->
        attrs
    | Some cls ->
        let existing, others =
          List.partition (fun a -> String.starts_with ~prefix:"class=" a) attrs
        in
        let merged =
          match (escaped_class, existing) with
          | Some c, _ :: _ ->
              Printf.sprintf "class=\"%s %s\"" c cls
          | _ ->
              Printf.sprintf "class=\"%s\"" cls
        in
        merged :: others
  in
  let parts =
    if inline_style <> "" then
      Printf.sprintf "style=\"%s\"" inline_style :: attrs
    else
      attrs
  in
  if parts = [] then
    None
  else
    Some (String.concat " " parts)

let render_token ~options ~registry ~label ~theme ~extra_themes ~emit_default
    (token : Token.t) =
  let prefix = options.Html_options.css_variable_prefix in
  let primary = Token.style token in
  let extras =
    List.map
      (fun (label, theme, index) -> (label, theme, Token.style_at index token))
      extra_themes
  in
  let extra_vars =
    token_theme_declarations ~prefix ~emit_default ~label (theme, primary)
      extras
  in
  let text = escape_token_text token.text in
  match
    render_span_attrs ~options ~registry
      ~style:(token_style_to_css ~emit_default ~prefix primary)
      ~extra_style:(String.concat ";" extra_vars)
      token.decoration token.scopes
  with
  | None ->
      text
  | Some attrs ->
      Printf.sprintf "<span %s>%s</span>" attrs text

let dedupe_preserving_order items =
  let rec loop seen acc = function
    | [] ->
        List.rev acc
    | x :: xs ->
        if List.mem x seen then
          loop seen acc xs
        else
          loop (x :: seen) (x :: acc) xs
  in
  loop [] [] items

let render ?(options = Html_options.default) (themed : Themed.t) =
  let options =
    {
      options with
      Html_options.css_variable_prefix =
        Escape.css_ident options.css_variable_prefix;
      style_mode =
        ( match options.style_mode with
        | Html_options.Css_classes { class_prefix } ->
            Html_options.Css_classes
              { class_prefix = Escape.css_ident class_prefix }
        | Html_options.Inline_styles ->
            Html_options.Inline_styles
        );
    }
  in
  let (label, theme), extra_themes = themed.themes in
  let extra_themes =
    List.mapi
      (fun i (label, theme) -> (Escape.css_ident label, theme, i + 1))
      extra_themes
  in
  let label = Escape.css_ident label in
  let has_extras = extra_themes <> [] in
  let themes = (label, theme, 0) :: extra_themes in
  let prefix = options.css_variable_prefix in
  let registry =
    match options.style_mode with
    | Html_options.Css_classes { class_prefix } ->
        Some (create_registry class_prefix)
    | Html_options.Inline_styles ->
        None
  in
  let emit_default =
    match options.default_color with
    | Html_options.Default_color ->
        true
    | Html_options.No_default_color ->
        false
  in
  let lines =
    List.mapi
      (fun i line ->
        let content =
          String.concat ""
            (List.map
               (render_token ~options ~registry ~label ~theme ~extra_themes
                  ~emit_default
               )
               (join_crlf line)
            )
        in
        if options.line_numbers then
          Printf.sprintf "<span class=\"line\" data-line=\"%d\">%s</span>"
            (i + 1) content
        else
          Printf.sprintf "<span class=\"line\">%s</span>" content
      )
      themed.lines
  in
  let code_content = String.concat "" lines in
  let pre_classes =
    let classes =
      [ "ochre" ]
      @ ( if has_extras then
            "ochre-themes" :: theme.Theme.name
            :: List.map
                 (fun (_, (theme : Theme.theme), _) -> theme.name)
                 extra_themes
          else
            []
        )
      @ match options.pre_class with Some c -> [ c ] | None -> []
    in
    dedupe_preserving_order classes
  in
  let pre_class_attr = escape_text (String.concat " " pre_classes) in
  let page_variables (label, (theme : Theme.theme), _) =
    [
      prefix ^ label ^ "-bg:" ^ Color.to_hex theme.bg;
      prefix ^ label ^ ":" ^ Color.to_hex theme.fg;
    ]
  in
  let pre_style_parts =
    ( if emit_default then
        [
          "background-color:var("
          ^ css_var_background_name prefix
          ^ "," ^ Color.to_hex theme.bg ^ ")";
          "color:var("
          ^ css_var_foreground_name prefix
          ^ "," ^ Color.to_hex theme.fg ^ ")";
        ]
      else
        []
    )
    @ List.concat_map page_variables
        ( if emit_default then
            extra_themes
          else
            themes
        )
  in
  let pre_style =
    Printf.sprintf " style=\"%s\"" (String.concat ";" pre_style_parts)
  in
  let code_attrs =
    match options.code_class with
    | Some c ->
        Printf.sprintf " class=\"%s\"" (escape_text c)
    | None ->
        ""
  in
  Printf.sprintf "<pre class=\"%s\"%s tabindex=\"0\"><code%s>%s</code></pre>"
    pre_class_attr pre_style code_attrs code_content

let theme_css ?(css_variable_prefix = "--ochre-") label =
  let label = Escape.css_ident label in
  let prefix =
    Escape.css_ident
      (Html_options.normalize_css_variable_prefix css_variable_prefix)
  in
  let rule prop =
    Printf.sprintf "  %s: var(%s);" (read_var ~prefix prop)
      (theme_var ~prefix ~label prop)
  in
  let prop css = List.find (fun prop -> prop.css = css) props in
  String.concat "\n"
    [
      ".ochre,";
      ".ochre span {";
      rule (prop "color");
      Printf.sprintf "  %s: var(%s%s-bg);"
        (css_var_background_name prefix)
        prefix label;
      rule (prop "font-style");
      rule (prop "font-weight");
      rule (prop "text-decoration");
      rule (prop "background-color");
      "}";
    ]

let collect_classes registry =
  let buf = Buffer.create 256 in
  List.iter
    (fun (style, cls) ->
      Buffer.add_string buf (Printf.sprintf ".%s { %s }\n" cls style)
    )
    (List.rev registry.order);
  Buffer.contents buf

let render_theme_css ?(css_variable_prefix = "--ochre-") ~class_prefix
    (themed : Themed.t) =
  let (_, theme), _ = themed.themes in
  let prefix =
    Escape.css_ident
      (Html_options.normalize_css_variable_prefix css_variable_prefix)
  in
  let reg = create_registry (Escape.css_ident class_prefix) in
  List.iter
    (List.iter (fun token ->
         let style =
           token_style_to_css ~emit_default:true ~prefix (Token.style token)
         in
         if style <> "" then ignore (class_for_style reg style)
     )
    )
    themed.lines;
  Printf.sprintf ".ochre { background-color:%s; color:%s }\n%s"
    (Color.to_hex theme.bg) (Color.to_hex theme.fg) (collect_classes reg)
