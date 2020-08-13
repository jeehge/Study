import UIKit


func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt >> \(someInt), anotherInt >> \(anotherInt)")
// Prints "someInt >> 107, anotherInt >> 3"

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//func swapTwoValues(_ a: inout Any, _ b: inout Any) {
//	let temporaryA: Any = a
//    a = b
//    b = temporaryA
//}
//
//var someAny: Any = 1
//var anotherAny: Any = "Two"
//
//swapTwoValues(&someAny, &anotherAny)
//print("someAny >> \(someAny), anotherAny >> \(anotherAny)")
//// Prints "someAny >> Two, anotherAny >> 1"
//
//var stringOne: String = "One"
//someAny = stringOne
//anotherAny = 2
//
//swapTwoValues(&someAny, &anotherAny)
//print("someAny >> \(someAny), anotherAny >> \(anotherAny)")

//swapTwoValues(&stringOne, &anotherAny) // error


/**
제네릭 함수
*/

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
	let temporaryA: T = a
    a = b
    b = temporaryA
}

swapTwoValues(&someInt, &anotherInt)
print("someInt >> \(someInt), anotherInt >> \(anotherInt)")
// Prints "someInt >> 107, anotherInt >> 3"

var someDouble: Double = 1.34
var anotherDouble: Double = 34.51

swapTwoValues(&someDouble, &anotherDouble)
print("someDouble >> \(someDouble), anotherDouble >> \(anotherDouble)")
// Prints "someDouble >> 34.51, anotherDouble >> 1.34"

var someString: String = "A"
var anotherString: String = "TEXT"

swapTwoValues(&someString, &anotherString)
print("someString >> \(someString), anotherString >> \(anotherString)")
// Prints "someString >> TEXT, anotherString >> A"

/**
제네릭 타입
*/

//struct IntStack {
//    var items = [Int]()
//    mutating func push(_ item: Int) {
//        items.append(item)
//    }
//    mutating func pop() -> Int {
//        return items.removeLast()
//    }
//}



//struct Stack<Element> {
//    var items = [Element]()
//    mutating func push(_ item: Element) {
//        items.append(item)
//    }
//    mutating func pop() -> Element {
//        return items.removeLast()
//    }
//}
//
//let stackInt: Stack<Int> = Stack<Int>()
//let stackDouble: Stack<Double> = Stack<Double>()
//let stackString: Stack<String> = Stack<String>()


/**
제네릭 타입 확장
*/

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}


/**
타입제한
*/

//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    // function body goes here
//}

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["가", "나", "다", "라", "마"]
if let foundIndex = findIndex(ofString: "라", in: strings) {
    print("'라'가 있는 인덱스 위치는 \(foundIndex)")
}
// Prints "'라'가 있는 인덱스 위치는 3"

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])

/**
프로토콜의 연관 타입
*/

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


struct Stack<Element>: Container {
    
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
