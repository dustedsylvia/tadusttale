if (!variable_global_exists("player_initialized")) {
	global.player_initialized = true;
	
	global.can_move = true;
	global.player_name = environment_get_variable("username");
	global.player_lv = 1;
	global.player_maxhp = 16 + (4 * global.player_lv);
	global.player_hp = global.player_maxhp;
	global.weapon = "Stick";
	global.armor = "Bandage";
	
	switch global.weapon {
		case "Stick":
			global.weapon_atk = 0;
		break;
	}
	
	switch global.armor {
		case "Bandage":
			global.armor_def = 0;
		break;
	}
	
	global.player_atk = (-2 + (2 * global.player_lv)) + global.weapon_atk;
	global.player_def = ((global.player_lv - 1) / 4) + global.armor_def;
	global.player_x = x;
	global.player_y = y;
	global.player_speed = 5;
	global.player_x1speed = global.player_speed;
	global.player_x2speed = global.player_speed;
	global.player_y1speed = global.player_speed;
	global.player_y2speed = global.player_speed;
	global.player_mode = 1; // 1 for Chara and 2 for Frisk
}

image_speed = 0;
image_xscale = 2;
image_yscale = 2;

charaleft = s_chara_left;
chararight = s_chara_right;
charadown = s_chara_down;
charaup = s_chara_up;

friskleft = s_frisk_left;
friskright = s_frisk_right;
friskdown = s_frisk_down;
friskup = s_frisk_up;

solidObjects = [playercollision, savepoint];

lastmode = 1;

colliding = function(playerx=x, playery=y) {
	for (var i = 0; i < array_length(solidObjects); i++) {
		if (place_meeting(playerx, playery, solidObjects[i])) {
			return solidObjects[i];
		}
	}
	
	return false;
}