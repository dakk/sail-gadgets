open Graphics;;
open Widgets;;

let width = 800;;
let height = 600;;
let background = rgb 40 40 40;;
let foreground = rgb 190 190 190;;
let accent = rgb 204 0 102;;

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
  Widgets.Digits.draw_float 300 300 40 foreground 125.33 2;

  Widgets.Compass.draw (width / 2) (height / 2) 200 125.;
  
  Unix.sleep 10;
  ()
;;

main ();;