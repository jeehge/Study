//
//  API.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/02.
//

import Foundation

/** upbit API
	시세 목록 조회 : https://docs.upbit.com/reference#%EC%8B%9C%EC%84%B8-%EC%A2%85%EB%AA%A9-%EC%A1%B0%ED%9A%8C
*/
enum Method: String {
	case GET
	case POST
}

enum API {
	case market		// 업비트에서 거래 가능한 마켓 목록
	case ticker		// 요청 당시 종목의 스냅샷을 반환
}

extension API {
	static let baseURL = "https://api.upbit.com/v1"
	
	var path: String {
		switch self {
		case .market:
			return API.baseURL + "/market/all"
		case .ticker:
			return API.baseURL + "/ticker"
		}
	}
	
	var method: Method {
		switch self {
		case .market:
			return .GET
		case .ticker:
			return .GET
		}
	}
}
