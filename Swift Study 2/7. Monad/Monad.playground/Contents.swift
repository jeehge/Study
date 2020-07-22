import UIKit

let numberTwo = Optional(2)

func plusOne(num: Int) -> Int {
	return num + 1
}

//plusOne(num: Optional(2)) // error

print(numberTwo.map { plusOne(num: $0)})


func checkTwo(_ num: Int) -> Int? {
	if num == 2 {
		return 2
	}
	return nil
}

print(Optional(3).flatMap(checkTwo))
print(Optional(3).map(checkTwo))
print(Optional(3).flatMap(plusOne(num:)))

let optionalArr: [Int?] = [1, 2, nil, 5]

let mappedArr: [Int?] = optionalArr.map { $0 }
let flatmappedArr: [Int] = optionalArr.flatMap { $0 }

print(mappedArr)
print(flatmappedArr)

let numbers = [1, 2, 3, 4, 5]

let mapped = numbers.map { $0 * 2 }
// [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
print(mapped)

//let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
//// [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
//print(flatMapped)

let arr = [[1, 2, 3], [4, 5, 6]]
let optinalArr = [[1, 2, 3], [nil, 4, 5, 6]]


let flatMapped = arr.flatMap {
    $0
}

print(flatMapped) // [1, 2, 3, 4, 5, 6]


let optionalFlatMapped = optinalArr.flatMap {
    $0
}

print(optionalFlatMapped) // [Optional(1), Optional(2), Optional(3), nil, Optional(4), Optional(5), Optional(6)]

let compactMapped = optinalArr.compactMap {
    $0
}

print(compactMapped)

let optinalArr2 = [[1, 2, 3], [nil, 4, 5, 6], nil]

let compactMapped2 = optinalArr2.compactMap {
    $0
}

print(compactMapped2)
