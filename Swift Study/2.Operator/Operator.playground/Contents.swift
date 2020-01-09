import UIKit

/**
 할당(대입) 연산자
 값을 할당(대입)하거나 초기화할 때 사용
 서로 다른 데이터 타입은 할당할 수 없음
 C나 Objective-C의 연산자와는 다르게 리턴값이 없음
 */
var a = 5
let b = 7
a = b

let (c, d) = (5, 7)
// a 는 5, b 는 7 이 대입

// error : 리턴값이 없기 때문에 사용할 수 없음
//if e = f {
//
//}

/**
 산술 연산자
 수학에서 쓰이는 연산할 때 사용
 */
let one = 1
let two = 2

one + two
one - two
one * two
one / two
// 나머지 연산자
one % two

// 증감 연산자는 swift3에서 사라졌음
//one++

/**
 비교 연산자
 값을 비교할때 사용
 Bool 값을 반환 -> true인지 false 체크
 */

let leftValue = 5
let rightValue = 6

leftValue   ==    rightValue    // 같음 : 두 값이 같을 경우만 true 그 외는 false 반환
leftValue   !=    rightValue    // 같지 않음 : 두 값이 같지 않다면 true
leftValue   >     rightValue    // 보다 큼
leftValue   <     rightValue    // 보다 작음
leftValue   >=    rightValue    // 크거나 같음
leftValue   <=    rightValue    // 작거나 같음


/**
 삼항 조건 연산자
 피연산자가 세 개인 연산자
 */

let count = 10
var result = 0

if count > 5 {
    result = 1
} else {
    result = 0
}

result = count>5 ? 1:0


/**
 논리 연산자
 논리 연산에 사용하는 연산자
 조건문을 사용하다 보면 가장 많이 보이는 연산자
 */

let boolValue = false

if !boolValue {
    print("\(boolValue)")
}

let three = 3
let four = 4

if three > 1 && four > 1 {
    
}

if three == 3 || four == 4 {
    
}

/**
 비트 연산자
 비트 논리 연산을 위한 연산자
 */

let bitValueA: UInt8 = 0b01011100
let bitValueB: UInt8 = 0b11001010

print(String(bitValueA&bitValueB, radix: 2))
print(String(bitValueA|bitValueB, radix: 2))
print(String(bitValueA^bitValueB, radix: 2))
print(String(~bitValueA, radix: 2))
print(String(bitValueA<<3, radix: 2))
print(String(bitValueA>>3, radix: 2))

/**
 사용자 정의 연산자
 */

// 전위 연산자
// 연산자를 구현하기 위해 미리 선언
prefix operator **

// 제곱을 수행하는 연산자를 정의
prefix func ** (num: Int) -> Int{
    return num * num
}
print(**10)

// 후위 연산자
postfix operator ++
// 전위와 같이 연산자를 구현하기 위해 미리 선언

// 값에 1을 더하는 연산자 정의
postfix func ++ (num: Int) -> Int{
    return num + 1
}
print(5++)

print(**5++)

