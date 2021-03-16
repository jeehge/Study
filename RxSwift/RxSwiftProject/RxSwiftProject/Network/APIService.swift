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
	var markeListResponse: PublishSubject<[MarketCodeInfo]> = PublishSubject<[MarketCodeInfo]>()
	var tickerResponse: PublishSubject<[TickerInfo]> = PublishSubject<[TickerInfo]>()

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
				self.markeListResponse.onNext(result)
				self.markeListResponse.onCompleted()
			case .failure(let error):
				print(error)
			}
		}
	}
	
	// 시세 Ticker 조회
	private func requestTickerInfo() {
		markeListResponse.concatMap { $0 }.next

		markeListResponse.subscribe(onNext: <#T##(([MarketCodeInfo]) -> Void)?##(([MarketCodeInfo]) -> Void)?##([MarketCodeInfo]) -> Void#>, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>).disposed(by: dis)
		let parameters: [String: String] = [
			"markets": info.market
		]

		return NetworkManager.request(api: .ticker, parameters: parameters) { [weak self] (reuslt: Result<[TickerInfo], Error>) in
			guard let self = self else s{ return }
			switch reuslt {
			case .success(let info):
				self.tickerResponse.onNext(info)
				self.tickerResponse.onCompleted()
			case .failure(let error):
				print(error)
			}
		}
	}
}
