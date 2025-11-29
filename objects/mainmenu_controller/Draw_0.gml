if (state == 0) {
	draw_sprite(archwaybottom, 0, 350, 0);
	draw_sprite(floweysground, 0, 292, 346);
	
	draw_set_font(dtf_sans_big); // Not an Upscaler Anymore
	
	draw_rectangle_colour(20, 50, 260, 140, c_white, c_white, c_white, c_white, false);
	draw_rectangle_colour(25, 55, 255, 135, c_black, c_black, c_black, c_black, false);
	
	draw_text(37, 65, name);
	draw_text(140, 65, "LV " + string(global.player_lv));
	if (global.seconds < 10) { seconds = "0" + string(global.seconds); } else { seconds = string(global.seconds); }
	draw_text(200, 65, string(global.minutes) + ":" + seconds);
	draw_text(37, 100, global.savepoint);
	switch (selectedoption) {
		case 1:
			draw_text_outline(25, 190, "Continue", 1, 1, 0, #FFFF00, 1, #000000, 2, 1);
			draw_text_outline(25, 230, "Reset", 1, 1, 0, #FFFFFF, 1, #000000, 2, 1);
			draw_text_outline(25, 270, "Settings", 1, 1, 0, #FFFFFF, 1, #000000, 2, 1);
		break;
		
		case 2:
			draw_text_outline(25, 190, "Continue", 1, 1, 0, #FFFFFF, 1, #000000, 2, 1);
			draw_text_outline(25, 230, "Reset", 1, 1, 0, #FFFF00, 1, #000000, 2, 1);
			draw_text_outline(25, 270, "Settings", 1, 1, 0, #FFFFFF, 1, #000000, 2, 1);
		break;
		
		
		case 3:
			draw_text_outline(25, 190, "Continue", 1, 1, 0, #FFFFFF, 1, #000000, 2, 1);
			draw_text_outline(25, 230, "Reset", 1, 1, 0, #FFFFFF, 1, #000000, 2, 1);
			draw_text_outline(25, 270, "Settings", 1, 1, 0, #FFFF00, 1, #000000, 2, 1);
		break;
		
		default:
			draw_text_outline(25, 190, "Continue", 1, 1, 0, #FFFFFF, 1, #000000, 2, 1);
			draw_text_outline(25, 230, "Reset", 1, 1, 0, #FFFFFF, 1, #000000, 2, 1);
			draw_text_outline(25, 270, "Settings", 1, 1, 0, #FFFFFF, 1, #000000, 2, 1);
		break;
	}
	
	
	
	draw_set_font(cot);
	draw_set_halign(fa_center);
	draw_text_color(320, 460, "TA!DUSTTALE V0.1 by Team Ashes 2025-", #808080, #808080, #808080, #808080, 1);
	draw_set_halign(fa_left);
}

if (state == 1) {
	draw_set_font(dtf_sans); // The Upscaling Never Ends
	draw_text_transformed(180, 68, "A name has already\nbeen chosen.", 2, 2, 0);
	
	if (selectedoption == 1) {
		draw_text_transformed_color(146, 408, "No", 2, 2, 0, #FFFF00, #FFFF00, #FFFF00, #FFFF00, 1);
		draw_text_transformed(460, 408, "Yes", 2, 2, 0);
	} else {
		draw_text_transformed(146, 408, "No", 2, 2, 0);
		draw_text_transformed_color(460, 408, "Yes", 2, 2, 0, #FFFF00, #FFFF00, #FFFF00, #FFFF00, 1);
	}
	
	if (current_nm == 1) {
		draw_text_transformed(nm_x, nm_y, undertale_nm, nm_scale, nm_scale, nm_rot);
	} else {
		draw_text_transformed(nm_x, nm_y, underswap_nm, nm_scale, nm_scale, nm_rot);
	}
}

if (state == 2) {
	draw_set_font(dtf_sans);
	if (current_nm == 1) {
		draw_text_transformed(nm_x, nm_y, undertale_nm, nm_scale, nm_scale, nm_rot);
	} else {
		draw_text_transformed(nm_x, nm_y, underswap_nm, nm_scale, nm_scale, nm_rot);
	}
	
	draw_sprite_ext(s_fader, 1, 0, 0, 1, 1, 0, c_white, fader_progress);
}