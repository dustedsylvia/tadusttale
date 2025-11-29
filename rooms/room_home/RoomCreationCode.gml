if (ini_file_exists("file0.ini")) {
	room_goto(room_mainmenu_canon);
} else {
	room_goto(room_title);
}