import UIKit

/**
 map
 filter
 reduce
 */

let numbers: [Int] = [1, 2, 3, 4, 5]
var operationNumbers: [Int] = [Int]()
var strings: [String] = [String]()

// 기존 for
for number in numbers {
    operationNumbers.append(number * number)
}

// map
operationNumbers = numbers.map({ (number: Int) -> Int in
    return number * number
})

strings = numbers.map({ (number: Int) -> String in
    return "\(number)"
})



// 기본 클로저 표현식 사용
operationNumbers = numbers.map({ (number: Int) -> Int in
    return number * number
})

// 매개변수 및 반환 타입 생략
operationNumbers = numbers.map({ return $0 * 2 })

// 반환 키워드 생략
operationNumbers = numbers.map({ $0 * 2 })

// 후행 클로저 사용
operationNumbers = numbers.map{ $0 * 2 }



let evenNumbers: [Int] = numbers.filter { (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers)

let oddNumbers: [Int] = numbers.filter { $0 % 2 != 0 }
print(oddNumbers)


let numberSum = numbers.reduce(0, { x, y in
    x + y
})

print(numberSum)
// numberSum == 15

let letters = "abracadabra"
let letterCount = letters.reduce(into: [:]) { counts, letter in
    counts[letter, default: 0] += 1
}

print(letterCount)



let members: [String] = ["내일 날씨 맑음", "찜 스",
"졔 ", "탄 이",
"왕 촙", "민 서",
"스 로", "Jyoung ",
"필 비", " NOWEAT"]
let memberList = members.map { $0.components(separatedBy: [" "]).joined() }
print(memberList)


let attendList = memberList.filter { $0 != "찜스" && $0 != "필비" }
print(attendList)

let finalList = members.map { $0.components(separatedBy: [" "]).joined() }
                       .filter { $0 != "찜스" && $0 != "필비" }
print(finalList)

//
//func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//
//    let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//    print(deviceTokenString)
//}
//
//
//func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    let deviceTokenString = deviceToken.map { String(format: "%02x", $0)}.joined()
//    print(deviceTokenString)
//}﻿
//
//// Called when APNs has assigned the device a unique token
//func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    // Convert token to string (디바이스 토큰 값을 가져옵니다.)
//    let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//    // let deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
//
//    // Print it to console(토큰 값을 콘솔창에 보여줍니다. 이 토큰값으로 푸시를 전송할 대상을 정합니다.)
//    print("APNs device token: \(deviceTokenString)")
//
//    Messaging.messaging().apnsToken = deviceToken
//
//    // Persist it in your backend in case it's new
//}


let array1: [[Int]] = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12, 13, 14], [15] ]
let test1 = array1.reduce([Int](), { $0 + $1 })
print(test1)

let test2 = array1.reduce([Int](), { $0 + $1 }).reduce(into: 0, { $0 += $1 })
print(test2)

let array2 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

