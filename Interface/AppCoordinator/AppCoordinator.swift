//
//  AppCoordinator.swift
//  Interface
//
//  Created by Author on 06.08.2021.
//

import UIKit
import Core

public class AppCoordinator: NSObject {
    public init(tabBarVC: UITabBarController) {
        self.tabBarVC = tabBarVC
    }

    private let tabBarVC: UITabBarController
}

extension AppCoordinator: AppCoordination {
    public func switchToSoundScreen() {
        tabBarVC.selectedIndex = 0
    }

    public func switchToMagicColorsScreen() {
        tabBarVC.selectedIndex = 2
    }
}
