//
//  UIColor+rgb.swift
//  Interface
//
//  Created by Author on 6/15/21.
//

extension UIColor {
    convenience init(rgb: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    convenience init(rgba: UInt) {
        self.init(
            red: CGFloat((rgba & 0xFF000000) >> 24) / 255.0,
            green: CGFloat((rgba & 0x00FF0000) >> 16) / 255.0,
            blue: CGFloat((rgba & 0x0000FF00) >> 8) / 255.0,
            alpha: CGFloat(rgba & 0x000000FF) / 255.0
        )
    }
}
