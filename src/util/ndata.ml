open React
open Nmea

type t = {
  ll: Coord.t signal * (?step:step -> Coord.t -> unit);
  hdg: float signal * (?step:step -> float -> unit); 
  sog: float signal * (?step:step -> float -> unit); 
}

let empty () = {
  ll= S.create @@ ((0.0, Coord.N), (0.0, Coord.W));
  hdg= S.create 0.0;
  sog= S.create 0.0;
};;

let detect_sources () =
  ["/dev/ttyACM0"]
;;


let rec polling data = 
    let is = open_in (List.hd @@ detect_sources ()) in
    let rec p () = 
        (* Printf.printf "Polling data\n%!"; *)
        let s = Parse.next is in
        (match s with
        | None -> ()
        | Some(Sentence.GPRMC (m)) -> (
            Printf.printf "GPRMC()\n%!";
            (snd data.hdg) m.cmg;
            (snd data.sog) m.sog;
            (snd data.ll) m.coord;
        )
        | Some(Sentence.GPGLL (m)) -> (
            Printf.printf "GPGLL()\n%!";
            (snd data.ll) m.coord;
        )
        | Some(Sentence.GPGGA (m)) -> (
            Printf.printf "GPGGA()\n%!";
            (snd data.ll) m.coord;
        )
        | Some (m) -> (
            Printf.printf "Not handled: %s\n%!" @@ Sentence.to_string m;
        ));
        Thread.delay 1.0;
        p ()			
    in
    p ()
;;