//
//  DownloadScreenViewModelImplTests.swift
//  CoreTests
//
//  Created by Author on 18.10.22.
//

import Core
import XCTest

class DownloadScreenViewModelImplTests: XCTestCase {
    func test_state_afterInit() {
        let sut = makeSUT()

        XCTAssertEqual(sut.viewModel.state.value, .lockScreen)
    }

    func test_onUnlockForReward() {
        let sut = makeSUT()

        sut.viewModel.onUnlockForReward()

        XCTAssertEqual(sut.viewModel.state.value, .downloadAndOpen)
    }
    
    func test_state_onDownloadAndOpenTapped() {
        let sut = makeSUT()

        sut.viewModel.onDownloadAndOpenTapped()

        XCTAssertEqual(sut.viewModel.state.value, .downloading)
    }
    
    func test_state_onTryForReward() {
        let sut = makeSUT()

        sut.viewModel.onTryForReward()

        XCTAssertEqual(sut.appCoordinationSpy.actions, [.presentAdShowScreen])
    }

    func test_startsDownload_onDownloadAndOpenTapped() {
        let sut = makeSUT()

        sut.viewModel.onDownloadAndOpenTapped()

        XCTAssertEqual(sut.downloadingSpy.actions, [.download])
    }

    func test_cancelDownload_onCancelTapped() {
        let sut = makeSUT()

        sut.viewModel.onCancelTapped()

        XCTAssertEqual(sut.downloadingSpy.actions, [.cancel])
    }

    func test_state_afterGetSuccessDownloadingResult_onDownloadAndOpenTapped() {
        let sut = makeSUT()

        sut.viewModel.onDownloadAndOpenTapped()
        sut.downloadingSpy.completeDownloading(with: .success(.someResult))

        XCTAssertEqual(sut.viewModel.state.value, .downloadAndOpen)
    }

    func test_state_afterGetFailedDownloadingResult_onDownloadAndOpenTapped() {
        let sut = makeSUT()

        sut.viewModel.onDownloadAndOpenTapped()
        sut.downloadingSpy.completeDownloading(with: .failure(.failed))

        XCTAssertEqual(sut.viewModel.state.value, .retry)
    }

    func test_state_afterGetCancelledDownloadingResult_onDownloadAndOpenTapped() {
        let sut = makeSUT()

        sut.viewModel.onDownloadAndOpenTapped()
        sut.downloadingSpy.completeDownloading(with: .failure(.cancelled))

        XCTAssertEqual(sut.viewModel.state.value, .downloadAndOpen)
    }

    func test_startsDownload_onRetryTapped() {
        let sut = makeSUT()

        sut.viewModel.onRetryTapped()

        XCTAssertEqual(sut.downloadingSpy.actions, [.download])
    }

    func test_state_afterGetSuccessDownloadingResult_onRetryTapped() {
        let sut = makeSUT()

        sut.viewModel.onRetryTapped()
        XCTAssertEqual(sut.viewModel.state.value, .downloading, "precondition")

        sut.downloadingSpy.completeDownloading(with: .success(.someResult))

        XCTAssertEqual(sut.viewModel.state.value, .downloadAndOpen)
    }

    func test_state_afterGetFailedDownloadingResult_onRetryTapped() {
        let sut = makeSUT()

        sut.viewModel.onRetryTapped()
        sut.downloadingSpy.completeDownloading(with: .failure(.failed))

        XCTAssertEqual(sut.viewModel.state.value, .retry)
    }

    func test_state_afterGetCancelledDownloadingResult_onRetryTapped() {
        let sut = makeSUT()

        sut.viewModel.onRetryTapped()
        sut.downloadingSpy.completeDownloading(with: .failure(.cancelled))

        XCTAssertEqual(sut.viewModel.state.value, .downloadAndOpen)
    }

    func test_opensMagicColorsScreen_afterGetSuccessDownloadingResult() {
        let sut = makeSUT()

        sut.viewModel.onDownloadAndOpenTapped()
        sut.downloadingSpy.completeDownloading(with: .success(.someResult))

        XCTAssertEqual(sut.appCoordinationSpy.actions, [.switchToMagicColorsScreen])
    }

    func test_doesNotOpenMagicColorsScreen_afterGetFailureDownloadingResult() {
        DownloadingError.allCases.forEach {
            let sut = makeSUT()

            sut.viewModel.onDownloadAndOpenTapped()
            sut.downloadingSpy.completeDownloading(with: .failure($0))

            XCTAssertEqual(sut.appCoordinationSpy.actions, [], "failed for \($0)")
        }
    }
}

extension DownloadScreenViewModelImplTests {
    private typealias SUT = (
        viewModel: DownloadScreenViewModel,
        downloadingSpy: DownloadingSpy,
        appCoordinationSpy: AppCoordinationSpy
    )

    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line
    ) -> SUT {
        let downloadingSpy = DownloadingSpy()
        let appCoordinationSpy = AppCoordinationSpy()
        let viewModel = DownloadScreenViewModelImpl(
            downloader: downloadingSpy,
            appCoordinator: appCoordinationSpy
        )

        trackForMemoryLeaks(viewModel, file: file, line: line)
        trackForMemoryLeaks(downloadingSpy, file: file, line: line)
        trackForMemoryLeaks(appCoordinationSpy, file: file, line: line)

        return (viewModel, downloadingSpy, appCoordinationSpy)
    }
}
