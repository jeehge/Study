//
//  CellIdentifierable.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/01.
//

import UIKit

// 해당 프로토콜을 채택한 경우만 아이덴티파이어를 사용할수있도록 했습니다
protocol CellIdentifierable { }

extension CellIdentifierable where Self: UITableViewCell {
	static var identifier: String {
		return String(describing: self)
	}
}

extension UITableViewCell: CellIdentifierable { }
