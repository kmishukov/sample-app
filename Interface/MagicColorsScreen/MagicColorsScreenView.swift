//
//  MagicColorsScreenView.swift
//  Interface
//
//  Created by Author on 19.10.22.
//

import Core
import Combine

public class MagicColorsScreenView: UIView {
    public init(viewModel: MagicColorsScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        assemble()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let viewModel: MagicColorsScreenViewModel
    private let hiddenLabel = UILabel()
    private let willHideLabel = UILabel()
    private let changeBGColorButton = UIButton()
    private let resetBGColorButton = UIButton()
    private let tutorialButton = UIButton()
    private let tutorialLabel = UILabel()
    private let challengeButton = UIButton()
    private let challengeLabel = UILabel()
    private var subscription: Cancellable?
}

extension MagicColorsScreenView {
    public override func updateConstraints() {
        defer { super.updateConstraints() }

        tutorialButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 200, height: 50))
            $0.top.equalTo(self.snp.topMargin)
            $0.right.equalToSuperview()
        }

        challengeButton.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 200, height: 50))
            $0.top.equalTo(self.snp.topMargin)
            $0.left.equalToSuperview()
        }

        tutorialLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 300, height: 100))
        }

        hiddenLabel.snp.makeConstraints {
            $0.bottom.equalTo(changeBGColorButton.snp.top).offset(0)
            $0.size.equalTo(changeBGColorButton)
            $0.centerX.equalTo(changeBGColorButton)
        }

        willHideLabel.snp.makeConstraints {
            $0.top.equalTo(changeBGColorButton.snp.bottom).offset(0)
            $0.size.equalTo(changeBGColorButton)
            $0.centerX.equalTo(changeBGColorButton)
        }

        changeBGColorButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize.init(width: 200, height: 50))
        }

        resetBGColorButton.snp.makeConstraints {
            $0.edges.equalTo(changeBGColorButton)
        }
    }
}

extension MagicColorsScreenView {
    private func assemble() {
        with(hiddenLabel) {
            $0.text = "Hidden white text"
            $0.textColor = .white
        }
        
        with(willHideLabel) {
            $0.text = "Will hide"
            $0.textColor = .red
        }
        
        with(tutorialButton) {
            $0.setTitle("TUTORIAL", for: .normal)
            $0.backgroundColor = .orange
            $0.addTarget(self, action: #selector(onTutorial), for: .touchUpInside)
        }
        
        with(challengeButton) {
            $0.setTitle("Challange", for: .normal)
            $0.backgroundColor = .green
            $0.addTarget(self, action: #selector(onChallengeTapped), for: .touchUpInside)
        }
        
        with(challengeLabel) {
            $0.text = "This is challenge text"
            $0.textColor = .white
        }

        with(tutorialLabel) {
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        
        with(changeBGColorButton) {
            $0.backgroundColor = .red
            $0.addTarget(self, action: #selector(onChangeBGColor), for: .touchUpInside)
        }
        
        with(resetBGColorButton) {
            $0.backgroundColor = .white
            $0.addTarget(self, action: #selector(onResetBGColor), for: .touchUpInside)
        }

        addSubviews(
            hiddenLabel,
            willHideLabel,
            changeBGColorButton,
            resetBGColorButton,
            tutorialButton,
            tutorialLabel,
            challengeButton,
            challengeLabel
        )

        subscribe()

        setNeedsUpdateConstraints()
    }

    private func subscribe() {
        subscription = viewModel.mode
            .sink { [weak self] in
                self?.renderMode($0)
            }
    }

    private func renderMode(_ mode: MagicColorsMode) {
        switch mode {
        case .base:
            backgroundColor = .white
            tutorialLabel.text = nil
            changeBGColorButton.isHidden = false
            resetBGColorButton.isHidden = true
            tutorialButton.isHidden = false
            challengeButton.isHidden = false
            hiddenLabel.isHidden = false
        case .color:
            backgroundColor = changeBGColorButton.backgroundColor
            changeBGColorButton.isHidden = true
            resetBGColorButton.isHidden = false
            tutorialLabel.text = nil
            hiddenLabel.isHidden = false
        case .tutorial(let message):
            tutorialLabel.text = message
            hiddenLabel.isHidden = false
        case .challenge:
            backgroundColor = changeBGColorButton.backgroundColor
            changeBGColorButton.isHidden = true
            resetBGColorButton.isHidden = true
            tutorialButton.isHidden = true
            challengeButton.isHidden = true
            tutorialLabel.text = nil
            hiddenLabel.isHidden = true
            randPositionChallengeText()
        }
    }

    @objc private func onTutorial() {
        viewModel.onTutorialTapped()
    }
    
    @objc private func onChallengeTapped() {
        viewModel.onChallengeTapped()
    }

    @objc private func onResetBGColor() {
        viewModel.onResetBGColorTapped()
    }

    @objc private func onChangeBGColor() {
        viewModel.onChangeBGColorTapped()
    }
}

extension MagicColorsScreenView {
    private func randPositionChallengeText() {
        let randomXPosition: CGFloat
        let randomYPosition: CGFloat

        if Int.random(in: 0..<100) > 50 {
            randomXPosition = CGFloat.random(in: 0..<self.frame.width - challengeLabel.frame.width)
            randomYPosition = CGFloat.random(in: challengeButton.frame.maxY..<hiddenLabel.frame.minY - challengeLabel.frame.height)
        } else {
            randomXPosition = CGFloat.random(in: 0..<self.frame.width - challengeLabel.frame.width)
            randomYPosition = CGFloat.random(in: willHideLabel.frame.maxY..<self.frame.height - challengeLabel.frame.height)
        }
        challengeLabel.frame = CGRect(
            x: randomXPosition,
            y: randomYPosition,
            width: challengeLabel.frame.width,
            height: challengeLabel.frame.height
        )
    }
}
