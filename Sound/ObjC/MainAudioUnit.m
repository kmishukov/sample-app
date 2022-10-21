//
//  MainAudioUnit.m
//  Sound
//
//  Created by Author on 27.10.2020.
//

#import "MainAudioUnit.h"
#import "TPCircularBuffer.h"
#import "SoundRouter.h"
#import <QuartzCore/QuartzCore.h>
#import "constants.h"

@interface MainAudioUnit ()

@property (nonatomic, assign) int blocksPerBuffer;
@property (nonatomic, assign) TPCircularBuffer ringBuffer;
@property (nonatomic, assign) int framesInReserve;
@property (nonatomic, assign) int framesPerSlice;

@end

@implementation MainAudioUnit

- (instancetype)init {
    self = [super init];
    if (self) {
        self.framesInReserve = 0;
        self.blocksPerBuffer = 8;
    }
    return self;
}

static OSStatus AudioRenderCallback(
        void *inRefCon,
        AudioUnitRenderActionFlags *ioActionFlags,
        const AudioTimeStamp *inTimeStamp,
        UInt32 inBusNumber,
        UInt32 inNumberFrames,
        AudioBufferList *ioData
        ) {
    MainAudioUnit *pdAudioUnit = (__bridge MainAudioUnit *)inRefCon;
    int framesPerSlice = pdAudioUnit.blocksPerBuffer * BLOCK_SIZE;

    bool isSupported = (inNumberFrames <= framesPerSlice);
    if (!isSupported) {
        return kUnknownType;
    }

    float inBuffer[framesPerSlice * 2];
    memset(&inBuffer, 0,
           framesPerSlice * 2 * sizeof(float));

    if (pdAudioUnit->_framesInReserve < inNumberFrames) {
        [SoundRouter.shared processAudioWithBuffer:inBuffer blocks:pdAudioUnit.blocksPerBuffer];
        TPCircularBufferProduceBytes(&pdAudioUnit->_ringBuffer,
                                     &inBuffer,
                                     (int32_t)sizeof(inBuffer));
        pdAudioUnit->_framesInReserve += (framesPerSlice - inNumberFrames);
    } else {
        pdAudioUnit->_framesInReserve -= inNumberFrames;
    }
    //Data for current frame retrieved from the circular buffer.
    Float32 *data = (Float32 *)ioData->mBuffers[0].mData;
    uint32_t availableBytes;
    UInt32 len = ioData->mBuffers[0].mDataByteSize;
    void *ptr = TPCircularBufferTail(&pdAudioUnit->_ringBuffer,
                                     &availableBytes);
    if (availableBytes >= len) {
        memcpy(data,
               ptr,
               len);
        TPCircularBufferConsume(&pdAudioUnit->_ringBuffer,
                                len);
    }

    return noErr;
}

- (AURenderCallback)renderCallback {
    return AudioRenderCallback;
}

- (void)setBlocksPerBuffer:(int)blocksPerBuffer {
    self.framesPerSlice = BLOCK_SIZE * blocksPerBuffer;
    if (_blocksPerBuffer != blocksPerBuffer) {
        if (_ringBuffer.buffer) {
            TPCircularBufferCleanup(&_ringBuffer);
        }
        TPCircularBufferInit(&_ringBuffer, _framesPerSlice * 4 * sizeof(float));
    }
    _blocksPerBuffer = blocksPerBuffer;

}

- (int)configureWithSampleRate:(Float64)sampleRate numberChannels:(int)numChannels inputEnabled:(BOOL)inputEnabled {
    int result = [super configureWithSampleRate:44100
                                 numberChannels:numChannels
                                   inputEnabled:inputEnabled];
    return result;
}

@end
