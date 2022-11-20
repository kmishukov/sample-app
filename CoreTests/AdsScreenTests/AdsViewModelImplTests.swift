//
//  AdsViewModelImplTests.swift
//  CoreTests
//
//  Created by Oleg Pustoshkin on 20.11.2022.
//

import Core
import XCTest

class AdsViewModelImplTests: XCTestCase {
    func test_state_afterInit() {
        let viewModel = makeSUT(rewardCompletion: {}, closeCompletion: {})

        XCTAssertEqual(viewModel.state.value, .initState)
    }

    func test_state_onCloseTapped() {
        let viewModel = makeSUT(
            rewardCompletion: {},
            closeCompletion: {}
        )

        viewModel.onCloseTapped()

        XCTAssertEqual(viewModel.state.value, .initState)
    }

    func test_state_onCloseTapped_completion() {
        let expectation = self.expectation(description: "Close completion")
        let viewModel = makeSUT(
            rewardCompletion: {},
            closeCompletion: {
                expectation.fulfill()
            }
        )

        viewModel.onCloseTapped()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.state.value, .initState)
    }
   
    func test_state_onGetRewardTapped_And_Success() {
        let expectation = self.expectation(description: "Reward activated")
        let viewModel = makeSUT(
            rewardCompletion: {
                expectation.fulfill()
            },
            closeCompletion: {}
        )

        viewModel.onGetRewardTapped()

        wait(for: [expectation], timeout: 10.0)
    }

    func test_state_onModuleActivated() {
        let expectation = self.expectation(description: "Reward activated")
        let viewModel = makeSUT(
            rewardCompletion: {
                expectation.fulfill()
            },
            closeCompletion: {}
        )

        viewModel.onModuleActivated()

        let result = XCTWaiter.wait(for: [expectation], timeout: 10)
        XCTAssertEqual(viewModel.state.value, .showReward)
        XCTAssertNotEqual(result, .completed)
    }
    
    func test_state_onModuleActivated_state_after_and_reward() {
        let expectation = self.expectation(description: "Reward activated")
        let viewModel = makeSUT(
            rewardCompletion: {
            },
            closeCompletion: {}
        )

        viewModel.onModuleActivated()
        XCTAssertEqual(viewModel.state.value, .showAds)

        let subscription = viewModel.state
            .filter { $0 == .showReward }
            .sink { _ in 
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(viewModel.state.value, .showReward)
    }

    func test_state_onGetRewardTapped_And_CloseAfter() {
        let expectation = self.expectation(description: "Reward activated")
        let viewModel = makeSUT(
            rewardCompletion: {
                expectation.fulfill()
            },
            closeCompletion: {}
        )

        viewModel.onModuleActivated()
        viewModel.onCloseTapped()

        let result = XCTWaiter.wait(for: [expectation], timeout: 10)
        XCTAssertEqual(viewModel.state.value, .showAds)
        XCTAssertNotEqual(result, .completed)
    }
}

extension AdsViewModelImplTests {
    private func makeSUT(
        rewardCompletion: @escaping (() -> Void),
        closeCompletion: @escaping (() -> Void),
        file: StaticString = #file,
        line: UInt = #line
    ) -> AdsScreenViewModel {
        
        let viewModel = AdsScreenViewModelImpl(rewardCompletion: rewardCompletion, closeCompletion: closeCompletion)

        trackForMemoryLeaks(viewModel, file: file, line: line)

        return viewModel
    }
}
