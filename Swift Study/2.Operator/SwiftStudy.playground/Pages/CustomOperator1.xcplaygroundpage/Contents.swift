import UIKit
import Foundation

/* string operator */
prefix operator <>

prefix func <>(value: String) -> Int {
    return value.count
}

let stringOperator = "문자열의 길이를 반환합니다"

print("길이: \(<>stringOperator)")


/* int operator */
postfix operator ^

postfix func ^(value: Int) -> Int {
    return value * value
}

let value = 10

print("제곱: \(value^)")


/* Question! */
let str = """
문자열의 길이의 제곱을 반환하고 싶어요.
왜 오류가 나는 걸까요?
오류가 안 나게 수정해주세요!
"""

print("문자열 길이의 제곱: \((<>str)^)")

/**
 연산자 우선순위
 하나의 피연산자에 후위연산자와 전위연산자가 한 줄에 실행되면
 후위 연산자가 먼저 실행됩니다
 */
