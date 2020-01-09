//
//  ViewController.swift
//  AccessControlProject
//
//  Created by JH on 2019/10/27.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aInstance: SomeClass = SomeClass()
        aInstance.internalMethod()          // 같은 모듈이므로 호출 가능
        aInstance.filePrivateMethod()       // 다른 파일이므로 호출 불가 - 오류
        aInstance.internalProperty = 1      // 같은 모듈이므로 접근 가능
        aInstance.filePrivateProperty = 1   // 다른 파일이므로 접근 불가 - 오류
    }
}

