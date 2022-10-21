//
//  WeakifyAdapter.swift
//  Sample
//
//  Created by Author on 19.10.22.
//

final class WeakifyAdapter<T: AnyObject> {
    weak var adaptee: T?

    init(adaptee: T? = nil) {
        self.adaptee = adaptee
    }
}
