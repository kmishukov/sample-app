//
//  AppDelegate.swift
//  Sample
//
//  Created by Author on 10.06.2021.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let service = AudioSessionManagerComposer().compose()
        let (rootVC, coordinator) = MainComposer().compose()
        service.start()

        let window = MainWindow(
            frame: UIScreen.main.bounds,
            appCoordinator: coordinator
        )
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
