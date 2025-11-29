state = 0;
selectedoption = 1;

name = environment_get_variable("username");
if (string_length(name) > 6) {
    name = string_copy(name, 1, 6);
}

// make a time instance
instance_create_depth(-100, -100, 0, time);

// We need some variables from the SAVE file. But don't fully load it yet.
load_save_file_info("file0.ini");

// RESET variables (i js copied this from [object]title_controller)
undertale_nm = "Chara";
underswap_nm = "Frisk";
current_nm = 1;

nm_scale = 2;
nm_x = -999;
nm_y = 120;
nm_rot = 0;
clock = 0;

fader_progress = 0;

instance_create_depth(0, 0, 0, videoplayer);