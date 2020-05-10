open Graphics;;


let draw x y r hdg = 
  set_line_width 3;
  (* set_color foreground; *)
  draw_circle x y r;
  moveto x y;
  lineto (x + 25) (y+r-10);
;;