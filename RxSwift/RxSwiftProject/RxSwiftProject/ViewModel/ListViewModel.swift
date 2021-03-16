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
		service.markeListResponse.bind(to: list).disposed(by: disposeBag)
	}
}

// TODO: -
// 왜 이렇게 했나 ?
//
