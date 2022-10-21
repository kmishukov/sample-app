//
//  UIView+addSubviews.swift
//  Sampler
//
//  Created by Author on 10/26/20.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        disableAutoresizingMasks(views)
        addSubviews(views)
    }

    func addSubviews(_ views: [UIView]) {
        disableAutoresizingMasks(views)
        views.forEach(self.addSubview)
    }

    private func disableAutoresizingMasks(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
