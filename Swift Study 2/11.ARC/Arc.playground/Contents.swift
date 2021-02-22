import UIKit

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) 초기화 중")
    }
	
	var room: Room?
	
    deinit {
        print("\(name) 초기화 해제중")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "졔")
// Prints "졔 초기화 중"

reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil
// Prints "졔 초기화 해제중"

var globalReference: Person?

func foo1() {
	let person = Person(name: "졔 foo1")
}

func foo2() {
	let person = Person(name: "졔 foo2")
	
	globalReference = person
}

foo1()
foo2()

class Room {
	let number: String
	
	init(number: String) {
		self.number = number
	}
	
	weak var host: Person?
	
	deinit {
        print("Room \(number) 초기화 해제중")
    }
}
