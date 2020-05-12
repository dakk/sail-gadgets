open React
open Nmea

type t = {
  ll: Coord.t signal * (?step:step -> Coord.t -> unit);
  hdg: float signal * (?step:step -> float -> unit); 
  sog: float signal * (?step:step -> float -> unit); 
  sats: Sentence.sat list signal * (?step:step -> Sentence.sat list -> unit); 
}

let empty () = {
  ll= S.create @@ ((0.0, Coord.N), (0.0, Coord.W));
  hdg= S.create 0.0;
  sog= S.create 0.0;
  sats= S.create [];
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
        | Some(Sentence.RMC (m)) -> (
            (* Printf.printf "GPRMC()\n%!"; *)
            (snd data.hdg) m.cmg;
            (snd data.sog) m.sog;
            (snd data.ll) m.coord;
        )
        | Some(Sentence.GLL (m)) -> (
            (* Printf.printf "GPGLL()\n%!"; *)
            (snd data.ll) m.coord;
        )
        | Some(Sentence.GGA (m)) -> (
            (* Printf.printf "GPGGA()\n%!"; *)
            (snd data.ll) m.coord;
        )
        | Some(Sentence.GSV (m)) -> (
            (* Printf.printf "GPGSV(%d,%d)\n%!" m.msg_n m.msg_i; *)
            let sl = if m.msg_i = 1 then m.sats else m.sats @ S.value (fst data.sats) in
            (snd data.sats) sl
        )
        | Some (m) -> (
            Printf.printf "Not handled: %s\n%!" @@ Sentence.to_string m;
        ));
        p ()			
    in
    p ()
;;