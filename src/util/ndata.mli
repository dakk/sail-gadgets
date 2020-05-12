open React
open Nmea

type t = {
  ll: Coord.t signal * (?step:step -> Coord.t -> unit);
  hdg: float signal * (?step:step -> float -> unit); 
  sog: float signal * (?step:step -> float -> unit); 
  sats: Sentence.sat list signal * (?step:step -> Sentence.sat list -> unit); 
}

val empty : unit -> t

val detect_sources : unit -> string list

val polling : t -> unit