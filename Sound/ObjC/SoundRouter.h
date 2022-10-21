//
//  SoundRouter.h
//  Sound
//
//  Created by Author on 29.04.2021.
//

#import <Foundation/Foundation.h>
#import <Core/Core-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface SoundRouter : NSObject <SoundRouting, SoundInitialization>

- (id)init NS_SWIFT_UNAVAILABLE("Private API");

+ (SoundRouter *)shared;

- (void)processAudioWithBuffer:(Float32 *)buffer blocks:(int)blocks;
- (BOOL)attachToAudioSession;

@end

NS_ASSUME_NONNULL_END
