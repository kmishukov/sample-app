//
//  player.h
//  Sound
//
//  Created by Author on 25.07.2022.
//

#ifndef player_h
#define player_h

typedef struct _player {
    int position;
    float volume;
} t_player;

t_player *player_create(void);
void player_process_audio(t_player *x, int blocks, float *buffer);
void player_play_sound(t_player *x);

#endif /* player_h */
