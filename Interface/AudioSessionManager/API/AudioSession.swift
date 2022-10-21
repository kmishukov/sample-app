//
//  AudioSession.swift
//  Core
//
//  Created by Author on 15.10.21.
//

import AVFoundation

public protocol AudioSession {
    func setActive(_ active: Bool, options: AVAudioSession.SetActiveOptions) throws
    func setCategory(
        _ category: AVAudioSession.Category,
        mode: AVAudioSession.Mode,
        options: AVAudioSession.CategoryOptions
    ) throws
}
