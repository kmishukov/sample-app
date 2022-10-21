//
//  SoundInitialization.swift
//  Core
//
//  Created by Author on 15.10.21.
//

import Foundation

@objc public protocol SoundInitialization {
    func attachToAudioSession() -> Bool
}
