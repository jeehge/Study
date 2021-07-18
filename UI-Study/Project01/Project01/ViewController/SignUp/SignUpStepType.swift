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
    
    var text: String {
        switch self {
        case .phoneNumber:
            return "휴대폰번호를\n입력해주세요"
        case .residentRegistrationNumber:
            return "주민번호 앞 7자리를\n입력해주세요"
        case .newsAgency:
            return "통신사를\n선택해주세요"
        case .name:
            return "이름을\n입력해주세요"
        }
    }
}
