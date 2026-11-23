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

type colors = Variables | Light_dark of { light : int; dark : int }

let colors (themed : Themed.t) =
  match themed.themes with
  | ("light", _), [ ("dark", _) ] ->
      Light_dark { light = 0; dark = 1 }
  | ("dark", _), [ ("light", _) ] ->
      Light_dark { light = 1; dark = 0 }
  | _ ->
      Variables

let variable_props = function
  | Variables ->
      props
  | Light_dark _ ->
      List.filter (fun prop -> not (is_colour_prop prop)) props

let light_dark light dark = "light-dark(" ^ light ^ "," ^ dark ^ ")"

let light_dark_declarations ~(light : Style.t) ~(dark : Style.t) =
  let background (style : Style.t) =
    Option.fold ~none:"transparent" ~some:Color.to_hex style.background
  in
  ( if light.background = None && dark.background = None then
      []
    else
      [ "background-color:" ^ light_dark (background light) (background dark) ]
  )
  @ [
      "color:"
      ^ light_dark (Color.to_hex light.foreground) (Color.to_hex dark.foreground);
    ]

let variable_read ~prefix token prop =
  Option.map
    (fun value -> prop.css ^ ":var(" ^ read_var ~prefix prop ^ "," ^ value ^ ")")
    (prop.value (Token.style token))

let variable_reads ~colors ~prefix token =
  List.filter_map (variable_read ~prefix token) (variable_props colors)

let class_fields ~colors ~prefix token =
  match colors with
  | Variables ->
      let field keep =
        String.concat ";"
          (List.filter_map
             (variable_read ~prefix token)
             (List.filter keep props)
          )
      in
      List.filter (( <> ) "")
        [
          field (fun prop -> not (is_colour_prop prop));
          field (fun prop -> prop.css = "background-color");
          field (fun prop -> prop.kind = Colour);
        ]
  | Light_dark { light; dark } ->
      light_dark_declarations
        ~light:(Token.style_at light token)
        ~dark:(Token.style_at dark token)

let token_styles ~colors ~emit_default ~prefix token =
  match colors with
  | Variables when not emit_default ->
      ([], [])
  | Variables ->
      (class_fields ~colors ~prefix token, [])
  | Light_dark _ ->
      (class_fields ~colors ~prefix token, variable_reads ~colors ~prefix token)

let token_theme_declarations ~props ~prefix ~emit_default ~label (theme, style)
    extras =
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
  | ((first : Token.t), first_source, first_column)
    :: ((second : Token.t), second_source, second_column)
    :: rest
    when String.ends_with ~suffix:"\r" first.text
         && String.starts_with ~prefix:"\n" second.text ->
      let length = String.length first.text in
      let kept = String.sub first.text 0 (length - 1) in
      let second =
        ({ second with text = "\r" ^ second.text }, second_source, second_column)
      in
      if kept = "" then
        join_crlf (second :: rest)
      else
        ({ first with text = kept }, first_source, first_column)
        :: join_crlf (second :: rest)
  | token :: rest ->
      token :: join_crlf rest
  | [] ->
      []

let with_columns line =
  snd
    (List.fold_left_map
       (fun column (token : Token.t) ->
         (column + String.length token.text, (token, token, column))
       )
       0 line
    )

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

let render_span_attrs ~options ~registry ~fields ~extra_style
    (decoration : Token.decoration_properties option) scopes =
  let open Html_options in
  let attrs = [] in
  let attrs =
    if options.scopes_as_data_attrs && scopes <> [] then
      ("data-scope", String.concat " " scopes) :: attrs
    else
      attrs
  in
  let decoration_class =
    Option.bind decoration (fun (d : Token.decoration_properties) -> d.class_)
  in
  let attrs, decoration_style =
    match decoration with
    | None ->
        (attrs, "")
    | Some d ->
        let a =
          match d.class_ with Some c -> ("class", c) :: attrs | None -> attrs
        in
        let a =
          List.fold_left (fun acc (k, v) -> ("data-" ^ k, v) :: acc) a d.data
        in
        (a, Option.value d.style ~default:"")
  in
  let class_style, inline_style =
    match (options.style_mode, registry) with
    | Css_classes _, Some reg when fields <> [] ->
        ( Some (String.concat " " (List.map (class_for_style reg) fields)),
          join_styles [ extra_style; decoration_style ]
        )
    | _ ->
        (None, join_styles (fields @ [ extra_style; decoration_style ]))
  in
  let attrs =
    match class_style with
    | None ->
        attrs
    | Some cls ->
        let others = List.filter (fun (name, _) -> name <> "class") attrs in
        let merged =
          match decoration_class with Some c -> c ^ " " ^ cls | None -> cls
        in
        ("class", merged) :: others
  in
  if inline_style <> "" then
    ("style", inline_style) :: attrs
  else
    attrs

let is_name_start = function
  | 'A' .. 'Z' | 'a' .. 'z' | '_' | ':' ->
      true
  | _ ->
      false

let is_name_char = function
  | '0' .. '9' | '.' | '-' ->
      true
  | c ->
      is_name_start c

let attribute_name name =
  if name = "" then
    "_"
  else
    String.mapi
      (fun i c ->
        if (i = 0 && is_name_start c) || (i > 0 && is_name_char c) then
          c
        else
          '_'
      )
      name

let attribute_text = function
  | `String text ->
      text
  | `Int i ->
      string_of_int i
  | `Float f ->
      Float.to_string f
  | `Bool _ ->
      ""

let words text = List.filter (( <> ) "") (String.split_on_char ' ' text)

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

let merge_class first second =
  String.concat " " (dedupe_preserving_order (words first @ words second))

let merge_style first second =
  String.concat ";" (List.filter (( <> ) "") [ first; second ])

let merge_duplicates attrs =
  let key name = String.lowercase_ascii name in
  let merge name =
    match key name with
    | "class" ->
        Some merge_class
    | "style" ->
        Some merge_style
    | _ ->
        None
  in
  List.rev
    (List.fold_left
       (fun acc (name, value) ->
         match List.find_opt (fun (n, _) -> key n = key name) acc with
         | None ->
             (name, value) :: acc
         | Some (_, first) ->
             let merged =
               match merge name with
               | Some combine ->
                   `String
                     (combine (attribute_text first) (attribute_text value))
               | None ->
                   value
             in
             List.map
               (fun (n, v) ->
                 if key n = key name then
                   (n, merged)
                 else
                   (n, v)
               )
               acc
       )
       [] attrs
    )

let node tag attrs children =
  JSX.node tag
    (merge_duplicates
       (List.map
          (function
            | name, `String value ->
                ( attribute_name name,
                  `String (Escape.to_string Escape.valid_utf8 value)
                )
            | name, value ->
                (attribute_name name, value)
            )
          attrs
       )
    )
    children

let string_attrs = List.map (fun (name, value) -> (name, `String value))

let apply_hooks hooks get attrs =
  List.fold_left
    (fun attrs hooks ->
      match get hooks with Some hook -> hook attrs | None -> attrs
    )
    attrs hooks

let render_token ~options ~registry ~colors ~label ~theme ~extra_themes
    ~emit_default ~hooks ~line_index (token, source, column) =
  let prefix = options.Html_options.css_variable_prefix in
  let primary = Token.style token in
  let extras =
    List.map
      (fun (label, theme, index) -> (label, theme, Token.style_at index token))
      extra_themes
  in
  let extra_vars =
    token_theme_declarations ~props:(variable_props colors) ~prefix
      ~emit_default:(emit_default || colors <> Variables)
      ~label (theme, primary) extras
  in
  let text = JSX.unsafe (escape_token_text token.text) in
  let fields, reads = token_styles ~colors ~emit_default ~prefix token in
  let attrs =
    string_attrs
      (render_span_attrs ~options ~registry ~fields
         ~extra_style:(String.concat ";" (reads @ extra_vars))
         token.decoration token.scopes
      )
  in
  match
    apply_hooks hooks
      (fun (h : Transform.attribute_hooks) ->
        Option.map (fun f -> f ~line_index ~column source) h.span
      )
      attrs
  with
  | [] ->
      text
  | attrs ->
      node "span" attrs [ text ]

let theme_at (themed : Themed.t) index =
  let default, extras = themed.themes in
  snd (List.nth (default :: extras) index)

let page_light_dark ~(light : Theme.theme) ~(dark : Theme.theme) =
  [
    "background-color:"
    ^ light_dark (Color.to_hex light.bg) (Color.to_hex dark.bg);
    "color:" ^ light_dark (Color.to_hex light.fg) (Color.to_hex dark.fg);
  ]

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
  let colors = colors themed in
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
          List.map
            (render_token ~options ~registry ~colors ~label ~theme ~extra_themes
               ~emit_default ~hooks:themed.hooks ~line_index:i
            )
            (join_crlf (with_columns line))
        in
        let attrs =
          ("class", `String "line")
          ::
          ( if options.line_numbers then
              [ ("data-line", `Int (i + 1)) ]
            else
              []
          )
        in
        node "span"
          (apply_hooks themed.hooks
             (fun (h : Transform.attribute_hooks) ->
               Option.map (fun f -> f ~line_index:i line) h.line
             )
             attrs
          )
          content
      )
      themed.lines
  in
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
  let page_variables (label, (theme : Theme.theme), _) =
    [
      prefix ^ label ^ "-bg:" ^ Color.to_hex theme.bg;
      prefix ^ label ^ ":" ^ Color.to_hex theme.fg;
    ]
  in
  let pre_style_parts =
    match colors with
    | Light_dark { light; dark } ->
        let light, dark = (theme_at themed light, theme_at themed dark) in
        page_light_dark ~light ~dark
    | Variables ->
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
  let code_attrs =
    match options.code_class with
    | Some c ->
        [ ("class", `String c) ]
    | None ->
        []
  in
  node "pre"
    (apply_hooks themed.hooks
       (fun (h : Transform.attribute_hooks) ->
         Option.map (fun f -> f themed.lines) h.pre
       )
       [
         ("class", `String (String.concat " " pre_classes));
         ("style", `String (String.concat ";" pre_style_parts));
         ("tabindex", `Int 0);
       ]
    )
    [ node "code" code_attrs lines ]

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
  let colors = colors themed in
  let prefix =
    Escape.css_ident
      (Html_options.normalize_css_variable_prefix css_variable_prefix)
  in
  let reg = create_registry (Escape.css_ident class_prefix) in
  List.iter
    (List.iter (fun token ->
         List.iter
           (fun field -> ignore (class_for_style reg field))
           (class_fields ~colors ~prefix token)
     )
    )
    themed.lines;
  let page =
    match colors with
    | Light_dark { light; dark } ->
        page_light_dark ~light:(theme_at themed light)
          ~dark:(theme_at themed dark)
    | Variables ->
        [
          "background-color:" ^ Color.to_hex theme.bg;
          "color:" ^ Color.to_hex theme.fg;
        ]
  in
  Printf.sprintf ".ochre { %s }\n%s" (String.concat "; " page)
    (collect_classes reg)
