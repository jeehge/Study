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
        $0.textColor = .black
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
    
    private let boderView = UIView().then {
        $0.clipsToBounds = true
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 18
    }
    
    // MARK: - Variable
    
    private var types: [String] = []
    private var shouldAnimateFirstRow = false
    private var currentType: SignUpStepType = .phoneNumber
    private let cellSize: CGSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 77)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        
        setupView()
    }
    
    // MARK: - Private Method
    
    private func signUpStepType(type: SignUpStepType) {
        currentType = type
        setInfoLabel(text: type.text)
        
        let easeOutCirc = CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.0, 1)
        
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(easeOutCirc)
        
        tableView.beginUpdates()
        types.insert(type.title, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .none)
        shouldAnimateFirstRow = true
        tableView.endUpdates()
        
        CATransaction.commit()
    }
    
    func isPhone(candidate: String) -> Bool {
        let regex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: candidate)
    }
    
    func setInfoLabel(text: String) {
        UIView.animate(withDuration: 0.2, animations: {
            self.infoLabel.alpha = 0.5
            self.loadViewIfNeeded()
        }, completion: { _ in
            self.infoLabel.text = text
            UIView.animate(withDuration: 0.4, animations: {
                self.infoLabel.alpha = 1.0
                self.loadViewIfNeeded()
            }, completion: nil)
        })
    }
}

extension SignUpViewController {
    private func setupView() {
        view.addSubviews(infoLabel, tableView)
        
        tableView.addSubview(boderView)
        
        boderView.snp.makeConstraints {
            $0.width.equalTo(cellSize.width)
            $0.height.equalTo(cellSize.height)
        }
        
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
        return cellSize.height + 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SignUpTableViewCell
        
        boderView.snp.remakeConstraints {
            $0.width.equalTo(cellSize.width)
            $0.height.equalTo(cellSize.height)
            $0.top.leading.trailing.equalTo(cell)
        }
    }
}

extension SignUpViewController: SignUpTableViewCellDelegate {
    func textFieldDidChange(_ textField: UITextField) {
        switch currentType {
        case .phoneNumber:
            if textField.text?.count == 11 { // 정규식으로 바꾸는게 좋을
                signUpStepType(type: .residentRegistrationNumber)
            }
        case .residentRegistrationNumber:
            if textField.text?.count == 7 { // 정규식으로 바꾸는게 좋을
                signUpStepType(type: .newsAgency)
            }
        case .newsAgency:
            break
        case .name:
            //
            print("name")
        }
    }
}
