//
//  MainComposer.swift
//  Sample
//
//  Created by Author on 27.09.2021.
//

import Core
import Sound
import Interface

final class MainComposer {
    func compose() -> (
        rootVC: UIViewController,
        coordinator: AppCoordination
    ) {
        let weakifyAdapterAppCoordinator = WeakifyAdapter<AppCoordinator>()
        let tabBarVC = TabBarController(viewControllers: [
            composeSoundScreen(),
            composeDownloadScreen(appCoordinator: weakifyAdapterAppCoordinator),
            composeMagicColorsScreen(),
            composeGoodByeScreen(appCoordinator: weakifyAdapterAppCoordinator)
        ])
        let appCoordinator = AppCoordinator(tabBarVC: tabBarVC)
        weakifyAdapterAppCoordinator.adaptee = appCoordinator
        return (tabBarVC, appCoordinator)
    }
}

extension MainComposer {
    private func composeSoundScreen() -> UIViewController {
        let viewModel = SoundScreenViewModelImpl(soundRouter: SoundRouter.shared())
        let mainView = SoundScreenView(viewModel: viewModel)
        return SoundScreenViewController(mainView: mainView)
    }

    private func composeDownloadScreen(appCoordinator: AppCoordination) -> UIViewController {
        let downloader = Downloader(
            delayedAction: DispatchQueue.main,
            isSuccessDownloading: { arc4random_uniform(2) == 0 }
        )
        let viewModel = DownloadScreenViewModelImpl(downloader: downloader, appCoordinator: appCoordinator)
        let mainView = DownloadScreenView(viewModel: viewModel)
        return DownloadScreenViewController(mainView: mainView)
    }

    private func composeMagicColorsScreen() -> UIViewController {
        let viewModel = MagicColorsScreenViewModelImpl()
        let mainView = MagicColorsScreenView(viewModel: viewModel)
        return MagicColorsScreenViewController(mainView: mainView)
    }

    private func composeGoodByeScreen(appCoordinator: AppCoordination) -> UIViewController {
        let notificationAppHideService = NotificationAppHideServiceImp()
        let viewModel = GoodByeViewModelImpl(appCoordinator: appCoordinator, notificationAppHideService: notificationAppHideService)
        let mainView = GoodByeScreenView(viewModel: viewModel)
        return GoodByeScreenViewController(mainView: mainView)
    }
}
