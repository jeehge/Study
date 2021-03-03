//
//  MainViewController.swift
//  RxSwiftProject
//
//  Created by JH on 2021/02/22.
//

import UIKit

final class MainViewController: BaseViewController {
	// MARK: - Properties
	@IBOutlet private weak var tableView: UITableView!
	
	private var resultList: [MarketCodeInfo] = []
	private var list: [MarketCodeInfo] = [] {
		didSet {
			tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initTableView()
		requestMarketInfoList()
	}
	
	// MARK: - Initialize
	private func initTableView() {
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	// MARK: - IBAction
	@IBAction private func actionGetKRW(_ sender: UIButton) {
		list = resultList.filter { $0.market.contains("KRW") }
	}
	
	@IBAction private func actionGetBTC(_ sender: UIButton) {
		list = resultList.filter { $0.market.contains("BTC") }
	}
	
	@IBAction private func actionGetUSDT(_ sender: UIButton) {
		list = resultList.filter { $0.market.contains("USDT") }
	}
	
	@IBAction private func actionGetInterest(_ sender: UIButton) {
		
	}
	
	// MARK: - Request
	// 시세 종목 조회 - 마켓 코드 조회
	private func requestMarketInfoList() {
		let parameters: [String: String] = [
			"isDetails": "true"
		]

		NetworkManager.request(api: .market, parameters: parameters) { [weak self] (reuslt: Result<[MarketCodeInfo], Error>) in
			guard let self = self else { return }
			switch reuslt {
			case .success(let result):
				self.resultList = result
				self.list = self.resultList.filter { $0.market.contains("KRW") }
			case .failure(let error):
				print(error)
			}
		}
	}
	
	// 시세 Ticker 조회 - 현재가 정보
	
	// MARK: - Test code
	func getTestData() {
		let defaultSession = URLSession(configuration: .default)
		var dataTask: URLSessionDataTask?
		
		if var urlComponents = URLComponents(string: "https://api.upbit.com/v1/market/all") {
			urlComponents.query = "isDetails=true"
			guard let url = urlComponents.url else { return }
			
			dataTask = defaultSession.dataTask(with: url) { data, response, error in
				if let data = data,
				   let response = response as? HTTPURLResponse,
				   response.statusCode == 200 {
					do {
						let response = try JSONSerialization.jsonObject(with: data, options: [])
						print(response)
					} catch {
						print("Error")
					}
				}
			}
			dataTask?.resume()
		}
	}
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return list.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MarketInfoCell.identifier, for: indexPath) as! MarketInfoCell
		cell.setMarketInfoCell(info: list[indexPath.row])
		return cell
	}
}
