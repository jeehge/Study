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

/**
 Any, AnyObject, nil
 */
var serverResponseCode: Int? = 404
// serverResponseCode contains an actual Int value of 404
serverResponseCode = nil
// serverResponseCode now contains no value


/**
 타입 추론
 변수나 상수를 선언할 때 타입을 명시하지 않아도 컴파일러가 할당된 값을 기준으로 변수나 상수의 타입을 결정
 */

// 타입을 지정하지 않았으나 타입 추론을 통하여 변수 name 은 String 타입으로 선언
var myName = "졔"

// 앞서 타입 추론에 의해 name은 String 타입의 변수로 지정되었기 때문에 정수를 할당하려고 하면 오류 발생
//myName = 100 // error


// 타입 별칭

typealias MyInt = Int
typealias YourInt = Int
typealias MyDouble = Double

let age: MyInt = 100
var year: YourInt = 2019

// 둘 다 Int의 별칭이기 때문에 같은 타입으로 취급
year = age

// 튜플

// Int, String 타입을 갖는 튜플
var array: (index: Int, value: String) = (0, "value")

// 인덱스를 통해서 값을 빼 올 수 있음
print("index: \(array.0), value: \(array.1)")

// 인덱스를 통해 값을 할당할 수 있음
array.0 = 1
array.1 = "value1"

print("index: \(array.0), value: \(array.1)")

array.index = 2
array.value = "value2"

print("index: \(array.index), value: \(array.value)")


// 배열

/**
 배열을 선언하는 다양한 방법
 */

// 대괄호를 사용하여 배열임을 표현
var array1: Array<String> = ["Right","Left","Up","Down"]

// 위 선언과 정확히 동일한 표현
var array1_1: [String] = ["Right","Left","Up","Down"]

// 빈 배열 선언 방법
var array2 = Array<String>()
var array3 : Array<String> = Array()
var array4 = [String]()
var array5 : [String] = []
var array6 : Array<String> = [String]()
var array7 : [String] = Array()

// 배열의 타입을 정확히 명시해줬다면 []만으로도 빈 배열을 생성할 수 있음
var emptyArray: [String] = []
print(emptyArray.isEmpty)
print(array2.count)

/**
 배열 접근
 */
// An array of 'Int' elements
let oddNumbers = [1, 3, 5, 7, 9, 11, 13, 15]

// Shortened forms are preferred
var emptyDoubles: [Double] = []

var digitCounts = Array(repeating: 0, count: 10)
print(digitCounts)
// Prints "[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]"

if let firstElement = oddNumbers.first, let lastElement = oddNumbers.last {
    print(firstElement, lastElement, separator: ", ")
}
// Prints "1, 15"

print(emptyDoubles.first, emptyDoubles.last, separator: ", ")
// Prints "nil, nil"

print(oddNumbers[0], oddNumbers[3], separator: ", ")
// Prints "1, 7"

//print(emptyDoubles[0]) // error
// Triggers runtime error: Index out of range

/**
 배열 요소 추가 삭제
 */

var students = ["A", "B", "C"]

students.append("D")
students.append(contentsOf: ["E", "F"])
// ["A", "B", "C", "D", "E", "F"]

students.insert("C&D", at: 3)
// ["A", "B", "C", "C&D", "D", "E", "F"]

students.remove(at: 0)
// ["B", "C", "C&D", "D", "E", "F"]

students.removeLast()
// ["B", "C", "C&D", "D", "E"]

if let i = students.firstIndex(of: "D") {
    students[i] = "Max"
}
// ["B", "C", "C&D", "Max", "E"]

/**
 딕셔너리
 */

// 빈 딕셔너리 생성
var namesOfIntegers = [Int: String]()

// 딕셔너리를 생성하는 다른 방법
var namesOfIntegers2: [Int: String] = [:]
var namesOfIntegers3: Dictionary = [Int:String]()
var namesOfIntegers4: Dictionary<Int, String> = Dictionary<Int, String>()

namesOfIntegers[16] = "sixteen"
// namesOfIntegers now contains 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]

// 딕셔너리 접근 및 수정
var airports: [String: String] = ["YYZ": "토론토 피어슨", "DUB": "더블린"]
print("The airports dictionary contains \(airports.count) items.")
// Prints "The airports dictionary contains 2 items."

// isEmpty 프로퍼티 - count 속성이 0인지 확인
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}
// Prints "The airports dictionary is not empty."


// 딕셔너리에 새로운 키를 사용하여 값을 추가할 수 있음
airports["LHR"] = "런던"
// the airports dictionary now contains 3 items

airports["LHR"] = "런던 히드로"


// updateValue (_ : forKey :) 메서드는 키가 없으면 키 값을 설정하거나 해당 키가 이미 있으면 값을 업데이트
// updateValue (_ : forKey :) 메서드는 업데이트를 수행한 후 이전 값을 반환
if let oldValue = airports.updateValue("더블린 공항", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// Prints "The old value for DUB was 더블린."


airports["APL"] = "애플 인터네셔널"

// airports에서 "APL"을 제거
airports["APL"] = nil


// 또는 removeValue (forKey :) 메소드를 사용하여 사전에서 키-값 쌍을 제거
// 이 메소드는 키-값 쌍이 존재하는 경우이를 제거하고 제거 된 값을 리턴하거나 값이 존재하지 않으면 nil을 리턴
if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}
// Prints "The removed airport's name is Dublin Airport."

print(airports)


// 딕셔너리 반복
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
// LHR: 런던 히드로
// YYZ: 토론토 피어슨

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: LHR
// Airport code: YYZ

for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: 런던 히드로
// Airport name: 토론토 피어슨

/**
 Set
 */

// set 생성
var letters = Set<Character>()
var letters2: Set<Character> = []

// letters는 Character 타입 값 한개를 포함
letters.insert("a")

// letters는 이제 빈 세트이지만 여전히 Set<Character> 유형
letters = []

// “문자열 값 집합”으로 선언되며 Set<String>
// String 타입으로 문자열만 저장 가능
// "락", "클래식", "힙합"으로 초기화됨
var favoriteGenres: Set<String> = ["락", "클래식", "힙합"]

/**
 Set은 타입을 명시적으로 선언해주지 않으면 배열로 인식됨
 */
var favoriteGenres2: Set = ["락", "클래식", "힙합"]

// set 접근 및 수정

// set의 항목 수를 확인
print("I have \(favoriteGenres.count) favorite music genres.")
// Prints "I have 3 favorite music genres."

// isEmpty 프로퍼티 - count 속성이 0인지 확인
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
// Prints "I have particular music preferences."

// insert (_ :) 메소드를 호출하여 세트에 새 항목을 추가
favoriteGenres.insert("재즈")

// remove (_ :) 메소드를 호출하여 Set에서 아이템을 제거
// removeAll () 메소드로 Set의 모든 항목 제거
// Set의 멤버 인 경우 아이템을 제거하고 제거 된 값을 반환하거나 세트에 포함되지 않은 경우 nil을 반환
if let removedGenre = favoriteGenres.remove("락") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
// Prints "락? I'm over it."

// contains (_ :) 메소드 Set에 특정 항목이 포함되어 있는지 확인
if favoriteGenres.contains("펑크") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// Prints "It's too funky in here."

// Set 반복
for genre in favoriteGenres {
    print("\(genre)")
}
// 재즈
// 클래식
// 힙합

for genre in favoriteGenres.sorted() {
    print("\(genre)")
}
// 재즈
// 클래식
// 힙합

// 열거형

//enum School {
//    case primary        // 유치원
//    case elementary     // 초등
//    case middle         // 중등
//    case high           // 고등
//    case college        // 대학
//    case university     // 대학교
//    case graduate       // 대학원
//}
//
//// School 열거형 변수의 생성 및 값 변경
//var enumValue1: School = School.university
//
//var enumValue2: School = .university
//
//enumValue1 = .graduate

enum School: String {
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    case graduate = "대학원"
}

let education: School = .university
print("저의 최종 학력은 \(education.rawValue) 졸업입니다.")


//enum School: String {
//    case primary = "유치원"
//    case elementary = "초등학교"
//    case middle = "중학교"
//    case high = "고등학교"
//    case college = "대학"
//    case university
//    case graduate
//}
//
//let education: School = .university
//print("저의 최종 학력은 \(education.rawValue) 졸업입니다.")

enum Numbers: Int {
    case zero
    case one
    case two
    case ten = 10
}

print(Numbers.zero.rawValue)
print(Numbers.one.rawValue)
print(Numbers.two.rawValue)
print(Numbers.ten.rawValue)


enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dinner: MainDish = .pasta(taste: "크림")
dinner = .pizza(dough: "치즈크러스트", topping: "불고기")
dinner = .chicken(withSauce: true)
dinner = .rice

// 특정 항목에 순환 열거형 항목 명시
enum ArithmeticExpression1 {
    case number(Int)
    indirect case addition(ArithmeticExpression1, ArithmeticExpression1)
    indirect case multiplication(ArithmeticExpression1, ArithmeticExpression1)
}

// 열거형 전체에 순환 열거형 명시
indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

let five = ArithmeticExpression2.number(5)
let four = ArithmeticExpression2.number(4)
let sum = ArithmeticExpression2.addition(five, four)
let final = ArithmeticExpression2.multiplication(sum, ArithmeticExpression2.number(2))

func evaluate(_ expression: ArithmeticExpression2) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

let result: Int = evaluate(final)
print("(5 + 4) * 2 = \(result)")

