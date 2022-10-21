//
//  DownloadScreenViewModel.swift
//  Core
//
//  Created by Author on 18.10.22.
//

public enum DownloadScreenState {
    case downloadAndOpen
    case downloading
    case retry
}

public protocol DownloadScreenViewModel {
    var state: ValuePublisher<DownloadScreenState> { get }

    func onDownloadAndOpenTapped()
    func onRetryTapped()
    func onCancelTapped()
}
