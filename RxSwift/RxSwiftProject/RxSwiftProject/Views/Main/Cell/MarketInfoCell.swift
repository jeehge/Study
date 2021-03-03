//
//  MarketInfoCell.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/03.
//

import UIKit

final class MarketInfoCell: UITableViewCell {
	@IBOutlet private weak var marketLabel: UILabel!
	@IBOutlet private weak var koreanNameLabel: UILabel!
	@IBOutlet private weak var englishNameLabel: UILabel!
	@IBOutlet private weak var marketWarningLabel: UILabel!
	
	// 재사용될 때 값을 초기화
	override func prepareForReuse() {
		super.prepareForReuse()
		
		marketLabel.text = ""
		koreanNameLabel.text = ""
		englishNameLabel.text = ""
		marketWarningLabel.text = ""
	}
	
	func setMarketInfoCell(info: MarketCodeInfo) {
		marketLabel.text = info.market
		koreanNameLabel.text = info.koreanName
		englishNameLabel.text = info.englishName
		marketWarningLabel.text = info.marketWarning
	}
}
