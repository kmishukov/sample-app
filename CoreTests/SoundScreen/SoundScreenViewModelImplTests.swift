//
//  SoundScreenViewModelImplTests.swift
//  CoreTests
//
//  Created by Author on 13.10.2022.
//

import Core
import XCTest

class SoundScreenViewModelImplTests: XCTestCase {
    func test_playsSound_onPlayTapped() {
        let sut = makeSUT()
        XCTAssertEqual(sut.soundRouterSpy.playSoundCallCount, 0, "precondition")

        sut.viewModel.onPlayTapped()

        XCTAssertEqual(sut.soundRouterSpy.playSoundCallCount, 1)
    }
}

extension SoundScreenViewModelImplTests {
    typealias SUT = (
        viewModel: SoundScreenViewModel,
        soundRouterSpy: SoundRouterSpy
    )

    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line
    ) -> SUT {
        let soundRouterSpy = SoundRouterSpy()
        let viewModel = SoundScreenViewModelImpl(soundRouter: soundRouterSpy)

        trackForMemoryLeaks(viewModel, file: file, line: line)
        trackForMemoryLeaks(soundRouterSpy, file: file, line: line)

        return (viewModel, soundRouterSpy)
    }
}
