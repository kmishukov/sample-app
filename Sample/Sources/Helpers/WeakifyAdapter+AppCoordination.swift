//
//  WeakifyAdapter+AppCoordination.swift
//  Sample
//
//  Created by Author on 19.10.22.
//

import Core

extension WeakifyAdapter: AppCoordination where T: AppCoordination {
    func switchToSoundScreen() {
        adaptee?.switchToSoundScreen()
    }

    func switchToMagicColorsScreen() {
        adaptee?.switchToMagicColorsScreen()
    }
}
