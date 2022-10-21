//
//  AudioSessionManager.swift
//  Sampler
//
//  Created by Author on 27.10.2020.
//

import AVFoundation
import Core

public class AudioSessionManager: Service {
    public init(
        audioSession: AudioSession,
        soundManager: SoundInitialization
    ) {
        self.audioSession = audioSession
        self.soundManager = soundManager
    }

    public func start() {
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true, options: [])
            try attachToAudioSession()
        } catch let error {
            fatalError("Is not implemented \(error)")
        }
    }

    private let audioSession: AudioSession
    private let soundManager: SoundInitialization
}

extension AudioSessionManager {
    private func attachToAudioSession() throws {
        if !soundManager.attachToAudioSession() {
            throw AudioSessionManagerError.noAttachToAudioSession
        }
    }
}

private enum AudioSessionManagerError: Error {
    case noAttachToAudioSession
}
