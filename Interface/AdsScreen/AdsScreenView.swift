//
//  AdsScreenView.swift
//  Interface
//
//  Created by Author on 19.10.22.
//

import Core

public class AdsScreenView: UIView {
    public init(viewModel: AdsScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        assemble()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let viewModel: AdsScreenViewModel
    private let closeButton = UIButton()
    private let getRewardButton = UIButton()
    private let adLabel = UILabel()
}

extension AdsScreenView {
    public override func updateConstraints() {
        defer { super.updateConstraints() }

        closeButton.snp.makeConstraints {
            $0.top.equalTo(self.snp.topMargin).offset(20)
            $0.left.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 50))
        }

        getRewardButton.snp.makeConstraints {
            $0.top.equalTo(self.snp.topMargin).offset(20)
            $0.right.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 50))
        }

        adLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension AdsScreenView {
    private func assemble() {
        with(closeButton) {
            $0.setTitle("Close", for: .normal)
            $0.addTarget(self, action: #selector(onClose), for: .touchUpInside)
        }

        with(getRewardButton) {
            $0.setTitle("Get reward", for: .normal)
            $0.addTarget(self, action: #selector(onGetReward), for: .touchUpInside)
        }

        with(adLabel) {
            $0.text = "The place for your ads!"
            $0.textColor = .white
            $0.textAlignment = .center
        }

        addSubviews(
            adLabel,
            closeButton,
            getRewardButton
        )

        setNeedsUpdateConstraints()
    }

    @objc private func onClose() {
        viewModel.onCloseTapped()
    }

    @objc private func onGetReward() {
        viewModel.onGetRewardTapped()
    }
}
