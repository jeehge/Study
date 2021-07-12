//
//  SignUpTextField.swift
//  Project01
//
//  Created by JH on 2021/07/10.
//

import UIKit

@IBDesignable
final class SignUpInputView: UIView {
    
    // MARK: - UI
    
    private let boderView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 18
    }
    
    private let inputLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.text = "휴대폰번호"
    }
    
    private let inputTextField = UITextField().then {
        $0.tintColor = .red
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .black
    }
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
}

extension SignUpInputView {
    private func setup() {
        self.addSubviews(boderView, inputLabel, inputTextField)
        
        boderView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        inputLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(inputLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
