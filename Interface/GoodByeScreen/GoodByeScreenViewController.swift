//
//  GoodByeScreenViewController.swift
//  Interface
//
//  Created by Oleg Pustoshkin on 19.11.2022.
//

import Foundation

import Foundation

public class GoodByeScreenViewController: UIViewController {
    public required init(mainView: GoodByeScreenView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let mainView: GoodByeScreenView
}

extension GoodByeScreenViewController {
    public override func loadView() {
        view = mainView
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainView.onModuleDeactivated()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.onModuleActivated()
    }
}

extension GoodByeScreenViewController: TabBarDeselectedProtocol {
    public func deselectedByUser() {
        mainView.onTabChanged()
    }
}
