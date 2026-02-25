(** Core types for styled syntax highlighting.

    These types represent the output of the highlighting pipeline:
    source code tokenized and styled according to a TextMate theme. *)

(** Hex color string (e.g. ["#ff0000"]). *)
type color = string

(** Font style that can be applied to a token. *)
type font_style =
  | Bold
  | Italic
  | Underline
  | Strikethrough

(** A token with resolved styling from a theme.

    Each token represents a fragment of source code with its associated
    colors and font styles, as determined by TextMate scope matching. *)
type styled_token = {
  text : string;
  foreground : color option;
  background : color option;
  font_style : font_style list;
  scopes : string list;
}

(** A line of styled tokens. *)
type line = styled_token list

(** Complete highlighted code: a list of lines, each containing styled tokens.

    {[
      let code : Token.highlighted_code =
        Ochre.highlight_to_tokens hl ~lang:"ocaml" "let x = 42"
      in
      List.iter (fun line ->
        List.iter (fun (tok : Token.styled_token) ->
          Printf.printf "%s" tok.text
        ) line
      ) code
    ]} *)
type highlighted_code = line list
