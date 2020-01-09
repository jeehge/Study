import UIKit

/**
 Error Handling
 */

enum VendingMachineError: Error {
    case invalidSelection // 유효하지 않은 선택
    case insufficientFunds(coinsNeeded: Int) // 자금부족 - 필요한 동전 개수
    case outOfStock // - 품절
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventoruy = [
        "Candy Bar" : Item(price: 12, count: 7),
        "Chips" : Item(price: 10, count: 4),
        "Biscuit" : Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispense(snack: String) {
        print("\(snack) 제공")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = inventoruy[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        self.coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        self.inventoruy[name] = newItem
        
        dispense(snack: name)
    }
}

let favoriteSnacks = [
    "yagom" : "Chips",
    "jinsung" : "Biscuit",
    "heejin" : "Chocolate"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

//let machine: VendingMachine = VendingMachine()
//machine.coinsDeposited = 30
//
//var purchase: PurchasedSnack = try PurchasedSnack(name: "Biscuit", vendingMachine: machine)
//print(purchase.name)
//
//for (person, favoriteSnack) in favoriteSnacks {
//    print(person, favoriteSnack)
//    try buyFavoriteSnack(person: person, vendingMachine: machine)
//}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Invalid selection, out of stock, or not enough money.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}
// Prints "Invalid selection, out of stock, or not enough money."

//func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
//    if shouldThrowError {
//        enum SomeError: Error {
//            case justSomeError
//        }
//
//        throw SomeError.justSomeError
//    }
//
//    return 100
//}
//
//let y: Int = try! someThrowingFunction(shouldThrowError: false)
//print(y)
//
//let x: Int = try! someThrowingFunction(shouldThrowError: true) // 런타임 오류


func someThrowingFunction() throws {
    enum SomeError: Error {
        case justSomeError
    }

    throw SomeError.justSomeError
}

func someFunction(callback: () throws -> Void) rethrows {
//    try callback()

    enum AnotherError: Error {
        case justAnotherError
    }

    do {
        // 매개변수로 전달할 오류 던지기 함수이므로
        // catch 절에서 제어할 수 있습니다
        try callback()
    } catch {
        throw AnotherError.justAnotherError
    }

    do {
        // 매개변수로 전달한 오류 던지기 함수가 아니므로
        // catch 절에서 제어할 수 없습니다
        try someThrowingFunction()
    } catch {
        // 오류 발생
//        throw AnotherError.justAnotherError
    }

    // catch 절 외부에서 단독으로 오류를 던질 수는 없습니다. 오류 발생
//    throw AnotherError.justAnotherError
}

do {
    try someFunction(callback: someThrowingFunction)
} catch {
    print(error)
}

protocol SomeProtocol {
    func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws
    func someRethrowingFunctionFromProtocol(callback: () throws -> Void) rethrows
}

class SomeClass: SomeProtocol {
    func someThrowingFunction(callback: () throws -> Void) throws { }
    func someFunction(callback: () throws -> Void) rethrows { }
    
    func someRethrowingFunctionFromProtocol(callback: () throws -> Void) rethrows {
        
    }
    
    func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws {
        
    }
}

class someChildClass: SomeClass {
    override func someThrowingFunction(callback: () throws -> Void) throws {
        
    }
    
    override func someFunction(callback: () throws -> Void) rethrows {
        //
    }
}

for i in 0...2 {
    defer {
        print("A", separator: "", terminator: " ")
    }
    print(i, separator: "", terminator: " ")
    
    if i % 2 == 0 {
        defer {
            print("", separator: "", terminator: "\n")
        }
        
        print("It's event", separator: "", terminator: " ")
    }
}

func someFunction() {
    defer{ print("4")}
    print("2")
    print("3")
}

print("1")
someFunction()
print("5")
