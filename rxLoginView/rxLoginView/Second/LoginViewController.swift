//
//  LoginViewController.swift
//  rxLoginView
//
//  Created by JH on 23/07/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

// 숙제 https://medium.com/swift2go/mvvm-with-rxswift-the-user-login-cc43df423c9e
class LoginViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let loginViewMedel: LoginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginButton.setTitle("로그인", for: .normal)
        
        loginViewMedel.validateCrentials()
        bind()
    }
    
    private func bind() {
        emailTextField.rx.text.orEmpty.bind(to: loginViewMedel.emailViewModel.value).disposed(by: disposeBag)
        pwTextField.rx.text.orEmpty.bind(to: loginViewMedel.passwordViewModel.value).disposed(by: disposeBag)
        
        loginViewMedel.isSuccess.asObservable().subscribe(onNext: { (result) in
            self.loginButton.isEnabled = result
        }).disposed(by: disposeBag)
    }

}
