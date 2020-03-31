import UIKit

/**
 Maybe
 */


/**
 Either
 */


// http://www.mseri.me/implementing-either-type-in-swift/
/**
 It has been only a couple of days since Apple announced and released Swift. It has possibly been the most important and interesting announcement of Apple in the last few years and started an amount of discussions around the web.

 With the hours passing, we've found out that there was at least another Swift in the history of programming languages (with a similar icon) and that Swift is under development since 2010 and its father is Chris Lattner, creator of clang and LLVM.

 As we can read from his page, it's no surprise that people have found similarities with Rust, Haskell, Ruby, Python, Julia, and many other language. And the more I play with Swift, the happier I am of what they did. I really hope that the language will be released with an open source license as LLVM, clang and in some sense Objective-C.

 But let's come to the hearth of this post. I find abstract types and monadic construct very powerful and fun to code. And the type system in Swift, desite not being as flexible and powerful as Haskell's, gives a lot of freedom in this directon. Optionals fall exactly in this context and correspond very closely to Haskell's Maybe class.

 As you can read in Apple Inc. “The Swift Programming Language.” ebook, the optional type in Swift is nothing but synctactic sugar for the following enum
 */
/* Reimplement the Swift standard library's optional type */
enum OptionalValue<T> {
    case None
    case Some(T)
}

/**
 WhereT represents a generic type, nil is indeed syntactic sugar for OptionalValue<T>.None and ? the same for OptionalValue<T>.Some(T).

 You can then use a switch and swift pattern matching capabilities to manage the error
*/
var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

switch possibleInteger {
case .Some(let value) :
    /* just type 'value' here to see '100' appearing in playground REPL */
    print("Value is: \(value)")
case .None :
    print("Error: no value.")
}

/**
 I am not going in the realm of Monads (yet) and try to explain them, but I think that the either type could be very useful in Swift. As for the optional, we can easily define it as
 */
enum Either<T1, T2> {
    case Left(T1)
    case Right(T2)
}

/**
 As in Haskell, Either is parameterized by two types, not one. A value of the Either type either contains a value of type T1 or of type T2. With it, we can discriminate between two possibilities and using Swift pattern matching we can write a nice, clean code.

 Either can be used as a generalization of optional types in which Left not only encodes failure but is accompanied by an error message (so often T1 will be just String). Then Right encodes success and the accompanying value.

 For example
*/
var possibleInteger1: Either <String, Int> = .Left("Not a number")
var possibleInteger2: Either <String, Int> = .Right(3)

switch possibleInteger1 {
case .Left(let errorText) :
    print("Error: \(errorText)")
case .Right(let value) :
    print("The value is: \(value)")
}


switch possibleInteger2 {
case .Left(let errorText) :
    print("Error: \(errorText)")
case .Right(let value) :
    print("The value is: \(value)")
}

func safeDiv(x: Float, y: Float) -> Either <String, Float> {
    if y == 0 {
        return Either<String, Float>.Left("Error: division by zero")
    } else {
        return Either<String, Float>.Right(x/y)
    }
}

var badDivision = safeDiv(x: 2, y: 0)
print(badDivision)

/**
 In some sense you still have a kind of assert without having to stop the execution and raise and exception. This let's you control certain kind of errors or expected behaviors with much ease.

 Additionally, it would be pretty easy to use generics and typealiases to shorten sensibly the notation and clean the code above.
 */


enum Either<Value> {
    case success(Value)
    case failure(Error)
}

load { [weak self] result in
    switch result {
    case .success(let data):
        self?.render(data)
    case .failure(let error):
        self?.handle(error)
    }
}
