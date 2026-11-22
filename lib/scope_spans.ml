type span = { offset : int; length : int; scope : string }
type t = span list

let invalid (span : span) message =
  Error
    (Error.Invalid_scope_span
       {
         offset = span.offset;
         length = span.length;
         scope = span.scope;
         message;
       }
    )

let inside_scalar source boundary =
  let rec start index =
    if index > 0 && boundary - index < 3 && Utf8.is_continuation source index
    then
      start (index - 1)
    else
      index
  in
  boundary > 0
  && Utf8.is_continuation source boundary
  &&
  let first = start (boundary - 1) in
  first + Utf8.scalar_length source first > boundary

let is_blank = function ' ' | '\t' | '\n' | '\r' -> true | _ -> false

let check source previous_end span =
  if span.length < 1 then
    invalid span "the span is empty"
  else if span.offset < 0 || span.length > String.length source - span.offset
  then
    invalid span "the span is outside the source"
  else
    let stop = span.offset + span.length in
    if inside_scalar source span.offset || inside_scalar source stop then
      invalid span "the span starts or ends inside a UTF-8 sequence"
    else if span.offset < previous_end then
      invalid span "the span overlaps another span"
    else if span.scope = "" || String.exists is_blank span.scope then
      invalid span "the scope is empty or holds a blank"
    else
      Ok stop

let make ~source spans =
  let spans = List.stable_sort (fun a b -> compare a.offset b.offset) spans in
  let rec go previous_end = function
    | [] ->
        Ok spans
    | span :: rest -> (
        match check source previous_end span with
        | Ok stop ->
            go stop rest
        | Error _ as error ->
            error
      )
  in
  go 0 spans

let rec drop_before offset = function
  | span :: rest when span.offset + span.length <= offset ->
      drop_before offset rest
  | spans ->
      spans

let rec take_before offset = function
  | span :: rest when span.offset < offset ->
      span :: take_before offset rest
  | _ ->
      []

let cut (text, scopes, (position : Token.position)) covering =
  let start = position.offset in
  let stop = start + position.length in
  let piece first last scopes =
    if last > first then
      [
        ( String.sub text (first - start) (last - first),
          scopes,
          {
            position with
            offset = first;
            column = position.column + (first - start);
            length = last - first;
          }
        );
      ]
    else
      []
  in
  let rec go cursor = function
    | [] ->
        piece cursor stop scopes
    | span :: rest ->
        let first = max span.offset start in
        let last = min (span.offset + span.length) stop in
        piece cursor first scopes
        @ piece first last (span.scope :: scopes)
        @ go last rest
  in
  go start covering

let same_styles a b = Token.all_styles a = Token.all_styles b

let token ~make spans ((_, scopes, (position : Token.position)) as raw) =
  let start = position.offset in
  let stop = start + position.length in
  let spans = drop_before start spans in
  match take_before stop spans with
  | [] ->
      (spans, [ make raw ])
  | _ when scopes = [] ->
      (spans, [ make raw ])
  | covering ->
      let whole = make raw in
      let pieces = List.map make (cut raw covering) in
      if List.for_all (same_styles whole) pieces then
        (spans, [ whole ])
      else
        (spans, pieces)

let apply ~make spans lines =
  snd
    (List.fold_left_map
       (fun spans line ->
         let spans, tokens = List.fold_left_map (token ~make) spans line in
         (spans, List.concat tokens)
       )
       spans lines
    )
