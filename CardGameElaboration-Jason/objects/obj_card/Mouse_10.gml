if (global.phase == global.phase_select)&&(face_up == true){
	if (ds_list_find_index(obj_dealer.handPlayer,id) >= 0){ 
		target_y =534;	
		global.selected_card = id;
	}
}