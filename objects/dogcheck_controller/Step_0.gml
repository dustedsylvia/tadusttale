if (corrupted) {
	loadtext = loadtexts[random_range(0, array_length(loadtexts))];
}

try {
	details = "==Start variables==\n" + 
	          "global.player_name: " + global.player_name + "\n" +
	          "global.player_lv: " + string(global.player_lv) + "\n" + 
	          "global.player_maxhp: " + string(global.player_maxhp) + "\n" + 
	          "global.weapon: " + global.weapon + "\n" + 
	          "global.armor: " + global.armor + "\n" + 
	          "global.player_mode: " + string(global.player_mode) + "\n" +
	          "global.savepoint: " + global.savepoint + "\n" +
			  "global.seconds: " + string(global.seconds) + "\n" +
			  "global.minutes: " + string(global.minutes) + "\n" +
			  "==End variables==";
} catch (e) {
	details = "\nError loading global variables.\nSAVE FILE is most likely unrecoverable."
}

if (keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_enter)) {
	game_end(-1);
}