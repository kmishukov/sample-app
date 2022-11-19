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

        XCTAssertEqual(viewModel.state.value, .rewardShowingProposal)
    }

    func test_state_onCloseTapped() {
        let viewModel = makeSUT(
            rewardCompletion: {},
            closeCompletion: {}
        )

        viewModel.onCloseTapped()

        XCTAssertEqual(viewModel.state.value, .rewardShowingProposal)
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
        XCTAssertEqual(viewModel.state.value, .rewardShowingProposal)
    }

    func test_state_onGetRewardTapped() {
        let viewModel = makeSUT(rewardCompletion: {}, closeCompletion: {})

        viewModel.onGetRewardTapped()

        XCTAssertEqual(viewModel.state.value, .showAds)
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
        XCTAssertEqual(viewModel.state.value, .showAds)
    }
    
    func test_state_onGetRewardTapped_And_CloseAfter() {
        let expectation = self.expectation(description: "Reward activated")
        let viewModel = makeSUT(
            rewardCompletion: {
                expectation.fulfill()
            },
            closeCompletion: {}
        )

        viewModel.onGetRewardTapped()
        viewModel.onCloseTapped()

        let result = XCTWaiter.wait(for: [expectation], timeout: 10)
        XCTAssertEqual(viewModel.state.value, .showAds)
        XCTAssertNotEqual(result, .completed)
    }

    func test_state_activateReward() {
        let expectation = self.expectation(description: "Reward activated")
        let viewModel = makeSUT(
            rewardCompletion: {
                expectation.fulfill()
            },
            closeCompletion: {}
        )

        viewModel.activateReward()

        wait(for: [expectation], timeout: 1.0)
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
