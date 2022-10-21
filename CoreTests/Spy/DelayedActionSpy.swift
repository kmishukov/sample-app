//
//  DelayedActionSpy.swift
//  CoreTests
//
//  Created by Author on 18.10.22.
//

import Core
import Combine

final class DelayedActionSpy: DelayedAction, Cancellable {
    private(set) var delayAction: TimeInterval?
    private(set) var cancelAction = false

    func perform(afterDelay delay: TimeInterval, action: @escaping () -> Void) -> Cancellable {
        delayAction = delay
        delayedAction = action
        return self
    }

    func cancel() {
        cancelAction = true
    }

    func simulateDelayedAction() {
        delayedAction?()
        delayedAction = nil
    }

    private var delayedAction: (() -> Void)?
}
