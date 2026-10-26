open Token

let css_var_foreground_name prefix =
  if String.length prefix > 0 && prefix.[String.length prefix - 1] = '-' then
    String.sub prefix 0 (String.length prefix - 1)
  else
    prefix

let css_var_background_name prefix = prefix ^ "bg"

let color_declaration prop color =
  Option.map (fun c -> prop c) (Option.bind color Escape.css_color)

type var_kind = Colour | Named of string

type prop = {
  css : string;
  kind : var_kind;
  value : Theme.theme -> styled_token -> string option;
  neutral : Theme.theme -> string;
}

let text_decoration styles =
  match (List.mem Underline styles, List.mem Strikethrough styles) with
  | true, true ->
      Some "underline line-through"
  | true, false ->
      Some "underline"
  | false, true ->
      Some "line-through"
  | false, false ->
      None

let when_styled style value (token : styled_token) =
  if List.mem style token.font_style then
    Some value
  else
    None

let props =
  [
    {
      css = "font-weight";
      kind = Named "font-weight";
      value = (fun _ token -> when_styled Bold "bold" token);
      neutral = (fun _ -> "normal");
    };
    {
      css = "font-style";
      kind = Named "font-style";
      value = (fun _ token -> when_styled Italic "italic" token);
      neutral = (fun _ -> "normal");
    };
    {
      css = "text-decoration";
      kind = Named "text-decoration";
      value = (fun _ token -> text_decoration token.font_style);
      neutral = (fun _ -> "none");
    };
    {
      css = "background-color";
      kind = Named "token-bg";
      value = (fun _ token -> Option.bind token.background Escape.css_color);
      neutral = (fun _ -> "transparent");
    };
    {
      css = "color";
      kind = Colour;
      value = (fun _ token -> Option.bind token.foreground Escape.css_color);
      neutral =
        (fun (theme : Theme.theme) ->
          Option.value (Escape.css_color theme.fg) ~default:"inherit"
        );
    };
  ]

let is_colour_prop prop = prop.kind = Colour || prop.css = "background-color"

(** [prefix] ends with [-]. The variable a token reads, set by {!theme_css}. *)
let read_var ~prefix prop =
  match prop.kind with
  | Colour ->
      css_var_foreground_name prefix
  | Named name ->
      prefix ^ name

(** The variable that holds one theme's value of [prop]. *)
let theme_var ~prefix ~label prop =
  match prop.kind with
  | Colour ->
      prefix ^ label
  | Named name ->
      prefix ^ label ^ "-" ^ name

let token_style_to_css ~emit_default ~prefix theme token =
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
             (prop.value theme token)
         )
         props
      )

(** The inline declarations that make a token follow every theme. A property is
    needed when any theme gives the token a value for it. The token then reads
    its variable, and every theme defines that variable, with the neutral value
    where the theme has none, so no value leaks from one theme into another. The
    primary theme reads from its own fallback, unless [emit_default] is false:
    then it defines variables like the extra themes, and colours are left to the
    page. *)
let token_theme_declarations ~prefix ~emit_default ~label (theme, token) extras
    =
  let themed = (label, theme, token) :: extras in
  let needed =
    List.filter
      (fun prop ->
        List.exists
          (fun (_, theme, token) -> prop.value theme token <> None)
          themed
      )
      props
  in
  let reads =
    List.filter_map
      (fun prop ->
        let read = read_var ~prefix prop in
        if emit_default then
          if prop.value theme token = None then
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
      (fun (label, theme, token) ->
        List.map
          (fun prop ->
            theme_var ~prefix ~label prop
            ^ ":"
            ^ Option.value (prop.value theme token) ~default:(prop.neutral theme)
          )
          needed
      )
      defined
  in
  reads @ definitions

let escape_text = Escape.to_string Escape.html

(** A carriage return directly before a line feed stays raw: an HTML parser
    reads the pair as one newline. Any other carriage return is written as a
    character reference, because a raw one would be read as a newline. *)
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

(** Moves a carriage return that ends a token into the token that starts with
    the line feed, so the pair is never split between two elements. *)
let rec join_crlf = function
  | (first : styled_token) :: (second : styled_token) :: rest
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
(** Registry for collecting style->class mappings during rendering. [table]
    gives O(1) dedup lookup per token; [order] tracks insertion order for
    {!collect_classes}. *)

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

let render_token ~options ~registry ~extras ~emit_default ~label
    (primary_theme, primary) =
  let prefix = options.Html_options.css_variable_prefix in
  let primary_style =
    token_style_to_css ~emit_default ~prefix primary_theme primary
  in
  let extra_vars =
    token_theme_declarations ~prefix ~emit_default ~label
      (primary_theme, primary) extras
  in
  let text = escape_token_text primary.text in
  match
    render_span_attrs ~options ~registry ~style:primary_style
      ~extra_style:(String.concat ";" extra_vars)
      primary.decoration primary.scopes
  with
  | None ->
      text
  | Some attrs ->
      Printf.sprintf "<span %s>%s</span>" attrs text

let render_line ~options ~registry ~extras_line ~emit_default ~label
    ~primary_theme primary_line =
  let primary_line = join_crlf primary_line in
  let extras_arrays =
    List.map
      (fun (label, theme, line) ->
        (label, theme, Array.of_list (join_crlf line))
      )
      extras_line
  in
  let render_one i tok =
    let extras =
      List.map
        (fun (label, theme, arr) -> (label, theme, Array.get arr i))
        extras_arrays
    in
    render_token ~options ~registry ~extras ~emit_default ~label
      (primary_theme, tok)
  in
  String.concat "" (List.mapi render_one primary_line)

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

let render ?(options = Html_options.default) ?label theme ?(extra_themes = [])
    code =
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
  let extra_themes =
    List.map
      (fun (label, theme, tokens) -> (Escape.css_ident label, theme, tokens))
      extra_themes
  in
  let label = Escape.css_ident (Option.value label ~default:theme.Theme.name) in
  let has_extras = extra_themes <> [] in
  let emit_default_color = options.default_color = Html_options.Default_color in
  let labels =
    List.map (fun (label, _, _) -> label) extra_themes
    @
    if emit_default_color then
      []
    else
      [ label ]
  in
  ( match
      List.find_opt
        (fun label -> List.length (List.filter (String.equal label) labels) > 1)
        labels
    with
  | Some label ->
      invalid_arg
        (Printf.sprintf
           "Render_html.render: the theme label %S is used twice (after \
            replacing characters outside A-Za-z0-9_-); each theme needs its \
            own label, and the default theme is labelled by ?label or its name \
            when default_color is No_default_color"
           label
        )
  | None ->
      ()
  );
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
  let extra_lines =
    List.map
      (fun (label, theme, tokens) -> (label, theme, Array.of_list tokens))
      extra_themes
  in
  let lines =
    List.mapi
      (fun i line ->
        let extras_line =
          List.map
            (fun (label, theme, tokens) -> (label, theme, tokens.(i)))
            extra_lines
        in
        let content =
          render_line ~options ~registry ~extras_line ~emit_default ~label
            ~primary_theme:theme line
        in
        if options.line_numbers then
          Printf.sprintf "<span class=\"line\" data-line=\"%d\">%s</span>"
            (i + 1) content
        else
          Printf.sprintf "<span class=\"line\">%s</span>" content
      )
      code
  in
  let code_content = String.concat "" lines in
  let pre_classes =
    let classes =
      [ "ochre" ]
      @ ( if has_extras then
            [ "ochre-themes" ]
          else
            []
        )
      @ ( if has_extras then
            theme.Theme.name
            :: List.map
                 (fun (_label, theme, _tokens) -> theme.Theme.name)
                 extra_themes
          else
            []
        )
      @ match options.pre_class with Some c -> [ c ] | None -> []
    in
    dedupe_preserving_order classes
  in
  let pre_class_attr = escape_text (String.concat " " pre_classes) in
  let page_variables (label, (theme : Theme.theme)) =
    List.filter_map Fun.id
      [
        color_declaration (fun c -> prefix ^ label ^ "-bg:" ^ c) (Some theme.bg);
        color_declaration (fun c -> prefix ^ label ^ ":" ^ c) (Some theme.fg);
      ]
  in
  let themes_as_variables =
    ( if emit_default then
        []
      else
        [ (label, theme) ]
    )
    @ List.map (fun (label, theme, _tokens) -> (label, theme)) extra_themes
  in
  let pre_style_parts =
    ( if emit_default then
        List.filter_map Fun.id
          [
            color_declaration
              (fun c ->
                "background-color:var("
                ^ css_var_background_name prefix
                ^ "," ^ c ^ ")"
              )
              (Some theme.Theme.bg);
            color_declaration
              (fun c ->
                "color:var(" ^ css_var_foreground_name prefix ^ "," ^ c ^ ")"
              )
              (Some theme.Theme.fg);
          ]
      else
        []
    )
    @ List.concat_map page_variables themes_as_variables
  in
  let pre_style =
    if pre_style_parts <> [] then
      Printf.sprintf " style=\"%s\"" (String.concat ";" pre_style_parts)
    else
      ""
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
    (theme : Theme.theme) code =
  let prefix =
    Escape.css_ident
      (Html_options.normalize_css_variable_prefix css_variable_prefix)
  in
  let reg = create_registry (Escape.css_ident class_prefix) in
  List.iter
    (fun line ->
      List.iter
        (fun (tok : styled_token) ->
          let style = token_style_to_css ~emit_default:true ~prefix theme tok in
          if style <> "" then ignore (class_for_style reg style)
        )
        line
    )
    code;
  let buf = Buffer.create 512 in
  let declarations =
    List.filter_map Fun.id
      [
        color_declaration (fun c -> "background-color:" ^ c) (Some theme.bg);
        color_declaration (fun c -> "color:" ^ c) (Some theme.fg);
      ]
  in
  if declarations <> [] then
    Buffer.add_string buf
      (Printf.sprintf ".ochre { %s }\n" (String.concat "; " declarations));
  Buffer.add_string buf (collect_classes reg);
  Buffer.contents buf
