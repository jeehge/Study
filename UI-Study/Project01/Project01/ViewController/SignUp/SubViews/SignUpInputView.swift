//
//  SignUpTextField.swift
//  Project01
//
//  Created by JH on 2021/07/10.
//

import UIKit

@IBDesignable
final class SignUpInputView: UIView {
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
}

extension SignUpInputView {
    private func setup() {
        
    }
}
