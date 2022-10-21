//
//  Downloader.swift
//  Core
//
//  Created by Author on 18.10.22.
//

import Combine

public class Downloader {
    public init(
        delayedAction: DelayedAction,
        isSuccessDownloading: @escaping () -> Bool
    ) {
        self.delayedAction = delayedAction
        self.isSuccessDownloading = isSuccessDownloading
    }

    private let delayedAction: DelayedAction
    private let isSuccessDownloading: () -> Bool
    private let downloadingDuration: TimeInterval = 1.0
    private var cancellableAction: Cancellable?
    private var actionCompletion: ((Result<DownloadingResult, DownloadingError>) -> Void)?
}

extension Downloader: Downloading {
    public func download(completion: @escaping (Result<DownloadingResult, DownloadingError>) -> Void) {
        actionCompletion = completion
        cancellableAction = delayedAction.perform(afterDelay: downloadingDuration) { [weak self] in
            guard let self = self else { return }

            completion(self.isSuccessDownloading() ? .success(.someResult) : .failure(.failed))
        }
    }

    public func cancel() {
        cancellableAction?.cancel()
        actionCompletion?(.failure(.cancelled))
    }
}
