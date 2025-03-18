draw_set_font(fnt_gui_standard_small);

draw_set_color(c_white);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(x, y, "TITLE", 4, 4, 0);

draw_text_transformed(x, y + 80, "Start new dungeon or load from files", 1, 1, 0);