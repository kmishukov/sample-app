//
//  DownloadScreenViewController.swift
//  Interface
//
//  Created by Author on 18.10.22.
//

import Foundation

public class DownloadScreenViewController: UIViewController {
    public required init(mainView: DownloadScreenView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let mainView: DownloadScreenView
}

extension DownloadScreenViewController {
    public override func loadView() {
        view = mainView
    }
}
