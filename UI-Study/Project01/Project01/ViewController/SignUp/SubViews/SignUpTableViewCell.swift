//
//  SignUpTableViewCell.swift
//  Project01
//
//  Created by JH on 2021/07/14.
//

import UIKit
import SnapKit

protocol SignUpTableViewCellDelegate: AnyObject {
    func textFieldDidChange(_ textField: UITextField)
}

final class SignUpTableViewCell: UITableViewCell {

    weak var cellDelegate: SignUpTableViewCellDelegate?
    
    // MARK: - UI
    
    private let cellView = UIView().then {
        $0.layer.masksToBounds = true
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 18
    }
    
    private let boderView = UIView().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 18
    }
    
    private let inputLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    private let inputTextField = UITextField().then {
        $0.tintColor = .red
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .black
    }

    // MARRK: - Initalize

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(text: String) {
        inputLabel.text = text
        
        boderView.isHidden = false
    }
}

extension SignUpTableViewCell {
    private func setupView() {
        self.backgroundColor = .clear
        contentView.addSubview(cellView)
        
        cellView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
        
        cellView.addSubviews(boderView, inputLabel, inputTextField)
        
        boderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
        
        inputLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(inputLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        inputTextField.becomeFirstResponder()
        inputTextField.delegate = self
    }
}

extension SignUpTableViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        cellDelegate?.textFieldDidChange(textField)
    }
}
