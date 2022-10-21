//
//  AnyPublisher+Value.swift
//  Core
//
//  Created by Author on 18.10.22.
//

import Combine

extension AnyPublisher where Self.Failure == Never {
    public var value: Output {
        var receivedValue: Output!
        _ = sink {
            receivedValue = $0
        }
        return receivedValue
    }
}
