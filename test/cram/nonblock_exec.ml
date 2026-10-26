let () =
  Unix.set_nonblock Unix.stdout;
  let argv = Array.sub Sys.argv 1 (Array.length Sys.argv - 1) in
  Unix.execvp argv.(0) argv
