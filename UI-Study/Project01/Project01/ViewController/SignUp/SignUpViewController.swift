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
    
    private var inputTextField: SignUpInputView = SignUpInputView()
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .clear
        $0.register(SignUpTableViewCell.self,
                    forCellReuseIdentifier: SignUpTableViewCell.identifier)
        $0.dataSource = self
//        $0.delegate = self

        $0.separatorStyle = .none
    }
    
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
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(32)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            $0.height.equalTo(72)
        }
        
        signUpStepType(type: .phoneNumber)
    }
    
    private func signUpStepType(type: SignUpStepType) {
        switch type {
        case .phoneNumber:
            inputTextField = SignUpInputView(text: "휴대폰번호")
            infoLabel.text = "휴대폰번호를\n입력해주세요"
        case .residentRegistrationNumber:
            inputTextField = SignUpInputView(text: "주민등록번호")
            infoLabel.text = "주민번호 앞 7자리를\n입력해주세요"
        case .newsAgency:
            inputTextField = SignUpInputView(text: "통신사")
            infoLabel.text = "통신사를\n선택해주세요"
        case .name:
            inputTextField = SignUpInputView(text: "이름")
            infoLabel.text = "이름을\n입력해주세요"
        }
    }
}

extension SignUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
