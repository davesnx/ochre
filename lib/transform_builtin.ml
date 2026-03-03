let line_highlight ?(background = "#ffffff22") lines =
  Transform.make "line-highlight" ~after_line:(fun ~line_index line ->
      if List.mem line_index lines then
        List.map
          (fun (tok : Token.styled_token) ->
            { tok with background = Some background })
          line
      else line)

let word_highlight ?(foreground = "#ffff00") ?(font_style = [ Token.Bold ])
    words =
  Transform.make "word-highlight" ~after_line:(fun ~line_index:_ line ->
      List.map
        (fun (tok : Token.styled_token) ->
          if List.mem tok.text words then
            { tok with foreground = Some foreground; font_style }
          else tok)
        line)

let diff_markers =
  Transform.make "diff-markers" ~before_render:(fun doc ->
      List.map
        (fun line ->
          match line with
          | ({ Token.text; _ } as first) :: rest
            when String.length text > 0 && text.[0] = '+' ->
              List.map
                (fun (tok : Token.styled_token) ->
                  { tok with background = Some "#22883322" })
                ({
                   first with
                   text = String.sub text 1 (String.length text - 1);
                 }
                :: rest)
          | ({ Token.text; _ } as first) :: rest
            when String.length text > 0 && text.[0] = '-' ->
              List.map
                (fun (tok : Token.styled_token) ->
                  { tok with background = Some "#88222222" })
                ({
                   first with
                   text = String.sub text 1 (String.length text - 1);
                 }
                :: rest)
          | line -> line)
        doc)

let scope_marker ?(background = "#ffff0033") scope_prefix =
  Transform.make "scope-marker" ~after_line:(fun ~line_index:_ line ->
      List.map
        (fun (tok : Token.styled_token) ->
          if
            List.exists
              (fun s ->
                String.length s >= String.length scope_prefix
                && String.sub s 0 (String.length scope_prefix) = scope_prefix)
              tok.scopes
          then { tok with background = Some background }
          else tok)
        line)
