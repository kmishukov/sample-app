//
//  facade.c
//  Sound
//
//  Created by Author on 29.04.2021.
//

#include "facade.h"
#include "player.h"

t_player *shared_player;

void facade_init() {
    shared_player = player_create();
}

void facade_process_audio(int blocks, float *buffer) {
    player_process_audio(shared_player, blocks, buffer);
}

void facade_play_sound(void) {
    player_play_sound(shared_player);
}
