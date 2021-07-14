//
//  CellIdentifierable.swift
//  Project01
//
//  Created by JH on 2021/07/10.
//

import UIKit

protocol CellIdentifierable { }

extension CellIdentifierable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: CellIdentifierable { }
