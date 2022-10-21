//
//  SoundScreenViewModelImpl.swift
//  Core
//
//  Created by Author on 13.10.2022.
//

import Foundation

public class SoundScreenViewModelImpl {
    public init(soundRouter: SoundRouting) {
        self.soundRouter = soundRouter
    }

    private let soundRouter: SoundRouting
}

extension SoundScreenViewModelImpl: SoundScreenViewModel {
    public func onPlayTapped() {
        soundRouter.playSound()
    }
}
