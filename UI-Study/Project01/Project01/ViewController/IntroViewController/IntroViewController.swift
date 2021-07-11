//
//  IntroViewController.swift
//  Project01
//
//  Created by JH on 2021/07/10.
//

import UIKit

final class IntroViewController: BaseViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: { [weak self] in
            guard let self = self else { return }
            let signUpVC: SignUpViewController = SignUpViewController.viewController(from: .main)
            signUpVC.modalPresentationStyle = .fullScreen
            signUpVC.modalTransitionStyle = .crossDissolve
            self.present(signUpVC, animated: true, completion: nil)
        })
    }
}
