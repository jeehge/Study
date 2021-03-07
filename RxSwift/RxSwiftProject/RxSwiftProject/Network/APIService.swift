//
//  APIService.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/04.
//

import RxSwift
import RxCocoa

final class APIService {
	// MARK: - Properties
	var listResponse: BehaviorSubject<[MarketCodeInfo]> = BehaviorSubject(value: [])
	let d: BehaviorRelay<[MarketCodeInfo]>  =  BehaviorRelay(value: [])
	
	// MARK: - Request
	// 시세 종목 조회 - 마켓 코드 조회
	func requestMarketInfoList() {
		let parameters: [String: String] = [
			"isDetails": "true"
		]

		NetworkManager.request(api: .market, parameters: parameters) { [weak self] (reuslt: Result<[MarketCodeInfo], Error>) in
			guard let self = self else { return }
			switch reuslt {
			case .success(let result):
				self.listResponse.onNext(result)
				self.listResponse.onCompleted()
			case .failure(let error):
				print(error)
			}
		}
	}

}
