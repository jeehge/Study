//
//  TicketInfo.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/03.
//

import Foundation

struct TicketInfo: Decodable {
	let market: String 				// 종목 구분 코드
	let tradeDate: String			// 최근 거래 일자(UTC)
	let tradeTime: String			// 최근 거래 시각(UTC)
	let tradeDateKst: String		// 최근 거래 일자(KST)
	let tradeTimeKst: String		// 최근 거래 시각(KST)
	let openingPrice: Double		// 시가
	let highPrice: Double			// 고가
	let lowPrice: Double			// 저가
	let tradePrice: Double			// 종가
	let prevClosingPrice: Double	// 전일 종가
	/**
	EVEN : 보합
	RISE : 상승
	FALL : 하락
	*/
	let change: String
	let changePrice: Double			// 변화액의 절대값
	let changeRate: Double			// 변화율의 절대값
	let signedChangePrice: Double	// 부호가 있는 변화액
	let signedChangeRate: Double	// 부호가 있는 변화율
	let tradeVolume: Double			// 가장 최근 거래량
	let accTradePrice: Double		// 누적 거래대금(UTC 0시 기준)
	let accTradePrice24h: Double	// 24시간 누적 거래대금
	let accTradeVolume: Double		// 누적 거래량(UTC 0시 기준)
	let accTradeVolume24h: Double	// 24시간 누적 거래량
	let highest52weekPrice: Double	// 52주 신고가
	let highest52weekDate: String	// 52주 신고가 달성일
	let lowest52weekPrice: Double	// 52주 신저가
	let lowest52weekDate: String	// 52주 신저가 달성일
	let timestamp: Float			// 타임스탬프
	
	private enum CodingKeys: String, CodingKey {
		case market
		case tradeDate = "trade_date"
		case tradeTime = "trade_time"
		case tradeDateKst = "trade_date_kst"
		case tradeTimeKst = "trade_time_kst"
		case openingPrice = "opening_price"
		case highPrice = "high_price"
		case lowPrice = "low_price"
		case tradePrice = "trade_price"
		case prevClosingPrice = "prev_closing_price"
		case change
		case changePrice = "change_price"
		case changeRate = "change_rate"
		case signedChangePrice = "signed_change_price"
		case signedChangeRate = "signed_change_rate"
		case tradeVolume = "trade_volume"
		case accTradePrice = "acc_trade_price"
		case accTradePrice24h = "acc_trade_price_24h"
		case accTradeVolume = "acc_trade_volume"
		case accTradeVolume24h = "acc_trade_volume_24h"
		case highest52weekPrice = "highest_52_week_price"
		case highest52weekDate = "highest_52_week_date"
		case lowest52weekPrice = "lowest_52_week_price"
		case lowest52weekDate = "lowest_52_week_date"
		case timestamp
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		market = try container.decode(String.self, forKey: .market)
		tradeDate = try container.decode(String.self, forKey: .tradeDate)
		tradeTime = try container.decode(String.self, forKey: .tradeTime)
		tradeDateKst = try container.decode(String.self, forKey: .tradeDateKst)
		tradeTimeKst = try container.decode(String.self, forKey: .tradeTimeKst)
		openingPrice = try container.decode(Double.self, forKey: .openingPrice)
		highPrice = try container.decode(Double.self, forKey: .highPrice)
		lowPrice = try container.decode(Double.self, forKey: .lowPrice)
		tradePrice = try container.decode(Double.self, forKey: .tradePrice)
		prevClosingPrice = try container.decode(Double.self, forKey: .prevClosingPrice)
		change  = try container.decode(String.self, forKey: .change)
		changePrice = try container.decode(Double.self, forKey: .changePrice)
		changeRate = try container.decode(Double.self, forKey: .changeRate)
		signedChangePrice = try container.decode(Double.self, forKey: .signedChangePrice)
		signedChangeRate = try container.decode(Double.self, forKey: .signedChangeRate)
		tradeVolume = try container.decode(Double.self, forKey: .tradeVolume)
		accTradePrice = try container.decode(Double.self, forKey: .accTradePrice)
		accTradePrice24h = try container.decode(Double.self, forKey: .accTradePrice24h)
		accTradeVolume = try container.decode(Double.self, forKey: .accTradeVolume)
		accTradeVolume24h = try container.decode(Double.self, forKey: .accTradeVolume24h)
		highest52weekPrice = try container.decode(Double.self, forKey: .highest52weekPrice)
		highest52weekDate  = try container.decode(String.self, forKey: .highest52weekDate)
		lowest52weekPrice = try container.decode(Double.self, forKey: .lowest52weekPrice)
		lowest52weekDate  = try container.decode(String.self, forKey: .lowest52weekDate)
		timestamp  = try container.decode(Float.self, forKey: .timestamp)
	}
}
