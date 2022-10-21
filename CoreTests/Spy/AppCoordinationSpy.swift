//
//  AppCoordinationSpy.swift
//  CoreTests
//
//  Created by Author on 19.10.22.
//

import Core

final class AppCoordinationSpy: AppCoordination {
    enum Action: Equatable {
        case switchToSoundScreen
        case switchToMagicColorsScreen
    }

    private(set) var actions = [Action]()

    func switchToSoundScreen() {
        actions.append(.switchToSoundScreen)
    }

    func switchToMagicColorsScreen() {
        actions.append(.switchToMagicColorsScreen)
    }
}
