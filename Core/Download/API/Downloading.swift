//
//  Downloading.swift
//  Core
//
//  Created by Author on 18.10.22.
//

public enum DownloadingError: Error, CaseIterable {
    case failed
    case cancelled
}

public enum DownloadingResult {
    case someResult
}

public protocol Downloading {
    func download(completion: @escaping (Result<DownloadingResult, DownloadingError>) -> Void)
    func cancel()
}
