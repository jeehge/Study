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
	private var markeListResponse: PublishSubject<[MarketCodeInfo]> = PublishSubject<[MarketCodeInfo]>()
	private var tickerResponse: PublishSubject<[TickerInfo]> = PublishSubject<[TickerInfo]>()
	private let disposeBag = DisposeBag()
	
	var markeList: Observable<[MarketCodeInfo]> {
		return markeListResponse.asObserver()
	}
	
	var tickerList: Observable<[TickerInfo]> {
		return tickerResponse.asObserver()
	}

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
				self.getTickerInfo()
			case .failure(let error):
				print(error)
			}
		}
	}
	
	func getTickerInfo() {
		let r = markeListResponse.map { list in
			print(list.count)
			list.forEach { info in
				self.requestTickerInfo(markets: info.market)
			}
		}
		
		print(r)
	}
	
	// 시세 Ticker 조회
	func requestTickerInfo(markets: String = "KRW-BTC") {
		let parameters: [String: String] = [
			"markets": markets
		]

		NetworkManager.request(api: .ticker, parameters: parameters) { [weak self] (reuslt: Result<[TickerInfo], Error>) in
			guard let self = self else { return }
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
