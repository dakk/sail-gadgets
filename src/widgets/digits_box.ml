open Graphics;;

let draw_float x y h col d n =
  set_color Style.bg2;
  set_line_width 3;
  draw_rect (x-h/2) (y-h) ((h)*d) (h + h/2);
  set_color Style.bg3;
  fill_rect (x-h/2) (y-h) ((h)*d) (h + h/2);
  Digits.draw_float (x + 5) (y + 5) (h-10) col 2 n
;;