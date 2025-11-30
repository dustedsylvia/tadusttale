var key_z = keyboard_check_pressed(ord("Z"));
var key_enter = keyboard_check_pressed(vk_enter);
var confirm = (key_z or key_enter);

if (place_meeting(x, y, playerinteract) and confirm and state == 0) {
	global.can_move = false;
	textbox = instance_create_depth(0, 0, -9998, flavorer);
	textbox.text = objecttext;
	state = 1;
}

if (state == 1) {
	if (!instance_exists(flavorer)) {
		state = 0;
		global.can_move = true;
	}
}