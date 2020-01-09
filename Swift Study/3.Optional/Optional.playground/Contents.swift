import UIKit

/**
 함수
 */

func introduction(name: String) -> String {
    return "Hello, My name is \(name)"
}

let selfIntroduction: String = introduction(name: "jihye")
print(selfIntroduction)


func introduction(_ name: String, _ age: Int) -> String {
    return "Hello, My name is \(name).\n I am \(age) years old."
}

print(introduction("jihye", 30))

/**
 옵셔널
 */

//var someInt: Int = 10
//var someInt: Int? = nil



// nil은 String 타입에 할당될 수 없다
var someValue1: String = "Hello world!"
//someValue1 = nil    // 컴파일 에러

/**
 변수 안에 값이 확실이 있다는 것을 보장해 줄 수 없을 때 Optional을 사용한다
 */

var someValue2: String? = "hello world!"
someValue2 = nil

/**
 someValue2는 String 데이터 타입을 가질 수도 있고 안가질 수도 있다는 의미
 */


// 값이 있을 수도 있고 없을 수도 있는 변수를 정의할 때는 '?'를 붙여줍니다
var name: String?
print(name)     // nil

name = "jihye"
print(name)     // Optional("jihye")


// 옵셔널로 정의한 변수는 옵셔널이 아닌 변수와 다릅니다
let optionalName: String? = "jihye"
//var requiredName: String = optionalName // 컴파일 에러
var requiredName: String = optionalName! // !를 붙여주면 에러가 나지 않는다



func getIntroduction(item: String) -> String? {
    if (item == "name") {
       return "권지혜 입니다"
    }
    return nil
}

var introduction: String? = getIntroduction(item: "age")
let text = "저는 "
var message = text + introduction!  // compile-time error
print(message)

//var message: String = ""
//if introduction != nil {
//    message = text + introduction!
//} else {
//    message = "age is nil"
//}
//print(message)


/**
 옵셔널 바인딩
 옵셔널 값을 가져오고 싶을 때 사용
 */

if let name = optionalName {
    print(name)     // 값이 존재한다면 출력
} else {
    // 존재하지 않는다면 이 부분 실행
}


//if let strIntroduction = introduction {
//    message = text + strIntroduction
//    print(message)
//} else {
//    print("존재 하지 않는 항목입니다")
//}





