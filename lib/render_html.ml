open Token

let font_style_to_css_var_fallback prefix = function
  | Bold ->
      "font-weight:var(" ^ prefix ^ "font-weight,bold)"
  | Italic ->
      "font-style:var(" ^ prefix ^ "font-style,italic)"
  | Underline ->
      "text-decoration:var(" ^ prefix ^ "text-decoration,underline)"
  | Strikethrough ->
      "text-decoration:var(" ^ prefix ^ "text-decoration,line-through)"

let css_var_foreground_name prefix =
  if String.length prefix > 0 && prefix.[String.length prefix - 1] = '-' then
    String.sub prefix 0 (String.length prefix - 1)
  else
    prefix

let css_var_background_name prefix = prefix ^ "bg"

(** [prefix] is expected to end with [-] (e.g. [--ochre-dark-]). *)
let font_style_to_css_var prefix = function
  | Bold ->
      prefix ^ "font-weight:bold"
  | Italic ->
      prefix ^ "font-style:italic"
  | Underline ->
      prefix ^ "text-decoration:underline"
  | Strikethrough ->
      prefix ^ "text-decoration:line-through"

let color_declaration prop color =
  Option.map (fun c -> prop c) (Option.bind color Escape.css_color)

let token_style_to_css ~emit_default ~prefix token =
  if not emit_default then
    ""
  else
    let fg_var = css_var_foreground_name prefix in
    let bg_var = css_var_background_name prefix in
    let colors =
      List.filter_map Fun.id
        [
          color_declaration
            (fun c -> "color:var(" ^ fg_var ^ "," ^ c ^ ")")
            token.foreground;
          color_declaration
            (fun c -> "background-color:var(" ^ bg_var ^ "," ^ c ^ ")")
            token.background;
        ]
    in
    String.concat ";"
      (List.map (font_style_to_css_var_fallback prefix) token.font_style
      @ List.rev colors
      )

(** Generate CSS custom property declarations for a themed token. [prefix] must
    end with [-] (e.g. [--ochre-dark-]). Produces vars like
    [--ochre-dark:#color], [--ochre-dark-bg:#color],
    [--ochre-dark-font-weight:bold]. *)
let token_style_to_css_vars prefix token =
  let fg_name = css_var_foreground_name prefix in
  let vars =
    List.filter_map Fun.id
      [
        color_declaration (fun c -> fg_name ^ ":" ^ c) token.foreground;
        color_declaration (fun c -> prefix ^ "bg:" ^ c) token.background;
      ]
  in
  let vars = List.rev vars in
  let vars = List.map (font_style_to_css_var prefix) token.font_style @ vars in
  vars

let escape_text = Escape.to_string Escape.html

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

let render_token ~options ~registry ~extras ~emit_default primary =
  let prefix = options.Html_options.css_variable_prefix in
  let primary_style = token_style_to_css ~emit_default ~prefix primary in
  let extra_vars =
    List.concat_map
      (fun (label, tok) -> token_style_to_css_vars (prefix ^ label ^ "-") tok)
      extras
  in
  let text = escape_text primary.text in
  match
    render_span_attrs ~options ~registry ~style:primary_style
      ~extra_style:(String.concat ";" extra_vars)
      primary.decoration primary.scopes
  with
  | None ->
      text
  | Some attrs ->
      Printf.sprintf "<span %s>%s</span>" attrs text

let render_line ~options ~registry ~extras_line ~emit_default primary_line =
  let extras_arrays =
    List.map (fun (label, line) -> (label, Array.of_list line)) extras_line
  in
  let render_one i tok =
    let extras =
      List.map (fun (label, arr) -> (label, Array.get arr i)) extras_arrays
    in
    render_token ~options ~registry ~extras ~emit_default tok
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

let render ?(options = Html_options.default) theme ?(extra_themes = []) code =
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
  let has_extras = extra_themes <> [] in
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
  let extras_arrays =
    List.map
      (fun (label, _theme, tokens) -> (label, Array.of_list tokens))
      extra_themes
  in
  let lines =
    List.mapi
      (fun i line ->
        let extras_line =
          List.map (fun (label, arr) -> (label, Array.get arr i)) extras_arrays
        in
        let content =
          render_line ~options ~registry ~extras_line ~emit_default line
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
    @
    if has_extras then
      List.concat_map
        (fun (label, theme, _tokens) ->
          List.filter_map Fun.id
            [
              color_declaration
                (fun c -> prefix ^ label ^ "-bg:" ^ c)
                (Some theme.Theme.bg);
              color_declaration
                (fun c -> prefix ^ label ^ ":" ^ c)
                (Some theme.Theme.fg);
            ]
        )
        extra_themes
    else
      []
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

let theme_css label =
  let label = Escape.css_ident label in
  let prefix = "--ochre-" in
  let base_fg = css_var_foreground_name prefix in
  let base_bg = css_var_background_name prefix in
  let base_font_style = prefix ^ "font-style" in
  let base_font_weight = prefix ^ "font-weight" in
  let base_text_decoration = prefix ^ "text-decoration" in
  let themed_fg = prefix ^ label in
  let themed_prefix = prefix ^ label ^ "-" in
  Printf.sprintf
    {|.ochre,
.ochre span {
  %s: var(%s);
  %s: var(%sbg);
  %s: var(%sfont-style);
  %s: var(%sfont-weight);
  %s: var(%stext-decoration);
}|}
    base_fg themed_fg base_bg themed_prefix base_font_style themed_prefix
    base_font_weight themed_prefix base_text_decoration themed_prefix

let collect_classes registry =
  let buf = Buffer.create 256 in
  List.iter
    (fun (style, cls) ->
      Buffer.add_string buf (Printf.sprintf ".%s { %s }\n" cls style)
    )
    (List.rev registry.order);
  Buffer.contents buf

let render_theme_css ~class_prefix (theme : Theme.theme) code =
  let reg = create_registry (Escape.css_ident class_prefix) in
  List.iter
    (fun line ->
      List.iter
        (fun (tok : styled_token) ->
          let style =
            token_style_to_css ~emit_default:true ~prefix:"--ochre-" tok
          in
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
