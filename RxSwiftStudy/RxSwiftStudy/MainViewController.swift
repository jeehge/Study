//
//  MainViewController.swift
//  RxSwiftStudy
//
//  Created by JH on 19/08/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    let indetifier: String = "MenuCell"
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTableView()
    }
    
    func bindTableView() {
        let menuArray = ["Issues App", "Stopwatch"]
        let abservable: Observable<[String]> = Observable.of(menuArray)
        
        abservable.bind(to: tableView.rx.items(cellIdentifier: indetifier)) { (index: Int, element: String, cell: UITableViewCell) in
            cell.textLabel?.text = element
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let cell: UITableViewCell = self?.tableView.cellForRow(at: indexPath) else { return }
                cell.backgroundColor = .red
            }).disposed(by: disposeBag)
    }

}

