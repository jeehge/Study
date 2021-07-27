//
//  String+Extension.swift
//  Project02
//
//  Created by JH on 2021/07/27.
//

import UIKit

extension String {
    func placeholder(color: UIColor) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        return NSAttributedString(string: self,
                                  attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                               .foregroundColor: color,
                                               .paragraphStyle: paragraphStyle])
    }
}
