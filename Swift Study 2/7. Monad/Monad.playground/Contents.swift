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
