//
//  ViewcontrollerFromStoryBoard.swift
//  RxSwiftStudy
//
//  Created by JH on 19/08/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit


protocol ViewcontrollerFromStoryBoard {
    
}

extension ViewcontrollerFromStoryBoard where Self: UIViewController {
    static var viewController: Self {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self
            else { return Self() }
        return viewController
    }
}
