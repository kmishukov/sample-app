//
//  DownloadScreenView.swift
//  Interface
//
//  Created by Author on 18.10.22.
//

import Core
import Combine

public class DownloadScreenView: UIView {
    public init(viewModel: DownloadScreenViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        assemble()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let viewModel: DownloadScreenViewModel
    private let downloadAndOpenButton = UIButton()
    private let cancelWaitingButton = UIButton()
    private let retryButton = UIButton()
    private let waitingOverlayView = UIView()
    private var subscription: Cancellable?
}

extension DownloadScreenView {
    public override func updateConstraints() {
        defer { super.updateConstraints() }

        downloadAndOpenButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize.init(width: 200, height: 50))
        }

        waitingOverlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        cancelWaitingButton.snp.makeConstraints {
            $0.edges.equalTo(downloadAndOpenButton)
        }

        retryButton.snp.makeConstraints {
            $0.edges.equalTo(downloadAndOpenButton)
        }
    }
}

extension DownloadScreenView {
    private func assemble() {
        with(self) {
            $0.backgroundColor = .orange
        }

        with(downloadAndOpenButton) {
            $0.backgroundColor = .black
            $0.setTitle("Download & Open", for: .normal)
            $0.addTarget(self, action: #selector(onDownloadAndOpen), for: .touchUpInside)
        }

        with(waitingOverlayView) {
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        }

        with(cancelWaitingButton) {
            $0.backgroundColor = .brown
            $0.setTitle("Cancel", for: .normal)
            $0.addTarget(self, action: #selector(onCancel), for: .touchUpInside)
        }

        with(retryButton) {
            $0.backgroundColor = .green
            $0.setTitle("Retry", for: .normal)
            $0.addTarget(self, action: #selector(onRetry), for: .touchUpInside)
        }

        waitingOverlayView.addSubviews(
            cancelWaitingButton,
            retryButton
        )

        addSubviews(
            downloadAndOpenButton,
            waitingOverlayView
        )

        subscribe()

        setNeedsUpdateConstraints()
    }

    private func subscribe() {
        subscription = viewModel.state
            .sink { [weak self] in
                self?.renderState($0)
            }
    }

    private func renderState(_ state: DownloadScreenState) {
        downloadAndOpenButton.isHidden = state != .downloadAndOpen
        retryButton.isHidden = state != .retry
        cancelWaitingButton.isHidden = state != .downloading
        waitingOverlayView.isHidden = state == .downloadAndOpen
    }

    @objc private func onDownloadAndOpen() {
        viewModel.onDownloadAndOpenTapped()
    }

    @objc private func onRetry() {
        viewModel.onRetryTapped()
    }

    @objc private func onCancel() {
        viewModel.onCancelTapped()
    }
}
