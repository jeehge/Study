//
//  PasswordViewModel.swift
//  rxLoginView
//
//  Created by JH on 23/07/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PasswordViewModel: ValidationViewModel {
    var errorMessage: String = "password error"
    var value: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    // errorValue 변수를 초기화 할 때 암호 길이를 6 ~ 15 자로 검증하는 validateCredentials () 함수에 구현을 제공
    func validateCredentials() -> Bool {
        return value.value.count >= 6 && value.value.count <= 15
    }
}

