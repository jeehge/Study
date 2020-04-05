//
//  MainListViewController.swift
//  StudyProject
//
//  Created by JH on 2020/04/05.
//  Copyright © 2020 JH. All rights reserved.
//

import UIKit

enum ListMenu: CustomStringConvertible {
    case imageFilter
    
    var description: String {
        switch self {
        case .imageFilter:
            return "Image Filter"
        }
    }
}

class MainListViewController: UIViewController, ViewControllerFromStoryBoard {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    private let identifier: String = "MenuCell"
    private let menuArray: [ListMenu] =  [.imageFilter]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    // MARK: - Initialize
    private func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // tableview 동적으로 높이 조절
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 70
    }
    
    // MARK: - IBAction
    @IBAction func actionBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: -
extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = self.menuArray[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch menuArray[indexPath.row] {
        case .imageFilter:
            let imageFilterVC: ImageFilterViewController = ImageFilterViewController.viewController(name: "ImageFilter")
            self.navigationController?.pushViewController(imageFilterVC, animated: true)
        }
    }
}



