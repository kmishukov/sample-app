//
//  SoundRouter.m
//  Sound
//
//  Created by Author on 29.04.2021.
//

#import "SoundRouter.h"
#import "facade.h"
#import "MainAudioUnit.h"
#import "PdAudioController.h"

@interface SoundRouter ()

@property (nonatomic, strong, readonly) PdAudioController *audioController;

@end

@implementation SoundRouter

- (id)init {
    self = [super init];
    if (self) {
        facade_init();
        MainAudioUnit *mainAudioUnit = [MainAudioUnit new];
        _audioController = [[PdAudioController alloc] initWithAudioUnit:mainAudioUnit];
    }
    return self;
}

+ (SoundRouter *)shared {
    static SoundRouter *sharedRouter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRouter = [self new];
    });
    return sharedRouter;
}

- (void)processAudioWithBuffer:(Float32 *)buffer blocks:(int)blocks {
    facade_process_audio(blocks, buffer);
}

#pragma mark - SoundRouting

- (BOOL)attachToAudioSession {
    PdAudioStatus status = [self.audioController configurePlaybackWithSampleRate:48000 numberChannels:2 inputEnabled:false mixingEnabled:false];
    if (status == PdAudioError) {
        return NO;
    }

    status = [self.audioController configureBlocksPerBuffer:8];
    if (status == PdAudioError) {
        return NO;
    }

    self.audioController.active = YES;

    return self.audioController.active;
}

- (void)playSound {
    facade_play_sound();
}

@end
