if (x != target_x) {
	x = lerp(x,target_x,0.2);	
}

if (y != target_y) {
	y = lerp(y,target_y,0.2);
}

if (type == global.mouse) sprite_index = spr_mouse;
if (type == global.human) sprite_index = spr_human;
if (type == global.elephant) sprite_index = spr_elephant;
if (type == global.cat) sprite_index = spr_cat;
if (type == global.cucumber) sprite_index = spr_cucumber;
if (face_up == false) sprite_index = spr_back;

draw_sprite(sprite_index, image_index, x, y);
