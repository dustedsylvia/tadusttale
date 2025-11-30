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
	//if (leftp) {
	//	if (global.player_mode == 1) {
	//		sprite_index = charaleft;
	//	} else if (global.player_mode == 2) {
	//		sprite_index = friskleft;
	//	}
	//	image_index = 0;
	//}

	//if (rightp) {
	//	if (global.player_mode == 1) {
	//		sprite_index = chararight;
	//	} else if (global.player_mode == 2) {
	//		sprite_index = friskright;
	//	}
	//	image_index = 0;
	//}

	//if (upp) {
	//	if (global.player_mode == 1) {
	//		sprite_index = charaup;
	//	} else if (global.player_mode == 2) {
	//		sprite_index = friskup;
	//	}
	//	image_index = 0;
	//}

	//if (downp) {
	//	if (global.player_mode == 1) {
	//		sprite_index = charadown;
	//	} else if (global.player_mode == 2) {
	//		sprite_index = friskdown;
	//	}
	//	image_index = 0;
	//}
	
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
	
	// yes. yes i do feel unclean. why do you ask?
	//image_speed = 0;
	if (left) {
		x -= global.player_x1speed;
		//if (!right and !down and !up) {
		if (!right) {
			if (global.player_mode == 1) {
				sprite_index = charaleft;
			} else if (global.player_mode == 2) {
				sprite_index = friskleft;
			}
			//image_index = 0;
		}
		//image_speed = 1;
		//if (!colliding()) {
		//	image_speed = 1;
		//} else { x += global.player_xspeed; image_index = 0; }
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
			//image_index = 0;
		}
		//image_speed = 1;
		//if (!colliding()) {
		//	x += global.player_xspeed;
		//	if (!colliding()) {
		//		image_speed = 1;
		//	} else { x -= global.player_xspeed; image_index = 0; }
		//}
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
			//image_index = 0;
		}
		//image_speed = 1;
		//if (!colliding()) {
		//	y -= global.player_yspeed;
		//	if (!colliding()) {
		//		image_speed = 1;
		//	} else { y += global.player_yspeed; image_index = 0; }
		//}
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
			//image_index = 0;
		}
		//image_speed = 1;
		//if (!colliding()) {
		//	y += global.player_yspeed;
		//	if (!colliding()) {
		//		image_speed = 1;
		//	} else { y -= global.player_yspeed; image_index = 0; }
		//}
	}
	
	//if (!left and !right and !up and !down) {
	//	image_index = 0;
	//}
}

player_int.x = x - 1; // otherwise the left collisions won't work right
player_int.y = y;

if (prevx == x and prevy == y) {
	image_speed = 0;
	image_index = 0;
} else {
	image_speed = 1;
}

prevx = x;
prevy = y;