// yes these 3 lines were "borrowed" from JBE
// since i wrote it i don't think it's immoral though
game_set_speed(30, gamespeed_fps);
display_reset(display_aa, false);
randomize();

clock = 0;

state = 1;

undertale_ls = s_UNDERTALE; // ls = logo sprite
underswap_ls = s_UNDERSWAP;
pzoespr = s_presszorenter;
current_ls = 1;

ins_text = "[Z or Enter] - Confirm\n[X or Shift] - Cancel\n[C or CTRL] - Menu (In-game)\n[F4] - Fullscreen\n[Hold ESC] - Quit\nWhen HP is 0, you lose.";

sel_option = 1;

undertale_nm = "Chara";
underswap_nm = "Frisk";
current_nm = 1;

nm_scale = 2;
nm_x = -999;
nm_y = 120;
nm_rot = 0;

fader_progress = 0;