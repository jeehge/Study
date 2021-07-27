//
//  CellIdentifierable.swift
//  Project02
//
//  Created by JH on 2021/07/27.
//

import UIKit

protocol CellIdentifierable { }

extension CellIdentifierable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: CellIdentifierable { }
