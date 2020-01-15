import UIKit

/**
 일급함수
 */


/**
 Function composition (함수의 합성)
 */

// 주어진 코드는 짝수만의 합을 계산하는 코드입니다. 함수의 합성을 이용하여 완성하세요
func comp<A, B, C>(_ pf1: @escaping (A) -> B,
                   _ pf2: @escaping (B) -> C) -> (A) -> C {
    return { i in
        return pf2(pf1(i))
    }
}

//func filterEven(_ ns: [Int]) -> [Int] {
//    //함수를 구현하세요
//}
//
//func sum(_ ns: [Int]) -> Int {
//    //함수를 구현하세요
//}
//
//let filteredSum = comp(filterEven, sum)
//
//func solution_Q_2_3(_ nums: [Int]) -> Int {
//    return filteredSum(nums)
//}

func filterEven(_ ns: [Int]) -> [Int] {
    return ns.filter( { $0 % 2 == 0 })
}

func sum(_ ns: [Int]) -> Int {
    return ns.reduce(0, +)
}

let filteredSum = comp(filterEven, sum)

func solution_Q_2_3(_ nums: [Int]) -> Int {
    return filteredSum(nums)
}




/**
 Async Result (비동기 반환)
 */





/**
 Currying (커링)
 */





/**
 Partial Application (부분 적용)
 */





/**
 Memoization (메모이제이션)
 */
