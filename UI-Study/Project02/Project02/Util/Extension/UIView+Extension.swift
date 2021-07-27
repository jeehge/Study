//
//  UIView+Extension.swift
//  Project02
//
//  Created by JH on 2021/07/27.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
