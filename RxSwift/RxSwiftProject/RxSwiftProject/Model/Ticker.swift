//
//  Ticker.swift
//  RxSwiftProject
//
//  Created by JH on 2021/02/24.
//

import Foundation
/**
Codable은 Encodable과 Decodable
Encodable -> data를 Encoder에서 변환해주려는 프로토콜로 바꿔주는 것
Decodable -> data를 원하는 모델로 Decode 해주는 것
*/
struct Ticker: Decodable {
	let type: String				// 타입, ticker : 현재가
	let code: String				// 마켓 코드 (ex. KRW-BTC)
	let openingPrice: Double		// 시가
	let highPrice: Double			// 고가
	let lowPrice: Double			// 저가
	let tradePrice: Double			// 현재가
	let prevClosingPrice: Double	// 전일 종가
	/**
	RISE : 상승
	EVEN : 보합
	FALL : 하락
	*/
	let change: String				// 전일 대비
	let changePrice: Double			// 부호 없는 전일 대비 값
	let signedChangePrice: Double	// 전일 대비 값
	let changeRate: Double			// 부호 없는 전일 대비 등락율
	let signedChangeRate: Double	// 전일 대비 등락율
	let tradeVolume: Double			// 가장 최근 거래량
	let accTradeVolume: Double		// 누적 거래량(UTC 0시 기준)
	let accTradeVolume24h: Double	// 24시간 누적 거래량
	let accTradePrice: Double		// 누적 거래대금(UTC 0시 기준)
	let accTradePrice24h: Double	// 24시간 누적 거래 대금
	let tradeDate: String 			// 최근 거래 일자(UTC), yyyyMMdd
	let tradeTime: String			// 최근 거래 시각(UTC), HHmmss
	let tradeTimestamp: Float		// 체결 타임스탬프(milliseconds)
	/**
	ASK : 매도
	BID : 매수
	*/
	let askBid: String				// 매수/매도 구분
	let accAskVolume: Double		// 누적 매도량
	let accBidVolume: Double		// 누적 매수량
	let highest52weekPrice: Double	// 52주 최고가
	let highest52weekDate: String 	// 52주 최고가 달성일, yyyy-MM-dd
	let lowest52weekPrice: Double	// 52주 최저가
	let lowest52weekDate: String	// 52주 최저가 달성일, yyyy-MM-dd
	let tradeStatus: String?		// 거래상태
	/**
	PREVIEW : 입금지원
	ACTIVE : 거래지원가능
	DELISTED : 거래지원종료
	*/
	let marketState: String			// 거래상태
	let marketStateForios: String?	// 거래상태
	let isTradingSuspended: Bool	// 거래 정지 여부
	let delistingDate: Date			// 상장폐지일
	/**
	NONE : 해당없음
	CAUTION : 투자유의
	*/
	let marketWarning: String		// 유의 종목 여부
	let timestamp: Float			// 타임스탬프 (milliseconds)
	/**
	SNAPSHOT : 스냅샷
	REALTIME : 실시간
	*/
	let streamType: String			// 스트림 타입
	
	private enum CodingKeys: String, CodingKey {
		case type
		case code
		case openingPrice = "opening_price"
		case highPrice = "high_price"
		case lowPrice = "low_price"
		case tradePrice = "trade_price"
		case prevClosingPrice = "prev_closing_price"
		case change
		case changePrice = "change_price"
		case signedChangePrice = "signed_change_price"
		case changeRate = "change_rate"
		case signedChangeRate = "signed_change_rate"
		case tradeVolume = "trade_volume"
		case accTradeVolume = "acc_trade_volume"
		case accTradeVolume24h = "acc_trade_volume_24h"
		case accTradePrice = "acc_trade_price"
		case accTradePrice24h = "acc_trade_price_24h"
		case tradeDate = "trade_date"
		case tradeTime = "trade_time"
		case tradeTimestamp = "trade_timestamp"
		case askBid = "ask_bid"
		case accAskVolume = "acc_ask_volume"
		case accBidVolume = "acc_bid_volume"
		case highest52weekPrice = "highest_52_week_price"
		case highest52weekDate = "highest_52_week_date"
		case lowest52weekPrice = "lowest_52_week_price"
		case lowest52weekDate = "lowest_52_week_date"
		case tradeStatus = "trade_status"
		
		case marketState = "market_state"
		case marketStateForios = "market_state_for_ios"
		case isTradingSuspended = "is_trading_suspended"
		case delistingDate = "delisting_date"
		case marketWarning = "market_warning"
		case timestamp = "timestamp"
		case streamType = "stream_type"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		type = try container.decode(String.self, forKey: .type)
		code = try container.decode(String.self, forKey: .code)
		openingPrice = try container.decode(Double.self, forKey: .openingPrice)
		highPrice = try container.decode(Double.self, forKey: .highPrice)
		lowPrice = try container.decode(Double.self, forKey: .lowPrice)
		tradePrice = try container.decode(Double.self, forKey: .tradePrice)
		prevClosingPrice = try container.decode(Double.self, forKey: .prevClosingPrice)
		change = try container.decode(String.self, forKey: .change)
		changePrice = try container.decode(Double.self, forKey: .changePrice)
		signedChangePrice = try container.decode(Double.self, forKey: .signedChangePrice)
		changeRate = try container.decode(Double.self, forKey: .changeRate)
		signedChangeRate = try container.decode(Double.self, forKey: .signedChangeRate)
		tradeVolume = try container.decode(Double.self, forKey: .tradeVolume)
		accTradeVolume = try container.decode(Double.self, forKey: .accTradeVolume)
		accTradeVolume24h = try container.decode(Double.self, forKey: .accTradeVolume24h)
		accTradePrice = try container.decode(Double.self, forKey: .accTradePrice)
		accTradePrice24h = try container.decode(Double.self, forKey: .accTradePrice24h)
		tradeDate = try container.decode(String.self, forKey: .tradeDate)
		tradeTime = try container.decode(String.self, forKey: .tradeTime)
		tradeTimestamp = try container.decode(Float.self, forKey: .tradeTimestamp)
		askBid = try container.decode(String.self, forKey: .askBid)
		accAskVolume = try container.decode(Double.self, forKey: .accAskVolume)
		accBidVolume = try container.decode(Double.self, forKey: .accBidVolume)
		highest52weekPrice = try container.decode(Double.self, forKey: .highest52weekPrice)
		highest52weekDate = try container.decode(String.self, forKey: .highest52weekDate)
		lowest52weekPrice = try container.decode(Double.self, forKey: .lowest52weekPrice)
		lowest52weekDate = try container.decode(String.self, forKey: .lowest52weekDate)
		tradeStatus = try? container.decodeIfPresent(String.self, forKey: .tradeStatus)
		marketState = try container.decode(String.self, forKey: .marketState)
		marketStateForios  = try? container.decodeIfPresent(String.self, forKey: .marketStateForios)
		isTradingSuspended = try container.decode(Bool.self, forKey: .isTradingSuspended)
		delistingDate = try container.decode(Date.self, forKey: .delistingDate)
		marketWarning = try container.decode(String.self, forKey: .marketWarning)
		timestamp = try container.decode(Float.self, forKey: .timestamp)
		streamType = try container.decode(String.self, forKey: .streamType)
	}
}
