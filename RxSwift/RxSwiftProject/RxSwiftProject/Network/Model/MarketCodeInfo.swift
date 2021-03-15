//
//  MarketCodeInfo.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/02.
//

import Foundation

struct MarketCodeInfo: Decodable {
	let market: String 			// 업비트에서 제공중인 시장 정보
	let koreanName: String		// 거래 대상 암호화폐 한글명
	let englishName: String		// 거래 대상 암호화폐 영문명
	let marketWarning: String	// 유의 종목 여부	NONE (해당 사항 없음), CAUTION(투자유의)
	var ticker: TickerInfo? = nil
	
	private enum CodingKeys: String, CodingKey {
		case market
		case koreanName = "korean_name"
		case englishName = "english_name"
		case marketWarning = "market_warning"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		market = try container.decode(String.self, forKey: .market)
		koreanName = try container.decode(String.self, forKey: .koreanName)
		englishName = try container.decode(String.self, forKey: .englishName)
		marketWarning = try container.decode(String.self, forKey: .marketWarning)
	}
}
