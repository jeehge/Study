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
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 2
    }
    
    private let inputTextField: SignUpInputView = SignUpInputView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.addSubviews(infoLabel, inputTextField)
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(32)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
        
        infoLabel.text = "휴대폰번호를\n입력해주세요"
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(32)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.height.equalTo(72)
        }
    }
}
