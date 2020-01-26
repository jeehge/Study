import UIKit

/**
 Functor, Monad
 */

func someAdd(_ value: Int) -> Int {
    return value + 1
}

someAdd(5)              // 6
//someAdd(Optional(5))    // error

Optional(5).map(someAdd)

var value: Int? = 2
value.map { $0 + 1 }

value = nil
value.map { $0 + 1 }



func doubledEven(_ num: Int) -> Int? {
    if num % 2 == 0 {
        return num * 2
    }
    return nil
}

Optional(3).flatMap(doubledEven)
Optional.none.flatMap(doubledEven)


//var completionHandlers: [() -> Void] = []
//func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
//    completionHandlers.append(completionHandler)
//}
//
//func someFunctionWithNonescapingClosure(closure: () -> Void) {
//    closure()
//}
//
//class SomeClass {
//    var x = 10
//    func doSomething() {
//        someFunctionWithEscapingClosure { self.x = 100 }
//        someFunctionWithNonescapingClosure { x = 200 }
//    }
//}
//
//let instance = SomeClass()
//instance.doSomething()
//print(instance.x)
//// Prints "200"
//
//completionHandlers.first?()
//print(instance.x)
//// Prints "100"
