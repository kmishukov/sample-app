//
//  AppCoordinator.swift
//  Core
//
//  Created by Author on 13.10.2022.
//

import Foundation

public protocol AppCoordination {
    func switchToSoundScreen()
    func switchToMagicColorsScreen()
    func presentAdShowScreen(rewardCompletion: @escaping (() -> Void))
}
