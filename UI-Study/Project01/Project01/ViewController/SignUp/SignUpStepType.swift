//
//  SignUpStepType.swift
//  Project01
//
//  Created by JH on 2021/07/14.
//

import Foundation

enum SignUpStepType: CaseIterable {
    case phoneNumber                    // 휴대폰번호
    case residentRegistrationNumber     // 주민등록번호
    case newsAgency                     // 통신사
    case name                           // 이름
    
    var title: String {
        switch self {
        case .phoneNumber:
            return "휴대폰번호"
        case .residentRegistrationNumber:
            return "주민등록번호"
        case .newsAgency:
            return "통신사"
        case .name:
            return "이름"
        }
    }
}
