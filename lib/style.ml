type font_style = {
  bold : bool;
  italic : bool;
  underline : bool;
  strikethrough : bool;
}

let plain =
  { bold = false; italic = false; underline = false; strikethrough = false }

type t = {
  foreground : Color.t;
  background : Color.t option;
  font_style : font_style;
}
