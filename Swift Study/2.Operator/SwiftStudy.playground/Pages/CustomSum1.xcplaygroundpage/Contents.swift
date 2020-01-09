//: [Previous](@previous)

import Foundation

// 연산자를 구현하기 위해 미리 선언
infix operator ++

// 연산자 정의
func ++(lhs: Int, rhs: Int) -> Int {
    return Int(lhs + rhs)
}

func customSum(_ a: Int, _ b: Int) -> Int {
    return a ++ b
}

print("5 + 2 = \(customSum(5, 2))")

// 연산자 오버로드
func ++(lhs: String, rhs: String) -> String {
    return lhs + rhs
}

func customSum(_ a: String, _ b: String) -> String {
    return a ++ b
}

let lhs = "안녕하세요"
let rhs = "저는 이지영입니다"

print("\"\(lhs)\" + \"\(rhs)\" = \(customSum(lhs, rhs))")
