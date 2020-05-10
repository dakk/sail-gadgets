open Graphics;;

(* render a 7 segment digit *)
let draw x y h c n p =
  let w = h / 2 in
  let draw1 () = moveto x y; lineto (x-w) y in
  let draw4 () = moveto x y; lineto (x) (y-w) in
  let draw3 () = moveto x (y-w); lineto (x-w) (y-w) in
  let draw2 () = moveto (x-w) (y); lineto (x-w) (y-w) in
  let draw7 () = moveto (x) (y-w); lineto (x) (y-h) in
  let draw6 () = moveto (x) (y-h); lineto (x-w) (y-h) in
  let draw5 () = moveto (x-w) (y-w); lineto (x-w) (y-h) in
  set_line_width 4;
  set_color c;
  if p then fill_rect (x+10) (y-h-2) 4 4;
  match n with 
  | 0 -> draw1(); draw2(); draw4(); draw5(); draw6(); draw7()
  | 1 -> draw4(); draw7()
  | 2 -> draw1(); draw3(); draw4(); draw5(); draw6()
  | 3 -> draw1(); draw3(); draw4(); draw6(); draw7()
  | 4 -> draw2(); draw3(); draw4(); draw7()
  | 5 -> draw1(); draw2(); draw3(); draw6(); draw7()
  | 6 -> draw1(); draw2(); draw3(); draw5(); draw6(); draw7()
  | 7 -> draw1(); draw4(); draw7()
  | 8 -> draw1(); draw2(); draw3(); draw4(); draw5(); draw6(); draw7()
  | 9 -> draw1(); draw2(); draw3(); draw4(); draw6(); draw7()
  | _ -> ()
;;

let draw_int x y h col n =
  let ns = Printf.sprintf "%d" n in
  String.iteri (fun i c -> (
    let ch = Char.code c - Char.code '0' in
    draw (x + (h/2 + 25) * i) y h col ch false
  )) ns
;;

let draw_float x y h col n d =
  let ns = Printf.sprintf "%f" n in
  let rec ite s i p pd =
    let hasp = if not p && String.length s > i+1 && String.get s (i+1) = '.' then true else false in
    let ch = Char.code (String.get ns i) - Char.code '0' in
    draw (x + (h/2 + 25) * (if p then i-1 else i)) y h col ch hasp;
    if not p || pd < d then ite s (i+1) (p || hasp) (if p then pd+1 else pd) else ()
  in 
  ite ns 0 false 0
;;
