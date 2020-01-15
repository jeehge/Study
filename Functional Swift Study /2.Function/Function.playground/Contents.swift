import UIKit


/**
 순수 함수
 */

var c: Int = 10
func pureFunction1(a: Int, b: Int) -> Int {
    return a + b
}

func pureFunction2(a: Int, b: Int) -> Int {
    return a + b + c
}


pureFunction1(a: 5, b: 10)
pureFunction1(a: 5, b: 10)


pureFunction2(a: 5, b: 10)
pureFunction2(a: 5, b: 10)

c = 20
pureFunction2(a: 5, b: 10)


func pureFunction3(a: Int, b: Int) -> Int {
    c = b
    return a + b + c
}

// FP 2-1.
func solution_Q_2_1(_ nums: [Int]) -> Int {
    var sum = 0
    for i in nums {
        sum += i
    }
    return sum
}


func mySolution_Q_2_1(_ nums: [Int]) -> Int {
    return nums.reduce(0, +)
}

/**
 고차 함수 (Highter-Order Function)
 */

// 일급 객체로서의 함수
// 예제코드는 https://yzzzzun.tistory.com/13 여기서 가져왔습니다
// 해당 사이트에 자세한 설명도 있으니 참고하시기 바랍니다!!!!!!!
// 1. 변수나 상수에 함수를 대입할 수 있습니다
var highterOrderFunc = pureFunction1(a: 5, b: 10)

// 2. 함수의 반환 타입으로 함수를 사용할 수 있습니다
func plus(a:Int, b:Int) -> Int{
    return a+b
}

func calc(_ operand : String) -> (Int,Int) -> Int{
    switch operand {
    case "+":
        return plus
    default:
        return plus
    }
}

let operand = calc("+")
operand(3,4)

// 3. 함수의 인자값으로 함수를 사용할 수 있습니다
func increment(param: Int) -> Int {
    return param + 1
}

func broker(base: Int, function fn: (Int) -> Int) -> Int {
    return fn(base)
}

let x: Int = broker(base: 4, function: increment)
print(x)

// My Example Code
func newNumber(param: Int) -> Int {
    return param - 1
}

func add(a: Int, function fn: (Int) -> Int) -> Int {
    return a + fn(a)
}

func subtraction(a: Int, function fn: (Int) -> Int) -> Int {
    return a - fn(a)
}

func calculator(_ operand: String) -> (Int, ((Int) -> Int)) -> Int{
    switch operand {
    case "+":
        return add
    case "-":
        return subtraction
    default:
        return add
    }
}

let operand2 = calculator("-")
operand2(3, newNumber)


// FP 2-2.
// 주어진 코드는 고차함수를 사용하여 짝수만의 합을 계산하는 코드입니다. 코드를 완성하세요
//let f: (Int) -> Bool = { } //함수 내부를 구현하세요
//let s: (Int, Int) -> Int = { } //함수 내부를 구현하세요
//
//func solution_Q_2_2(_ nums: [Int]) -> Int {
//    print(nums)
//    return nums.filter(f).reduce(0, s)
//}
//
//let f: (Int) -> Bool = { $0 % 2 == 0 } //함수 내부를 구현하세요
//let s: (Int, Int) -> Int = { $0 + $1 } //함수 내부를 구현하세요
//
//func mySsolution_Q_2_2(_ nums: [Int]) -> Int {
//    return nums.filter(f).reduce(0, s)
//}


/**
 익명함수
 */

func someFunction() {
    print("Hello Word")
}
 
someFunction()
 
({ ( ) -> Void in
    print("Hello Word")
})()


func someFunction1(name: String) {
    print("내 이름은 \(name)입니다.")
}

func someFunction2(num: Int) -> Int {
    return num * 2
}


({(name: String) -> Void in
    print("내 이름은 \(name)입니다.")
})

({(num: Int) -> Int in
    return num * 2
})





