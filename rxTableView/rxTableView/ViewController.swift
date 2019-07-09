//
//  ViewController.swift
//  rxTableView
//
//  Created by JH on 05/07/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let indetifier: String = "TextCell"
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTableView()
        
    }
    
    // https://github.com/RxSwiftCommunity/RxDataSources
    private func bindTableView() {
        let textArray = ["1","2","3","4","5","6","7","8","9","10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
        let abservable: Observable<[String]> = Observable.of(textArray)
        
        // 1. tableView.rx.items(cellIdentifier:String) 사용하기
//        abservable.bind(to: tableView.rx.items(cellIdentifier: indetifier)) { (index: Int, element: String, cell: UITableViewCell) in
//            cell.textLabel?.text = element
//        }.disposed(by: disposeBag)
        
        // 2. tableView.rx.items(cellIdentifier: String, cellType: Cell.Type) 사용하기 -> cell class 가 있는 경우 사용
        abservable.bind(to: tableView.rx.items(cellIdentifier: indetifier, cellType: TextCell.self)) { (index: Int, element: String, cell: TextCell) in
            cell.textLabel?.text = element
        }.disposed(by: disposeBag)
        
        
        // 3. tableView.rx.items(dataSource:protocol<RxTableViewDataSourceType, UITableViewDataSource>) 사용하기 -> RxDataSources
    }

}

// 2 사용 체크하기 위해 만듬
// storyboard 에서 class 지정해줘야 함
class TextCell: UITableViewCell {
    
}
