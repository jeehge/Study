import UIKit


/**
조건문
 */

// if 문
var five = 5

// if 만 사용
if five < 6 {
    print("five는 6보다 작다")
}
// Prints "five는 6보다 작다"

// if, else 사용
if five > 6 {
    print("five는 6보다 크다")
} else {
    print("five는 6보다 작다")
}
// Prints "five는 6보다 작다"

// if, else if, else 사용
if five == 5 {
    print("five는 5이다")
} else if five > 6 {
    print("five는 6보다 크다")
} else {
    print("five는 6보다 작다")
}
// Prints "five는 5이다"

// else 생략 가능
if five < 5 {
    print("five는 5이다")
} else if five < 6 {
    print("five는 6보다 작다")
}
// Prints "five는 5이다"


// switch
//switch 입력 값{
//case 비교 값 1:
//    실행 구문
//case 비교 값 2:
//    실행 구문
//    // 이번 case를 마치고 switch 구문을 탈출하지 않습니다. 아래 case로 넘어갑니다.
//case 비교 값 3, 비교 값 4, 비교 값 5: // 한번에 여러 값과 비교할 수 있습니다.
//    실행 구문
//    break // break 키워드를 통한 종료는 선택 사항입니다.
//default: // 한정된 범위가 명확지 않다면 default는 필수입니다.
//    otherwise, do something else
//}


let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}
// Prints "The last letter of the alphabet"


//let anotherCharacter: Character = "a"
//switch anotherCharacter {
//case "a": // Invalid, case문에 body가 없으므로 에러가 발생합니다.
//case "A":
//    print("The letter A")
//default:
//    print("Not the letter A")
//}
//// 컴파일 에러 발생!

let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}

let 나의총점 = 100
let 나의학점: String
switch 나의총점 {
case 100:
    나의학점 = "A"
case 90..<99:
    나의학점 = "B"
case 80..<89:
    나의학점 = "C"
case 70..<79:
    나의학점 = "D"
default:
    나의학점 = "F"
}
print("이번 학기 나의 성적은 총점 : \(나의총점), 학점 : \(나의학점)")
// Prints "이번 학기 나의 성적은 총점 : 100, 학점 : A"


let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// Prints "(1, 1) is inside the box"


let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with an x value of 2"

let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
// Prints "On an axis, 9 from the origin"

/**
 반복문
 */

// for-in
//
//for 임시 상수 in 시퀀스 아이템 {
//    실행 코드
//}

var names = ["은지", "소영", "은영", "수정"]
for name in names {
    print("안녕, \(name)!")
}

//안녕, 은지!
//안녕, 소영!
//안녕, 은영!
//안녕, 수정!

let numberOfLegs = ["거미": 8, "개미": 6, "고양이": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)는 \(legCount)개 다리를 가지고 있다")
}

//거미는 8개 다리를 가지고 있다
//개미는 6개 다리를 가지고 있다
//고양이는 4개 다리를 가지고 있다

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
// Prints "3 to the power of 10 is 59049"


let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
    print(tickMark)
}


// while

//var names = ["은지", "소영", "은영", "수정"]
while names.isEmpty == false {
    print("안녕, \(names.removeLast())!")
}


var names2 = ["은지", "소영", "은영", "수정"]
repeat {
    print("안녕, \(names2.removeFirst())!")
} while names2.isEmpty == false

//안녕, 은지!
//안녕, 소영!
//안녕, 은영!
//안녕, 수정!


/**
 구문 이름표
 */

outer: for i in 1...5 {
    inner: for j in 1...9 {
        print("i : \(i)")
        print("j : \(j)")
        if j == 3 {
            break outer
        }
    }
}

/**
 함수
 */

//func 함수 이름 (매개변수...) -> 반환 타입 {
//    실행 구문
//    return 반환 값
//}

func 인사(이름: String) -> String {
    let result = "안녕, " + 이름 + "!"
    return result
}

print(인사(이름: "졔"))
print(인사(이름: "민"))

// 매개변수가 없는 함수
func function() -> String {
    return "안녕"
}

print(function())
// Prints "안녕"


// 매개변수가 여러 개인 함수

func function(myName: String, yourName: String) -> String {
    return "안녕! \(yourName), 난 \(myName)"
}
print(function(myName: "졔", yourName: "민"))
// Prints "안녕! 민, 난 졔"

// 반환 값이 없는 함수
func function(name: String) {
    print("안녕, \(name)!")
}
function(name: "졔")

//func 함수 이름(전달인자 레이블 매개변수 이름: 매개변수 타입, 전달인자 레이블 매개변수 이름: 매개변수 타입...) -> 반환 타입 {
//    실행 구문
//    return 반환 값
//}

// 매개변수 이름과 전달인자 레이블을 가지는 함수
func function(from myName: String, to yourName: String) {
    print("안녕! \(yourName), 난 \(myName)")
}

function(from: "졔", to: "민")

// 전달인자 레이블이 없는 함수
func function(_ myName: String, _ yourName: String) {
    print("안녕! \(yourName), 난 \(myName)")
}

function("졔", "민")


func sayHello(_ name: String, times: Int = 3) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "안녕! \(name)!!" + " "
    }
    
    return result
}

print(sayHello("졔"))

print(sayHello("민", times: 2))


func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
// returns 10.0, which is the arithmetic mean of these three numbers


func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero는 이제 중첩 돼 있는 stepForward() 함수를 가르킵니다.
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!



func crashAndBurn() -> Never {
    fatalError("Some")
}

crashAndBurn() // 프로세스 종료 후 오류 보고

func someFunction(isAllIsWell: Bool) {
    guard isAllIsWell else {
        print("마을에 도둑이 들었습니다")
        crashAndBurn()
    }
    print("All is well")
}

someFunction(isAllIsWell: true)     // All is well
someFunction(isAllIsWell: false)    // 마을에 도둑이 들었습니다!
// 프로세스 종료 후 오류 보고

func say(_ something: String) -> String {
    print(something)
    return something
}


@discardableResult func discardableResultSay(_ something: String) -> String {
    print(something)
    return something
}

say("하이!")

discardableResultSay("하이!")
