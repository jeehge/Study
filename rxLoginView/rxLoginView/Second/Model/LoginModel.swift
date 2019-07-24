//
//  LoginModel.swift
//  rxLoginView
//
//  Created by JH on 23/07/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit

// username, password 를 저장하는 클래스
class LoginModel {

    var username: String?
    var password: String?
    
    init() {}
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
