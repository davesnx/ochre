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

let token_style_to_css ~emit_default ~prefix token =
  let fg_var = css_var_foreground_name prefix in
  let bg_var = css_var_background_name prefix in
  let styles = [] in
  let styles =
    if emit_default then
      match token.foreground with
      | Some color ->
          ("color:var(" ^ fg_var ^ "," ^ color ^ ")") :: styles
      | None ->
          styles
    else
      styles
  in
  let styles =
    if emit_default then
      match token.background with
      | Some color ->
          ("background-color:var(" ^ bg_var ^ "," ^ color ^ ")") :: styles
      | None ->
          styles
    else
      styles
  in
  let styles =
    if emit_default then
      List.map (font_style_to_css_var_fallback prefix) token.font_style @ styles
    else
      styles
  in
  String.concat ";" styles

(** Generate CSS custom property declarations for a themed token. [prefix] must
    end with [-] (e.g. [--ochre-dark-]). Produces vars like
    [--ochre-dark:#color], [--ochre-dark-bg:#color],
    [--ochre-dark-font-weight:bold]. *)
let token_style_to_css_vars prefix token =
  let fg_name = css_var_foreground_name prefix in
  let vars = [] in
  let vars =
    match token.foreground with
    | Some color ->
        (fg_name ^ ":" ^ color) :: vars
    | None ->
        vars
  in
  let vars =
    match token.background with
    | Some color ->
        (prefix ^ "bg:" ^ color) :: vars
    | None ->
        vars
  in
  let vars = List.map (font_style_to_css_var prefix) token.font_style @ vars in
  vars

let escape_text text =
  let buf = Buffer.create (String.length text) in
  Escape.html buf text;
  Buffer.contents buf

(** Deterministic hash of a style string to produce short class names. *)
let style_hash s =
  (* Simple DJB2 hash *)
  let h = ref 5381 in
  String.iter (fun c -> h := (!h * 33) + Char.code c) s;
  let h = !h land 0x7FFFFFFF in
  Printf.sprintf "%x" h

type class_registry = { mutable map : (string * string) list; prefix : string }
(** Registry for collecting style->class mappings during rendering. *)

let create_registry prefix = { map = []; prefix }

let class_for_style registry style =
  match List.assoc_opt style registry.map with
  | Some cls ->
      cls
  | None ->
      let cls = registry.prefix ^ style_hash style in
      registry.map <- (style, cls) :: registry.map;
      cls

let render_span_attrs ~options ~registry style decoration scopes =
  let open Html_options in
  let attrs = [] in
  (* scope data attribute *)
  let attrs =
    if options.scopes_as_data_attrs && scopes <> [] then
      Printf.sprintf "data-scope=\"%s\"" (String.concat " " scopes) :: attrs
    else
      attrs
  in
  (* decoration properties *)
  let attrs, extra_style =
    match decoration with
    | None ->
        (attrs, None)
    | Some (dec : decoration_properties) ->
        let a = attrs in
        let a =
          match dec.class_ with
          | Some c ->
              Printf.sprintf "class=\"%s\"" c :: a
          | None ->
              a
        in
        let a =
          List.fold_left
            (fun acc (k, v) -> Printf.sprintf "data-%s=\"%s\"" k v :: acc)
            a dec.data
        in
        (a, dec.style)
  in
  let combined_style =
    match (style, extra_style) with
    | "", None ->
        ""
    | s, None | "", Some s ->
        s
    | s, Some ds ->
        s ^ ";" ^ ds
  in
  match options.style_mode with
  | Inline_styles ->
      if combined_style = "" && attrs = [] then
        None
      else
        let parts =
          if combined_style <> "" then
            Printf.sprintf "style=\"%s\"" combined_style :: attrs
          else
            attrs
        in
        Some (String.concat " " parts)
  | Css_classes { class_prefix = _ } -> (
      match registry with
      | None ->
          (* fallback to inline if no registry *)
          if combined_style = "" && attrs = [] then
            None
          else
            let parts =
              if combined_style <> "" then
                Printf.sprintf "style=\"%s\"" combined_style :: attrs
              else
                attrs
            in
            Some (String.concat " " parts)
      | Some reg ->
          if combined_style = "" && attrs = [] then
            None
          else
            let cls_attr =
              if combined_style <> "" then
                let cls = class_for_style reg combined_style in
                (* merge with existing class attr from decoration *)
                match decoration with
                | Some { class_ = Some existing; _ } ->
                    Printf.sprintf "class=\"%s %s\"" existing cls
                | _ ->
                    Printf.sprintf "class=\"%s\"" cls
              else
                match decoration with
                | Some { class_ = Some c; _ } ->
                    Printf.sprintf "class=\"%s\"" c
                | _ ->
                    ""
            in
            (* filter out the old class attr from attrs, add new one *)
            let other_attrs =
              List.filter
                (fun a ->
                  not (String.length a >= 6 && String.sub a 0 6 = "class=")
                )
                attrs
            in
            let parts =
              if cls_attr <> "" then
                cls_attr :: other_attrs
              else
                other_attrs
            in
            if parts = [] then
              None
            else
              Some (String.concat " " parts)
    )

let render_token ~options ~registry ~extras ~emit_default primary =
  let prefix = options.Html_options.css_variable_prefix in
  let primary_style = token_style_to_css ~emit_default ~prefix primary in
  let extra_vars =
    List.concat_map
      (fun (label, tok) -> token_style_to_css_vars (prefix ^ label ^ "-") tok)
      extras
  in
  let all_parts =
    ( if primary_style <> "" then
        [ primary_style ]
      else
        []
    )
    @ extra_vars
  in
  let style = String.concat ";" all_parts in
  let text = escape_text primary.text in
  match
    render_span_attrs ~options ~registry style primary.decoration primary.scopes
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
  let has_extras = extra_themes <> [] in
  let prefix = options.css_variable_prefix in
  let extras_codes =
    List.map (fun (label, _theme, tokens) -> (label, tokens)) extra_themes
  in
  (* Create class registry if using CSS classes mode *)
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
  let emit_default_token_styles = emit_default in
  let extras_arrays =
    List.map (fun (label, codes) -> (label, Array.of_list codes)) extras_codes
  in
  let lines =
    List.mapi
      (fun i line ->
        let extras_line =
          List.map (fun (label, arr) -> (label, Array.get arr i)) extras_arrays
        in
        let content =
          render_line ~options ~registry ~extras_line
            ~emit_default:emit_default_token_styles line
        in
        if options.line_numbers then
          Printf.sprintf "<span class=\"line\" data-line=\"%d\">%s</span>"
            (i + 1) content
        else
          Printf.sprintf "<span class=\"line\">%s</span>" content
      )
      code
  in
  let code_content = String.concat "\n" lines in
  (* Build <pre> classes *)
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
  let pre_class_attr = String.concat " " pre_classes in
  (* Build <code> class *)
  let code_class_attr =
    match options.code_class with Some c -> Some c | None -> None
  in
  (* Build <pre> style *)
  let pre_style_parts =
    ( if emit_default then
        [
          "background-color:var("
          ^ css_var_background_name prefix
          ^ "," ^ theme.Theme.bg ^ ")";
          "color:var("
          ^ css_var_foreground_name prefix
          ^ "," ^ theme.Theme.fg ^ ")";
        ]
      else
        []
    )
    @
    if has_extras then
      List.concat_map
        (fun (label, theme, _tokens) ->
          [
            prefix ^ label ^ "-bg:" ^ theme.Theme.bg;
            prefix ^ label ^ ":" ^ theme.Theme.fg;
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
    match code_class_attr with
    | Some c ->
        Printf.sprintf " class=\"%s\"" c
    | None ->
        ""
  in
  Printf.sprintf "<pre class=\"%s\"%s tabindex=\"0\"><code%s>%s</code></pre>"
    pre_class_attr pre_style code_attrs code_content

let theme_css label =
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

(** Generate a CSS stylesheet from a class registry (for Css_classes mode).
    Returns a string of CSS rules mapping each class to its style properties. *)
let collect_classes registry =
  let buf = Buffer.create 256 in
  List.iter
    (fun (style, cls) ->
      Buffer.add_string buf (Printf.sprintf ".%s { %s }\n" cls style)
    )
    (List.rev registry.map);
  Buffer.contents buf

(** Generate a complete CSS stylesheet for a theme (for class-based mode). Maps
    each unique token style to a deterministic class name. *)
let render_theme_css ~class_prefix (theme : Theme.theme) code =
  let reg = create_registry class_prefix in
  (* Walk all tokens to register their styles *)
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
  (* Add the pre/code base styles *)
  let buf = Buffer.create 512 in
  Buffer.add_string buf
    (Printf.sprintf ".ochre { background-color:%s; color:%s }\n" theme.bg
       theme.fg
    );
  Buffer.add_string buf (collect_classes reg);
  Buffer.contents buf
