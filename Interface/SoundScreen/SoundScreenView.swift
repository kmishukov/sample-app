//
//  SoundScreenView.swift
//  Interface
//
//  Created by Author on 13.10.2022.
//

import UIKit
import SnapKit
import Core

public class SoundScreenView: UIView {
    public init(viewModel: SoundScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        assemble()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let viewModel: SoundScreenViewModel
    private let playButton = UIButton()
}

extension SoundScreenView {
    public override func updateConstraints() {
        defer { super.updateConstraints() }

        playButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension SoundScreenView {
    private func assemble() {
        with(self) {
            $0.backgroundColor = .yellow
        }

        with(playButton) {
            $0.setTitle("PLAY", for: .normal)
            $0.backgroundColor = .black
            $0.addTarget(self, action: #selector(onPlayTapped), for: .touchDown)
        }

        addSubviews(playButton)

        setNeedsUpdateConstraints()
    }

    @objc private func onPlayTapped() {
        viewModel.onPlayTapped()
    }
}
