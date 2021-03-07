//
//  MainViewController.swift
//  RxSwiftProject
//
//  Created by JH on 2021/02/22.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
	// MARK: - Properties
	@IBOutlet private weak var tableView: UITableView!
	
	private let viewModel = ListViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initTableView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		viewModel.listObservable.bind(to: tableView.rx.items(cellIdentifier: MarketInfoCell.identifier, cellType: MarketInfoCell.self)) { index, item, cell in
			cell.setMarketInfoCell(info: item)
		}.disposed(by: disposeBag)
	}
	
	// MARK: - Initialize
	private func initTableView() {
		tableView.delegate = self
//		tableView.dataSource = self
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

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return list.count
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cell = tableView.dequeueReusableCell(withIdentifier: MarketInfoCell.identifier, for: indexPath) as! MarketInfoCell
//		cell.setMarketInfoCell(info: list[indexPath.row])
//		return cell
//	}
}
