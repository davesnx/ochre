(* Sample OCaml code *)
let rec factorial n =
  if n <= 1 then 1
  else n * factorial (n - 1)

let main () =
  let result = factorial 5 in
  Printf.printf "5! = %d\n" result
