open Token

let font_style_to_css = function
  | Bold -> "font-weight:bold"
  | Italic -> "font-style:italic"
  | Underline -> "text-decoration:underline"
  | Strikethrough -> "text-decoration:line-through"

let font_style_to_css_var prefix = function
  | Bold -> prefix ^ "-font-weight:bold"
  | Italic -> prefix ^ "-font-style:italic"
  | Underline -> prefix ^ "-text-decoration:underline"
  | Strikethrough -> prefix ^ "-text-decoration:line-through"

let token_style_to_css token =
  let styles = [] in
  let styles =
    match token.foreground with
    | Some color -> ("color:" ^ color) :: styles
    | None -> styles
  in
  let styles =
    match token.background with
    | Some color -> ("background-color:" ^ color) :: styles
    | None -> styles
  in
  let styles = List.map font_style_to_css token.font_style @ styles in
  String.concat ";" styles

let token_style_to_css_vars prefix token =
  let vars = [] in
  let vars =
    match token.foreground with
    | Some color -> (prefix ^ ":" ^ color) :: vars
    | None -> vars
  in
  let vars =
    match token.background with
    | Some color -> (prefix ^ "-bg:" ^ color) :: vars
    | None -> vars
  in
  let vars = List.map (font_style_to_css_var prefix) token.font_style @ vars in
  vars

let escape_text text =
  let buf = Buffer.create (String.length text) in
  Escape.html buf text;
  Buffer.contents buf

let render_span_attrs style decoration =
  match decoration with
  | None ->
      if style = "" then None else Some (Printf.sprintf "style=\"%s\"" style)
  | Some (dec : decoration_properties) ->
      let attrs = [] in
      let attrs =
        match dec.class_ with
        | Some c -> Printf.sprintf "class=\"%s\"" c :: attrs
        | None -> attrs
      in
      let combined_style =
        match (style, dec.style) with
        | "", None -> ""
        | s, None | "", Some s -> s
        | s, Some ds -> s ^ ";" ^ ds
      in
      let attrs =
        if combined_style <> "" then
          Printf.sprintf "style=\"%s\"" combined_style :: attrs
        else attrs
      in
      let attrs =
        List.fold_left
          (fun acc (k, v) -> Printf.sprintf "data-%s=\"%s\"" k v :: acc)
          attrs dec.data
      in
      if attrs = [] then None else Some (String.concat " " attrs)

(** Render a single token with optional extra themed tokens. [extras] is a list
    of [(label, token)] pairs whose colors become [--ochre-<label>:] CSS custom
    properties. *)
let render_token ~extras primary =
  let primary_style = token_style_to_css primary in
  let extra_vars =
    List.concat_map
      (fun (label, tok) -> token_style_to_css_vars ("--ochre-" ^ label) tok)
      extras
  in
  let all_parts =
    (if primary_style <> "" then [ primary_style ] else []) @ extra_vars
  in
  let style = String.concat ";" all_parts in
  let text = escape_text primary.text in
  match render_span_attrs style primary.decoration with
  | None -> text
  | Some attrs -> Printf.sprintf "<span %s>%s</span>" attrs text

let render_line ~extras_line primary_line =
  let render_one i tok =
    let extras =
      List.map (fun (label, line) -> (label, List.nth line i)) extras_line
    in
    render_token ~extras tok
  in
  String.concat "" (List.mapi render_one primary_line)

let render theme ?(themes = []) code =
  let has_extras = themes <> [] in
  let extras_codes =
    List.map (fun (label, _theme, tokens) -> (label, tokens)) themes
  in
  let lines =
    List.mapi
      (fun i line ->
        let extras_line =
          List.map
            (fun (label, codes) -> (label, List.nth codes i))
            extras_codes
        in
        Printf.sprintf "<span class=\"line\">%s</span>"
          (render_line ~extras_line line))
      code
  in
  let code_content = String.concat "\n" lines in
  if has_extras then
    let theme_names =
      theme.Theme.name
      :: List.map (fun (_label, theme, _tokens) -> theme.Theme.name) themes
    in
    let extra_pre_vars =
      List.concat_map
        (fun (label, theme, _tokens) ->
          let prefix = "--ochre-" ^ label in
          [ prefix ^ "-bg:" ^ theme.Theme.bg; prefix ^ ":" ^ theme.Theme.fg ])
        themes
    in
    let pre_style =
      ("background-color:" ^ theme.Theme.bg)
      :: ("color:" ^ theme.Theme.fg)
      :: extra_pre_vars
    in
    Printf.sprintf
      "<pre class=\"ochre ochre-themes %s\" style=\"%s\" \
       tabindex=\"0\"><code>%s</code></pre>"
      (String.concat " " theme_names)
      (String.concat ";" pre_style)
      code_content
  else
    Printf.sprintf
      "<pre class=\"ochre\" style=\"background-color:%s;color:%s\"><code \
       style=\"display:block;padding:20px\">%s</code></pre>"
      theme.Theme.bg theme.Theme.fg code_content

let css_for_theme label =
  let prefix = "--ochre-" ^ label in
  Printf.sprintf
    {|.ochre,
.ochre span {
  color: var(%s) !important;
  background-color: var(%s-bg) !important;
  font-style: var(%s-font-style) !important;
  font-weight: var(%s-font-weight) !important;
  text-decoration: var(%s-text-decoration) !important;
}|}
    prefix prefix prefix prefix prefix

let dark_mode_css =
  let prefix = "--ochre-dark" in
  Printf.sprintf
    {|@media (prefers-color-scheme: dark) {
  .ochre,
  .ochre span {
    color: var(%s) !important;
    background-color: var(%s-bg) !important;
    font-style: var(%s-font-style) !important;
    font-weight: var(%s-font-weight) !important;
    text-decoration: var(%s-text-decoration) !important;
  }
}|}
    prefix prefix prefix prefix prefix
