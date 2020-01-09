import UIKit

/**
 구조체와 클래스
 */

// 구조체
//struct 구조체 이름 {
//    프로퍼티와 메서드들
//}

// 클래스
//class 클래스 이름 {
//    프로퍼티와 메서드들
//}
//
//class 클래스 이름: 부모클래스 이름 {
//    프로퍼티와 메서드들
//}


//var name: Type = DefaultValue
//let name: Type = DefaultValue


// 저장 속성 프로퍼티
// 클래스
//class Person {
//    let name: String = "jihye"
//    var age: Int = 31
//}
//
//let p = Person() // 새로운 인스턴스 생성
//p.name
//p.age
//
//p.age = 30
//p.name = "New Name"


// 구조체
//struct Person {
//    let name: String = "jihye"
//    var age: Int = 31
//}
//
//var p = Person() // 새로운 인스턴스 생성
//p.name
//p.age
//
//p.age = 30


// 지연 저장 프로퍼티
//lazy var name: Type = DefaultValue


// 스탭 1
//struct Image {
//    init() {
//        print("new image")
//    }
//}
//
//struct BlogPost {
//    let title: String = "Title"
//    let content: String = "Content"
//    let attachment: Image = Image()
//}
//
//let post = BlogPost()

// 스탭2
//struct Image {
//    init() {
//        print("new image")
//    }
//}
//
//struct BlogPost {
//    let title: String = "Title"
//    let content: String = "Content"
//    lazy var attachment: Image = Image()
//}
//
//var post = BlogPost()
//post.attachment

// 스탭 3
//struct Image {
//    init() {
//        print("new image")
//    }
//}
//
//struct BlogPost {
//    let title: String = "Title"
//    let content: String = "Content"
//    lazy var attachment: Image = Image()
//
//    let date: Date = Date() // 날짜 속성을 추가해서 현재 날짜로 초기화
//
//
//    // 날짜를 문자열로 바꾸는 코드는 한줄로 표현이 어려워서 클로저를 사용
//    lazy var formattedDate: String = { // 초기값 선언
//        let f = DateFormatter()
//        f.dateStyle = .long
//        f.timeStyle = .medium
//        return f.string(from: date)
//    }()
//}
//
//var post = BlogPost()
//post.attachment
//post.date

// 연산 프로퍼티
//struct Point {
//    var x = 0.0, y = 0.0
//}
//struct Size {
//    var width = 0.0, height = 0.0
//}
//struct Rect {
//    var origin = Point()
//    var size = Size()
//    var center: Point {
//        get {
//            let centerX = origin.x + (size.width / 2)
//            let centerY = origin.y + (size.height / 2)
//            return Point(x: centerX, y: centerY)
//        }
//        set(newCenter) {
//            origin.x = newCenter.x - (size.width / 2)
//            origin.y = newCenter.y - (size.height / 2)
//        }
//    }
//}
//var square = Rect(origin: Point(x: 0.0, y: 0.0),
//    size: Size(width: 10.0, height: 10.0))
//let initialSquareCenter = square.center
//print(initialSquareCenter)
//print(square.origin)
//print(square.size)
//square.center = Point(x: 15.0, y: 15.0)
//print(square.origin)
//print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
//// prints "square.origin is now at (10.0, 10.0)"


//class SomeClass {
//    var data: Int {
//        get {
//            return data          // ERROR
//        }
//        set {
//            data = newValue      // ERROR
//        }
//    }
//}

//class StepCounter {
//    var totalSteps: Int = 0 {
//        willSet(newTotalSteps) {
//            print("About to set totalSteps to \(newTotalSteps)")
//        }
//        didSet {
//            if totalSteps > oldValue  {
//                print("Added \(totalSteps - oldValue) steps")
//            }
//        }
//    }
//}
//let stepCounter = StepCounter()
//stepCounter.totalSteps = 200
//// About to set totalSteps to 200
//// Added 200 steps
//stepCounter.totalSteps = 360
//// About to set totalSteps to 360
//// Added 160 steps
//stepCounter.totalSteps = 896
//// About to set totalSteps to 896
//// Added 536 steps

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

//class SomeClass {
//    static var storedTypeProperty = "Some value."
//    static var computedTypeProperty: Int {
//        return 27
//    }
//    static var overrideableComputedTypeProperty: Int {
//        return 107
//    }
//}
//
//class testClass: SomeClass {
//    override class var overrideableComputedTypeProperty: Int {
//        return 22
//    }
//}
//
//
//testClass.overrideableComputedTypeProperty

class Counter {
    var count = 0
    func increment() {
        count += 1
        print(count)
    }
    func increment(by amount: Int) {
        count += amount
        print(count)
    }
    func reset() {
        count = 0
        print(count)
    }
}

let counter = Counter()
// the initial counter value is 0
counter.increment()
// the counter's value is now 1
counter.increment(by: 5)
// the counter's value is now 6
counter.reset()
// the counter's value is now 0

//struct Counter {
//    var count = 0
//    mutating func increment() {
//        count+=1
//        print(count)
//    }
//    mutating func incrementBy(amount: Int) {
//        count += amount
//        print(count)
//    }
//    mutating func reset() {
//        count = 0
//        print(count)
//    }
//}
//
//var counter = Counter()
//// the initial counter value is 0
//counter.increment()
//// the counter's value is now 1
//counter.incrementBy(amount: 5)
//// the counter's value is now 6
//counter.reset()
//// the counter's value is now 0


//struct ModelInfo {
//    // MARK: - Properties
//    var seq: Int
//    var title: String
//    var content: String
//
//    // MARK: - Initialize
//    init(seq: Int, title: String, content:String) {
//        seq = seq
//        title = title
//        content = content
//    }
//}
