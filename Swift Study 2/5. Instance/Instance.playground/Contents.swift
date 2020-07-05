import UIKit

//struct User {
//    var id: String
//    var level: Int
//
//    init() {
//        id = "test01"
//        level = 1
//    }
//}
//
//let user: User = User()
//print(user)



//
//struct User {
//    var id: String
//    var level: Int
//}
//
//let user01: User = User(id: "id01", level: 1)
//print(user01)
//
//
//let user02: User = User(id: "test02", level: 2)
//print(user02)


struct SomeStruct {
    init(intValue: Int) {
        print("Int Value: \(intValue)")
    }
    
    init(stringValue: String) {
        print("String Value: \(stringValue)")
    }
    
    init(doubleValue: Double) {
        print("Double Value: \(doubleValue)")
    }
}

let someInt: SomeStruct = SomeStruct(intValue: 2)
let someString: SomeStruct = SomeStruct(stringValue: "test")
let someDouble: SomeStruct = SomeStruct(doubleValue: 3.14)

//class Person {
//    let name: String
//    var age: Int?
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//let jihye: Person = Person(name: "jihye")
//jihye.name = "지혜" // error

/**
 Double 타입의 x와 y를 갖고 있는 Point
 x와 y 는 0.0 초깃값 설정
 */
struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
}

/**
Double 타입의 width와 height를 갖고 있는 Size
width 와 height 는 0.0 초깃값 설정
*/
struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let rect = Rect()
print(rect)

let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 10.0, height: 10.0))
print(originRect)

let centerRect = Rect(center: Point(x: 5.0, y: 5.0),
                      size: Size(width: 10.0, height: 10.0))
print(centerRect)


class Person {
    var name: String

    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        
        self.name = name
    }
}

let test01: Person? = Person(name: "jihye")

if let j: Person = test01 {
    print(j.name)
} else {
    print("초기화 되지 않음")
}

let test02: Person? = Person(name: "")

if let j: Person = test02 {
    print(j.name)
} else {
    print("초기화 되지 않음")
}


//enum TemperatureUnit {
//    case kelvin, celsius, fahrenheit
//    init?(symbol: Character) {
//        switch symbol {
//        case "K":
//            self = .kelvin      // 절대온도
//        case "C":
//            self = .celsius     // 섭씨
//        case "F":
//            self = .fahrenheit  // 화씨
//        default:
//            return nil
//        }
//    }
//}
//
//let fahrenheitUnit = TemperatureUnit(symbol: "F")
//if fahrenheitUnit != nil {
//    print("초기화 성공")
//}
//
//let unknownUnit = TemperatureUnit(symbol: "X")
//if unknownUnit == nil {
//    print("초기화 실패")
//}

enum TemperatureUnit: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
    print("초기화 성공")
}
// Prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(rawValue: "X")
if unknownUnit == nil {
    print("초기화 실패")
}
// Prints "This is not a defined temperature unit, so initialization failed."


//class SomeClass {
//    let someProperty: SomeType = {
//        // create a default value for someProperty inside this closure
//        // someValue must be of the same type as SomeType
//        return someValue
//    }()
//}
