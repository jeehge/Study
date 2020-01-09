//: [Previous](@previous)

import Foundation

infix operator **: MultiplicationPrecedence

func **(lhs: Double, rhs: Double) -> Double {
    return lhs * rhs
}

infix operator ^: TernaryPrecedence

func ^(lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}

infix operator ++: AssignmentPrecedence

func ++(lhs: Double, rhs: Double) -> Double {
    return lhs + rhs
}

// 아래 계산 결과는 무엇이 나올까요?
let result = 5 ** 10 ^ 3 ++ 2

// 위 사용자 지정 연산자의 우선순위 그룹을 조정해서 아래 조건식이 참이 되게 해주세요
print("\(result) == 125002.0")

/**
 BitwiseShiftPrecedence -> MultiplicationPrecedence -> AdditionPrecedence -> RangeFormationPrecedence -> CastingPrecedence -> NilCoalescingPrecedence -> ComparisonPrecedence -> LogicalConjunctionPrecedence -> TernaryPrecedence -> AssignmentPrecedence
 
 ++ -> ** -> ^
 ** -> ^ -> ++ 정답!!!!!!!!! 위치를 바꾸쟈!!!!!!!!!!
 */
