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


