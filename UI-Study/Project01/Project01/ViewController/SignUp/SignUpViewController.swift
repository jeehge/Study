//
//  SignUpViewController.swift
//  Project01
//
//  Created by JH on 2021/07/10.
//

import UIKit
import Then
import SnapKit

final class SignUpViewController: BaseViewController {
    
    // MARK: - UI
    private let infoLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 2
        $0.text = "휴대폰 번호를 입력해주세요"
    }
    
    private let inputTextField: SignUpInputView = SignUpInputView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    private func setupView() {
        view.addSubviews(infoLabel)
        
        infoLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
}
