//
//  URLComponents+Extension.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/02.
//

import Foundation

extension URLComponents {
	mutating func setQueryItems(with parameters: [String: String]) {
		self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
	}
}
