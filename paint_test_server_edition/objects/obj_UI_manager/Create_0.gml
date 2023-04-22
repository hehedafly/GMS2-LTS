button_ls=ds_list_create();
ds_list_add(button_ls, "multiplayer", "singleplayer", "host", "enter", "cancel", "back");

click=0;
click_recordpos=[-1, -1];
ip_record="";
port_record=25565;
username_record="";
uuid_record=-1;

//visible_stock=1;
visible_stock=1;
//draw_enable_drawevent(false);
restart_clock=0;
restart_clock_max=room_speed*60*20;

#region server_init

username_record="server";
ip_record="127.0.0.1";
port_record=19810;

#endregion

function synchronization(inst_id, force){
	if(inst_id!=self){
		with(inst_id){
			ipadress=obj_UI_manager.ip_record;
			port=obj_UI_manager.port_record;
			username=obj_UI_manager.username_record;
			if(obj_UI_manager.uuid_record!=-1){uuid=obj_UI_manager.uuid_record}
		}
		if(force!=undefined){with(inst_id){uuid=obj_UI_manager.uuid_record}}
	}
	else{
			ip_record=obj_connecter.ipadress;
			port_record=obj_connecter.port;
			username_record=obj_connecter.username;
			if(force!=undefined){uuid_record=obj_connecter.uuid;}
	}
}
function draw_new_button(xx, yy, text, size, temp_map, button_id){
	if(text>=0 && text<ds_list_size(button_ls)){
		draw_circle_color(xx, yy, size, c_black, c_white, 0);
		draw_circle_color(xx, yy, size-4, c_white, c_white, 0);
		draw_text_color(xx-size*0.75, yy-4, button_ls[| text], c_black, c_black, c_black, c_black, 1);
	}
	
	if(array_length(click_recordpos)==4 && is_array(temp_map[? button_id])){
		array_set(ds_map_find_value(temp_map, button_id), 2, point_distance(click_recordpos[0], click_recordpos[1], temp_map[? button_id][0], temp_map[? button_id][1]));
		array_set(ds_map_find_value(temp_map, button_id), 3, point_distance(click_recordpos[2], click_recordpos[3], temp_map[? button_id][0], temp_map[? button_id][1]));
	}
	else if(is_array(temp_map[? button_id])){
		array_set(ds_map_find_value(temp_map, button_id), 2, 9999);
		array_set(ds_map_find_value(temp_map, button_id), 3, 9999);
	}
}
function mouse_init(){
	click=0;
	array_delete(click_recordpos, 0, array_length(click_recordpos));
	click_recordpos=[-1, -1];
}
function get_text(temp_type, nowtext){//提供初始选项以及得到所需文本
	if(nowtext==undefined || nowtext==""){
		if(temp_type=="ip"){
			nowtext="127.0.0.1";	
		}
		else if(temp_type=="port"){nowtext=port_record;}
		else if(temp_type=="username"){nowtext="player0";}
		else if(temp_type=="uuid"){nowtext=-1;}
	}
	if(temp_type=="ip"){
		while(true){
			var temp_text=get_string("sever ip:", nowtext);
			if(temp_text!=""){return(temp_text)}
		}
	}
	else if(temp_type=="port"){
		while(true){
			var temp_text=get_string("sever port:", nowtext);
			if(temp_text!=""){return(temp_text)}
		}
	}
	else if(temp_type=="name"){
		while(true){
			var temp_text=get_string("user name:", nowtext);
			if(temp_text!=""){return(temp_text)}
		}
	}
	else if(temp_type=="uuid"){
		while(true){
			var temp_text=get_string("UUID: ", nowtext);
			if(temp_text!=""){return(temp_text)}
		}
	}
	else{return(-1);}
}
function draw_text_block(x1, y1, x2, y2, content, align, getting_block_type, extra_text){//align: 0-中间, 1:左对齐
	draw_rectangle_color(x1, y1,x2, y2, c_black, c_black, c_black, c_black, false);
	draw_rectangle_color(x1+4, y1+2, x2-4, y2-2, c_white ,c_white ,c_white, c_white, false);
	if(align){draw_text_color(x1+4, y1, string(content), c_black, c_black, c_black, c_black, 1);}
	else{draw_text_color((x1+x2)*0.5-string_width(string(content))*0.5, y1, string(content), c_black, c_black, c_black, c_black, 1);}
	if(extra_text!= undefined){draw_text_color(x1-string_width(string(extra_text)), y1, extra_text, c_black, c_black, c_black, c_black, 1);}
	
	if(mouse_check_button_pressed(mb_left) && mouse_x>x1 && mouse_x<x2 && mouse_y>y1 && mouse_y<y2){
		var temp_content=get_text(getting_block_type, content)
		return(temp_content);
	}
	else{return(content)}
}