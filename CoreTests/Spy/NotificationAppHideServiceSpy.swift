//
//  NotificationAppHideServiceSpy.swift
//  CoreTests
//
//  Created by Oleg Pustoshkin on 19.11.2022.
//

import Foundation
import Core
import Combine

final class NotificationAppHideServiceSpy: NotificationAppHideServiceProtocol {
    private let passthroughSubject = PassthroughSubject<Void, Never>()

    var subjectsSendCount = 0

    func subscribe() -> AnyPublisher<Void, Never> {
        passthroughSubject.eraseToAnyPublisher()
    }

    func sendEvent() {
        subjectsSendCount += 1
        passthroughSubject.send(Void())
    }
}
