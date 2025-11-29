if (state == 0) {
	draw_sprite(archwaybottom, 0, 220, 0);
	draw_sprite(floweysground, 0, 162, 346);
	draw_set_font(dtf_sans_big); // Not an Upscaler Anymore
	draw_text(140, 130, name);
	draw_text(140, 166, global.savepoint);
	draw_text(314, 132, "LV " + string(global.player_lv));
	if (global.seconds < 10) { seconds = "0" + string(global.seconds); } else { seconds = string(global.seconds); }
	draw_text(452, 132, string(global.minutes) + ":" + seconds);
	
	switch (selectedoption) {
		case 1:
			draw_text_color(170, 216, "Continue", #FFFF00, #FFFF00, #FFFF00, #FFFF00, 1);
			draw_text(390, 218, "Reset");
			draw_text(264, 256, "Settings");
		break;
		
		case 2:
			draw_text(170, 216, "Continue");
			draw_text_color(390, 218, "Reset", #FFFF00, #FFFF00, #FFFF00, #FFFF00, 1);
			draw_text(264, 256, "Settings");
		break;
		
		
		case 3:
			draw_text(170, 216, "Continue");
			draw_text(390, 218, "Reset");
			draw_text_color(264, 256, "Settings", #FFFF00, #FFFF00, #FFFF00, #FFFF00, 1);
		break;
		
		default:
			draw_text(170, 216, "Continue");
			draw_text(390, 218, "Reset");
			draw_text(264, 256, "Settings");
		break;
	}
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

// oldest menu
//draw_set_font(dtf);
//draw_text(100, 100, "press Z to load your save file\n\n(i got lazy on the main menu)");

//draw_text_outline(200, 200, "Continue\nReset\nSettings", 1, 1, 0, #FFFFFF, 1, #000000, 2, 1);