//
//  PreferenceManager.swift
//  RxSwiftStudy
//
//  Created by JH on 19/08/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PreferenceManager {

    enum Constants: String {
        case tokenKey
        case refreshTokenKey
    }
    
    fileprivate var tokenSubject: BehaviorSubject<String?> = BehaviorSubject(value: UserDefaults.standard.string(forKey: Constants.tokenKey.rawValue))
    
    var token: String? {
        get {
            let token = UserDefaults.standard.string(forKey: Constants.tokenKey.rawValue)
            return token
        }
        set {
            UserDefaults.standard.set(newValue, forKey:  Constants.tokenKey.rawValue)
            tokenSubject.onNext(newValue)
        }
    }
    
    var refreshToken: String? {
        get {
            let token = UserDefaults.standard.string(forKey: Constants.refreshTokenKey.rawValue)
            return token
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.refreshTokenKey.rawValue)
        }
    }
}

extension PreferenceManager: ReactiveCompatible { }

extension Reactive where Base: PreferenceManager {
    var token: Observable<String?> {
        return base.tokenSubject.asObserver()
    }
}
