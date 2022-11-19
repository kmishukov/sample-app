//
//  NotificationAppHideServiceTest.swift
//  CoreTests
//
//  Created by Oleg Pustoshkin on 19.11.2022.
//

import Core
import XCTest

class NotificationAppHideServiceTest: XCTestCase {
    func test_doesNothing_afterInit() {
        let notificationAppHideServiceSpy = makeSUT()

        XCTAssertEqual(notificationAppHideServiceSpy.subjectsSendCount, 0)
    }

    func test_checkCount_sendEvent() {
        let notificationAppHideServiceSpy = makeSUT()

        notificationAppHideServiceSpy.sendEvent()

        XCTAssertEqual(notificationAppHideServiceSpy.subjectsSendCount, 1)
    }
    
    func test_check_subscription_sendEvent() {
        let notificationAppHideServiceSpy = makeSUT()
        let expectation = self.expectation(description: "Wait for value recived")

        let subscribeObject = notificationAppHideServiceSpy.subscribe()
        
        var valueReceived = false
        let subscription = subscribeObject.sink { _ in
            valueReceived = true
            expectation.fulfill()
        }

        notificationAppHideServiceSpy.sendEvent()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(notificationAppHideServiceSpy.subjectsSendCount, 1)
        XCTAssertEqual(valueReceived, true)
    }
}

extension NotificationAppHideServiceTest {
    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line
    ) -> NotificationAppHideServiceSpy {
        let notificationAppHideServiceSpy = NotificationAppHideServiceSpy()

        trackForMemoryLeaks(notificationAppHideServiceSpy, file: file, line: line)

        return notificationAppHideServiceSpy
    }
}
