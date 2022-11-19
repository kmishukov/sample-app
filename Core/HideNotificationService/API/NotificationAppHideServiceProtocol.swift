//
//  NotificationAppHideServiceProtocol.swift
//  Core
//
//  Created by Oleg Pustoshkin on 19.11.2022.
//

import Foundation
import Combine

public protocol NotificationAppHideServiceProtocol {
    func subscribe() -> AnyPublisher<Void, Never>
}
