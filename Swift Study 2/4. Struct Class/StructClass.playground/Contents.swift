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


let numberDictionary = [1: "one", 2: "two", 3: "three"]

for (key, value) in numberDictionary {
    print("\(key) is the \(value)")
}


// 일단 사용자 정의 구조체 UserData를 정의합니다.
struct UserData {
    var intValue: Int       = 0
    var strValue: String    = ""
}

/*
대입연산에 의해 즉각적으로 프로퍼티 복사가 발생하는 것을 막기 위해
참조타입인 Class를 이용해 UserData를 한번 wrapping 해줄 필요가 있습니다.
또한, UserData말고도 다른 타입에 대해 범용적으로 활용할 수 있도록
Generic(<T>)으로 데이터타입에 대한 유연성을 부여해줍니다.
*/
class DataWrapper<T> {
    var data: T

    init(data: T) {
      self.data = data
    }
}

/*
  DataWrapper를 제어해줄 CowData 구조체를 선언합니다.
*/
struct CowData<T> {
    // Data Wrapper
    private var dataWrapper: DataWrapper<T>
    init(data: T) {
        self.dataWrapper = DataWrapper(data: data)
    }
    
    var data: T {
        get {
            return self.dataWrapper.data
        }
        set {
            if !isKnownUniquelyReferenced(&self.dataWrapper) {
                // dataWrapper에 대한 참조가 Uniquely하지 않으면 새로운 Wrapper를 생성하여 값을 대입해줍니다.
                self.dataWrapper = DataWrapper(data: newValue)
            } else {
                // dataWrapper에 대한 참조가 Uniquely하다면 기존 Wrapper에 대해서 struct 값을 대입해줍니다.
                self.dataWrapper.data = newValue
            }
        }
    }
}

var cowData1 = CowData(data: UserData())
cowData1.data.strValue = "i'm UserData1"

// cowData2의 dataWrapper는 cowData1와 동일한 참조를 가지게 됩니다.
var cowData2 = cowData1

print("!! cowData2의 dataWrapper는 cowData1와 동일한 참조를 가지고 있습니다.")
print("cowData1.data.strValue: \(cowData1.data.strValue)")
print("cowData2.data.strValue: \(cowData2.data.strValue)\n")

 // cowData2의 dataWrapper가 새로운 struct값과 함께 새롭게 할당됩니다.
cowData2.data.strValue = "i'm UserData2"

print("!! cowData2의 dataWrapper는 cowData1와 다른 참조를 가지고 있습니다.")
print("cowData1.data.strValue: \(cowData1.data.strValue)")
print("cowData2.data.strValue: \(cowData2.data.strValue)\n")


func print(address o: UnsafeRawPointer) {
    print(String(format: "%p", Int(bitPattern: o)))
}

var array1: [Int] = [0, 1, 2, 3]
var array2 = array1

print(address: array1)
print(address: array2)

array2.append(4)

print(address: array2)
