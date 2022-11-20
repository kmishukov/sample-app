//
//  MagicColorsScreenViewModelImplTests.swift
//  CoreTests
//
//  Created by Author on 19.10.22.
//

import Core
import XCTest

class MagicColorsScreenViewModelImplTests: XCTestCase {
    func test_mode_afterInit() {
        let sut = makeSUT()

        XCTAssertEqual(sut.mode.value, .base)
    }

    func test_mode_onChangeBGColorTapped() {
        let sut = makeSUT()

        sut.onChangeBGColorTapped()

        XCTAssertEqual(sut.mode.value, .color)
    }

    func test_mode_onResetBGColorTapped_forBaseMode() {
        let sut = makeSUT()

        sut.onChangeBGColorTapped()
        sut.onResetBGColorTapped()

        XCTAssertEqual(sut.mode.value, .base)
    }

    func test_mode_onTutorialTapped() {
        let sut = makeSUT()

        sut.onTutorialTapped()

        XCTAssertEqual(sut.mode.value, .tutorial(message: "Tutorial mode!"))
    }

    func test_mode_onChangeBGColorTapped_forTutorialMode() {
        let sut = makeSUT()

        sut.onTutorialTapped()
        sut.onChangeBGColorTapped()

        XCTAssertEqual(sut.mode.value, .tutorial(message: "Will change background color to self color"))
    }

    func test_mode_onResetBGColorTapped_forTutorialMode() {
        let sut = makeSUT()

        sut.onTutorialTapped()
        sut.onResetBGColorTapped()

        XCTAssertEqual(sut.mode.value, .tutorial(message: "Will change colors back"))
    }

    func test_mode_onTutorialTapped_forTutorialMode_fromPreviousBaseMode() {
        let sut = makeSUT()

        sut.onTutorialTapped()
        sut.onTutorialTapped()

        XCTAssertEqual(sut.mode.value, .base)
    }

    func test_mode_onTutorialTapped_forTutorialMode_fromPreviousColorMode() {
        let sut = makeSUT()

        sut.onChangeBGColorTapped()
        sut.onTutorialTapped()
        sut.onTutorialTapped()

        XCTAssertEqual(sut.mode.value, .color)
    }
    
    func test_mode_onChallengeTapped() {
        let sut = makeSUT()

        sut.onChallengeTapped()

        XCTAssertEqual(sut.mode.value, .challenge)
    }

    func test_mode_onChallengeTapped_after_challenge() {
        let sut = makeSUT()
        let expectation = self.expectation(description: "Challenge end")

        sut.onChallengeTapped()
        XCTAssertEqual(sut.mode.value, .challenge)
        
        let subscription = sut.mode
            .filter { $0 == .base }
            .sink(
                receiveValue: { _ in
                    expectation.fulfill()
                }
            )
    
        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        XCTAssertEqual(sut.mode.value, .base)
        XCTAssertEqual(result, .completed)
    }
}

extension MagicColorsScreenViewModelImplTests {
    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line
    ) -> MagicColorsScreenViewModelImpl {
        let viewModel = MagicColorsScreenViewModelImpl()

        trackForMemoryLeaks(viewModel, file: file, line: line)

        return viewModel
    }
}
