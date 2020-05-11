open Graphics;;
open Widgets;;

let width = 800;;
let height = 600;;

let draw i () =
  set_color Widgets.Style.bg;
  fill_rect 0 0 width height;
  set_color Widgets.Style.fg;
  set_font Widgets.Style.font;

  Widgets.Tab.draw 40 ["Dasboard"; "Start Line"; "MOB"; "Tack Meter"; "Wind"; "Track"] i;
  moveto 10 (height-30);
  draw_string "Speed (kts)";
  Widgets.Digits_box.draw_float 30 (height - 60) 40 Widgets.Style.fg 5 (125.33 +. float_of_int i *. 1.156);
  moveto 300 (height-30);
  draw_string "Position";
  moveto 300 (height-60);
  draw_string "39.15489 N  8.35431 E";
  

  Widgets.Compass.draw (width / 2) (height / 2) 200 125.;
;;

let main () = 
  open_graph @@ Printf.sprintf " %dx%d" width height;

  let rec dr i =
    draw i ();
    Unix.sleep 1;
    dr ((i+1) mod 6)
  in dr 0;
  ()
;;

main ();;