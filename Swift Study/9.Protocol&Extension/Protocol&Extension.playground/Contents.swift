import UIKit

/**
 프로토콜
 */

protocol ProtocolName {
    // 프로토콜 정의
}

protocol Coffee {
    func making()
}

protocol Cafe: Coffee {
    func sale()
}

protocol Restaurant: Coffee {
    func service()
}

class MyShop: Cafe {
    func sale() {
        print("커피를 판매하다")
    }
    
    func making() {
        print("커피를 만들다")
    }
}


///

protocol SomeProtocol {
    var someText: String { get }
}

protocol AnotherProtocol {
    var anotherText: String { get}
}

struct SomeStruct: SomeProtocol, AnotherProtocol {
    var someText: String
    var anotherText: String
}

class SomeClass: SomeProtocol {
    var someText: String
    
    init(someText: String) {
        self.someText = someText
    }
}

class AnotherClass: SomeClass, AnotherProtocol {
    var anotherText: String
    
    init(someText: String, anotherText: String) {
        self.anotherText = anotherText
        super.init(someText: someText)
    }
}

func printProtocol(to some: SomeProtocol & AnotherProtocol) {
    print("text : \(some.someText) \(some.anotherText)")
}


let test1: SomeStruct = SomeStruct(someText: "some", anotherText: "another")
printProtocol(to: test1)

let test2: SomeClass = SomeClass(someText: "some")
//printProtocol(to: test2) // Error!

//var someVariable1: SomeClass & AnotherClass & AnotherProtocol // Error!

var someVariable2: SomeClass & AnotherProtocol

someVariable2 = AnotherClass(someText: "some", anotherText: "another")

//someVariable2 = test2 // Error!


/////



print(test1 is SomeProtocol)
print(test1 is AnotherProtocol)

print(test2 is SomeProtocol)
print(test2 is AnotherProtocol)


if let instance: SomeProtocol = test1 as? SomeProtocol {
    print("\(instance) is SomeProtocol")
}

if let instance: AnotherProtocol = test1 as? AnotherProtocol {
    print("\(instance) is AnotherProtocol")
}

if let instance: SomeProtocol = test2 as? SomeProtocol {
    print("\(instance) is SomeProtocol")
}

if let instance: AnotherProtocol = test2 as? AnotherProtocol {
    print("\(instance) is AnotherProtocol")
}


////

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed"
print(john.fullName)

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"
print(ncc1701.fullName)


protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"


protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}


var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on



@objc protocol Moveable {
    func walk()
    @objc optional func fly()
}

class Dog: NSObject, Moveable {
    func walk() {
        print("Dog walks")
    }
}

class Bird: NSObject, Moveable {
    func walk() {
        print("Bird walks")
    }
    
    func fly() {
        print("Bird flys")
    }
}

let dog: Dog = Dog()
let bird: Bird = Bird()

dog.walk()
bird.walk()
bird.fly()

var instane: Moveable = dog
instane.fly?()

instane = bird
instane.fly?()


class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


//extension 확장할 타입 이름 {
//    // 타입에 추가될 새로운 기능 구현
//}

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
   size: Size(width: 5.0, height: 5.0))


extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]
// returns 7
746381295[10]


Array

Dictionary
