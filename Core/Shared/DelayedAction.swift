//
//  DelayedAction.swift
//  Core
//
//  Created by Author on 20.10.22.
//

import Combine

public protocol DelayedAction {
    @discardableResult
    func perform(afterDelay delay: TimeInterval, action: @escaping () -> Void) -> Cancellable
}
