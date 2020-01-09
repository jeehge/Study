//
//  CustomOptional.swift
//  CustomOptional
//
//  Created by 이지영 on 13/10/2019.
//  Copyright © 2019 이지영. All rights reserved.
//

import Foundation

public enum CustomOptional<Wrapped> {
    case none
    case some(Wrapped)
    
    public init(_ value: Wrapped) {
        self = .some(value)
    }
    
    /**
 필요한 것 구현하기!
     */
}
