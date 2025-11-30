// Scroll to the bottom for very important information (not scrollbait)

var leftp = keyboard_check_pressed(vk_left);
var rightp = keyboard_check_pressed(vk_right);
var upp = keyboard_check_pressed(vk_up);
var downp = keyboard_check_pressed(vk_down);

var left = keyboard_check(vk_left);
var right = keyboard_check(vk_right);
var up = keyboard_check(vk_up);
var down = keyboard_check(vk_down);

if (!instance_exists(playerinteract)) {
	player_int = instance_create_depth(x - 1, y, -9999, playerinteract);
}

if (lastmode != global.player_mode) {
	if (global.player_mode == 1) {
		sprite_index = charadown;
	} else if (global.player_mode == 2) {
		sprite_index = friskdown;
	}
	
	lastmode = global.player_mode;
}

if (global.can_move == true) {
	// check collisions
	global.player_x1speed = global.player_speed;
	global.player_x2speed = global.player_speed;
	global.player_y1speed = global.player_speed;
	global.player_y2speed = global.player_speed;
	
	if (colliding(x - global.player_x1speed, y) != false) {
		global.player_x1speed = distance_to_object(colliding(x - global.player_x1speed, y));
	}
	if (colliding(x + global.player_x2speed, y) != false) {
		global.player_x2speed = distance_to_object(colliding(x + global.player_x2speed, y));
	}
	if (colliding(x, y - global.player_y1speed) != false) {
		global.player_y1speed = distance_to_object(colliding(x, y - global.player_y1speed));
	}
	if (colliding(x, y + global.player_y2speed) != false) {
		global.player_y2speed = distance_to_object(colliding(x, y + global.player_y2speed));
	}
	
	if (left) {
		x -= global.player_x1speed;
		//if (!right and !down and !up) {
		if (!right) {
			if (global.player_mode == 1) {
				sprite_index = charaleft;
			} else if (global.player_mode == 2) {
				sprite_index = friskleft;
			}
		}
	}
	if (right) {
		x += global.player_x2speed;
		//if (!left and !down and !up) {
		if (!left) {
			if (global.player_mode == 1) {
				sprite_index = chararight;
			} else if (global.player_mode == 2) {
				sprite_index = friskright;
			}
		}
	}
	if (up) {
		y -= global.player_y1speed;
		//if (!right and !down and !left) {
		if (!down) {
			if (global.player_mode == 1) {
				sprite_index = charaup;
			} else if (global.player_mode == 2) {
				sprite_index = friskup;
			}
		}
	}
	if (down) {
		y += global.player_y2speed;
		//if (!right and !left and !up) {
		if (!up) {
			if (global.player_mode == 1) {
				sprite_index = charadown;
			} else if (global.player_mode == 2) {
				sprite_index = friskdown;
			}
		}
	}
}

try { // weirdly this causes issues so we have to use a try statement
	  // edit i was being stupid. it breaks when there's two player objects.
	  // so just don't put two player objects ffs
	player_int.x = x - 1; // otherwise the left collisions won't work right
	player_int.y = y;
} catch (e) {};

if (prevx == x and prevy == y) {
	image_speed = 0;
	image_index = 0;
} else {
	image_speed = 1;
}

prevx = x;
prevy = y;

// UT style camera follow
camera = view_get_camera(0);
camera_x = camera_get_view_x(camera);
camera_y = camera_get_view_y(camera);
camera_w = camera_get_view_width(camera);
camera_h = camera_get_view_height(camera);

if (camera_x >= 0 and camera_x <= room_width - camera_w and x - 300 >= 0 and x - 300 <= room_width - camera_w) {
	// 320 - (sprite_width * sprite_xscale) / 2
	// 320 - (20 * 2) / 2
	// 320 - 20
	// 300
	camera_x = x - 300;
	//show_debug_message("set camera_x to " + string(camera_x));
} else {
	//if (camera_x <= 0 or x - 300 <= 0) { show_debug_message("setting camera_x to 0 because camera_x is " + string(camera_x)); camera_x = 0; }
	//else if (camera_x >= room_width - camera_w or x - 300 >= room_width - camera_w) { show_debug_message("setting camera_x to " + string(room_width - camera_w) + " because camera_x is " + string(camera_x)); camera_x = room_width - camera_w; }
	if (camera_x <= 0 or x - 300 <= 0) { camera_x = 0; }
	else if (camera_x >= room_width - camera_w or x - 300 >= room_width - camera_w) { camera_x = room_width - camera_w; }
}

if (camera_y >= 0 and camera_y <= room_height - camera_h and y - 210 >= 0 and y - 210 <= room_height - camera_h) {
	// 240 - (sprite_height * sprite_yscale) / 2
	// 240 - (30 * 2) / 2
	// 240 - 30
	// 210
	camera_y = y - 210;
	//show_debug_message("set camera_y to " + string(camera_y))
} else {
	//if (camera_y <= 0 or y - 210 <= 0) { show_debug_message("setting camera_y to 0 because camera_y is " + string(camera_y)); camera_y = 0; }
	//else if (camera_y >= room_height - camera_h or y - 210 >= room_height - camera_h) { show_debug_message("setting camera_y to " + string(room_height - camera_h) + " because camera_y is " + string(camera_y)); camera_y = room_height - camera_h; }
	if (camera_y <= 0 or y - 210 <= 0) { camera_y = 0; }
	else if (camera_y >= room_height - camera_h or y - 210 >= room_height - camera_h) { camera_y = room_height - camera_h; }
}

camera_set_view_pos(camera, camera_x, camera_y);
//show_debug_message("Camera X is now " + string(camera_get_view_x(camera)) + " and camera Y is now " + string(camera_get_view_y(camera)));

// so the player's movement works fine. the code that picks which sprite the player
// uses is flawed. there's three versions:
// one (this is commented out on lines 49, 60, 71, and 82) seems more canon to
// undertale until you press more than two arrows at a time. then it all breaks.
// two (this is the one being used right now) works with 3+ directional inputs
// but looks strange. it looks better than the player moonwalking though imo so
// that's the one i left in.
// three (this one hasn't been written yet) saves the direction the player is
// currently moving in. when a new key is pressed, check and see if the arrow
// corresponding to that direction is still being pressed. if it is don't do
// anything. if it isn't change the sprite.

// some of the old code i deleted for clarity is still in [object]player_debug.
// all of it was commented out but you can read it for better understanding.

// oh also for some reason when going down and only holding that key it works
// fine but when holding other keys (ex going down left) it only does the first
// two frames of the animation?? i dont know its weird

if (keyboard_check_pressed(ord("E"))) { audio_play_sound(heal, 1, 0); }
if (keyboard_check_pressed(ord("R"))) { show_error("wait", true); }