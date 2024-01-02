### 5. Intermediate async/await & CheckedContinuation
async/await & CheckedContinuation 중간

In the previous chapter, you worked through creating custom asynchronous sequences. At this point, you should already feel right at home when it comes to using `AsyncSequence` and `AsyncStream`.

이전 장에서는 커스텀 비동기 시퀀스를 작성하는 작업을 했습니다. 이쯤 되면  `AsyncSequence` 와 `AsyncStream` 을 사용하면 마음이 편해질 것입니다. 

You saw that wrapping existing APIs, like `NotificationCenter`, is very powerful, letting you reuse your tried-and-tested code in your modern `async`/`await` codebase.
`NotificationCenter` 와 같은 기존 API를 래핑하는 것은 매우 강력하며, 현재 사용 중인 `async`/`await` 코드베이스에서 시도해보고 테스트한 코드를 재사용할 수 있습니다.

In this chapter, you’ll continue working in the same direction. You’ll look into more ways to reuse existing code to the fullest by leveraging Swift’s superpowered concurrency features.

이 장에서는 같은 방향으로 계속 작업을 진행할 것입니다. 스위프트의 강력한 동시성 기능을 활용하여 기존 코드를 최대한 활용하는 방법에 대해 더 자세히 알아볼 것입니다.

### Introducing Continuations

Continuation을 소개

Two patterns of asynchronous programming have dominated Apple platforms for a long time: callbacks and the delegate pattern. With completion callbacks, you pass in a closure that executes when the work completes. With the delegate pattern, you create a delegate object, then call certain methods on it when work progresses or completes:

비동기 프로그래밍의 두 가지 패턴, 즉 콜백과 Delegate pattern 이 오랫동안 Apple 플랫폼을 지배해 왔습니다. completion callback을 사용하면 작업이 완료될 때 실행되는 클로저를 전달됩니다. delegate pattern을 사용하면 delegate 개체를 만든 다음 작업이 진행되거나 완료될 때 해당 개체에 대해 특정 메소드를 호출합니다.:

To encourage the new concurrency model’s adoption, Apple designed a minimal but powerful API that comes in handy when bridging existing code. It centers around the concept of a **continuation**.
애플은 새로운 컨커런시 모델의 채택을 장려하기 위해 기존 코드를 연결할 때 유용하게 사용할 수 있는 최소한이지만 강력한 API를 설계햇습니다. 이는 **continuation** 이라는 개념을 중심으로 합니다.

A continuation is an object that tracks a program’s state at a given point. The Swift concurrency model assigns each asynchronous unit of work a continuation instead of creating an entire thread for it. This allows the concurrency model to scale your work more effectively based on the capabilities of the hardware. It creates only as many threads as there are available CPU cores, and it switches between continuations instead of between threads, making the execution more efficient.

continuation 은 주어진 지점에서 프로그램의 상태를 추적하는 개체입니다. Swift 동시성 모델은 전체 스레드를 생성하는 대신 각 비동기 작업 단위를 연속으로 할당합니다. 이를 통해 동시성 모델은 하드웨어 기능에 따라 작업을 보다 효과적으로 확장할 수 있습니다.  사용 가능한 CPU 코어 수만큼만 스레드를 생성하고 스레드 간이 아닌continuation 간을 전환하여 실행을 더욱 효율적으로 만듭니다. 

You’re familiar with how an `await` call works: Your current code **suspends** execution and hands the thread and system resources over to the central handler, which decides what to do next.

 `await`  호출이 어떻게 작동하는지 잘 알고 있습니다. 현재 코드는 실행을 일시 중단하고 스레드와 시스템 리소스를 중앙 핸들러에 전달하여 다음에 수행할 작업을 결정합니다.

When the awaited function completes, your original code resumes, as long as no higher priority tasks are pending. But how?

대기 중인 함수가 완료되면 우선 순위가 더 높은 작업이 보류되지 않는 한 원래 코드가 다시 시작됩니다. 하지만 어떻게?

When the original code suspends, it creates a continuation that represents the entire captured state at the point of suspension. When it’s time to resume execution or throw, the concurrency system recreates the state from the continuation and the work… well, *continues*.

원본 코드가 일시 중단되면 일시 중단 시점에서 캡처된 전체 상태를 나타내는 연속이 생성됩니다. 실행을 재개하거나 던질 시간이 되면 동시성 시스템은 연속에서 상태를 다시 생성하고 작업은 … 음, 계속됩니다.

This all happens behind the scenes when you use `async` functions. You can also create continuations yourself, which you can use to extend existing code that uses callbacks or delegates. These APIs can benefit from using `await` as well.

이 모든 것은 `async` 함수를 사용할 때 발생합니다. 콜백이나 delegate 를 사용하는 기존 코드를 확장하는데 사용할 수 있는 연속을 직접 만들 수도 있습니다. 이러한 `async` API를 사용하면 이점도 얻을 수 있습니다.

Manually creating continuations allows you to migrate your existing code gradually to the new concurrency model.

continuation 을 수동으로 생성하면 기존 코드를 새로운 동시성 모델로 점진적으로 마이그레이션할 수 있습니다.
