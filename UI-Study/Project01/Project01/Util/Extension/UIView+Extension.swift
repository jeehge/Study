//
//  UIView+Extension.swift
//  Project01
//
//  Created by JH on 2021/07/10.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
