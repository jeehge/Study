//
//  LoginViewController.swift
//  RxSwiftStudy
//
//  Created by JH on 19/08/2019.
//  Copyright © 2019 JH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, ViewcontrollerFromStoryBoard {

    @IBOutlet weak var loginButton: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    func bind() {
        loginButton.rx.tap.flatMap { _ in
            App.api.getToken()
            }.subscribe(onNext: { (token, refreshToken) in
                App.preferenceManager.token = token
                App.preferenceManager.refreshToken = refreshToken
            }, onError: { [weak self] (error) in
                guard let `self` = self else { return }
                let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        App.preferenceManager.rx.token.filter { $0 != nil }.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    static func registerLoginViewController() {
        _ = App.preferenceManager.rx.token
            .filter { $0 == nil}
            .delay(0.1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                let viewController = LoginViewController.viewController
                App.delegate.window?.rootViewController?.present(viewController, animated: true, completion: nil)
            })
    }
    
}

