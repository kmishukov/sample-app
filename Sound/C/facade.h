//
//  facade.h
//  Sound
//
//  Created by Author on 29.04.2021.
//

#ifndef facade_h
#define facade_h

void facade_init(void);
void facade_process_audio(int blocks, float *buffer); //sample rate всегда 44100 Гц
void facade_play_sound(void);

#endif
