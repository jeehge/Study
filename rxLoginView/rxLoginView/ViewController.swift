//
//  ViewController.swift
//  rxLoginView
//
//  Created by JH on 05/07/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLoginView()
        initTextField()
    }
    
    // MARK: - Initialize
    func initLoginView() {
        self.loginButton.setTitle("로그인", for: .normal)
        // 굳이 필요없는 코드
//        self.loginButton.isEnabled = false
    }
    
    func initTextField() {
        let emailObservable = self.emailTextField.rx.text.orEmpty.asObservable().map { (email)  in
            // email 검증
            email.contains("@")
        }
        let passwordObservable = self.pwTextField.rx.text.orEmpty.asObservable().map { (password) in
            // password 검증
            password.count > 7
        }
        
//        Single.just("string").asObservable().subscribe -> 하나만
        // 로그인 버튼 - 8개까지 검증이 됨
        Observable
            .combineLatest(emailObservable, passwordObservable) { ($0, $1) }
            .subscribe(onNext: { (email, password) in
                self.loginButton.isEnabled = (email == true && password == true)
            }).disposed(by: disposeBag)
        
        // 더 간단하게 표현 가능
//        Observable
//            .combineLatest(emailObservable, passwordObservable).map { $0 && $1 }
//            .bind(to: self.loginButton.isEnabled)
        
        
    }
    
    // MARK: - IBAction
    @IBAction func actionLogin(_ sender: UIButton) {
        guard let emailTxt = self.emailTextField.text, let passwordTxt = self.pwTextField.text else {
            return
        }
    }
}

