if (state <= 2) {
	switch (current_ls) {
		case 1:
			draw_sprite_ext(undertale_ls, 1, 48, 198, 1.25, 1.25, 0, c_white, 1);
		break;
			
		case 2:
			draw_sprite_ext(underswap_ls, 1, 48, 198, 1.25, 1.25, 0, c_white, 1);
		break;
	}
}

if (state == 2) {
	draw_sprite_ext(pzoespr, 1, 240, 360, 1, 1, 0, c_white, 1);
}

if (state == 3) {
	draw_set_font(dtf_sans);
	draw_sprite(s_dashes, 1, 174, 56);
	draw_text_transformed_color(224, 40, "Instruction", 2, 2, 0, #c0c0c0, #c0c0c0, #c0c0c0, #c0c0c0, 1);
	draw_sprite(s_dashes, 1, 384, 56);
	
	draw_text_ext_transformed_color(170, 108, ins_text, 18, 999, 2, 2, 0, #c0c0c0, #c0c0c0, #c0c0c0, #c0c0c0, 1);
	
	if (sel_option == 1) {
		draw_text_transformed_color(170, 352, "Begin Game", 2, 2, 0, #FFFF00, #FFFF00, #FFFF00, #FFFF00, 1);
		draw_text_transformed(170, 392, "Settings", 2, 2, 0);
	} else {
		draw_text_transformed(170, 352, "Begin Game", 2, 2, 0);
		draw_text_transformed_color(170, 392, "Settings", 2, 2, 0, #FFFF00, #FFFF00, #FFFF00, #FFFF00, 1);
	}
	
	draw_set_font(cot);
	draw_set_halign(fa_center);
	draw_text_color(320, 460, "TA!DUSTTALE V0.1 by Team Ashes 2025-", #808080, #808080, #808080, #808080, 1);
	draw_set_halign(fa_left);
}

if (state == 4) {
	draw_set_font(dtf_sans);
	draw_text_transformed(180, 68, "A name has already\nbeen chosen.", 2, 2, 0);
	
	if (sel_option == 1) {
		draw_text_transformed_color(146, 408, "No", 2, 2, 0, #c8c800, #c8c800, #c8c800, #c8c800, 1);
		draw_text_transformed(460, 408, "Yes", 2, 2, 0);
	} else {
		draw_text_transformed_color(146, 408, "No", 2, 2, 0, #808080, #808080, #808080, #808080, 1);
		draw_text_transformed_color(460, 408, "Yes", 2, 2, 0, #FFFF00, #FFFF00, #FFFF00, #FFFF00, 1);
	}
}

if (state == 4 or state == 5) {
	//draw_set_halign(fa_center);
	if (current_nm == 1) {
		draw_text_transformed(nm_x, nm_y, undertale_nm, nm_scale, nm_scale, nm_rot);
	} else {
		draw_text_transformed(nm_x, nm_y, underswap_nm, nm_scale, nm_scale, nm_rot);
	}
	//draw_set_halign(fa_left);
}

if (state == 5) {
	draw_sprite_ext(s_fader, 1, 0, 0, 1, 1, 0, c_white, fader_progress);
}