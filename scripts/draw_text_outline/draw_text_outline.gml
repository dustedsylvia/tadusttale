/// @function draw_text_outline(text_x, text_y, text, xscale, yscale, angle, text_color, text_alpha, outline_color, outline_width, outline_alpha)
/// @description Draws text with an outline, adapted from https://www.reddit.com/r/gamemaker/comments/3ryb11/basic_outlined_text_script/

function draw_text_outline(text_x, text_y, text, xscale=1, yscale=1, angle=0, text_color=#FFFFFF, text_alpha=1, outline_color=#000000, outline_width=1, outline_alpha=1) {
	// Drawing outline
	draw_text_transformed_colour(text_x + outline_width, text_y + outline_width, text, xscale, yscale, angle, outline_color, outline_color, outline_color, outline_color, outline_alpha);
	draw_text_transformed_colour(text_x - outline_width, text_y - outline_width, text, xscale, yscale, angle, outline_color, outline_color, outline_color, outline_color, outline_alpha);
	draw_text_transformed_colour(text_x, text_y + outline_width, text, xscale, yscale, angle, outline_color, outline_color, outline_color, outline_color, outline_alpha);
	draw_text_transformed_colour(text_x + outline_width, text_y, text, xscale, yscale, angle, outline_color, outline_color, outline_color, outline_color, outline_alpha);
	draw_text_transformed_colour(text_x, text_y - outline_width, text, xscale, yscale, angle, outline_color, outline_color, outline_color, outline_color, outline_alpha);
	draw_text_transformed_colour(text_x - outline_width, text_y, text, xscale, yscale, angle, outline_color, outline_color, outline_color, outline_color, outline_alpha);
	draw_text_transformed_colour(text_x - outline_width, text_y + outline_width, text, xscale, yscale, angle, outline_color, outline_color, outline_color, outline_color, outline_alpha);
	draw_text_transformed_colour(text_x + outline_width, text_y - outline_width, text, xscale, yscale, angle, outline_color, outline_color, outline_color, outline_color, outline_alpha);
	
	// Drawing the actual text
	draw_text_transformed_colour(text_x, text_y, text, xscale, yscale, angle, text_color, text_color, text_color, text_color, text_alpha);
}