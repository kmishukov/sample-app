//
//  GoodByeViewModelImplTests.swift
//  CoreTests
//
//  Created by Oleg Pustoshkin on 19.11.2022.
//

import Core
import XCTest

class GoodByeViewModelImplTests: XCTestCase {
    func test_state_afterInit() {
        let sut = makeSUT()

        XCTAssertEqual(sut.viewModel.state.value, .initial)
    }

    func test_onGoodByeTapped() {
        let sut = makeSUT()

        sut.viewModel.onGoodByeTapped()
        
        XCTAssertEqual(sut.viewModel.state.value, .goodBye)
    }

    func test_onSeeYouTapped() {
        let sut = makeSUT()

        sut.viewModel.onSeeYouTapped()
        
        XCTAssertEqual(sut.viewModel.state.value, .seeYou)
    }
    
    func test_onHideApp() {
        let sut = makeSUT()

        sut.viewModel.onHideApp()
        
        XCTAssertEqual(sut.viewModel.state.value, .somewhereHere)
    }
    
    func test_onTabChanged() {
        let sut = makeSUT()

        sut.viewModel.onTabChanged()
        
        XCTAssertEqual(sut.viewModel.state.value, .leaveInEnglish)
    }

    func test_opensSoundScreen_afterOnGoodByeTapped() {
        let sut = makeSUT()

        sut.viewModel.onGoodByeTapped()

        XCTAssertEqual(sut.appCoordinationSpy.actions, [.switchToSoundScreen])
    }
    
    func test_opensSoundScreen_afterOnSeeYouTapped() {
        let sut = makeSUT()

        sut.viewModel.onSeeYouTapped()

        XCTAssertEqual(sut.appCoordinationSpy.actions, [.switchToSoundScreen])
    }

    func test_notificationAppHideServiceSpy_messageSend_module_not_activated() {
        let sut = makeSUT()
        
        var sinkState: GoodByeViewScreenState = .initial
        let subscription = sut.viewModel.state.sink {
            sinkState = $0
        }

        sut.notificationAppHideServiceSpy.sendEvent()

        XCTAssertNotEqual(sinkState, .somewhereHere)
    }
    
    func test_notificationAppHideServiceSpy_messageSend_module_activated() {
        let sut = makeSUT()
        
        var sinkState: GoodByeViewScreenState = .initial
        sut.viewModel.onModuleActivated()
        let subscription = sut.viewModel.state.sink {
            sinkState = $0
        }

        sut.notificationAppHideServiceSpy.sendEvent()

        XCTAssertEqual(sinkState, .somewhereHere)
    }
    
    func test_notificationAppHideServiceSpy_messageSend_module_activated_and_deactivate() {
        let sut = makeSUT()
        
        var sinkState: GoodByeViewScreenState = .initial
        sut.viewModel.onModuleActivated()
        let subscription = sut.viewModel.state.sink {
            sinkState = $0
        }

        sut.notificationAppHideServiceSpy.sendEvent()

        XCTAssertEqual(sinkState, .somewhereHere)
        
        
        sinkState = .initial
        sut.viewModel.onModuleDeactivated()
        sut.notificationAppHideServiceSpy.sendEvent()

        XCTAssertNotEqual(sinkState, .somewhereHere)
    }
}

extension GoodByeViewModelImplTests {
    private typealias SUT = (
        viewModel: GoodByeScreenViewModel,
        appCoordinationSpy: AppCoordinationSpy,
        notificationAppHideServiceSpy: NotificationAppHideServiceSpy
    )

    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line
    ) -> SUT {
        let appCoordinationSpy = AppCoordinationSpy()
        let notificationAppHideServiceSpy = NotificationAppHideServiceSpy()
        let viewModel = GoodByeViewModelImpl(
            appCoordinator: appCoordinationSpy,
            notificationAppHideService: notificationAppHideServiceSpy
        )

        trackForMemoryLeaks(viewModel, file: file, line: line)
        trackForMemoryLeaks(appCoordinationSpy, file: file, line: line)
        trackForMemoryLeaks(notificationAppHideServiceSpy, file: file, line: line)

        return (viewModel, appCoordinationSpy, notificationAppHideServiceSpy)
    }
}
