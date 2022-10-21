//
//  MainWindow.swift
//  Sample
//
//  Created by Author on 04.10.2021.
//

import UIKit
import Core

final class MainWindow: UIWindow {
    let appCoordinator: AppCoordination
    
    required init(frame: CGRect, appCoordinator: AppCoordination) {
        self.appCoordinator = appCoordinator
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
