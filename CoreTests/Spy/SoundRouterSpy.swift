//
//  SoundRouterSpy.swift
//  CoreTests
//
//  Created by Author on 13.10.2022.
//

import Core

class SoundRouterSpy: SoundRouting {
    private(set) var playSoundCallCount = 0

    func playSound() {
        playSoundCallCount += 1
    }
}
