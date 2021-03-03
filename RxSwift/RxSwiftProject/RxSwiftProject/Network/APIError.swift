//
//  APIError.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/02.
//

import Foundation

enum APIError {
	case errorCode(Int)
	case noData
	case parseError
}

extension APIError: LocalizedError {
	var errorText: String? {
		switch self {
		case .errorCode(let code):
			return "status code : \(code)"
		case .noData:
			return "데이터가 없습니다"
		case .parseError:
			return "파싱이 잘못되었습니다"
		}
	}
}
