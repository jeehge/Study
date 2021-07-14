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
    
    private lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .clear
        $0.register(SignUpTableViewCell.self,
                    forCellReuseIdentifier: SignUpTableViewCell.identifier)
        $0.dataSource = self
        $0.delegate = self

        $0.separatorStyle = .none
    }
    
    // MARK: - Variable
    
    private var types: [String] = []
    private var shouldAnimateFirstRow = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        view.addSubviews(infoLabel, tableView)
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(32)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(infoLabel)
            $0.bottom.equalToSuperview()
        }
        
        signUpStepType(type: .phoneNumber)
    }
    
    private func signUpStepType(type: SignUpStepType) {
        switch type {
        case .phoneNumber:
            infoLabel.text = "휴대폰번호를\n입력해주세요"
        case .residentRegistrationNumber:
            infoLabel.text = "주민번호 앞 7자리를\n입력해주세요"
        case .newsAgency:
            infoLabel.text = "통신사를\n선택해주세요"
        case .name:
            infoLabel.text = "이름을\n입력해주세요"
        }
//        types.append()
        
        let animationDuration = 0.9
        // http://easings.net/#easeOutCirc
        let easeOutCirc = CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.0, 1)

        UIView.beginAnimations("addRow", context: nil)
        UIView.setAnimationDuration(animationDuration)
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(easeOutCirc)

        tableView.beginUpdates()
        types.insert(type.title, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .none)
        shouldAnimateFirstRow = true
        tableView.endUpdates()

        CATransaction.commit()
        UIView.commitAnimations()
    }
}

extension SignUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SignUpTableViewCell.identifier,
                                                       for: indexPath) as! SignUpTableViewCell

        cell.cellDelegate = self
        cell.selectionStyle = .none
        cell.configure(text: types[indexPath.item])
        return cell
    }
}

extension SignUpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension SignUpViewController: SignUpTableViewCellDelegate {
    func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count == 11 {
            signUpStepType(type: .residentRegistrationNumber)
            
        }
    }
}
