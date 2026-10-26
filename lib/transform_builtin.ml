let line_highlight ?(background = "#ffffff22") lines =
  Transform.make "line-highlight" ~after_line:(fun ~line_index line ->
      if List.mem line_index lines then
        List.map
          (fun (tok : Token.styled_token) ->
            { tok with background = Some background }
          )
          line
      else
        line
  )

let word_highlight ?(foreground = "#ffff00") ?(font_style = [ Token.Bold ])
    words =
  Transform.make "word-highlight" ~after_line:(fun ~line_index:_ line ->
      List.map
        (fun (tok : Token.styled_token) ->
          if List.mem tok.text words then
            { tok with foreground = Some foreground; font_style }
          else
            tok
        )
        line
  )

let strip_marker (first : Token.styled_token) rest =
  let text = String.sub first.text 1 (String.length first.text - 1) in
  if text = "" then
    rest
  else
    { first with text } :: rest

let diff_markers =
  Transform.make "diff-markers" ~before_render:(fun doc ->
      List.map
        (fun line ->
          let with_background background line =
            List.map
              (fun (tok : Token.styled_token) ->
                { tok with background = Some background }
              )
              line
          in
          match line with
          | ({ Token.text; _ } as first) :: rest
            when String.length text > 0 && text.[0] = '+' ->
              with_background "#22883322" (strip_marker first rest)
          | ({ Token.text; _ } as first) :: rest
            when String.length text > 0 && text.[0] = '-' ->
              with_background "#88222222" (strip_marker first rest)
          | line ->
              line
        )
        doc
  )

let scope_marker ?(background = "#ffff0033") scope_prefix =
  Transform.make "scope-marker" ~after_line:(fun ~line_index:_ line ->
      List.map
        (fun (tok : Token.styled_token) ->
          if
            List.exists
              (fun s ->
                String.length s >= String.length scope_prefix
                && String.sub s 0 (String.length scope_prefix) = scope_prefix
              )
              tok.scopes
          then
            { tok with background = Some background }
          else
            tok
        )
        line
  )

(* Notation transforms mirror Shiki's [createCommentNotationTransformer]: a
   marker such as [[!code highlight]] must sit inside the last comment of a
   line, and the comment goes away when nothing else is left in it. *)

let block_comments =
  [ ("--[[", "]]"); ("<!--", "-->"); ("/*", "*/"); ("(*", "*)"); ("{-", "-}") ]

let line_comments = [ "//"; ";;"; "%%"; "--"; ";"; "%"; "#"; "\""; "'"; "*" ]
let search_openers = [ "//"; "#"; ";"; "%"; "--" ]
let is_blank = function ' ' | '\t' -> true | _ -> false

let starts_at text i prefix =
  let n = String.length prefix in
  let rec same k = k >= n || (text.[i + k] = prefix.[k] && same (k + 1)) in
  i >= 0 && i + n <= String.length text && same 0

let find_from text i pattern =
  let last = String.length text - String.length pattern in
  let rec go i =
    if i > last then
      None
    else if starts_at text i pattern then
      Some i
    else
      go (i + 1)
  in
  go i

let skip_blanks_back text i =
  let rec go i =
    if i > 0 && is_blank text.[i - 1] then
      go (i - 1)
    else
      i
  in
  go i

let skip_blanks text i =
  let rec go i =
    if i < String.length text && is_blank text.[i] then
      go (i + 1)
    else
      i
  in
  go i

let line_text line =
  String.concat "" (List.map (fun (tok : Token.styled_token) -> tok.text) line)

let body_length text =
  let n = String.length text in
  let n =
    if n > 0 && text.[n - 1] = '\n' then
      n - 1
    else
      n
  in
  if n > 0 && text.[n - 1] = '\r' then
    n - 1
  else
    n

(** Applies [f] to the pieces of tokens inside the sorted, disjoint [ranges]; a
    [None] drops the piece. One pass over the line. *)
let edit_ranges line ranges f =
  let rec go offset ranges = function
    | [] ->
        []
    | (tok : Token.styled_token) :: rest ->
        let next = offset + String.length tok.text in
        let rec drop = function
          | (_, stop) :: more when stop <= offset ->
              drop more
          | ranges ->
              ranges
        in
        let ranges = drop ranges in
        if next = offset then
          tok :: go next ranges rest
        else
          let piece a b inside =
            if a >= b then
              []
            else
              let tok =
                { tok with text = String.sub tok.text (a - offset) (b - a) }
              in
              if inside then
                Option.to_list (f tok)
              else
                [ tok ]
          in
          let rec split cursor ranges =
            match ranges with
            | (start, stop) :: more when start < next ->
                let low = max start cursor and high = min stop next in
                let before = piece cursor low false in
                let inside = piece low high true in
                if stop > next then
                  (before @ inside, ranges)
                else
                  let pieces, remaining = split high more in
                  (before @ inside @ pieces, remaining)
            | _ ->
                (piece cursor next false, ranges)
          in
          let pieces, ranges = split offset ranges in
          pieces @ go next ranges rest
  in
  go 0 ranges line

let edit_range line ~start ~stop f = edit_ranges line [ (start, stop) ] f

let has_scope ~prefix (tok : Token.styled_token) =
  List.exists
    (fun scope ->
      scope = prefix || String.starts_with ~prefix:(prefix ^ ".") scope
    )
    tok.scopes

let is_comment tok = has_scope ~prefix:"comment" tok

(** Plain text and Markdown give no comment scopes, so there a comment is found
    from its opener. Every other grammar must mark its comments. *)
let is_prose (tok : Token.styled_token) =
  tok.scopes = []
  || List.mem "text.html.markdown" tok.scopes
     && not (has_scope ~prefix:"string" tok || is_comment tok)

type context = {
  text : string;
  tokens : Token.styled_token array;
  offsets : int array;
  stop : int;
  run_start : int array;
  tail_is_comment : bool array;
  mutable last_opener : int array option;
  closers : (string, int * int option) Hashtbl.t;
}
(** What the notation scan needs to know about one line, built once, after a
    marker was seen on it. *)

let make_context line =
  let tokens = Array.of_list line in
  let count = Array.length tokens in
  let offsets = Array.make count 0 in
  let run_start = Array.make count 0 in
  let offset = ref 0 in
  Array.iteri
    (fun k (tok : Token.styled_token) ->
      offsets.(k) <- !offset;
      run_start.(k) <-
        ( if is_comment tok then
            if k > 0 && is_comment tokens.(k - 1) then
              run_start.(k - 1)
            else
              !offset
          else
            -1
        );
      offset := !offset + String.length tok.text
    )
    tokens;
  let tail_is_comment = Array.make (count + 1) true in
  for k = count - 1 downto 0 do
    tail_is_comment.(k) <-
      tail_is_comment.(k + 1)
      && (is_comment tokens.(k) || String.trim tokens.(k).text = "")
  done;
  let text = line_text line in
  let stop =
    let rec back i =
      if i > 0 && is_blank text.[i - 1] then
        back (i - 1)
      else
        i
    in
    back (body_length text)
  in
  {
    text;
    tokens;
    offsets;
    stop;
    run_start;
    tail_is_comment;
    last_opener = None;
    closers = Hashtbl.create 5;
  }

let holder ctx position =
  let low = ref 0 and high = ref (Array.length ctx.offsets - 1) in
  if !high < 0 then
    None
  else (
    while !low < !high do
      let middle = (!low + !high + 1) / 2 in
      if ctx.offsets.(middle) <= position then
        low := middle
      else
        high := middle - 1
    done;
    Some !low
  )

(** For each offset, the start of the last line-comment opener before it. *)
let last_opener ctx =
  match ctx.last_opener with
  | Some table ->
      table
  | None ->
      let n = String.length ctx.text in
      let table = Array.make (n + 1) (-1) in
      for i = 1 to n do
        table.(i) <-
          ( if List.exists (starts_at ctx.text (i - 1)) search_openers then
              i - 1
            else
              table.(i - 1)
          )
      done;
      ctx.last_opener <- Some table;
      table

let closes_after ctx position closer =
  let cached = Hashtbl.find_opt ctx.closers closer in
  match cached with
  | Some (from, found)
    when from <= position
         && match found with Some c -> c >= position | None -> true ->
      found <> None
  | _ ->
      let found = find_from ctx.text position closer in
      Hashtbl.replace ctx.closers closer (position, found);
      found <> None

let nearest_comment_start ctx position =
  let text = ctx.text in
  let block =
    List.filter_map
      (fun (opener, closer) ->
        let rec back i =
          if i < 0 then
            None
          else if starts_at text i opener then
            Some i
          else
            back (i - 1)
        in
        match back (position - 1) with
        | Some i when closes_after ctx position closer ->
            Some i
        | _ ->
            None
      )
      block_comments
  in
  match List.sort (fun a b -> compare b a) block with
  | start :: _ ->
      Some start
  | [] ->
      let start = (last_opener ctx).(position) in
      if start < 0 then
        None
      else
        Some start

type comment = {
  start : int;
  content_start : int;
  content_stop : int;
  stop : int;
}

(** The comment of the line that holds [position] and ends the line, as Shiki
    sees it: a block comment must close at the end of the line, any other
    comment runs to the end. Text that is not in a comment token is never part
    of it, except in plain text and Markdown. *)
let comment_around ctx position =
  let text = ctx.text and stop = ctx.stop in
  let start =
    match holder ctx position with
    | None ->
        None
    | Some k ->
        let tok = ctx.tokens.(k) in
        if is_comment tok then
          if ctx.tail_is_comment.(k + 1) then
            Some (skip_blanks text ctx.run_start.(k))
          else
            None
        else if is_prose tok then
          Option.map (skip_blanks text) (nearest_comment_start ctx position)
        else
          None
  in
  match start with
  | None ->
      None
  | Some start when start >= position || start >= stop ->
      None
  | Some start -> (
      let block =
        List.find_opt
          (fun (opener, _) -> starts_at text start opener)
          block_comments
      in
      match block with
      | Some (opener, closer) ->
          let content_start = start + String.length opener in
          let content_stop = stop - String.length closer in
          if
            content_stop > content_start
            && starts_at text content_stop closer
            && position >= content_start
          then
            Some { start; content_start; content_stop; stop }
          else
            None
      | None -> (
          match List.find_opt (starts_at text start) line_comments with
          | Some opener when position >= start + String.length opener ->
              Some
                {
                  start;
                  content_start = start + String.length opener;
                  content_stop = stop;
                  stop;
                }
          | _ ->
              None
        )
    )

type 'a marker = {
  payload : 'a;
  range : int option;
  comment_only : bool;
  deletion : (int * int) option;
}

(** The marker that [parse] reads in the comment that ends [line].
    [parse text i] reads a marker that starts at [i] and gives its end, a
    payload and the optional number of lines. *)
let find_marker ~parse line =
  let text = line_text line in
  match find_from text 0 "[!code " with
  | None ->
      None
  | Some first_position ->
      let ctx = make_context line in
      let rec search from =
        match find_from text from "[!code " with
        | None ->
            None
        | Some position -> (
            match parse text position with
            | None ->
                search (position + 1)
            | Some (stop, payload, range) -> (
                match comment_around ctx position with
                | Some comment when stop <= comment.content_stop ->
                    let first = skip_blanks_back text position in
                    let first = max first comment.content_start in
                    let rest =
                      String.sub text comment.content_start
                        (first - comment.content_start)
                      ^ String.sub text stop (comment.content_stop - stop)
                    in
                    let comment_only =
                      String.trim (String.sub text 0 comment.start) = ""
                    in
                    let deletion =
                      if String.trim rest = "" then
                        if comment_only then
                          None
                        else
                          Some
                            (skip_blanks_back text comment.start, comment.stop)
                      else
                        Some (first, stop)
                    in
                    Some { payload; range; comment_only; deletion }
                | _ ->
                    search (position + 1)
              )
          )
      in
      search first_position

let run_notation ~parse ~default_count ~apply doc =
  let lines = Array.of_list doc in
  let count = Array.length lines in
  let markers =
    List.filter_map Fun.id
      (List.mapi
         (fun i line -> Option.map (fun m -> (i, m)) (find_marker ~parse line))
         doc
      )
  in
  let removed = Array.make count false in
  List.iter
    (fun (i, marker) ->
      match marker.deletion with
      | Some (start, stop) ->
          lines.(i) <- edit_range lines.(i) ~start ~stop (fun _ -> None)
      | None ->
          removed.(i) <- true
    )
    markers;
  List.iter
    (fun (i, marker) ->
      let first =
        if marker.comment_only then
          i + 1
        else
          i
      in
      let last =
        min count
          (first + Option.value marker.range ~default:(default_count count))
      in
      for j = first to last - 1 do
        lines.(j) <- apply marker.payload lines.(j)
      done
    )
    markers;
  List.filteri (fun i _ -> not removed.(i)) (Array.to_list lines)

let is_digit = function '0' .. '9' -> true | _ -> false

let read_range text i =
  if i < String.length text && text.[i] = ':' then
    let rec digits j =
      if j < String.length text && is_digit text.[j] then
        digits (j + 1)
      else
        j
    in
    let stop = digits (i + 1) in
    if stop > i + 1 then
      Some (stop, int_of_string_opt (String.sub text (i + 1) (stop - i - 1)))
    else
      None
  else
    Some (i, None)

let parse_keyword keywords text position =
  let i = position + String.length "[!code " in
  List.find_map
    (fun keyword ->
      if starts_at text i keyword then
        match read_range text (i + String.length keyword) with
        | Some (j, range) when j < String.length text && text.[j] = ']' ->
            Some (j + 1, keyword, range)
        | _ ->
            None
      else
        None
    )
    keywords

let set_background background line =
  List.map
    (fun (tok : Token.styled_token) -> { tok with background = Some background })
    line

let notation_highlight ?(background = "#ffffff22") () =
  Transform.make "notation-highlight" ~before_render:(fun doc ->
      run_notation
        ~parse:(parse_keyword [ "highlight"; "hl" ])
        ~default_count:(fun _ -> 1)
        ~apply:(fun _ line -> set_background background line)
        doc
  )

let notation_diff ?(add_background = "#22883322")
    ?(remove_background = "#88222222") () =
  Transform.make "notation-diff" ~before_render:(fun doc ->
      run_notation
        ~parse:(parse_keyword [ "++"; "--" ])
        ~default_count:(fun _ -> 1)
        ~apply:(fun keyword line ->
          set_background
            ( if keyword = "++" then
                add_background
              else
                remove_background
            )
            line
        )
        doc
  )

let parse_word text position =
  let start = position + String.length "[!code word:" in
  if not (starts_at text position "[!code word:") then
    None
  else
    let buf = Buffer.create 16 in
    let rec word i =
      if i >= String.length text then
        None
      else
        match text.[i] with
        | '\\' when i + 1 < String.length text ->
            Buffer.add_char buf text.[i + 1];
            word (i + 2)
        | ':' | ']' ->
            Some i
        | c ->
            Buffer.add_char buf c;
            word (i + 1)
    in
    match word start with
    | Some stop when stop > start -> (
        match read_range text stop with
        | Some (j, range) when j < String.length text && text.[j] = ']' ->
            Some (j + 1, Buffer.contents buf, range)
        | _ ->
            None
      )
    | _ ->
        None

let highlight_word ~foreground ~font_style word line =
  let text = line_text line in
  let length = String.length word in
  let limit = body_length text in
  let rec occurrences from =
    match find_from text from word with
    | Some i when i + length <= limit ->
        (i, i + length) :: occurrences (i + length)
    | _ ->
        []
  in
  if length = 0 then
    line
  else
    edit_ranges line (occurrences 0) (fun tok ->
        Some { tok with foreground = Some foreground; font_style }
    )

let notation_word_highlight ?(foreground = "#ffff00")
    ?(font_style = [ Token.Bold ]) () =
  Transform.make "notation-word-highlight" ~before_render:(fun doc ->
      run_notation
        ~parse:(fun text position -> parse_word text position)
        ~default_count:Fun.id
        ~apply:(highlight_word ~foreground ~font_style)
        doc
  )
