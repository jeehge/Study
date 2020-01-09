import UIKit

/**
 접근제어
 */

public class SomePublicClass {}
//internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
//internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}


/**
 기본 접근수준은 internal
 그래서 생략가능
 */
class SomeInternalClass {}              // implicitly internal
let someInternalConstant = 0            // implicitly internal


//private class AClass {
//    // 공개 접근수준을 부여해도 AClass의 접근수준이 비공개 접근수준이므로
//    // 이 메서드의 접근수준도 비공개 접근수준으로 취급됩니다
//    public func someMethod() {
//
//    }
//}
//
//// AClass의 접근수준이 비공개 접근수준이므로
//// 공개 접근수준 함수의 매개변수나 반환 타입으로 사용 불가
//public func someFunction(a: AClass) -> AClass {
//    return a
//}

//class InteranlClass {} // 내부 접근수준 클래스
//private struct PrivateStruce {} // 비공개 접근수준 구조체
//
//// 요소로 사용되는 InteranlClass와 PrivateStruce의 접근수준이
//// publicTuple보다 낮기 때문에 사용할 수 없습니다
//public var publicTuple: (first: InteranlClass, second: PrivateStruce) = (InteranlClass(), PrivateStruce())
//
//// 요소로 사용되는 InteranlClass와 PrivateStruce의 접근수준이
//// privateTuple과 같거나 높기 때문에 사용할 수 있습니다
//private var privateTuple: (first: InteranlClass, second: PrivateStruce) = (InteranlClass(), PrivateStruce())

public typealias PointValue = Int

enum Num: PointValue {
     case one
     case two
}


public struct someType {
    private var count: Int = 0
    internal var internalComputedProperty: Int {
        get {
            return count
        }
        set {
            count += 1
        }
    }
    
    internal private(set) var internalGetOnlyComputedProperty: Int {
        get {
            return count
        }
        set {
            count += 1
        }
    }
    
    public subscript() -> Int {
       get {
            return count
        }
        set {
            count += 1
        }
    }
    
    public internal(set) subscript(some: Int) -> Int {
        get {
            return count
        }
        set {
            count += 1
        }
    }
}
