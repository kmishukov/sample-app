//
//  player.c
//  Sound
//
//  Created by Author on 25.07.2022.
//

#include "player.h"
#include "bytes.h"
#include "sound_frames.h"
#include "constants.h"

// 8 мс для sample rate 44100
#define FRAMES_PER_FADE (352)

t_player *player_create(void) {
    t_player *x = bytes_create(sizeof(t_player));
    x->isFadeOut = 0;
    x->volume = 0;
    x->position = SOUND_FRAMES_COUNT;
    return x;
}

void player_process_audio(t_player *x, int blocks, float *buffer) {
    float *buffer_pointer = buffer;
    int n = blocks * BLOCK_SIZE;

    while(n--) {
        float frame = 0.0;
        if (x->position < SOUND_FRAMES_COUNT) {
            frame = sound_frames[x->position++];
        }

        if (x->isFadeOut == 0) {
            // fadein
            if (x->volume < 1.0) {
                x->volume += 1.0 / FRAMES_PER_FADE;
            }
        } else {
            // fadeout
            if (x->volume > 0.0) {
                x->volume -= 1.0 / FRAMES_PER_FADE;
                if (x->volume <= 0.0) {
                    x->volume = 0;
                }
            } else {
                x->isFadeOut = 0;
                x->position = 0;
                x->volume = 0;
            }
        }
        frame *= x->volume;

        *buffer_pointer++ = frame;
        *buffer_pointer++ = frame / 2;
    }
}

void player_play_sound(t_player *x) {
    if (x->position >= SOUND_FRAMES_COUNT) {
        x->isFadeOut = 0;
        x->position = 0;
        x->volume = 0;
    } else {
        x->isFadeOut = 1;
    }
}
