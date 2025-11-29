var left = keyboard_check_pressed(vk_left);
var right = keyboard_check_pressed(vk_right);
var up = keyboard_check_pressed(vk_up);
var down = keyboard_check_pressed(vk_down);

var confirm = keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_enter);

if (state == 0) {
	if (left or right) {
		if (selectedoption == 1) {
			selectedoption = 2;
		} else if (selectedoption == 2) {
			selectedoption = 1;
		}
	}

	if (down) {
		if (selectedoption != 3) {
			selectedoption = 3;
		}
	}

	if (up) {
		if (selectedoption == 3) {
			selectedoption = 1;
		}
	}
	
	if (confirm and selectedoption == 1) {
		load_save_file("file0.ini");
	}

	if (confirm and selectedoption == 2) {
		state = 1
	}

	if (confirm and selectedoption == 3) {
		screenshake(3, 1, 0.4); // settings doesn't exactly exist yet ;-;
		audio_play_sound(playerhit, 1, 0);
	}
	
} else if (state == 1) {
	if (left or right) {
		if (selectedoption == 1) {
			selectedoption = 2;
		} else if (selectedoption == 2) {
			selectedoption = 1;
		}
	}
	
	if (confirm and selectedoption == 1) {
		selectedoption = 2;
		state = 0;
	} else if (confirm and selectedoption == 2) {
		state = 2;
		audio_play_sound(sn_bigtransition, 1, 0);
	}
}

if (state == 1 or state == 2) {
	// RESET code
	if (irandom(5) == irandom(5)) { // switch the name
		if (current_nm == 1) { current_nm = 2 } else { current_nm = 1 };
	}
	
	if (nm_scale < 5) {
		nm_scale += 0.04;
	}
	
	nm_x = 320 - ((string_width("AAAAA") * nm_scale) / 2) // monospaced font so it doesn't matter
	
	if (nm_y < 257) {
		nm_y += 1.8;
	}
	
	nm_rot = irandom_range(-1, 1);
}

if (state == 2) {
	fader_progress += 0.01;
	clock += 1;
}

if (state == 2 and clock == 175) {
	load_empty_file_info();
	room_goto(room_welcometoanunderground);
}