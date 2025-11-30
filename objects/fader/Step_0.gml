if (state == 0) {
	opacity += fadespeed;
	if (opacity >= 1) {
		opacity = 1;
		state = 1;
	}
}

if (state == 1) {
	if (waittime > 0) {
		waittime -= 1;
	} else {
		state = 2;
	}
}

if (state == 2) {
	opacity -= fadespeed;
	if (opacity <= 0) {
		instance_destroy();
	}
}