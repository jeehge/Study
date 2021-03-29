//
//  ListViewModel.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/04.
//

import RxSwift
import RxCocoa

final class ListViewModel {
	private var list: PublishSubject<[MarketCodeInfo]> = PublishSubject<[MarketCodeInfo]>()
	
	private let service: APIService = APIService()
	private let webSocketService: WebSocketService = WebSocketService.shared
	
	let disposeBag: DisposeBag = DisposeBag()
	
	var listObservable: Observable<[MarketCodeInfo]> {
		return list.asObservable()
	}
	
	init() {
		bind()
	}
	
	deinit {
		print("diinit - ListViewModel")
	}
	
	private func bind() {
		subscribeMarketInfoList()
	}
	
	func subscribeMarketInfoList() {
		service.requestMarketInfoList()
		service.markeList.bind(to: list).disposed(by: disposeBag)
	}
}

