import UIKit

/**
 일급함수
 */

let adder: (Int, Int) -> Int = { $0 + $1 }

func twice() -> (Int) -> Int {
    return { value in
        return value * 2
    }
}

func LazyLog(_ message: () -> String) {
    #if DEBUG
    print(message())
    #endif
}

// My Example
func newNumber(param: Int) -> Int {
    return param - 1
}

func add(a: Int, function fn: (Int) -> Int) -> Int {
    return a + fn(a)
}

func subtraction(a: Int, function fn: (Int) -> Int) -> Int {
    return a - fn(a)
}

func calculator(_ operand: String) -> (Int, ((Int) -> Int)) -> Int {
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


/**
 Function composition (함수의 합성)
 
 함수의 반환값이 다른 함수의 입력값으로 사용되는 것을 함수의 합성(Composition) 이라고 합니다.
 당연하게도 함수가 합성되기 위해서는 함수의 반환값과 이것을 입력으로 받아들이는 값은 타입이 서로 같아야 합니다.
 */

func fc1(_ i: Int) -> Int {
    return i * 2
}

func fc2(_ i: Int) -> String {
    return "\(i)"
}

let result1 = fc2(fc1(100))

/**
 이 코드에서 f1의 수행결과가 f2 에 전달되어 사용되고 있습니다.
 f1과 f2가 합성되었다고 합니다.
 f1의 output값과 f2의 input값은 Int로 서로 타입이 같기 때문에 가능한 한 것입니다.
 함수도 1급개체로서 사용되기 때문에 다음과 같이 함수를 합성할 수도 있습니다.
 */

func ff(_ pf1: @escaping (Int) -> Int, _ pf2: @escaping (Int) -> String) -> (Int) -> String {
    return { i in
        return pf2(pf1(i))
    }
}
let fc3 = ff(fc1, fc2)
let result2 = fc3(100)

/**
 ff 라는 고차함수를 사용해서 함수를 합성해주는 함수를 만들었습니다.
 f1과 f2를 합성해서 f3로 만들고 합성된 함수를 한번에 사용하고 있습니다.
 다음과 같이 generic을 사용해서 범용적인 합성함수 생성 함수를 만들 수 있습니다.
 */

func comp<A, B, C>(_ pf1: @escaping (A) -> B, _ pf2: @escaping (B) -> C) -> (A) -> C {
    return { i in
        return pf2(pf1(i))
    }
}
let fc4 = comp(fc1, fc2)



/**
 실습
 주어진 코드는 짝수만의 합을 계산하는 코드입니다. 함수의 합성을 이용하여 완성하세요
 */

//func comp<A, B, C>(_ pf1: @escaping (A) -> B,
//                   _ pf2: @escaping (B) -> C) -> (A) -> C {
//    return { i in
//        return pf2(pf1(i))
//    }
//}

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
//func solution(_ nums: [Int]) -> Int {
//    return filteredSum(nums)
//}

//func comp<A, B, C>(_ pf1: @escaping (A) -> B,
//                   _ pf2: @escaping (B) -> C) -> (A) -> C {
//    return { i in
//        return pf2(pf1(i))
//    }
//}
//
//func filterEven(_ ns: [Int]) -> [Int] {
//    return ns.filter( { $0 % 2 == 0 })
//}
//
//func sum(_ ns: [Int]) -> Int {
//    return ns.reduce(0, +)
//}
//
//let filteredSum = comp(filterEven, sum)
//
//func solution_Q_2_3(_ nums: [Int]) -> Int {
//    return filteredSum(nums)
//}

// 예제
// 요리를 해보자!
enum 재료: String {
    case 고기
    case 토마토
    case 양배추
}

// 제너릭을 사용한 합성 함수
//func 요리<A, B, C>(_ pf1: @escaping (A) -> B,
//                  _ pf2: @escaping (B) -> C) -> (A) -> C {
//    return { i in
//        return pf2(pf1(i))
//    }
//}

func 요리(_ pf1: @escaping ([String]) -> [String],
        _ pf2: @escaping ([String]) -> String) -> ([String]) -> String {
    return { i in
        return pf2(pf1(i))
    }
}

func 재료손질(_ ns: [String]) -> [String] {
    return ns.map({
        var s: String = ""
        switch $0 {
        case 재료.고기.rawValue:
            s.append("다진 고기 ")
        case 재료.양배추.rawValue:
            s.append("크게 자른 양배추 ")
        case 재료.토마토.rawValue:
            s.append("잘게 자른 토마토 ")
        default:
            print("test")
        }
        return s
    })
}

func 햄버거(_ ns: [String]) -> String {
    var s: String = ""
    ns.forEach {
        s.append($0)
    }
    return "\(s)\n빵 위에 올려서 햄버거 완성!"
}

let cooking: ([String]) -> String = 요리(재료손질(_:), 햄버거(_:))
print(cooking(["고기", "토마토"]))



/**
 Async Result (비동기 반환)
 
 함수는 input 의 수행결과로 output을 내놓게 되지만,
 연산 과정이 시간이 걸리는 경우라면 프로그램의 수행이 멈추게 됩니다.
 이러한 방식을 동기식(sync)이라고 합니다.
 또 다른 비동기식(async)방식이 있는데, 결과는 나중에 생길 때 전달받기로 하고 프로그램의 수행을
 멈추지 않는 방식이죠.
 시간이 걸리는 작업, 예를들어 연산이 오래 걸리거나, 네트워크를 통해서 결과를 얻거나, 딜레이가 포함되는 내용같은 경우
 비동기 방식으로 함수를 구현하는 것이 좋습니다.
 */

func arf(_ nums: [Int]) -> Int {
    sleep(1)
    let sum = nums.reduce(0, +)
    return sum
}

/**
 이 코드에서는 수행과정에서 sleep 으로 수행시간이 1초 이상이 걸리게 됩니다. 프로그램도 1초이상 멈추게 됩니다.
 이것을 async 하게 변경하면 이렇게 됩니다.
 */

func af(_ nums: [Int], _ result: @escaping (Int) -> Void) {
    DispatchQueue.main.async {
        sleep(1)
        let sum = nums.reduce(0, +)
        result(sum)
    }
}

/**
 여기서 주목할 부분은 결과가 리턴값으로 전달되는 것이 아니라, 전달받은 함수(result)를 호출함으로써 전달된다는 것입니다.
 (나중에) 결과값이 생기게 된다면 이러한 처리를 하겠다 라는 구현을 함수로 만들어서 전달하면, 결과가 발생하는 시점에 수행되게 됩니다.
 이렇게 고차함수를 활용해서 async 결과를 전달할 수 있습니다.
 */



/**
 Currying (커링)
 
 여러개의 파라미터를 받는 함수를
 하나의 파라미터를 받는 여러 개의 함수로 쪼개는 것을 커링(Currying) 이라고 합니다.
 */

//func f(_ a: Int, _ b: Int) -> Int


/**
 이와같이 파라미터를 두 개 받는 함수가 있을 때, 이것을
 */

//func f1(_ a: Int) -> Int
//func f2(_ b: Int) -> Int


/**
 이렇게 파라미터 하나를 받는 함수 두 개로 쪼개는 것입니다.
 */

func multiply(_ a: Int) -> (Int) -> Int {
    return { b in
        return a * b
    }
}
let area = multiply(10)(20) //200

/**
 이 코드는 Higher-Order Function에서 이미 보았습니다. 이와 같이 고차함수를 사용해서 Currying 을 할 수 있습니다.
 커링을 왜 해야하나요?
 함수의 Output이 다른 함수의 Input으로 연결되면서 합성(Composition)됩니다.
 함수들이 서로 chain을 이루면서 연속적으로 연결이 되려면, Output과 Input의 타입과 개수가 같아야 합니다.
 함수의 Output은 하나밖에 없으니 Input도 모두 하나씩만 갖도록 한다면 합성하기가 쉬워질 것입니다.
 결국 함수의 합성을 원활하게 하기 위해서 커링을 사용하는 것입니다.
 */


/**
 실습
 주어진 코드에서 n의 배수만을 모아 합을 구하는 함수 filterSum을 currying 하여 filterSum2를 만드세요
 */

//func filterSum(_ ns: [Int], _ n: Int) -> Int {
//    return ns.filter({ $0 % n == 0 }).reduce(0, +)
//}
//
//func filterSum2(_ n: Int) -> ([Int]) -> Int {
//    //함수를 구현하세요
//}
//
//func solution(_ nums: [Int], _ r: Int) -> Int {
//    let filteredR = filterSum2(r)
//    return filteredR(nums)
//}

func filterSum(_ ns: [Int], _ n: Int) -> Int {
    return ns.filter({ $0 % n == 0 }).reduce(0, +)
}

func filterSum2(_ n: Int) -> ([Int]) -> Int {
    return { x in
        filterSum(x, n)
    }
}

func solution_Q_2_4(_ nums: [Int], _ r: Int) -> Int {
    let filteredR: ([Int]) -> Int = filterSum2(r)
    return filteredR(nums)
}


// 예제
// 요리를 해보자!
func 햄버거2(_ v1: [String], _ v2: String) -> String {
    var s: String = ""
    v1.forEach({
        switch $0 {
        case 재료.고기.rawValue:
            s.append("다진 고기 ")
        case 재료.양배추.rawValue:
            s.append("크게 자른 양배추 ")
        case 재료.토마토.rawValue:
            s.append("잘게 자른 토마토 ")
        default:
            print("test")
        }
    })

    return "\(s)\n\(v2)에 올려서 햄버거 완성!"
}

func 빵선택(_ n: String) -> ([String]) -> String {
    return { x in
        햄버거2(x, n)
    }
}

let cookingCurrying:([String]) -> String = 빵선택("호밀빵")
print(cookingCurrying(["고기","양배추","토마토"]))


/**
 Partial Application (부분 적용)
 */





/**
 Memoization (메모이제이션)
 */

func isPrime(_ n: Int) -> Bool {
    guard n > 1 else { return false }
    for k in 2..<n {
        if n % k == 0 { return false }
    }
    return true
}

func timeit(_ f: () -> ()) {
    let begin = Date()
    f()
    let elapsed: Int = Date.timeIntervalSince(begin) as! Int
    print("time: \(elapsed * 1000)ms")
}

func repeater(_ count: Int, f: () -> ()) {
    guard count > 0 else { return }
    for _ in 0..<count { f() }
}

// 테스트 : 메모이제이션 없을 때
repeater(3){
    timeit{
        print(Array(1...30000).filter(isPrime).count)
    }
}

// 테스트: 메모이제이션 적용시
let f = memoize(isPrime)
repeater(3){ timeit {
    print(Array(1...30000).filter(f).count)
}}
