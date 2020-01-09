//
//  CustomOptionalTests.swift
//  CustomOptionalTests
//
//  Created by 이지영 on 13/10/2019.
//  Copyright © 2019 이지영. All rights reserved.
//

import XCTest
@testable import CustomOptional

class CustomOptionalTests: XCTestCase {
    func test_customOptional_initialize() {
        let nonNilValue: CustomOptional<Int> = CustomOptional<Int>(0)
        let nilValue: CustomOptional<Int> = nil
        
        XCTAssert(nilValue != nonNilValue)
        XCTAssert(nonNilValue == .some(0))
        XCTAssert(nilValue == .none)
    }
    
    func test_accessNilError() {
        let nonNilValue: CustomOptional<Int> = CustomOptional<Int>(0)
        let nilValue: CustomOptional<Int> = nil
        
        XCTAssertNoThrow(try nonNilValue>> == 0)
        XCTAssertThrowsError(try nilValue>>, "access nil value!", { error in
            XCTAssert(error is CustomOptionalError)
        })
    }
    
    func test_defaultValue() {
        let nonNilValue: CustomOptional<Int> = CustomOptional<Int>(0)
        let nilValue: CustomOptional<Int> = nil
        
        XCTAssert(nonNilValue <> -1 == 0)
        XCTAssert(nilValue <> -1 == -1)
    }
    
    func test_getOptionalValue() {
        let nonNilValue: CustomOptional<Int> = CustomOptional<Int>(0)
        let nilValue: CustomOptional<Int> = nil
        
        XCTAssertNotNil(~nonNilValue)
        XCTAssertNil(~nilValue)
        XCTAssert(~nonNilValue == 0)
    }
}
