//
//  BottomSheetViewController.swift
//  Project01
//
//  Created by JH on 2021/07/18.
//

import UIKit

final class BottomSheetViewController: BaseViewController {
    
    enum BottomSheetType {
        case newsAgency
    }
    
    // MARK: - Proteries
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var topView: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        titleLabel.textColor = .white
        titleLabel.text = "통신사선택"
        closeButton.setTitle("닫기", for: .normal)
        topView.layer.cornerRadius = 16
        tableView.backgroundColor = .black
    }
    
    // MARK: - Internal Methods
    
    // MARK: - IBAction
    @IBAction private func actionClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension BottomSheetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomSheetInfoCell", for: indexPath)
        cell.textLabel?.textColor = .lightGray
        cell.textLabel?.text = "ㅇㅇ"
        return cell
    }
}

/**
 SKT
 KT
 LG U+
 SKT 알뜰폰
 kT 알뜰폰
 LG U+ 알뜰폰
 */
