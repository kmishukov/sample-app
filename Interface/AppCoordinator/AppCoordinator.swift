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

    public func presentAdShowScreen(rewardCompletion: @escaping (() -> Void)) {
        let viewController = composeAdsViewController(rewardCompletion: rewardCompletion)
        tabBarVC.present(viewController, animated: true)
    }
}

extension AppCoordinator {
    private func composeAdsViewController(rewardCompletion: @escaping (() -> Void)) -> UIViewController {
        let viewModel = AdsScreenViewModelImpl(rewardCompletion: rewardCompletion, closeCompletion: nil)
        let mainView = AdsScreenView(viewModel: viewModel)
        let viewController = AdsScreenViewController(mainView: mainView)
        viewModel.setCloseCompletion { [weak viewController] in
            guard let viewController = viewController else { return }
            viewController.dismiss(animated: true)
        }
        return viewController
    }
}
