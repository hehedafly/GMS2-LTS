if(visible_stock==0){with(all){visible=0;}}
else{with(all){visible=1;}}

if(room==Room_start){
	if(!instance_number(obj_connecter)){synchronization(instance_create_depth(0,0,1,obj_connecter))}
	else if(obj_connecter.username!=username_record || obj_connecter.uuid!=uuid_record){synchronization(obj_connecter, 1);}
	room_goto(Room_hall);
}
if(room==Room_hall){
	if(instance_number(obj_connecter)){
		//synchronization(obj_connecter);
		with(obj_connecter){
			if(ds_map_size(client_map)==0){
				network_init();
				ipadress=obj_UI_manager.ip_record;
				port=obj_UI_manager.port_record;
				type="server";
				server_create();
			}
		}
	}
	else{show_message("failed to create server, game reboot needed"); game_restart();}
	
	visible_stock=0;
	draw_enable_drawevent(false);
}