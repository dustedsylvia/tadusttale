draw_set_font(dtf);
draw_text_transformed_colour(15, 15, loadtext, 1.5, 1.5, 0, #FFFF00, #FFFF00, #FFFF00, #FFFF00, 1);
draw_text_transformed(15, 65, "Technical Details: ", 1, 1, 0);
draw_text_transformed(15, 105, details, 1, 1, 0);

draw_set_halign(fa_center);
draw_text_transformed(450, 20, "If a variable is -1997\nor 'error_nodata', it's corrupted.", 0.5, 0.5, 0);
draw_text(320, 420, "Press Z to exit.");
draw_set_halign(fa_left);

draw_set_font(cot);
draw_set_halign(fa_center);
draw_text_color(320, 460, "TA!DUSTTALE V0.1 by Team Ashes 2025-", #808080, #808080, #808080, #808080, 1);
draw_set_halign(fa_left);