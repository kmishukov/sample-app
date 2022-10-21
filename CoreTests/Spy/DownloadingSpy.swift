//
//  DownloadingSpy.swift
//  CoreTests
//
//  Created by Author on 18.10.22.
//

import Core

final class DownloadingSpy: Downloading {
    enum Action: Equatable {
        case download
        case cancel
    }

    private(set) var actions = [Action]()

    func download(completion: @escaping (Result<DownloadingResult, DownloadingError>) -> Void) {
        actions.append(.download)
        completions.append(completion)
    }

    func cancel() {
        actions.append(.cancel)
    }

    func completeDownloading(with result: Result<DownloadingResult, DownloadingError>) {
        let completion = completions.first
        completion?(result)
        completions.removeFirst()
    }

    private var completions = [((Result<DownloadingResult, DownloadingError>) -> Void)]()
}
