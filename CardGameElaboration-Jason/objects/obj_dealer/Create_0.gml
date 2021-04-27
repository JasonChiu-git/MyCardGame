global.phase_deal = 0;
global.phase_computer = 1;
global.phase_select = 2;
global.phase_play= 3;
global.phase_result = 4;
global.phase_reshuffle = 5;
global.phase = global.phase_deal;

global.selected_card = noone;

global.mouse = 0;
global.human = 1;
global.elephant = 2;
global.cat = 3;
global.cucumber = 4;

aiScore = 0;
playerScore = 0;

moveTimer = 0;
waitTimer = 0;

deckSize = 30;
deck = ds_list_create();

handComputer = ds_list_create();
handPlayer = ds_list_create();

playComputer = noone;
playPlayer = noone;

discardPile = ds_list_create();

for (i=0; i<deckSize; i++) {
	var newcard = instance_create_layer(0,0,"Instances",obj_card);
	newcard.face_up = false;
	newcard.dealt = false;
	if (i<deckSize/5){
		newcard.type = global.mouse;
	}
	else if (i<2*deckSize/5){
		newcard.type = global.human;
	}
	else if (i<3*deckSize/5){
		newcard.type = global.cat;
	}
	else if (i<4*deckSize/5){
		newcard.type = global.cucumber;
	}
	else {
		newcard.type = global.elephant;
	}
	ds_list_add(deck,newcard);	
}
	
	

ds_list_shuffle(deck);


for (i = 0; i<deckSize; i++){
	deck[| i].x = 40;			
	deck[| i].y = 320-(2*i);
	deck[| i].target_x = deck[| i].x;
	deck[| i].target_y = deck[| i].y;
	deck[| i].depth = deckSize-i;
}

