//
//  NotificationAppHideServiceImp.swift
//  Core
//
//  Created by Oleg Pustoshkin on 19.11.2022.
//

import Foundation
import Combine
import UIKit

public class NotificationAppHideServiceImp: NotificationAppHideServiceProtocol {
    public init() {}

    public func subscribe() -> AnyPublisher<Void, Never> {
        return  NotificationCenter.default
                    .publisher(for: UIApplication.willResignActiveNotification)
                    .map { _ in Void() }
                    .eraseToAnyPublisher()
    }
}
