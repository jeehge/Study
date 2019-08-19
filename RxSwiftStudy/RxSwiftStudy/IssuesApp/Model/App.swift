//
//  App.swift
//  RxSwiftStudy
//
//  Created by JH on 19/08/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit

struct App {
    static let api: API = API()
    static let preferenceManager: PreferenceManager = PreferenceManager()
    static let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
}
