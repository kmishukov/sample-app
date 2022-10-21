//
//  AudioSessionManagerComposer.swift
//  Sample
//
//  Created by Author on 15.10.21.
//

import Interface
import Sound
import AVFoundation
import UIKit

final class AudioSessionManagerComposer {
    func compose() -> Service {
        AudioSessionManager(
            audioSession: AVAudioSession.sharedInstance(),
            soundManager: SoundRouter.shared()
        )
    }
}

extension AVAudioSession: AudioSession {}
