//
//  ValidationViewModel.swift
//  rxLoginView
//
//  Created by JH on 23/07/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol ValidationViewModel {

    var errorMessage: String { get }    // 사용자에게 표시 할 사전 정의 된 오류 메시지 또는 API 응답을 통해 수신 된 메시지
    var value: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get}
    
    // 유효성 검사
    func validateCredentials() -> Bool
}

// 이렇게 선언해주면 validateCredentials() 는 필수가 아니다
extension ValidationViewModel {
    func validateCredentials() -> Bool {
        // default 값은 false
        return false
    }
}

// ?? BehaviorSubject BehaviorRelay 차이가 무엇인가
