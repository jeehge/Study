import UIKit

// 기본 클로저
let names: [String] = ["Chris", "Alex", "Eallen", "Barry", "Daniella"]

//func descendingPower(_ s1: String, _ s2: String) -> Bool {
//    return s1 > s2
//}

//let sorted = names.sorted(by: descendingPower)
//print(sorted)
// prints ["Eallen", "Daniella", "Chris", "Barry", "Alex"]

var sorted: [String] = names.sorted(by: { (s1: String, s2: String) -> Bool in
	return s1 > s2
})
print(sorted)

// 후행 클로저

let trailing﻿Closure: [String] = names.sorted { (s1: String, s2: String) -> Bool in
	return s1 > s2
}
print(trailing﻿Closure)


// 클로저 표현 간소화
// 1. 문맥을 이용한 타입 유추
sorted = names.sorted(by: { s1, s2 in return s1 > s2 } )

// 2. 단축 인자 이름
sorted = names.sorted(by: { return $0 > $1 } )

// 3. 암시적 반환 표현
sorted = names.sorted(by: { $0 > $1 } )

// 4. 연산자 함수
sorted = names.sorted(by: >)

// 값 획득

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}


let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// 값으로 10을 반환합니다.
incrementByTen()
// 값으로 20을 반환합니다.
incrementByTen()
// 값으로 30을 반환합니다.

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
// returns a value of 7

incrementByTen()
// 값으로 40을 반환합니다.

let incrementTest = incrementByTen
incrementTest()
// 값으로 50을 반환합니다.


// 탈출 클로저
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
//	completionHandlers.append(closure)
    closure()    // 함수 안에서 끝나는 클로저
}

class SomeClass {
    var x = 10
    func doSomething() {
		// 탈출 클로저에서는 명시적으로 self를 사용해야 함
        someFunctionWithEscapingClosure { self.x = 100 }
		// 비탈출 클로저에서 self는 선택 사항
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

completionHandlers.first?()
print(instance.x)
// Prints "100"

var studyMembers = ["졔", "낼", "민", "훈", "환", "원" , "은", "빈", "윤"]
print(studyMembers.count)
// Prints "8"

let checkStudyMemober = { studyMembers.removeLast() }
print(studyMembers.count)
// Prints "9"

//print("스터디 멤버가 아닌 사람은 : \(checkStudyMemober())!")
//print(studyMembers.count)
// Prints "8"

//func 스파이는누구인가(member spy: () -> String) {
//	print("스터디 멤버가 아닌 사람은 : \(spy())!")
//}
//스파이는누구인가(member: { studyMembers.removeLast() } )

func 스파이는누구인가(member spy: @autoclosure () -> String) {
	print("스터디 멤버가 아닌 사람은 : \(spy())!")
}
스파이는누구인가(member: studyMembers.removeLast())


var 나간멤버들: [() -> String] = []        //  클로저를 저장하는 배열을 선언
func 나간멤버(_ member: @autoclosure @escaping () -> String) {
    나간멤버들.append(member)
} // 클로저를 인자로 받아 그 클로저를 나간멤버들 배열에 추가하는 함수를 선언
나간멤버(studyMembers.remove(at: 0))    // 클로저를 나간멤버들 배열에 추가
나간멤버(studyMembers.remove(at: 0))

print("나간멤버는 \(나간멤버들.count) 명")  // 2개의 클로저가 추가 됨
for member in 나간멤버들 {
    print("나간 멤버 \(member())!")    // 클로저를 실행하면 배열의 0번째 원소를 제거하며 그 값을 출력
}

// withoutActuallyEscaping
//func allValues(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
//    return array.lazy.filter { !predicate($0) }.isEmpty
//}
// error: closure use of non-escaping parameter 'predicate'...

func allValues(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
    return withoutActuallyEscaping(predicate) { escapablePredicate in
        array.lazy.filter { !escapablePredicate($0) }.isEmpty
    }
}


// 클로저 저장
//var complitionHandler: ((Int)->Void)?
//
//func getSumOf(array:[Int], handler: @escaping ((Int)->Void)) {
//    //step 2
//    var sum: Int = 0
//    for value in array {
//        sum += value
//    }
//    //step 3
//    self.complitionHandler = handler
//}
//
//func doSomething() {
//    //step 1
//    self.getSumOf(array: [16,756,442,6,23]) { (sum) in
//        print(sum)
//        //step 4. 함수 종료
//    }
//}


// 비동기 작업
func sumText(array: [String], handler: @escaping ((String)->Void)) {
    //step 2
    var result: String = ""
    for c in array {
        result += c
    }
    //step 3. 비동기 작업
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.0){
        handler(result)
    }
}

func doSomething() {
    //step 1
    sumText(array: ["a", "b", "b", "c", "z"]) { (result) in
        print(result)
        //step 4. 함수 종료
    }
}

doSomething()

// func execute(handler: @escaping (() -> Void)?) {
func execute(handler: (() -> Void)?) {
	
}
