let default_highlight_background = Color.rgba 0x88 0x88 0x88 0x3a
let default_add_background = Color.rgba 0x22 0x88 0x33 0x22
let default_remove_background = Color.rgba 0x88 0x22 0x22 0x22
let default_word_foreground = Color.rgb 0xff 0xff 0x00
let bold = { Style.plain with bold = true }

let set_background background tok =
  Token.map_style
    (fun _ (style : Style.t) -> { style with background = Some background })
    tok

let set_word_style ~foreground ~font_style tok =
  Token.map_style
    (fun _ (style : Style.t) -> { style with foreground; font_style })
    tok

let add_class name attrs =
  let names = String.split_on_char ' ' name in
  if List.mem_assoc "class" attrs then
    List.map
      (function
        | "class", `String classes ->
            let present = String.split_on_char ' ' classes in
            let added = List.filter (fun n -> not (List.mem n present)) names in
            ("class", `String (String.concat " " (classes :: added)))
        | attr ->
            attr
        )
      attrs
  else
    attrs @ [ ("class", `String name) ]

let class_when condition name attrs =
  if condition then
    add_class name attrs
  else
    attrs

let no_hooks = { Transform.pre = None; line = None; span = None }

let line_classes ~pre_class classes =
  {
    no_hooks with
    pre =
      Some
        (fun doc ->
          let count = List.length doc in
          class_when
            (List.exists (fun (index, _) -> index >= 0 && index < count) classes)
            pre_class
        );
    line =
      Some
        (fun ~line_index _ attrs ->
          match List.assoc_opt line_index classes with
          | Some name ->
              add_class name attrs
          | None ->
              attrs
        );
  }

let span_class name marked =
  {
    no_hooks with
    span =
      Some
        (fun ~line_index:_ ~column:_ token attrs ->
          class_when (marked token) name attrs
        );
  }

let line_highlight ?(background = default_highlight_background) lines =
  Transform.make "line-highlight"
    ~after_line:(fun ~line_index line ->
      if List.mem line_index lines then
        List.map (set_background background) line
      else
        line
    )
    ~attributes:(fun _ ->
      line_classes ~pre_class:"has-highlighted"
        (List.map (fun index -> (index, "highlighted")) lines)
    )

let word_highlight ?(foreground = default_word_foreground) ?(font_style = bold)
    words =
  let marked (tok : Token.t) = List.mem tok.text words in
  Transform.make "word-highlight"
    ~after_line:(fun ~line_index:_ line ->
      List.map
        (fun tok ->
          if marked tok then
            set_word_style ~foreground ~font_style tok
          else
            tok
        )
        line
    )
    ~attributes:(fun _ -> span_class "highlighted-word" marked)

let strip_marker (first : Token.t) rest =
  let length = String.length first.text - 1 in
  if length = 0 then
    rest
  else
    Token.slice first ~pos:1 ~len:length :: rest

let diff_kind = function
  | { Token.text; _ } :: _ when String.length text > 0 && text.[0] = '+' ->
      Some (default_add_background, "diff add")
  | { Token.text; _ } :: _ when String.length text > 0 && text.[0] = '-' ->
      Some (default_remove_background, "diff remove")
  | _ ->
      None

let diff_markers =
  Transform.make "diff-markers"
    ~before_render:(fun doc ->
      List.map
        (fun line ->
          match (diff_kind line, line) with
          | Some (background, _), first :: rest ->
              List.map (set_background background) (strip_marker first rest)
          | _ ->
              line
        )
        doc
    )
    ~attributes:(fun doc ->
      line_classes ~pre_class:"has-diff"
        (List.concat
           (List.mapi
              (fun index line ->
                match diff_kind line with
                | Some (_, name) ->
                    [ (index, name) ]
                | None ->
                    []
              )
              doc
           )
        )
    )

let scope_marker ?(background = Color.rgba 0xff 0xff 0x00 0x33) scope_prefix =
  let marked (tok : Token.t) =
    List.exists (String.starts_with ~prefix:scope_prefix) tok.scopes
  in
  Transform.make "scope-marker"
    ~after_line:(fun ~line_index:_ line ->
      List.map
        (fun tok ->
          if marked tok then
            set_background background tok
          else
            tok
        )
        line
    )
    ~attributes:(fun _ -> span_class "highlighted-scope" marked)

let block_comments =
  [ ("--[[", "]]"); ("<!--", "-->"); ("/*", "*/"); ("(*", "*)"); ("{-", "-}") ]

let line_comments = [ "//"; ";;"; "%%"; "--"; ";"; "%"; "#"; "\""; "'"; "*" ]
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
  String.concat "" (List.map (fun (tok : Token.t) -> tok.text) line)

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

let edit_ranges line ranges f =
  let rec go offset ranges = function
    | [] ->
        []
    | (tok : Token.t) :: rest ->
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
              let tok = Token.slice tok ~pos:(a - offset) ~len:(b - a) in
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

let has_scope ~prefix (tok : Token.t) =
  List.exists
    (fun scope ->
      scope = prefix || String.starts_with ~prefix:(prefix ^ ".") scope
    )
    tok.scopes

let is_comment tok = has_scope ~prefix:"comment" tok

let has_root_scope ~prefix (tok : Token.t) =
  List.exists (String.starts_with ~prefix) tok.scopes

let is_prose (tok : Token.t) =
  tok.scopes = []
  || has_root_scope ~prefix:"text." tok
     && not
          (has_root_scope ~prefix:"source." tok
          || has_scope ~prefix:"string" tok
          || is_comment tok
          )

type context = {
  text : string;
  tokens : Token.t array;
  offsets : int array;
  stop : int;
  run_start : int array;
  tail_is_comment : bool array;
  mutable last_opener : int array option;
  closers : (string, int * int option) Hashtbl.t;
}

let make_context line =
  let tokens = Array.of_list line in
  let count = Array.length tokens in
  let offsets = Array.make count 0 in
  let run_start = Array.make count 0 in
  let offset = ref 0 in
  Array.iteri
    (fun k (tok : Token.t) ->
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

let last_opener ctx =
  match ctx.last_opener with
  | Some table ->
      table
  | None ->
      let n = String.length ctx.text in
      let table = Array.make (n + 1) (-1) in
      for i = 1 to n do
        table.(i) <-
          ( if
              (i = 1 || is_blank ctx.text.[i - 2])
              && List.exists (starts_at ctx.text (i - 1)) line_comments
            then
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
  let rendered = Array.make count 0 in
  for i = 1 to count - 1 do
    rendered.(i) <-
      (rendered.(i - 1)
      +
      if removed.(i - 1) then
        0
      else
        1
      )
  done;
  let applied =
    List.concat_map
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
        List.filter_map
          (fun j ->
            lines.(j) <- apply marker.payload lines.(j);
            if removed.(j) then
              None
            else
              Some (rendered.(j), marker.payload)
          )
          (List.init (max 0 (last - first)) (fun k -> first + k))
      )
      markers
  in
  (List.filteri (fun i _ -> not removed.(i)) (Array.to_list lines), applied)

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

let set_line_background background line =
  List.map (set_background background) line

let marked_lines ~pre_class ~line_class applied =
  line_classes ~pre_class
    (List.rev_map (fun (index, payload) -> (index, line_class payload)) applied)

let notation_lines ~name ~keywords ~pre_class ~line_class ~background =
  let run ~apply =
    run_notation ~parse:(parse_keyword keywords)
      ~default_count:(fun _ -> 1)
      ~apply
  in
  Transform.make name
    ~before_render:(fun doc ->
      fst
        (run
           ~apply:(fun keyword line ->
             set_line_background (background keyword) line
           )
           doc
        )
    )
    ~attributes:(fun doc ->
      marked_lines ~pre_class ~line_class
        (snd (run ~apply:(fun _ line -> line) doc))
    )

let notation_highlight ?(background = default_highlight_background) () =
  notation_lines ~name:"notation-highlight" ~keywords:[ "highlight"; "hl" ]
    ~pre_class:"has-highlighted"
    ~line_class:(fun _ -> "highlighted")
    ~background:(fun _ -> background)

let notation_diff ?(add_background = default_add_background)
    ?(remove_background = default_remove_background) () =
  notation_lines ~name:"notation-diff" ~keywords:[ "++"; "--" ]
    ~pre_class:"has-diff"
    ~line_class:(function "++" -> "diff add" | _ -> "diff remove")
    ~background:(function "++" -> add_background | _ -> remove_background)

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

let word_ranges word line =
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
    []
  else
    occurrences 0

let notation_word_highlight ?(foreground = default_word_foreground)
    ?(font_style = bold) () =
  let run ~apply =
    run_notation ~parse:parse_word ~default_count:Fun.id ~apply
  in
  Transform.make "notation-word-highlight"
    ~before_render:(fun doc ->
      fst
        (run
           ~apply:(fun word line ->
             edit_ranges line (word_ranges word line) (fun tok ->
                 Some (set_word_style ~foreground ~font_style tok)
             )
           )
           doc
        )
    )
    ~attributes:(fun doc ->
      let lines, applied = run ~apply:(fun _ line -> line) doc in
      let lines = Array.of_list lines in
      let ranges = Array.make (Array.length lines) [] in
      List.iter
        (fun (index, word) ->
          ranges.(index) <- word_ranges word lines.(index) @ ranges.(index)
        )
        applied;
      {
        no_hooks with
        span =
          Some
            (fun ~line_index ~column (tok : Token.t) attrs ->
              let stop = column + String.length tok.text in
              class_when
                (line_index < Array.length ranges
                && column < stop
                && List.exists
                     (fun (start, finish) -> start <= column && stop <= finish)
                     ranges.(line_index)
                )
                "highlighted-word" attrs
            );
      }
    )
