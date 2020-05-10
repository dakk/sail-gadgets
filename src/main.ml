open Graphics;;

let width = 800;;
let height = 600;;
let background = rgb 40 40 40;;
let foreground = rgb 190 190 190;;
let accent = rgb 204 0 102;;

(* render a 7 segment digit *)
let render_digit x y h c n p =
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

let render_int_digits x y h col n =
  let ns = Printf.sprintf "%d" n in
  String.iteri (fun i c -> (
    let ch = Char.code c - Char.code '0' in
    render_digit (x + (h/2 + 25) * i) y h col ch false
  )) ns
;;

let render_float_digits x y h col n d =
  let ns = Printf.sprintf "%f" n in
  let rec ite s i p pd =
    let hasp = if not p && String.length s > i+1 && String.get s (i+1) = '.' then true else false in
    let ch = Char.code (String.get ns i) - Char.code '0' in
    render_digit (x + (h/2 + 25) * (if p then i-1 else i)) y h col ch hasp;
    if not p || pd < d then ite s (i+1) (p || hasp) (if p then pd+1 else pd) else ()
  in 
  ite ns 0 false 0
;;

let render_compass x y r = 
  set_line_width 3;
  set_color foreground;
  draw_circle x y r;
  moveto x y;
  lineto (x + 25) (y+r-10);
;;

let main () = 
  open_graph @@ Printf.sprintf " %dx%d" width height;
  set_color background;
  fill_rect 0 0 width height;
  set_color foreground;
  moveto 200 200;
  set_font "-bitstream-bitstream vera sans mono-medium-o-normal--0-0-0-0-m-0-iso8859-1";
  (* set_text_size 48;
  draw_string "20 knots"; *)

  set_color accent;
  moveto 25 70;
  lineto (width - 25) 70;
  set_color foreground;
  moveto 50 25;
  draw_string "DASHBOARD | Regatta startline | MOB | Tack meter | Chart";
  render_float_digits 300 300 40 foreground 125.33 2;

  render_compass (width / 2) (height / 2) 200;
  
  Unix.sleep 10;
  ()
;;

main ();;