//
//  DownloaderTests.swift
//  CoreTests
//
//  Created by Author on 18.10.22.
//

import Core
import XCTest

class DownloaderTests: XCTestCase {
    func test_doesNothing_afterInit() {
        let sut = makeSUT()

        XCTAssertNil(sut.delayedActionSpy.delayAction)
    }

    func test_callsDelaeydActionWithDelay_onDownload() {
        let sut = makeSUT()

        sut.downloader.download { _ in }

        XCTAssertEqual(sut.delayedActionSpy.delayAction, 1.0)
    }

    func test_returnsSuccessResult_afterFinishDownloading_withSuccess() {
        let sut = makeSUT()
        let expectation = self.expectation(description: "Wait finish downloading")

        sut.downloader.download { result in
            XCTAssertEqual(result, .success(.someResult))
            expectation.fulfill()
        }

        sut.delayedActionSpy.simulateDelayedAction()

        wait(for: [expectation], timeout: 1.0)
    }

    func test_returnsFailureResult_afterFinishDownloading_withFailedError() {
        let sut = makeSUT(isSuccessDownloading: false)
        let expectation = self.expectation(description: "Wait finish downloading")

        sut.downloader.download { result in
            XCTAssertEqual(result, .failure(.failed))
            expectation.fulfill()
        }

        sut.delayedActionSpy.simulateDelayedAction()

        wait(for: [expectation], timeout: 1.0)
    }

    func test_callsCancelDelayedAction_onCancel() {
        let sut = makeSUT()

        sut.downloader.download { _ in }
        sut.downloader.cancel()

        XCTAssertTrue(sut.delayedActionSpy.cancelAction)
    }

    func test_returnsFailureResult_afterCancelDownloading() {
        let sut = makeSUT()
        let expectation = self.expectation(description: "Wait finish downloading")

        sut.downloader.download { result in
            XCTAssertEqual(result, .failure(.cancelled))
            expectation.fulfill()
        }

        sut.downloader.cancel()

        wait(for: [expectation], timeout: 1.0)
    }
}

extension DownloaderTests {
    private func makeSUT(
        isSuccessDownloading: Bool = true,
        file: StaticString = #file,
        line: UInt = #line
    ) -> (downloader: Downloader, delayedActionSpy: DelayedActionSpy) {
        let spy = DelayedActionSpy()
        let downloader = Downloader(
            delayedAction: spy,
            isSuccessDownloading: { isSuccessDownloading }
        )

        trackForMemoryLeaks(downloader, file: file, line: line)
        trackForMemoryLeaks(spy, file: file, line: line)

        return (downloader, spy)
    }
}
