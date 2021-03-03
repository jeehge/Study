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
	
	private var list: [MarketCodeInfo] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		requestMarketInfoList()
		
	}
	
	// MARK: - Request
	private func requestMarketInfoList() {
		let parameters: [String: String] = [
			"isDetails": "true"
		]

		NetworkManager.request(api: .market, parameters: parameters) { [weak self] (reuslt: Result<[MarketCodeInfo], Error>) in
			guard let self = self else { return }
			switch reuslt {
			case .success(let result):
				self.list = result
				self.tableView.reloadData()
			case .failure(let error):
				print(error)
			}
		}
	}
	
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
