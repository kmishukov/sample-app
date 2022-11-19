//
//  GoodByeScreenView.swift
//  Interface
//
//  Created by Oleg Pustoshkin on 19.11.2022.
//

import Core
import Combine

public class GoodByeScreenView: UIView {
    public init(viewModel: GoodByeScreenViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        assemble()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let viewModel: GoodByeScreenViewModel
    private let screenStatusLabel = UILabel()
    private let goodByeButton = UIButton()
    private let seeYouButton = UIButton()
    private let cancelWaitingButton = UIButton()
    private let retryButton = UIButton()
    private let waitingOverlayView = UIView()
    private var subscription: Cancellable?
}

extension GoodByeScreenView {
    public override func updateConstraints() {
        defer { super.updateConstraints() }

        screenStatusLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        goodByeButton.snp.makeConstraints {
            $0.centerX.equalTo(screenStatusLabel.snp.centerX)
            $0.top.equalTo(screenStatusLabel.snp.bottom).offset(16)
            $0.size.equalTo(CGSize.init(width: 200, height: 50))
        }

        seeYouButton.snp.makeConstraints {
            $0.edges.equalTo(goodByeButton)
        }
    }

    public func onTabChanged() {
        viewModel.onTabChanged()
    }

    public func onModuleActivated() {
        viewModel.onModuleActivated()
    }

    public func onModuleDeactivated() {
        viewModel.onModuleDeactivated()
    }
}

extension GoodByeScreenView {
    private func assemble() {
        with(self) {
            $0.backgroundColor = .orange
        }

        with(goodByeButton) {
            $0.backgroundColor = .black
            $0.setTitle("прощай", for: .normal)
            $0.addTarget(self, action: #selector(onGoodByeButtonTapped), for: .touchUpInside)
        }

        with(seeYouButton) {
            $0.backgroundColor = .black
            $0.setTitle("до встречи", for: .normal)
            $0.addTarget(self, action: #selector(onSeeYouButtonTapped), for: .touchUpInside)
        }

        addSubviews(
            screenStatusLabel,
            goodByeButton,
            seeYouButton
        )

        subscribe()

        setNeedsUpdateConstraints()
    }

    private func subscribe() {
        subscription = viewModel.state
            .removeDuplicates()
            .sink { [weak self] in
                self?.renderState($0)
            }
    }

    private func renderState(_ state: GoodByeViewScreenState) {
        switch state {
        case .initial:
            screenStatusLabel.text = "первый раз открыт"
            seeYouButton.isHidden = true
            goodByeButton.isHidden = false
        case .goodBye:
            screenStatusLabel.text = "Прощай"
            seeYouButton.isHidden = false
            goodByeButton.isHidden = true
        case .seeYou:
            screenStatusLabel.text = "До встречи"
            seeYouButton.isHidden = true
            goodByeButton.isHidden = true
        case .leaveInEnglish:
            screenStatusLabel.text = "ушёл не прощаясь"
            seeYouButton.isHidden = true
            goodByeButton.isHidden = true
        case .somewhereHere:
            screenStatusLabel.text = "где-то тут"
            seeYouButton.isHidden = true
            goodByeButton.isHidden = true
        }
    }

    @objc private func onGoodByeButtonTapped() {
        viewModel.onGoodByeTapped()
    }

    @objc private func onSeeYouButtonTapped() {
        viewModel.onSeeYouTapped()
    }
}
