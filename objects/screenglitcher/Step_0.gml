if (glitch) {
	glitch_time -= 1;
	var _xval = choose(-glitch_magnitude*100, glitch_magnitude*100);
	var _yval = choose(-glitch_magnitude*100, glitch_magnitude*100);
	camera_set_view_pos(view_camera[0], _xval, _yval);
	
	if (glitch_time <= 0) {
		glitch_magnitude -= glitch_fade;
		
		if (glitch_magnitude <= 0) {
		    camera_set_view_pos(view_camera[0], 0, 0);
		    glitch = false;
		}
	}
}