
switch (global.phase){
	case global.phase_deal:
		if (moveTimer == 0){
			
			if (ds_list_size(handComputer) < 5){
				var card = deck[| ds_list_size(deck)-1];
				ds_list_delete(deck,ds_list_size(deck)-1);
				ds_list_add(handComputer,card);
				
				card.target_x = 120 + 100*ds_list_size(handComputer);
				card.target_y = 80;
			}
			else if (ds_list_size(handPlayer) < 5){
				var card = deck[| ds_list_size(deck)-1];
				ds_list_delete(deck,ds_list_size(deck)-1);
				ds_list_add(handPlayer,card);
				
				card.target_x = 120 + 100*ds_list_size(handPlayer);
				card.target_y = 540;
			}
			else {
				for (i=0; i<5; i++){
					handPlayer[| i].face_up = true;	
				}
				global.phase = global.phase_computer;	
			}
		}
		break;
		
	case global.phase_computer:
		waitTimer++;	
		if (waitTimer == 40){	
			
			var index = irandom_range(0,ds_list_size(handComputer)); 
															
			
			
			playComputer = handComputer[| index];	
			playComputer.target_x = 320;	
			playComputer.target_y = 240;
			ds_list_delete(handComputer,index); 
			
		}
		if (waitTimer == 60){	
			
			waitTimer = 0;
			global.phase = global.phase_select;
		}
	
	
		break;
	
	case global.phase_select:
		
		if (mouse_check_button_pressed(mb_left)){
			
			if (global.selected_card != noone){
			
				var index = ds_list_find_index(handPlayer, global.selected_card);
				playPlayer = global.selected_card;
				playPlayer.target_x = 320;
				playPlayer.target_y = 390;
				ds_list_delete(handPlayer,index);
				
				global.phase = global.phase_play;
				global.selected_card = noone;
				waitTimer = 0;
			}
		}
		break;
		
	case global.phase_play:
		waitTimer++;
		if (waitTimer > 100){
			playComputer.face_up = true;
			global.phase = global.phase_result;
			if (playComputer.type == global.human){
				if (playPlayer.type == global.mouse){
					aiScore ++;
					audio_play_sound(snd_lose,0,0);
				}
				if (playPlayer.type == global.cucumber){
					playerScore ++;
					audio_play_sound(snd_win,0,0);
				}
				if (playPlayer.type == global.cat){
					aiScore ++;
					audio_play_sound(snd_win,0,0);
				}
				else if (playPlayer.type == global.elephant){
					playerScore ++;
					
				}
			}
			else if (playComputer.type == global.mouse){
				if (playPlayer.type == global.elephant){
					aiScore ++;
					audio_play_sound(snd_lose,0,0);
				}
				if (playPlayer.type == global.cucumber){
					aiScore ++;
					audio_play_sound(snd_lose,0,0);
				}
				if (playPlayer.type == global.cat){
					playerScore ++;
					audio_play_sound(snd_win,0,0);
				}
				else if (playPlayer.type == global.human){
					playerScore ++;
					audio_play_sound(snd_win,0,0);
				}
			}
			if (playComputer.type == global.elephant){
				if (playPlayer.type == global.human){
					aiScore ++;
					audio_play_sound(snd_lose,0,0);
				}
				if (playPlayer.type == global.cucumber){
					aiScore ++;
					audio_play_sound(snd_lose,0,0);
				}
				if (playPlayer.type == global.cat){
					playerScore ++;
					audio_play_sound(snd_win,0,0);
				}
				else if (playPlayer.type == global.mouse){
					playerScore ++;
					audio_play_sound(snd_win,0,0);
				}
			}
			if (playComputer.type == global.cucumber){
				if (playPlayer.type == global.human){
					aiScore ++;
					audio_play_sound(snd_lose,0,0);
				}
				if (playPlayer.type == global.cat){
					aiScore ++;
					audio_play_sound(snd_lose,0,0);
				}
				if (playPlayer.type == global.elephant){
					playerScore ++;
					audio_play_sound(snd_win,0,0);
				}
				else if (playPlayer.type == global.mouse){
					playerScore ++;
					audio_play_sound(snd_win,0,0);
				}
			}
			if (playComputer.type == global.cat){
				if (playPlayer.type == global.elephant){
					aiScore ++;
					audio_play_sound(snd_lose,0,0);
				}
				if (playPlayer.type == global.mouse){
					aiScore ++;
					audio_play_sound(snd_lose,0,0);
				}
				if (playPlayer.type == global.cucumber){
					playerScore ++;
					audio_play_sound(snd_win,0,0);
				}
				else if (playPlayer.type == global.human){
					playerScore ++;
					audio_play_sound(snd_win,0,0);
				}
			}
			waitTimer = 0;
		}
		break;
		
	case global.phase_result:
		waitTimer++;
		if (moveTimer == 0) && (waitTimer>60){
			if (playComputer != noone){
				ds_list_add(discardPile,playComputer);
				playComputer.target_x = 600;
				playComputer.target_y = 320 - ds_list_size(discardPile)*2;
				playComputer.depth = deckSize-ds_list_size(discardPile);
				playComputer = noone;
			}
			else if (playPlayer != noone){
				ds_list_add(discardPile,playPlayer);
				playPlayer.target_x = 600;
				playPlayer.target_y = 320 - ds_list_size(discardPile)*2;
				playPlayer.depth = deckSize-ds_list_size(discardPile);
				playPlayer = noone;
				
			}
			else if (ds_list_size(handComputer) > 0){
				var card = handComputer[| 0];
				ds_list_delete(handComputer, 0);
				ds_list_add(discardPile, card);
				card.target_y = 320 - ds_list_size(discardPile)*2;
				card.target_x = 600;
				card.face_up = true;
				card.depth = deckSize-ds_list_size(discardPile);
			}
			else if (ds_list_size(handPlayer) > 0){
				var card = handPlayer[| 0];
				ds_list_delete(handPlayer, 0);
				ds_list_add(discardPile, card);
				card.target_y = 320 - ds_list_size(discardPile)*2;
				card.target_x = 600;
				card.depth = deckSize-ds_list_size(discardPile);
			}
			
			else if (ds_list_size(deck) > 0) {
				global.phase = global.phase_deal;	
				waitTimer = 0;
			}
			else {
				global.phase = global.phase_reshuffle;
				waitTimer = 0;
			}
		}
	
		break;
		
	case global.phase_reshuffle:
	
		//reshuffle
		if (moveTimer%4 == 0){
			var index = ds_list_size(discardPile)-1;	
			var card = discardPile[| index];			
				
			ds_list_add(deck,card);							
			ds_list_delete(discardPile, index);			
				
			card.face_up = false;							
			card.target_x = 40;									
			card.target_y = 320 - 2*ds_list_size(deck);			
			card.depth = deckSize - ds_list_size(deck);		
				
			if (ds_list_size(deck) == deckSize){	
				ds_list_shuffle(deck);				
				for (i=0; i<deckSize; i++){
					deck[| i].depth = deckSize - i;
					deck[| i].y = 320 - 2*i;
					deck[| i].target_y = deck[| i].y;
				}
				global.phase = global.phase_deal;
			}		
		}
	
		break;
}


moveTimer++;
if (moveTimer ==16){
	moveTimer = 0;
}
