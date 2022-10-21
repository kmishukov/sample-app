//
//  DispatchQueue+DelayedAction.swift
//  Sample
//
//  Created by Author on 18.10.22.
//

import Core
import Combine

extension DispatchQueue: DelayedAction {
    @discardableResult
    public func perform(afterDelay delay: TimeInterval, action: @escaping () -> Void) -> Cancellable {
        let dispatchWorkItem = DispatchWorkItem(block: action)
        asyncAfter(deadline: .now() + delay, execute: dispatchWorkItem)
        return dispatchWorkItem
    }
}

extension DispatchWorkItem: Cancellable {}
