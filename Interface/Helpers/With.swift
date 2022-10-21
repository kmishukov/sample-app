//
//  With.swift
//  Interface
//
//  Created by Author on 6/15/21.
//

import Foundation

public func with<T>(_ o: T?, doAction: (T) -> Void) {
    if let o = o {
        doAction(o)
    }
}

public func with<T>(_ o: inout T, doAction: (T) -> Void) {
    doAction(o)
}

public func with<T: Sequence>(_ os: T, doAction: (T.Iterator.Element) -> Void) {
    os.forEach(doAction)
}
