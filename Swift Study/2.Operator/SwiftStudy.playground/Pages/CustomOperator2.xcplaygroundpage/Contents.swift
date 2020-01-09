//: [Previous](@previous)

import Foundation


precedencegroup Multiplicative {
    associativity: left
}

precedencegroup Exponentiative {
    associativity: left
    higherThan: Multiplicative
}

infix operator **: Exponentiative

func **(lhs: Int, rhs: Int) -> Int {
    return lhs * rhs
}

infix operator ++: Multiplicative

func ++(lhs: Int, rhs: Int) -> Int {
    return lhs + rhs
}

// 왜 오류가 날까요?
print(5 ++ 7 ** 2)

/**
 Adjacent operators are in non-associative precedence group 'DefaultPrecedence'
 
 중위 연산자를 정의할 때 우선순위 그룹을 명시해주지 않는다면 우선순위가 가장 높은 DefaultPrecedence 그룹을 우선순위 그룹으로 갖게 됩니다
 둘다 우선순위가 가장 높기 때문에 괄호를 붙여준다거나 ++, ** 우선순위를 다르게 해준다면 에러가 안날 것입니다
 */
