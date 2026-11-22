type t = private { r : int; g : int; b : int; a : int }

val rgb : int -> int -> int -> t
val rgba : int -> int -> int -> int -> t
val oklch : float -> float -> float -> t
val of_hex : string -> t option
val to_hex : t -> string
val equal : t -> t -> bool
val blend : over:t -> t -> t
val opaque : t -> t
