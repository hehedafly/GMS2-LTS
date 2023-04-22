if(keyboard_check(vk_control) && keyboard_check_pressed(vk_tab)){
	if(visible_stock==0){draw_enable_drawevent(true);visible_stock=1}
	else{draw_enable_drawevent(false);visible_stock=0}
}
if(restart_clock<restart_clock_max){restart_clock++;}
else{if(instance_number(obj_connecter)){
	with(obj_connecter){if(type=="server" && ds_map_size(client_map)==0){network_init();game_restart()}}
	}
	restart_clock=0;
}