import UIKit
import RxSwift

// Ignore
//let strikes = PublishSubject<String>()
//
//let disposeBag = DisposeBag()
//
//strikes
//.ignoreElements()
//    .subscribe { _ in
//        print("[Subscription is called]")
//}.disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C")
//
//strikes.onCompleted()

//let strikes = PublishSubject<String>()
//let disposeBag = DisposeBag()
//
//strikes.elementAt(0)
//    .subscribe(onNext: { _ in
//        print("You are out!")
//    }).disposed(by: disposeBag)
//
//strikes.onNext("X")
//strikes.onNext("X")
//strikes.onNext("X")

// Element At
//let strikes = PublishSubject<String>()
//
//let disposeBag = DisposeBag()
//
//strikes.elementAt(2)
//    .subscribe(onNext: { _ in
//        print("You are out!")
//    }).disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C")

// Filter

//let disposeBag = DisposeBag()
//
//Observable.of(1,2,3,4,5,6,7)
//    .filter { $0 % 2 == 0}
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

// skip

//let disposeBag = DisposeBag()
//
//Observable.of("A", "B", "C", "D", "E", "F")
//    .skip(3)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)


// skipWhile

//let disposeBag = DisposeBag()
//
//Observable.of(2,2,3,4,4)
//    .skipWhile { $0 % 2 == 0}
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)


// skipUntil

//let disposeBag = DisposeBag()
//
//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject.skipUntil(trigger)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//subject.onNext("A")
//subject.onNext("B")
//
//trigger.onNext("X")
//
//subject.onNext("C")

// take

//let disposeBag = DisposeBag()
//
//Observable.of(1,2,3,4,5,6)
//    .take(3)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

// take while

//let disposeBag = DisposeBag()
//
//Observable.of(2,4,6,7,8,10)
//    .takeWhile {
//        return $0 % 2 == 0
//    }.subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)


// take until

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.takeUntil(trigger)
    .subscribe(onNext: {
         print($0)
    }).disposed(by: disposeBag)

subject.onNext("1")
subject.onNext("2")

trigger.onNext("X")

subject.onNext("3")
