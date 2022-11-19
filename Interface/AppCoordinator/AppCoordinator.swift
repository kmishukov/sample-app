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
        // TODO: СДЕЛАТЬ
        // TODO: СДЕЛАТЬ
        // TODO: СДЕЛАТЬ
        // TODO: СДЕЛАТЬ
        // TODO: СДЕЛАТЬ
        // TODO: СДЕЛАТЬ
        /*let viewModel = GoodByeViewModelImpl(appCoordinator: appCoordinator, notificationAppHideService: notificationAppHideService)
        let mainView = GoodByeScreenView(viewModel: viewModel)
        return GoodByeScreenViewController(mainView: mainView)*/
        
        /*let viewModel = AdsScreenViewModelImp()
        let mainView = AdsScreenView(viewModel: viewModel)
        return AdsScreenViewController(mainView: mainView)*/
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }
}
