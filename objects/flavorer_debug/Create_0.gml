// flow:
// first frame: draws box
// second frame: draws asterisk
// third frame: nothing
// 4th frame: start drawing characters

// Todo:
//1. check the positions of everything (make sure it matches Undertale)

//2. the 2nd and 3rd asterisks are drawn 1 frame too late

//3. asterisk is not drawn on the very first frame

//4. when using [instant] as the first character, the text isn't drawn for one frame
//5. add a [textspd:<int>] tag
//6. add a [alpha:<float>] tag
//7. add a [font:<font>] tag
//8. add a [textbeep:<sound>] tag
//9. don't beep on certain characters like spaces
//10. the [color] tag will only take effect for that line

// Textbox variables
textbox_x = 32;
textbox_y = 320;
textbox_outer_width = 578;
textbox_outer_height = 152;
textbox_outerinner_offset_x = 6;
textbox_outerinner_offset_y = 6;
textbox_inner_width = 566;
textbox_inner_height = 140;
textbox_outer_color = #FFFFFF;
textbox_inner_color = #000000;
asterisk_sprite = s_asterisk;
text_line1_offset_x = 60;
text_line1_offset_y = 25; // It should be 28 but it's 3px off so 25 works...?
text_line2_offset_x = 60;
text_line2_offset_y = 61;
text_line3_offset_x = 60;
text_line3_offset_y = 97;
current_line = 0; // From 0-2 (a maximum of 3 lines per textbox)
total_lines = 0;
needs_page_init = true;
needs_line_init = true;
line1_asterisk = false;
line2_asterisk = false;
line3_asterisk = false;

// Text variable. This is the only variable you'll probably change.
// The other variables CAN be changed but by default they're canon to Undertale.
//text = ["* Looks like no text was\nadded for this dialog box.", "* You're filled with the power\nof default variables!"];
//text = ["* debugging is enabled\ninstance id: " + string(id), "* you can skip this text...\n[noskip][instant]* can't skip this part tho", "* watch this text...\n[instant]DRAW INSTANTLY :o\n* INSTANTLY!!!!!!!"];
//text = ["* [noskip]test of the no[instant]skip\ntag...", "* [instant]test of instant!"];
//text = ["* Instant text test", "* [instant]this draws instantly...", "* this skips in[instant]\nthe middle of the text...", "* and THIS shows\n[instant]that it works\n* with asterisks!"];
//text = ["* Watch how this text\nwill advance without any\nuser interaction!!![advance]"];
//text = ["* [noadvance]No escape...", "* __________________________________"];
//text = ["* [pauseforframes:30]This [pauseforframes:20]text will [pauseforframes:30]pause.[pauseforframes:30]"];
text = ["* [asteriskcolor1:#00FF00]HAVE YOU BEEN [color:#0000FF][WorkingOnA\n[asteriskcolor2:#00FF00][color:#FF00FF]Text[color:#276182]Engine] for [color:#FF0000]WAY [color:#372519]TOO [color:#ABCDEF]LONG???\n* [asteriskcolor3:#0000FF][color:#391833]with COLORS on [color:#00FFFF]LINE 3????", "* [asteriskcolor1:#00FFFF][color:#123456]Strangely, that name...[pauseforframes:30]\n* [asteriskcolor2:#0000FF]It resonates within you, filling\nyou with [color:#FF0000]DETERMINATION[color:#FFFFFF]."];

//text = ["* fucasfasdfk\nsdfjsjfds\n* twintwintiwntwitnwin"]

//text = ["* HAVE YOU BEEN [color:#0000FF][WorkingOnA\n[color:#FF00FF]Text[color:#276182]Engine] for [color:#FF0000]WAY [color:#372519]TOO [color:#ABCDEF]LONG???\n* [color:#391833]with COLORS on [color:#00FFFF]LINE 3????", "* Strangely, that name...[pauseforframes:30]\n* It resonates within you, filling\nyou with determination."];
// You might want to change this too
text_voicebeep = sn_voicebeep_narrator;

// Text variables
textspd = 1;
textfont = dtf;
textxoffset = 16;

// other text variables. DONT CHANGE THESE. YOU CAN CHANGE ALL THE OTHER ONES.
clock = 0;
text_char_index = 0;
text_page_index = 0;

// stores special command values ([instant], [noskip], etc.)
pauseforframes = 0;
pauseforframescache = [];
pauseforframesoverride = false;
pauseforframeslastchar = -1;
colorl0 = [];
colorl1 = [];
colorl2 = [];
defaultcolor = #FFFFFF;
// ALRIGHT IVE DISCOVERED HOW TO HANDLE COLORS
// EVERY TIME THE [color:#123456] TAG IS DETECTED REMOVE IT AND
// ADD THE TEXT INDEX OF THE COLOR TAG AND THE HEX CODE AS AN ARRAY
// OBJECT IN THIS ARRAY!!!!! THEN WE CAN JUST CHECK THE LIST EVERY FRAME AND SEE
// IF WE NEED TO UPDATE THE COLOR
asteriskcolor1 = #FFFFFF;
asteriskcolor2 = #FFFFFF;
asteriskcolor3 = #FFFFFF;
noskip = -1;
noskipoverride = false;
noskiplastchar = false;
instant = -1;
instantoverride = false;
instantlastchar = false;
advance = -1;
advanceoverride = false;
advancelastchar = false;
noadvance = -1;
noadvanceoverride = false;
noadvancelastchar = false;
done = false;

thisLineHasAnAsterisk = function() {
	return ((current_line == 0 and line1_asterisk == true) or (current_line == 1 and line2_asterisk == true) or (current_line == 2 and line3_asterisk == true));
}

stripAsterisks = function(text) {
	return string_replace_all(text, "* ", "");
}

normalize = function(text, exceptions=[]) {
	// first remove all no-argument tags
	if (array_contains(exceptions, "asterisk") == false) { text = string_replace_all(text, "* ", ""); };
	if (array_contains(exceptions, "instant") == false) { text = string_replace_all(text, "[instant]", ""); };
	if (array_contains(exceptions, "noskip") == false) { text = string_replace_all(text, "[noskip]", ""); };
	
	// next remove all of the argumentative tags
	if (array_contains(exceptions, "color") == false) {
		while true {
			var startingchar = string_pos("[color:", stripAsterisks(text));
			if (startingchar != 0) {
				var endingchar = 0;
				// i JUST realized i could have used string_pos for this :sob:
				// well its wtv atp...
				for (var i = startingchar; i < string_length(text) + 1; i++) {
					if (string_char_at(text, i) == "]") {
						endingchar = i;
						break;
					}
				}
				if (endingchar == 0) { show_debug_message("Unexpected end of color tag (in normalize function).\nCurrent line: " + current_line_text); } else {
					arg = string_copy(text, startingchar + 7, endingchar - (startingchar + 7));
					text = string_replace(text, "[color:" + arg + "]", "");
				}
			} else { break; };
		}
	}
	
	if (array_contains(exceptions, "pauseforframes") == false) {
		while true {
			var startingchar = string_pos("[pauseforframes:", stripAsterisks(text));
			if (startingchar != 0) {
				//show_debug_message(startingchar);
				var endingchar = 0;
				for (var i = startingchar; i < string_length(text) + 1; i++) {
					if (string_char_at(text, i) == "]") {
						endingchar = i;
						break;
					}
				}
				if (endingchar == 0) { show_debug_message("Unexpected end of pauseforframes tag (in normalize function).\nCurrent line: " + current_line_text); } else {
					arg = string_copy(text, startingchar + 16, endingchar - (startingchar + 16));
					text = string_replace(text, "[pauseforframes:" + arg + "]", "");
				}
			} else { break; };
		}
	}
	
	if (array_contains(exceptions, "asteriskcolor1") == false) {
		while true {
			var startingchar = string_pos("[asteriskcolor1:", stripAsterisks(text));
			if (startingchar != 0) {
				//show_debug_message(startingchar);
				var endingchar = 0;
				for (var i = startingchar; i < string_length(text) + 1; i++) {
					if (string_char_at(text, i) == "]") {
						endingchar = i;
						break;
					}
				}
				if (endingchar == 0) { show_debug_message("Unexpected end of asteriskcolor1 tag (in normalize function).\nCurrent line: " + current_line_text); } else {
					arg = string_copy(text, startingchar + 16, endingchar - (startingchar + 16));
					text = string_replace(text, "[asteriskcolor1:" + arg + "]", "");
				}
			} else { break; };
		}
	}
	
	if (array_contains(exceptions, "asteriskcolor2") == false) {
		while true {
			var startingchar = string_pos("[asteriskcolor2:", stripAsterisks(text));
			if (startingchar != 0) {
				//show_debug_message(startingchar);
				var endingchar = 0;
				for (var i = startingchar; i < string_length(text) + 1; i++) {
					if (string_char_at(text, i) == "]") {
						endingchar = i;
						break;
					}
				}
				if (endingchar == 0) { show_debug_message("Unexpected end of asteriskcolor2 tag (in normalize function).\nCurrent line: " + current_line_text); } else {
					arg = string_copy(text, startingchar + 16, endingchar - (startingchar + 16));
					text = string_replace(text, "[asteriskcolor2:" + arg + "]", "");
				}
			} else { break; };
		}
	}
	
	if (array_contains(exceptions, "asteriskcolor3") == false) {
		while true {
			var startingchar = string_pos("[asteriskcolor3:", stripAsterisks(text));
			if (startingchar != 0) {
				//show_debug_message(startingchar);
				var endingchar = 0;
				for (var i = startingchar; i < string_length(text) + 1; i++) {
					if (string_char_at(text, i) == "]") {
						endingchar = i;
						break;
					}
				}
				if (endingchar == 0) { show_debug_message("Unexpected end of asteriskcolor3 tag (in normalize function).\nCurrent line: " + current_line_text); } else {
					arg = string_copy(text, startingchar + 16, endingchar - (startingchar + 16));
					text = string_replace(text, "[asteriskcolor3:" + arg + "]", "");
				}
			} else { break; };
		}
	}
	
	//show_error(text,true);
	return text;
}

pffnormalize = function(text) { // quick wrapper for normalize
	return normalize(text, ["pauseforframes"]);
}

clrnormalize = function(text) {
	return normalize(text, ["color"]);
}

acnormalize = function(text) {
	return normalize(text, ["asteriskcolor1", "asteriskcolor2", "asteriskcolor3"]);
}

skip = function() {
	current_text = text[text_page_index];
	lines = string_split(current_text, "\n");
	current_line_text = lines[current_line];
	total_lines = array_length(lines) - 1;
	if (total_lines == 0) {
		text_char_index = string_length(lines[0]);
	} else if (total_lines == 1) {
		text_char_index = string_length(lines[1]);
	} else if (total_lines == 2) {
		text_char_index = string_length(lines[2]);
	}
		
	current_line = total_lines;
	needs_line_init = true;
	if (total_lines >= 0) {
		current_line = 0;
		current_line_text = lines[current_line];
		setupLine();
		line1 = string_copy(lines[0], 1, string_length(lines[0]));
		if (string_starts_with(line1, "* ")) {
			line1_asterisk = true;
		}
	}
	if (total_lines >= 1) {
		current_line = 1;
		current_line_text = lines[current_line];
		setupLine();
		line2 = string_copy(lines[1], 1, string_length(lines[1]));
		if (string_starts_with(line2, "* ")) {
			line2_asterisk = true;
		}
	}
	if (total_lines >= 2) {
		current_line = 2;
		current_line_text = lines[current_line];
		setupLine();
		line3 = string_copy(lines[2], 1, string_length(lines[2]));
		if (string_starts_with(line3, "* ")) {
			line3_asterisk = true;
		}
	}
}

next = function() {
	if (text_page_index != array_length(text) - 1) {
		text_page_index += 1;
		needs_page_init = true;
		needs_line_init = true;
		current_line = 0; // From 0-2 (a maximum of 3 lines per textbox)
		total_lines = 0;
		line1_asterisk = false;
		line2_asterisk = false;
		line3_asterisk = false;
		text_char_index = 0;
		current_line_text = "";
	} else {
		instance_destroy();
	}
}

calculateColor = function(index, line) {
	//if (keyboard_check(ord("Q"))) { show_error(index, true); };
	//show_error(color, true);
	var distance = 9999999;
	var color = defaultcolor;
	if (line == 0) {
		for (var i = 0; i < array_length(colorl0); i++) {
			if (colorl0[i][0] < index) {
				if (index - colorl0[i][0] < distance) {
					distance = index - colorl0[i][0];
					color = colorl0[i][1];
				}
			}// else {
			//	show_debug_message("color_index: " + string(color[i][0]));
			//	show_debug_message("index: " + string(index));
			//	show_debug_message("color: " + string(color[i][1]));
			//}
		}
	} else if (line == 1) {
		for (var i = 0; i < array_length(colorl1); i++) {
			if (colorl1[i][0] < index) {
				if (index - colorl1[i][0] < distance) {
					distance = index - colorl1[i][0];
					color = colorl1[i][1];
				}
			}
		}
	} else {
		for (var i = 0; i < array_length(colorl2); i++) {
			if (colorl2[i][0] < index) {
				if (index - colorl2[i][0] < distance) {
					distance = index - colorl2[i][0];
					color = colorl2[i][1];
				}
			}
		}
	}
	
	return color; //default color
}

setupLine = function() {
	show_debug_message(current_line);
	if (string_starts_with(current_line_text, "* ")) {
		if (current_line == 0) { line1_asterisk = true; };
		if (current_line == 1) { line2_asterisk = true; };
		if (current_line == 2) { line3_asterisk = true; };
		current_line_text = string_replace(current_line_text, "* ", "");
		lines[current_line] = current_line_text;
		text[text_page_index] = string_join_ext("\n", lines);
	}
	
	//show_error(pffnormalize("[color:#FFFFFF]This is a [pauseforframes:30]pauseforframes test."), true);
	//show_debug_message(clrnormalize("[color:#FFFFFF]This is a [pauseforframes:30]color test."));
	
	if (string_starts_with(current_line_text, "[noskip]")) { 
		noskipoverride = true;
	    current_line_text = string_replace_all(current_line_text, "[noskip]", "");
		lines[current_line] = current_line_text;
		text[text_page_index] = string_join_ext("\n", lines);
	}
	if (string_pos("[noskip]", current_line_text) != 0) {
		noskip = string_pos("[noskip]", stripAsterisks(current_line_text));
	    current_line_text = string_replace_all(current_line_text, "[noskip]", "");
		lines[current_line] = current_line_text;
		text[text_page_index] = string_join_ext("\n", lines);
		if (noskip > string_length(stripAsterisks(current_line_text))) { noskiplastchar = true; };
	}
	if (string_starts_with(current_line_text, "[instant]")) { 
		instantoverride = true;
	    current_line_text = string_replace_all(current_line_text, "[instant]", "");
		lines[current_line] = current_line_text;
		text[text_page_index] = string_join_ext("\n", lines);
	}
	if (string_pos("[instant]", current_line_text) != 0) {
		instant = string_pos("[instant]", stripAsterisks(current_line_text));
	    current_line_text = string_replace_all(current_line_text, "[instant]", "");
		lines[current_line] = current_line_text;
		text[text_page_index] = string_join_ext("\n", lines);
		if (instant > string_length(stripAsterisks(current_line_text))) { instantlastchar = true; };
	}
	if (string_starts_with(current_line_text, "[advance]")) { 
		advanceoverride = true;
	    current_line_text = string_replace_all(current_line_text, "[advance]", "");
		lines[current_line] = current_line_text;
		text[text_page_index] = string_join_ext("\n", lines);
	}
	if (string_pos("[advance]", current_line_text) != 0) {
		advance = string_pos("[advance]", stripAsterisks(current_line_text));
	    current_line_text = string_replace_all(current_line_text, "[advance]", "");
		lines[current_line] = current_line_text;
		text[text_page_index] = string_join_ext("\n", lines);
		if (advance > string_length(stripAsterisks(current_line_text))) { advancelastchar = true; };
	}
	if (string_starts_with(current_line_text, "[noadvance]")) { 
		noadvanceoverride = true;
	    current_line_text = string_replace_all(current_line_text, "[noadvance]", "");
		lines[current_line] = current_line_text;
		text[text_page_index] = string_join_ext("\n", lines);
	}
	if (string_pos("[noadvance]", current_line_text) != 0) {
		noadvance = string_pos("[noadvance]", stripAsterisks(current_line_text));
	    current_line_text = string_replace_all(current_line_text, "[noadvance]", "");
		lines[current_line] = current_line_text;
		text[text_page_index] = string_join_ext("\n", lines);
		if (noadvance > string_length(stripAsterisks(current_line_text))) { noadvancelastchar = true; };
	}
	while true { // ooo dangerous
		if (string_pos("[pauseforframes:", current_line_text) != 0) {
			var startingchar = string_pos("[pauseforframes:", pffnormalize(current_line_text));
			//show_debug_message(startingchar);
			//show_debug_message(string_length(pffnormalize(current_line_text)));
			var endingchar = 0;
			for (var i = startingchar; i < string_length(pffnormalize(current_line_text)) + 1; i++) {
				//show_debug_message(string_char_at(current_line_text, i));
				if (string_char_at(pffnormalize(current_line_text), i) == "]") {
					endingchar = i;
					//show_error("qhfkajfjkasfds", true);
					//show_debug_message("endingchar:", endingchar);
					break;
				}
			}
			if (endingchar == 0) { show_error("Unexpected end of pauseforframes tag.\nCurrent line: " + pffnormalize(current_line_text), true); };
			//pauseforframesarg = string_copy(pffnormalize(current_line_text), startingchar + 16, endingchar - (startingchar + 16));
			pauseforframesarg = string_copy(pffnormalize(current_line_text), startingchar + 16, endingchar - (startingchar + 16));// - (startingchar));
			
			if (string_pos("[pauseforframes:", pffnormalize(current_line_text))-1 != 0) {
				//show_error(pauseforframesarg + "\n" + pffnormalize(current_line_text), true);
				array_push(pauseforframescache, [string_pos("[pauseforframes:", pffnormalize(current_line_text))-1, real(pauseforframesarg)]);
			    current_line_text = string_replace(current_line_text, "[pauseforframes:" + pauseforframesarg + "]", "");
				lines[current_line] = current_line_text;
				text[text_page_index] = string_join_ext("\n", lines);
			} else {
				current_line_text = string_replace(current_line_text, "[pauseforframes:" + pauseforframesarg + "]", "");
				lines[current_line] = current_line_text;
				text[text_page_index] = string_join_ext("\n", lines);
				pauseforframes = real(pauseforframesarg);
			}
			if (real(pauseforframesarg) > string_length(normalize(current_line_text))) { pauseforframeslastchar = real(pauseforframesarg); }
			//else {
				//show_debug_message("start debug");
				//show_debug_message(pauseforframes);
				//show_debug_message(string_length(normalize(current_line_text)));
				//show_debug_message(pauseforframes > string_length(normalize(current_line_text)));
				//show_debug_message("end debug");
			//}
		} else {
			break;
		}
	}
	while true {
		if (string_pos("[color:", current_line_text) != 0) {
			var startingchar = string_pos("[color:", clrnormalize(current_line_text));
			//show_debug_message(startingchar);
			//show_debug_message(string_length(current_line_text));
			var endingchar = 0;
			for (var i = startingchar; i < string_length(clrnormalize(current_line_text)) + 1; i++) {
				if (string_char_at(clrnormalize(current_line_text), i) == "]") {
					endingchar = i;
					break;
				}
			}
			if (endingchar == 0) { show_error("Unexpected end of color tag.\nCurrent line: " + clrnormalize(current_line_text), true); };
			colorarg = string_copy(clrnormalize(current_line_text), startingchar + 7, endingchar - (startingchar + 7));
			if (string_length(colorarg) != 7) { show_error("Invalid argument for color tag.\nCurrent line: " + clrnormalize(current_line_text) + "\nDetected argument: " + colorarg, true); };
			//if (string_pos("[color:", stripAsterisks(current_line_text))-1 != 0) {
			if (current_line == 0) {
				array_push(colorl0, [string_pos("[color:", clrnormalize(current_line_text))-1, hextoclr(colorarg)]);
			} else if (current_line == 1) {
				array_push(colorl1, [string_pos("[color:", clrnormalize(current_line_text))-1, hextoclr(colorarg)]);
			} else {
				array_push(colorl2, [string_pos("[color:", clrnormalize(current_line_text))-1, hextoclr(colorarg)]);
			}
			current_line_text = string_replace(current_line_text, "[color:" + colorarg + "]", "");
			lines[current_line] = current_line_text;
			text[text_page_index] = string_join_ext("\n", lines);
			//}// else {
			//	current_line_text = string_replace(current_line_text, "[color:" + pauseforframesarg + "]", "");
			//	lines[current_line] = current_line_text;
			//	text[text_page_index] = string_join_ext("\n", lines);
			//	pauseforframes = real(pauseforframesarg);zxxz
			//}
			//if (pauseforframes > string_length(stripAsterisks(current_line_text))) { pauseflastchar = true; };
		} else {
			break;
		}
	}
	
	while true {
		if (string_pos("[asteriskcolor1:", current_line_text) != 0) {
			var startingchar = string_pos("[asteriskcolor1:", acnormalize(current_line_text));
			//show_debug_message(startingchar);
			//show_debug_message(string_length(current_line_text));
			var endingchar = 0;
			for (var i = startingchar; i < string_length(acnormalize(current_line_text)) + 1; i++) {
				if (string_char_at(acnormalize(current_line_text), i) == "]") {
					endingchar = i;
					break;
				}
			}
			if (endingchar == 0) { show_error("Unexpected end of asteriskcolor1 tag.\nCurrent line: " + acnormalize(current_line_text), true); };
			asteriskcolor1arg = string_copy(acnormalize(current_line_text), startingchar + 16, endingchar - (startingchar + 16));
			if (string_length(asteriskcolor1arg) != 7) { show_error("Invalid argument for asteriskcolor1 tag.\nCurrent line: " + acnormalize(current_line_text), true); };
			asteriskcolor1 = hextoclr(asteriskcolor1arg);
			current_line_text = string_replace(current_line_text, "[asteriskcolor1:" + asteriskcolor1arg + "]", "");
			lines[current_line] = current_line_text;
			text[text_page_index] = string_join_ext("\n", lines);
		} else {
			break;
		}
	}
	
	while true {
		if (string_pos("[asteriskcolor2:", current_line_text) != 0) {
			var startingchar = string_pos("[asteriskcolor2:", acnormalize(current_line_text));
			//show_debug_message(startingchar);
			//show_debug_message(string_length(current_line_text));
			var endingchar = 0;
			for (var i = startingchar; i < string_length(acnormalize(current_line_text)) + 1; i++) {
				if (string_char_at(acnormalize(current_line_text), i) == "]") {
					endingchar = i;
					break;
				}
			}
			if (endingchar == 0) { show_error("Unexpected end of asteriskcolor2 tag.\nCurrent line: " + acnormalize(current_line_text), true); };
			asteriskcolor2arg = string_copy(acnormalize(current_line_text), startingchar + 16, endingchar - (startingchar + 16));
			if (string_length(asteriskcolor2arg) != 7) { show_error("Invalid argument for asteriskcolor2 tag.\nCurrent line: " + acnormalize(current_line_text), true); };
			asteriskcolor2 = hextoclr(asteriskcolor2arg);
			current_line_text = string_replace(current_line_text, "[asteriskcolor2:" + asteriskcolor2arg + "]", "");
			lines[current_line] = current_line_text;
			text[text_page_index] = string_join_ext("\n", lines);
		} else {
			break;
		}
	}
	
	while true {
		if (string_pos("[asteriskcolor3:", current_line_text) != 0) {
			var startingchar = string_pos("[asteriskcolor3:", acnormalize(current_line_text));
			//show_debug_message(startingchar);
			//show_debug_message(string_length(current_line_text));
			var endingchar = 0;
			for (var i = startingchar; i < string_length(acnormalize(current_line_text)) + 1; i++) {
				if (string_char_at(acnormalize(current_line_text), i) == "]") {
					endingchar = i;
					break;
				}
			}
			if (endingchar == 0) { show_error("Unexpected end of asteriskcolor3 tag.\nCurrent line: " + acnormalize(current_line_text), true); };
			asteriskcolor3arg = string_copy(acnormalize(current_line_text), startingchar + 16, endingchar - (startingchar + 16));
			if (string_length(asteriskcolor3arg) != 7) { show_error("Invalid argument for asteriskcolor3 tag.\nCurrent line: " + acnormalize(current_line_text), true); };
			asteriskcolor3 = hextoclr(asteriskcolor3arg);
			current_line_text = string_replace(current_line_text, "[asteriskcolor3:" + asteriskcolor3arg + "]", "");
			lines[current_line] = current_line_text;
			text[text_page_index] = string_join_ext("\n", lines);
		} else {
			break;
		}
	}
}

//myvar = "f" + "o";
//try {
//	show_debug_message(real(myvar));
//} catch (e) {show_error("don't do that vro", false)};
//show_debug_message(string_length("four"));
//show_debug_message(string_pos("ur", "four"));
//show_debug_message(string_char_at("four", 3));