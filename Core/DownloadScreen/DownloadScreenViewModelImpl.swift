//
//  DownloadScreenViewModelImpl.swift
//  Core
//
//  Created by Author on 18.10.22.
//

public class DownloadScreenViewModelImpl {
    public init(downloader: Downloading, appCoordinator: AppCoordination) {
        self.downloader = downloader
        self.appCoordinator = appCoordinator
    }

    private let downloader: Downloading
    private let appCoordinator: AppCoordination
    private let stateSubject = ValueSubject<DownloadScreenState>(.downloadAndOpen)
}

extension DownloadScreenViewModelImpl: DownloadScreenViewModel {
    public var state: ValuePublisher<DownloadScreenState> {
        stateSubject.eraseToAnyPublisher()
    }

    public func onDownloadAndOpenTapped() {
        startDownload()
    }

    public func onRetryTapped() {
        startDownload()
    }

    public func onCancelTapped() {
        downloader.cancel()
    }
}

extension DownloadScreenViewModelImpl {
    private func startDownload() {
        stateSubject.value = .downloading
        downloader.download { [weak self] result in
            guard let self = self else { return }

            self.updateState(for: result)
            if case .success = result {
                self.appCoordinator.switchToMagicColorsScreen()
            }
        }
    }

    private func updateState(for result: Result<DownloadingResult, DownloadingError>) {
        let newState: DownloadScreenState = {
            switch result {
            case .success:
                return .downloadAndOpen
            case .failure(let error):
                switch error {
                case .cancelled:
                    return .downloadAndOpen
                case .failed:
                    return .retry
                }
            }
        }()
        stateSubject.value = newState
    }
}
