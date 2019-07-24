//
//  EmailIdViewModel.swift
//  rxLoginView
//
//  Created by JH on 23/07/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EmailIdViewModel: ValidationViewModel {
    var errorMessage: String = "email error"
    var value: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    // 전자 메일 ID 필드에 대해 사용자가 입력 한 전자 메일 아이디의 유효성을 검사
    func validateCredentials() -> Bool {
        return value.value.contains("@")
    }
    
}
