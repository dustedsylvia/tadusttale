if (global.wtau_cutscene_finished == true) { instance_destroy(); };

clock += 1;
if (state == 1) {
	if (clock == 60) {
		audio_play_sound(sn_falling, 1, 0);
	}

	if (clock == 95) {
		frisk_x = 240;
		frisk_y = 11;
	}

	if (clock == 96) {
		frisk_x = 268;
		frisk_y = 144;
	}

	if (clock == 97) {
		audio_play_sound(hit, 1, 0);
		frisk_x = 272;
		frisk_y = 242;
		frisk_s = s_frisksprawl;
		screenshake(6, 2, 0.8);
	}

	if (clock >= 187 and clock <= 247 and clock % 3 == 0) {
		if (frisk_x_offset == 0 or frisk_x_offset == -1) {
			frisk_x_offset = 1;
		} else if (frisk_x_offset == 1) {
			frisk_x_offset = -1;
		}
	}

	if (clock == 248) { frisk_x_offset = 0; };

	if (clock >= 249 and clock <= 277 and clock % 2 == 0) {
		if (frisk_x_offset == 0 or frisk_x_offset == -2) {
			frisk_x_offset = 2;
		} else if (frisk_x_offset == 2) {
			frisk_x_offset = -2;
		}
	}

	if (clock == 217) {
		audio_play_sound(playerhit, 1, 0);
		screenshake(3, 1, 0.4);
	}

	if (clock == 247) {
		audio_play_sound(playerhit, 1, 0);
		screenshake(3, 1, 0.4);
	}

	if (clock == 278) {
		frisk_x_offset = 0;
		frisk_s = s_frisk_down;
		frisk_x = 280;
		frisk_y = 237;
		audio_play_sound(playerhit, 1, 0);
		screenshake(3, 1, 0.4);
	}

	if (clock == 328) {
		frisk_s = s_frisk_right;
	}

	if (clock == 341) {
		audio_play_sound(sn_falling, 1, 0);
	}

	if (clock == 348 or clock == 368) {
		frisk_subimg = 1;
	}

	if (clock == 358 or clock == 378) {
		frisk_subimg = 0;
	}

	if (clock >= 348 and clock <= 378) {
		frisk_x += 2;
	}

	if (clock == 379) {
		chara_x = 240;
		chara_y = 11;
		frisk_s = s_frisk_left;
		audio_play_sound(sn_exclaim, 1, 0);
	}

	if (clock == 380) {
		chara_x = 268;
		chara_y = 144;
	}

	if (clock == 381) {
		audio_play_sound(hit, 1, 0);
		chara_x = 272;
		chara_y = 242;
		chara_s = s_charasprawl;
		screenshake(6, 2, 0.8);
		frisk_subimg = 1;
	}

	if (clock >= 382 and clock <= 402) {
		frisk_x = lerp(frisk_x, 370, 0.5);
	}

	if (clock == 403) {
		frisk_subimg = 0;
	}

	if (clock == 413) {
		frisk_s = s_frisk_right;
	}

	if (clock == 423) {
		frisk_s = s_frisk_up;
	}

	if (clock == 433) {
		frisk_s = s_frisk_down;
	}

	if (clock == 443) {
		frisk_s = s_frisk_left;
	}

	if (clock == 463) {
		audio_play_sound(playerhit, 1, 0);
		screenshake(3, 1, 0.4);
	}

	if (clock >= 463 and clock <= 492 and clock % 3 == 0) {
		if (chara_x_offset == 0 or chara_x_offset == -2) {
			chara_x_offset = 2;
		} else if (chara_x_offset == 2) {
			chara_x_offset = -2;
		}
	}

	if (clock == 493) {
		chara_x_offset = 0;
		chara_s = s_chara_down;
		chara_x = 280;
		chara_y = 237;
		audio_play_sound(playerhit, 1, 0);
		screenshake(3, 1, 0.4);
	}

	if (clock == 523) {
		chara_s = s_chara_right;
	}

	if (clock == 553) {
		var f = instance_create_depth(0, 0, -9998, flavorer);
		f.text = ["* omg frisk is that you :o"];
	}

	if (clock >= 553) {
		if (!instance_exists(flavorer)) {
			clock = 0;
			state = 2;
		}
	}
}

if (state == 2) {
	if (clock == 0) {
		screenglitch(6, 5, 0);
		chara_x = -999;
		chara_y = -999;
	}
	
	if (clock == 60) {
		var f = instance_create_depth(0, 0, -9998, flavorer);
		f.text = ["* what"];
	}
	
	if (clock >= 60) {
		if (!instance_exists(flavorer)) {
			var p = instance_create_depth(frisk_x, frisk_y, -9998, player);
			global.player_mode = 2;
			p.sprite_index = s_frisk_left;
			p.lastmode = 2; // stops overriding of sprite setting
			global.wtau_cutscene_finished = true;
			instance_destroy();
		}
	}
}

if (keyboard_check_pressed(ord("Q"))) {
	var p = instance_create_depth(frisk_x, frisk_y, -9998, player);
	global.player_mode = 2;
	p.sprite_index = s_frisk_left;
	p.lastmode = 2; // stops overriding of sprite setting
	global.wtau_cutscene_finished = true;
	instance_destroy();
};