import UIKit

/**
 서브스크립트
 */

//subscript(index: Int) -> Int {
//    get {
//        // 적절한 서브스크립트 결과값 반환
//    }
//
//    set(newValue) {
//        // 적절한 설정자 역할 수행
//    }
//}

struct Student {
    var name: String
    var number: Int
}

class School {
    var number: Int = 0
    var students: [Student] = []
    
    func addStudent(name: String) {
        let student: Student = Student(name: name, number: self.number)
        self.students.append(student)
        self.number += 1
    }
    
    func addStudents(names: String...) {
        for name in names {
            self.addStudent(name: name)
        }
    }
    
    subscript(index: Int) -> Student? {
        if index < self.number {
            return self.students[index]
        }
        return nil
    }
    
}

let highSchool: School = School()
highSchool.addStudents(names: "MiJeong", "Juhyun", "JiYoung", "SeongUk", "MoonDuk")

let aStudent: Student? = highSchool[1]
print("\(aStudent?.number) \(aStudent?.name)")


struct SomeStruct {
    subscript(index: Int) -> Int {
        return index * 2
    }
}

var someStruct = SomeStruct()
someStruct[5]
someStruct[50]


struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
            //Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2


struct OperationStruct {
   let decrementer: Int
   subscript(index: Int) -> Int {
      return decrementer / index
   }
}
let division = OperationStruct(decrementer: 100)

print("The number is divisible by \(division[9]) times")
print("The number is divisible by \(division[2]) times")
print("The number is divisible by \(division[3]) times")
print("The number is divisible by \(division[5]) times")
print("The number is divisible by \(division[7]) times")


class DaysOfWeek {
   private var days = ["Sunday", "Monday", "Tuesday", "Wednesday",
      "Thursday", "Friday", "Saturday"]
   subscript(index: Int) -> String {
      get {
         return days[index]
      }
      set {
         self.days[index] = newValue
      }
   }
}
var p = DaysOfWeek()

print(p[0])
print(p[1])
print(p[5])
print(p[6])
