//
//  TabBarController.swift
//  Interface
//
//  Created by Author on 04.08.2021.
//

import UIKit
import Core

public class TabBarController: UITabBarController {
    public required init(viewControllers: [UIViewController]) {
        assert(viewControllers.count == 4)
        super.init(nibName: nil, bundle: nil)
        assemble(viewControllers: viewControllers)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabBarController {
    private func assemble(viewControllers: [UIViewController]) {
        let titles: [String] = [
            "SOUND",
            "DOWNLOAD",
            "MAGIC COLORS",
            "GOOD BYE"
        ]

        for (index, vc) in viewControllers.enumerated() {
            with(vc.tabBarItem) {
                $0.title = titles[index]
            }
        }

        with(self) {
            $0.viewControllers = viewControllers
            $0.tabBar.isTranslucent = false
            $0.tabBar.backgroundColor = .white
        }
    }
}

extension TabBarController{
    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        guard let viewControllers = viewControllers,
              viewControllers.count >= selectedIndex,
              let deselectedViewController = viewControllers[selectedIndex] as? TabBarDeselectedProtocol
        else { return }

        deselectedViewController.deselectedByUser()
    }
}
