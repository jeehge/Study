import UIKit

protocol 날수있는 {
    var 날개있습니까: Bool { get set }

	func 날다(이름: String)
}

extension 날수있는 {
	func 날다(이름: String) {
		print("\(이름) 날아 다닙니다")
	}
}

struct 사람: 날수있는 {
    var 날개있습니까: Bool
    var 이름: String
}

struct 새: 날수있는 {
    var 날개있습니까: Bool
}



let items: Array<Int> = [1, 2, 3]

let mappedItems: Array<Int> = items.map { (item: Int) -> Int in
	return item * 10
}

print(mappedItems)

struct Stack<Element> {
	typealias ItemType = Element
	
    var items = [Element]()
   
	mutating func push(_ item: Element) {
        items.append(item)
    }
    
	mutating func pop() -> Element {
        return items.removeLast()
    }
	
	func map<T>(transform: (Element) -> T) -> Stack<T> {
        var transformedStack: Stack<T> = Stack<T>()

        for item in items {
            transformedStack.items.append(transform(item))
        }

        return transformedStack
    }
	
	func filter(includeElement: (Element) -> Bool) -> Stack<Element> {
		var filteredStack: Stack<ItemType> = Stack<ItemType>()

		for item in items {
			if includeElement(item) {
				filteredStack.items.append(item)
			}
		}

		return filteredStack
	}
    
	func reduce<T>(_ initial: T, combine: (T, Element) -> T) -> T {
		var result: T = initial
		
		for item in items {
			result = combine(result, item)
		}
		
		return result
	}
}

var myStack: Stack<Int> = Stack<Int>()
myStack.push(2)
myStack.push(7)
myStack.push(1)
print(myStack)
var myStrStack: Stack<String> = myStack.map { "\($0)" }
print(myStrStack)

let filteredStack: Stack<Int> = myStack.filter { $0 < 5 }
print(filteredStack)

let combinedInt: Int = myStack.reduce(100) { $0 + $1 }
print(combinedInt)

let combinedDouble: Double = myStack.reduce(100.0) { $0 + Double($1) }
print(combinedDouble)

let combinedString: String = myStack.reduce("") { $0 + "\($1) " }
print(combinedString)





protocol SelfPrintable {
    func printSelf()
}

extension SelfPrintable {
    func printSelf() {
        print(self)
    }
}

extension Int: SelfPrintable { }
extension Double: SelfPrintable { }
extension String: SelfPrintable { }

1024.printSelf()
"Hello Swift".printSelf()
3.14.printSelf()

