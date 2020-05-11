open React
(* open Nmea *)

type t = {
  (* gps: Coord.t signal * (?step:step -> Coord.t -> unit); *)
  hdg: float signal * (?step:step -> float -> unit); 
  sog: float signal * (?step:step -> float -> unit); 
}

val fake : unit -> t

val detect_sources : unit -> string list