//
//  UIImage+helpers.swift
//  Interface
//
//  Created by Author on 21.06.2021.
//

import UIKit

extension UIImage {
    static func makeImage(named name: String) -> UIImage {
        UIImage(
            named: name,
            in: .interface,
            with: nil
        )!
    }
}
