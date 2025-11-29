if (state == 1) {
	draw_sprite_ext(frisk_s, frisk_subimg, frisk_x + frisk_x_offset, frisk_y, 2, 2, 0, c_white, 1);
	draw_sprite_ext(chara_s, chara_subimg, chara_x + chara_x_offset, chara_y, 2, 2, 0, c_white, 1);
}

if (clock >= 379 and clock <= 399) {
	//draw_set_halign(fa_center);
	draw_sprite_ext(s_exclaim, 9, frisk_x + 10, frisk_y - 18, 2, 2, 0, c_white, 1);
	//draw_set_halign(fa_left);
}