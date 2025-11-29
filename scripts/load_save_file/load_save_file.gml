/// @function load_save_file(ini_filepath)
/// @description Loads a TA!Dusttale-style SAVE file.
/// @argument {String} ini_filepath The ini containing the SAVE data.
/// @return {Bool}

function load_save_file(ini_filepath) {
	load = load_save_file_info(ini_filepath);
	if (load == false) {
		room_goto(room_dogcheck);
	}
	
	// At this point, you should have all the data needed to load a Savepoint.
	
	switch (global.savepoint) {
		case "???????????":
			instance_create_depth(376, 256, -9998, player);
			room_goto(room_test);
		break;
	}
}