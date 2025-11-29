clock += 1;

var left = keyboard_check_pressed(vk_left);
var right = keyboard_check_pressed(vk_right);
var up = keyboard_check_pressed(vk_up);
var down = keyboard_check_pressed(vk_down);

var key_z = keyboard_check_pressed(ord("Z"));
var key_x = keyboard_check_pressed(ord("X"));

var key_enter = keyboard_check_pressed(vk_enter);
var key_shift = keyboard_check_pressed(vk_shift);

var confirm = (key_z or key_enter);
var cancel = (key_x or key_shift);

if (state <= 2) {
	if (irandom(5) == irandom(5)) { // switch the sprite
		if (current_ls == 1) { current_ls = 2 } else { current_ls = 1 };
	}
	
	if (confirm) {
		state = 3;
		confirm = false;
	}
}

if (clock == 100 and state == 1) { state = 2; };

if ((up or down) and state == 3) {
	if (sel_option == 1) { sel_option = 2 } else { sel_option = 1 };
}
if ((left or right) and state == 4) {
	if (sel_option == 1) { sel_option = 2 } else { sel_option = 1 };
}

if (confirm and state == 3) {
	if (sel_option == 1) {
		state = 4;
		sel_option = 2;
		confirm = false;
	} else {
		screenshake(3, 1, 0.4); // settings doesn't exactly exist yet ;-;
		audio_play_sound(playerhit, 1, 0);
	}
}

if (confirm and state == 4) {
	if (sel_option == 1) {
		screenshake(3, 1, 0.4); // If you haven't learned by this point...
		audio_play_sound(playerhit, 1, 0);
	} else {
		state = 5;
		clock = 0;
		audio_play_sound(sn_bigtransition, 1, 0);
	}
}

if (state == 4 or state == 5) {
	if (irandom(5) == irandom(5)) { // switch the sprite
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

if (state == 5) {
	fader_progress += 0.01;
}

if (state == 5 and clock == 175) {
	room_goto(room_welcometoanunderground);
}