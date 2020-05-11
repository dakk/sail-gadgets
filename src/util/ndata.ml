open React
(* open Nmea *)

type t = {
  (* gps: Coord.t signal * (?step:step -> Coord.t -> unit); *)
  hdg: float signal * (?step:step -> float -> unit); 
  sog: float signal * (?step:step -> float -> unit); 
}

let fake () = {
  hdg= S.create 1.0;
  sog= S.create 1.0;
};;

let detect_sources () =
  ["/dev/ttyACM0"]
;;