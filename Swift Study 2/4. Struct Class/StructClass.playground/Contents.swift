import UIKit

/**
 구조체
 */

struct User {
    var id: String
    var level: Int
}


//var user: User = User()
var userVar: User = User(id: "jihye", level: 100)
userVar.id = "jeehye"  // 변경 가능
userVar.level = 201    // 변경 가능

//let userLet: User = User(id: "jihye", level: 100)
//userLet.id = "jeehye"  // 변경 불가! 오류!
//userLet.level = 202    // 변경 불가!
           
/**
 클래스
 */

class Person {
    var name: String = ""
    
    deinit {
        print("Person 클래스의 인스턴스가 소멸됩니다")
    }
}

var personVar: Person = Person()
personVar.name = "졔"

let personLet: Person = Person()
personVar.name = "졔"

var person: Person? = Person()
person = nil


let user1 = User(id: "id01", level: 1)
var user2 = user1

user2.id = "id02"

print(user1)
print(user2)


enum 나침반 {
    case 동, 서, 남, 북
}
var 현재위치 = 나침반.서
let 기억위치 = 현재위치
현재위치 = .동
if 기억위치 == .서 {
    print("기억된 방향은 서쪽입니다 :)")
}

let person1: Person = Person()
person1.name = "졔"

let person2 = person1
person2.name = "민"

print(person1.name)
print(person2.name)

if person1 === person2 {
    print("동일한 인스턴스입니다")
}


