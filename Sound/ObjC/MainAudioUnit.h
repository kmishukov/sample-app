//
//  MainAudioUnit.h
//  Sound
//
//  Created by Author on 27.10.2020.
//

#import <Foundation/Foundation.h>
#import "PdAudioUnit.h"

extern float averageBufferSpentPercentage;
extern float maxBufferSpentPercentage;

@interface MainAudioUnit : PdAudioUnit

- (instancetype)init;

@end
