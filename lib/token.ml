type position = { offset : int; line : int; column : int; length : int }

type decoration_properties = {
  class_ : string option;
  style : string option;
  data : (string * string) list;
}

type styles = { themes : Theme.theme array; values : Style.t array }

type t = {
  text : string;
  position : position;
  scopes : string list;
  styles : styles;
  decoration : decoration_properties option;
}

type line = t list

let make_styles themes values = { themes; values }

let style token = token.styles.values.(0)
let style_at index token = token.styles.values.(index)
let style_count token = Array.length token.styles.values
let all_styles token = Array.to_list token.styles.values

let reorder_styles order token =
  let { themes; values } = token.styles in
  {
    token with
    styles =
      {
        themes = Array.map (fun i -> themes.(i)) order;
        values = Array.map (fun i -> values.(i)) order;
      };
  }

let map_style f token =
  let { themes; values } = token.styles in
  {
    token with
    styles = { themes; values = Array.mapi (fun i s -> f themes.(i) s) values };
  }

let slice token ~pos ~len =
  let position =
    if token.position.length = String.length token.text then
      {
        token.position with
        offset = token.position.offset + pos;
        column = token.position.column + pos;
        length = len;
      }
    else
      token.position
  in
  { token with text = String.sub token.text pos len; position }

let sub token ~pos ~len =
  if pos >= 0 && len >= 0 && len <= String.length token.text - pos then
    Some (slice token ~pos ~len)
  else
    None

let inserted token ~at text =
  {
    token with
    text;
    position =
      {
        token.position with
        offset = token.position.offset + at;
        column = token.position.column + at;
        length = 0;
      };
    decoration = None;
  }

let insert_before token text = inserted token ~at:0 text
let insert_after token text = inserted token ~at:token.position.length text
