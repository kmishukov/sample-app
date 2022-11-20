//
//  AdsScreenViewController.swift
//  Interface
//
//  Created by Author on 19.10.22.
//

import Foundation

public class AdsScreenViewController: UIViewController {
    public required init(mainView: AdsScreenView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let mainView: AdsScreenView
}

extension AdsScreenViewController {
    public override func loadView() {
        view = mainView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        mainView.viewDidLoad()
    }
}
