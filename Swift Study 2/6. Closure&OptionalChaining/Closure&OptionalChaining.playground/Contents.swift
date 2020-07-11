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
