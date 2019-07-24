//
//  LoginViewModel.swift
//  rxLoginView
//
//  Created by JH on 23/07/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewModel {
    let loginModel: LoginModel = LoginModel()
    let emailViewModel: EmailIdViewModel = EmailIdViewModel()
    let passwordViewModel: PasswordViewModel = PasswordViewModel()
    
    var isSuccess: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var errorMsg: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    let disposeBag: DisposeBag = DisposeBag()
    
    // 각 ViewModel 함수를 호출하여 필드 값을 비교
    func validateCrentials() {
        Observable
            .combineLatest(emailViewModel.value.asObservable(), passwordViewModel.value.asObservable())
            .subscribe(onNext: {_ in
                // BehaviorRelay 값변경할때 accept 사용
                self.isSuccess.accept(self.emailViewModel.validateCredentials() && self.passwordViewModel.validateCredentials())
        }).disposed(by: disposeBag)
        

//        emailViewModel.value.subscribe(onNext: {[weak self] (email) in
//            guard let `self` = self else { return }
//            self.emailViewModel.validateCredentials()
//        }).disposed(by: disposeBag)
//
//        passwordViewModel.value.subscribe(onNext: {[weak self] (password) in
//            guard let `self` = self else {return}
//            self.passwordViewModel.validateCredentials()
//        }).disposed(by: disposeBag)
    }
    
    // 모델 초기화
    // 성공 또는 실패 응답 isLoading, isSuccess, errorMessage의 앞부분에서 정의한 observable을 업데이트합니다.
    func loginUser() {
        
    }
}

