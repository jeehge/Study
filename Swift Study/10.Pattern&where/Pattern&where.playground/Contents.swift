import UIKit

/**
 pattern
 */

// Wildcard Pattern

for _ in 1...3 {
    // Do something three times.
}

// Identifier Pattern
let someValue = 42

// Value-Binding Pattern
//let point = (3, 2)
//switch point {
//    // Bind x and y to the elements of point.
//case let (x, y):
//    print("The point is at (\(x), \(y)).")
//}
// Prints "The point is at (3, 2)."


// Tuple Pattern
//let points = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]
//// This code isn't valid.
//for (x, 0) in points { // error
//    /* ... */
//}


let a1 = 2        // a: Int = 2
let (a2) = 2      // a: Int = 2
let (a3): Int = 2 // a: Int = 2


// Optional Pattern
let someOptional: Int? = 42
// Match using an enumeration case pattern.
if case .some(let x) = someOptional {
    print(x)
}

// Match using an optional pattern.
if case let x? = someOptional {
    print(x)
}

let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
// Match only non-nil values.
for case let number? in arrayOfOptionalInts {
    print("Found a \(number)")
}
// Found a 2
// Found a 3
// Found a 5

let point1 = (1, 2)
switch point1 {
case (0, 0):
    print("(0, 0) is at the origin.")
case (-2...2, -2...2):
    print("(\(point1.0), \(point1.1)) is near the origin.")
default:
    print("The point is at (\(point1.0), \(point1.1)).")
}
// Prints "(1, 2) is near the origin."

let weekday = 3
let lunch: String
switch weekday {
case 3:
    lunch = "Taco Tuesday!"
default:
    lunch = "Pizza again."
}
// lunch == "Taco Tuesday!"

let someInt: Int = 8
if case (1...10) = someInt {
    print("someInt is between 1 and 10")
}

if (1...10) ~= someInt {
    print("someInt is between 1 and 10")
}

let point = (1, 2)
switch point {
case (0, 0):
    print("(0, 0) is at the origin.")
case (-2...2, -2...2) where point.0 != 1:
    print("(\(point.0), \(point.1)) is near the origin.")
default:
    print("The point is at (\(point.0), \(point.1)).")
}
// Prints "(1, 2) is near the origin."

protocol SelfPrintable where Self: UIViewController {
    func printSelf()
}


func doubled<T>(integerValue: T) -> T where T: BinaryInteger {
    return integerValue * 2
}

//func doubled<T: BinaryInteger>(integerValue: T) -> T {
//    return integerValue * 2
//}

func print<T, U>(first: T, second: U) where T: CustomStringConvertible, U: CustomStringConvertible {
    print(first)
    print(second)
}

//func prints<T: CustomStringConvertible, U: CustomStringConvertible>(first: T, second: U) {
//    print(first)
//    print(second)
//}

//func compareTwoSequences<S1, S2>(a: S1, b: S2) where S1: Sequence, S1.SubSequence: Equatable, S2: Sequence, S2.SubSequence: Equatable {
//    //
//}
//
//protocol Container {
//    associatedtype ItemType where ItemType == BinaryInteger
//    var count: Int { get }
//
//    mutating func append(_ item: ItemType)
//    subscript(i: Int) -> ItemType { get }
//}


// enum 정의
enum Number {
    case Int(number: Int)
    case Double(number: Double)
    case Float(number: Float)
}

let num = Number.Double(number: 3.4)

switch num {
    case let Number.Double(num):
        print("Number is Double \(num)")
    default: () // default 내용은 없지만 없다고 표시해줘야 할때 사용해야만 합니다.
}

//  위와 동일한 구문을 다음과 같이 표현 가능해 집니다
if case let Number.Double(num) = num where num > 4 {
    print("Number is Double \(num)")
}
