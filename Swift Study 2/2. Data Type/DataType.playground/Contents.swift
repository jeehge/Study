import UIKit

// Int와 UInt
/**
 Int +, - 부호를 포함한 정수
 UInt - 부호를 포함하지 않는 0을 포함한 정수
 최댓값, 최솟값은 각각 max와 min
 Int와 UInt는 각각 8비트, 16비트, 32비트, 64비트의 형태
 (Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64)
 10진수 : 평소 사용하는 숫자와 동일
 2진수 : 접두어 0b 사용
 8진수 : 접두어 0o 사용
 16진수 : 접두어 0x 사용
 */

var value1: Int = -1
let value2: UInt = 1    // UInt 타입에는 음수값을 할당할 수 없음
print("value1 값: \(value1), value2 값 : \(value2)")
print("Int 최댓값 : \(Int.max), Int 최솟값 : \(Int.min)")
print("UInt 최댓값 : \(UInt.max), UInt 최솟값: \(UInt.min)")

print("Int64 최댓값: \(Int64.max), 최솟값: \(Int64.min)")
print("Int32 최댓값: \(Int32.max), 최솟값: \(Int32.min)")
print("Int16 최댓값: \(Int16.max), 최솟값: \(Int16.min)")
print("Int8 최댓값: \(Int8.max), 최솟값: \(Int8.min)")
print("UInt64 최댓값: \(UInt64.max), 최솟값: \(UInt64.min)")
print("UInt32 최댓값: \(UInt32.max), 최솟값: \(UInt32.min)")
print("UInt16 최댓값: \(UInt16.max), 최솟값: \(UInt16.min)")
print("UInt8 최댓값: \(UInt8.max), 최솟값: \(UInt8.min)")
    

let decimalNumber: Int = 12
let binaryNumber: Int = 0b1100
let octalNumber: Int = 0o14
let hexadecimalInteger: Int = 0xc

//let tooLarge: Int = Int.max + 1 // error: arithmetic operation '9223372036854775807 + 1' (on type 'Int') results in an overflow
//let cannotBeNegetive: UInt = -5 //  error: negative integer '-5' overflows when stored into unsigned type 'UInt'
//
//integer = unsignedInteger // error: cannot assign value of type 'UInt' to type 'Int'
//integer = Int(unsignedInteger)

// Bool
/**
 불리언 타입 참(true) 또는 거짓(false)
 */

let boolean: Bool = true
let isCheckValue: Bool = false

if isCheckValue {
    print("check value is true")
} else {
    print("check value is false")
}
 
// Float과 Double
/**
 부동소수점을 사용하는 실수
 부동소수 타입
 소수점 자리가 있는 수
 64비트 환경에서 Double은 최소 15자리 Float은 6자리 표현 가능
 */

// Float이 수용할 수 있는 범위를 넘어섭니다
// 자신이 감당할 수 있는 만큼만 남기므로 정확도가 떨어집니다
var floatValue: Float = 1234567890.1

// Double은 충분히 수용할 수 있습니다
let doubleValue: Double = 1234567890.1

print("floatValue: \(floatValue) doubleValue: \(doubleValue)")

// Float이 수용할 수 있는 범위의 수로 변경합니다
floatValue = 123456.1

// 문자열 보간법을 사용하지 않고 단순히 변수 또는 상수의 값만 보고 싶으면
// print 함수의 전달인자로 변수 또는 상수를 전달하면 됩니다
print(floatValue)


// Character
/**
 단어, 문장처럼 문자의 집합이 아닌 단 하나의 문자
 */

let alphabetA: Character = "A"
print(alphabetA)

// Character 값에 유니코드 문자를 사용할 수 있습니다
let commandCharacter: Character = "♡"
print(commandCharacter)

let 한글변수이름: Character = "ㄱ"

print("한글의 첫 자음: \(한글변수이름)")

// String
/**
 문자의 나열, 즉 문자열
 */

// 상수로 선언된 문자열은 변경이 불가능합니다
let name: String = "졔"

// 이니셜라이저를 사용하여 빈 문자열을 생성할 수 있습니다.
// var 키워드를 사용하여 변수를 생성했으므로 문자열의 수정 및 변경이 가능합니다
var introduce: String = String()

// append() 메서드를 사용하여 문자열을 이어붙일 수 있습니다
introduce.append("제 이름은")

// + 연산자를 통해서도 문자열을 이어붙일 수 있습니다
introduce = introduce + " " + name + "입니다."
print(introduce)

// name에 해당하는 문자의 수를 셀 수 있습니다
print("name의 글자 수 : \(name.count)")

// 빈 문자열인지 확인해볼 수 있습니다
print("introduce가 비어있습니까? : \(introduce.isEmpty)")

// 유니코드의 스칼라값을 사용하면 값에 해당하는 표현이 출력됩니다. - 어떤 모양이 출력되나요?
let unicodeScalarValue: String = "\u{2665}"


/*
 메소드를 통한 접두어, 접미어 확인
 prefix와 suffix
 
 hasPrefix : 문자열이 어떤 글자로 시작하는지 확인
 hasSuffix : 문자열이 어떤 글자로 끝나는지 확인
 */

let strTest = "안녕?"
if strTest.hasPrefix("안") {
    print("안으로 시작")
}

if strTest.hasSuffix("?") {
    print("?로 끝남")
}


/*
 문자열 대소문자 변경
 
 소문자로 변환 : 문자열.lowercased
 대문자로 변환 : 문자열.uppercased
 */

var userID = "Jihye0422"
print("소문자 :", userID.lowercased()) // 소문자 : jihye0422
print("대문자 :", userID.uppercased()) // 대문자 : JIHYE0422
