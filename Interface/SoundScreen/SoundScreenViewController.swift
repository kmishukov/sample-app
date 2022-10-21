//
//  SoundScreenViewController.swift
//  Interface
//
//  Created by Author on 13.10.2022.
//

import Foundation

public class SoundScreenViewController: UIViewController {
    public required init(mainView: SoundScreenView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let mainView: SoundScreenView
}

extension SoundScreenViewController {
    public override func loadView() {
        view = mainView
    }
}
