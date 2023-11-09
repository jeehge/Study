### **2. Getting Started With async/await**
async/await 시작

Now that you know what Swift Concurrency is and why you should use it, you’ll spend this chapter diving deeper into the actual `async`/`await` syntax and how it coordinates asynchronous execution.
스위프트 컨커런시가 무엇이고 왜 사용해야 하는지 알았으므로, 이 장에서는 실제 async/await 문법과 비동기 실행을 어떻게 동작하는지에 대해 자세히 알아보겠습니다.

You’ll also learn about the `Task` type and how to use it to create new asynchronous execution contexts.
Task 타입과 새로운 비동기 동작 컨텍스트를 만드는데 사용하는 방법에 대해서도 배울 것 입니다.

Before that, though, you’ll spend a moment learning about pre-Swift 5.5 concurrency as opposed to the new `async`/`await` syntax.
그러나 그 전에 새로운 `async`/`await` 문법이 아닌 스위프트 5.5 이전의 동시성에 대해 잠시 배우게 됩니다.

### **Pre-async/await asynchrony**
사전 async/await 비동기

Up until Swift 5.5, writing asynchronous code had many shortcomings. Take a look at the following example:
스위프트 5.5까지 비동기 코드를 쓰는 것은 많은 단점이 있었습니다. 다음 예를 살펴보세요:

```swift
class API {
  ...
  func fetchServerStatus(completion: @escaping (ServerStatus) -> Void) {
    URLSession.shared
      .dataTask(
        with: URL(string: "http://amazingserver.com/status")!
      ) { data, response, error in
        // Decoding, error handling, etc
        let serverStatus = ...
        completion(serverStatus)
      }
      .resume()
  }
}

class ViewController {
  let api = API()
  let viewModel = ViewModel()

  func viewDidAppear() {
    api.fetchServerStatus { [weak viewModel] status in
      guard let viewModel = viewModel else { return }
      viewModel.serverStatus = status
    }
  }
}

```

This is a short block of code that calls a network API and assigns the result to a property on your view model. It’s deceptively simple, yet it exhibits an excruciating amount of ceremony that obscures your intent. Even worse, it creates *a lot* of room for coding errors: Did you forget to check for an error? Did you really invoke the `completion` closure in every code path?
이것은 네트워크 API를 호출하고 결과를 view model의 속성에 할당하는 짧은 코드입니다. 이것은 보기에는 간단하지만 의도를 모호하게 만드는 극심한 고통을 주는 양의 방식을 보여줍니다. 더욱 심각한 것은 오류를 확인하는 것을 잊은 경우 또는 `completion` 클로저 호출을 까먹은 경우 코딩 오류가 발생할 여지가 많다는 점입니다. 

Since Swift used to rely on Grand Central Dispatch (GCD), a framework designed originally for Objective-C, it couldn’t integrate asynchrony tightly into the language design from the get-go. Objective-C itself only introduced blocks (the parallel of a Swift closure) in iOS 4.0, years after the inception of the language.
스위프트는 원래 Objective-C를 위해 설계된 프레임워크인 GCD(Grand Central Dispatch)에 의존했었기 때문에 처음부터 비동기성 언어 설계에 통합될 수 없었습니다. Objective-C 자체는 언어가 시작된 지 수년이 지난 iOS 4.0에서 블록(스위프트 폐쇄의 병렬)만 도입했습니다.

Take a moment to inspect the code above. You might notice that:
잠시 시간을 내어 위으 코드를 검사해 보십시오

- The compiler has no clear way of knowing how many times you’ll call `completion` inside `fetchServerStatus()`. Therefore, it can’t optimize its lifespan and memory usage.
이 컴파일러는 `fetchServerStatus()` 안에서 `completion` 를 몇 번 호출할 지 명확한 방법이 없어 수명과 메모리 사용량을 최적화할 수 없습니다.
- You need to handle memory management yourself by weakly capturing `viewModel`, then checking in the code to see if it was released before the closure runs.
`viewModel` 을 약하게 캡쳐한 다음 코드를 확인하여 클로저가 실행되기 전에 해제되었는지 확인하는 방법으로 메모리 관리를 직접 처리해야 합니다.
- The compiler has no way to make sure you handled the error. In fact, if you forget to handle `error` in the closure, or don’t invoke `completion` altogether, the method will silently freeze.
컴파일러는 당신이 오류를 처리했는지 확인할 방법이 없습니다. 사실, 당신이 클로저에서 오류를  처리하는 것을 잊거나 `completion` 를 호출하지 않는다면 그 방법은 조용히 얼어버릴 것 입니다.
- And the list goes on and on…
그리고 그 목록은 계속해서…

The modern concurrency model in Swift works closely with both the compiler *and* the runtime. It solves many issues, including those mentioned above.
Swift의 modern concurrency model은 컴파일러 및 런타임 둘 다와 밀접하게 연결되어 위에서 언급한 것을 포함하여 많은 문제를 해결합니다.

The modern concurrency model provides the following three tools to achieve the same goals as the example above:
modern concurrency model은 위의 예와 같은 목표를 달성하기 위해 다음과 같은 세 가지 도구를 제공합니다:

- **async**: Indicates that a method or function is asynchronous. Using it lets you *suspend* execution until an asynchronous method returns a result.
메서드 또는 함수가 비동기식임을 나타냅니다. 이를 사용하면 비동기식 메서드가 결과를 반환할 때까지 실행을 일시 중지할 수 있습니다.
- **await**: Indicates that your code might pause its execution while it waits for an `async`annotated method or function to return.
코드가 `async` 된 메서드 또는 함수가 반환되기를 기다리는 동안 실행을 일시 중지할 수 있음을 나타냅니다.
- **Task**: A unit of asynchronous work. You can wait for a task to complete or cancel it before it finishes.
비동기 작업의 단위입니다. 작업이 완료되기 전에 작업을 완료하거나 취소할 때까지 기다릴 수 있습니다.

Here’s what happens when you rewrite the code above using the modern concurrency features introduced in Swift 5.5:
스위프트 5.5에 도입된 modern concurrency 기능을 사용하여 위의 코드를 다시 작성하면 다음과 같은 일이 발생합니다:

```swift
class API {
  ...
  func fetchServerStatus() async throws -> ServerStatus {
    let (data, _) = try await URLSession.shared.data(
      from: URL(string: "http://amazingserver.com/status")!
    )
    return ServerStatus(data: data)
  }
}

class ViewController {
  let api = API()
  let viewModel = ViewModel()

  func viewDidAppear() {
    Task {
      viewModel.serverStatus = try await api.fetchServerStatus()
    }
  }
}

```

The code above has about the same number of lines as the earlier example, but the intent is clearer to both the compiler and the runtime. Specifically:
위의 코드는 앞의 예와 거의 같은 수의 행을 가지고 있지만 컴파일러와 런타임 모두에게 의도를 명확하게 알려줍니다. 구체적으로:

- **fetchServerStatus()** is an asynchronous function that can suspend and resume execution. You mark it by using the `async` keyword.
**fetchServerStatus()** 는 실행을 일시 중단했다가 재개할 수 있는 비동기 함수로 `async` 키워드를 사용하여 표시합니다.
- **fetchServerStatus()** either returns `Data` or throws an error. This is checked at compile time — no more worrying about forgetting to handle an erroneous code path!
**fetchServerStatus()** 는 Data를 반환하거나 오류를 발생시킵니다. 컴파일 시에 확인되므로 잘못된 코드 경로를 처리하는 것을 잊어버릴 염려가 업습니다!
- **Task** executes the given closure in an asynchronous context so the compiler knows what code is safe (or unsafe) to write in that closure.
**Task** 는 비동기 컨텍스트에서 지정된 클로저를 실행하므로 컴파일러는 해당 클로저에 쓰기에 안전한(또는 안전하지 않은) 코드를 알 수 있습니다.
- Finally, you give the runtime an opportunity to suspend or cancel your code every time you call an asynchronous function by using the **await** keyword. This lets the system constantly change the priorities in the current task queue.
마지막으로 **await** 키워드를 사용하여 비동기 함수를 호출할 때마다 런타임에 코드를 일시 중단하거나 취소할 수 있는 기회를 제공하므로 현재 작업 대기열의 우선순위를 계속 변경할 수 있습니다.

<br>

### **Separating code into partial tasks**
코드를 partial task로 분리

Above, you saw that “the code might suspend at each `await`” — but what does that mean? To optimize shared resources such as CPU cores and memory, Swift *splits up* your code into logical units called **partial tasks**, or **partials**. These represent parts of the code you’d like to run asynchronously.
위에서 “코드가 `await` 할 때마다 일시 중단될 수 있습니다.”라는 것을 보았습니다. 그러나 이것을 의미하는 것은 무엇일까요? CPU 코어 및 메모리와 같은 공유 리소스를 최적화하기 위해 스위프트 코드를 **partial tasks 또는** **partials** 라고 불리는 논리적 단위로 분리합니다. 이는 비동기적으로 실행할 코드의 일부를 나타냅니다.

The Swift runtime schedules each of these pieces separately for asynchronous execution. When each partial task completes, the system decides whether to continue with your code or to execute another task, depending on the system’s load and the priorities of the pending tasks.
스위프트 런타임은 비동기 실행을 위해 각 스레드를 개별적으로 스케줄링합니다. 각 partial task가 완료되면 시스템은 시스템의 로드 및 보류 중인 task의 우선 순위에 따라 코드를 계속 수행할 지 또는 다른 task를 실행할 지 결정합니다.

That’s why it’s important to remember that each of these `await`-annotated partial tasks might run on a different thread at the system’s discretion. Not only can the thread change, but you shouldn’t make assumptions about the app’s state after an `await`; although two lines of code appear one after another, they might execute some time apart. Awaiting takes an arbitrary amount of time, and the app state might change significantly in the meantime.
그렇기 때문에 `await` 주석이 달린 각각의 partial task는 시스템의 재량에 따라 서로 다른 스레드에서 실행될 수 있음을 기억해야 합니다. 스레드가 바뀔 수 있을 뿐만 아니라 `await` 후의 앱 상태에 대한 가정을 해서는 안되며, 코드 두 줄이 차례로 나타나더라도 일정 시간 간격이 떨어져 실행될 수 있습니다. 대기는 임의의 시간이 소요되고 그 사이에 앱 상태가 크게 변할 수 있습니다.

To recap, `async`/`await` is a simple syntax that packs a lot of punch. It lets the compiler guide you in writing safe and solid code, while the runtime optimizes for a well-coordinated use of shared system resources.
요약하자면 `async`/`await` 는 많은 구멍을 포장하는 간단한 구문입니다. 이를 통해 컴파일러는 안전하고 견고한 코드를 작성하여 안내할  수 있으며 런타임은 공유 시스템 리소스의 잘 조정된 사용을 최적화합니다. 

#### Executing partial tasks

partial task 실행

As opposed to the closure syntax mentioned at the beginning of this chapter, the modern concurrency syntax is light on ceremony. The keywords you use, such as `async`, `await` and `let`, clearly express your intent. The foundation of the concurrency model revolves around breaking asynchronous code into partial tasks that you execute on an **Executor**.
이 장의 앞 부분에서 언급한 클로저와는 달리 최신의 concurrency 구문은 형식적으로 가볍습니다. `async`, `await` 그리고 `let` 과 같은 당신이 사용하는 키워드는 당신의 의도를 명확하게 표현합니다.  concurrency model 의 기본은 비동기 코드를 **Executor** 에서 실행하는 부분적인 작업으로 분해하는 것을 중심으로 합니다.

Executors are similar to GCD queues, but they’re more powerful and lower-level. Additionally, they can quickly run tasks and completely hide complexity like order of execution, thread management and more.
Executor는 GCD queeue와 비슷하지만 더 강력하고 하위 레벨입니다. 또한 작업을 빠르게 실행하고 실행 순서, 스레드 관리 등의 복잡성을 완벽하게 숨길 수 있습니다.

<br>

### **Controlling a task’s lifetime**
task 수명 제어

One essential new feature of modern concurrency is the system’s ability to manage the lifetime of the asynchronous code.
최신의 concurrency의 중요한 새로운 특징 중 하나는 비동기 코드의 수명을 관리하는 시스템의 능력입니다.

A huge shortcoming of existing multi-threaded APIs is that once an asynchronous piece of code starts executing, the system cannot graciously reclaim the CPU core until the code decides to give up control. This means that even after a piece of work is no longer needed, it still consumes resources and performs its work for no real reason.
기존 멀티 스레드 API의 큰 단점은 비동기 코드가 실행되기 시작하면 해당 코드가 컨트롤을 포기하기로 결정할 때까지 시스템이 CPU 코어를 친절하게 회수할 수 없다는 것입니다. 즉, 작업이 더이상 필요하지 않은 후에도 아무런 이유없이 리소스를 소모하고 작업을 수행한다는 것입니다.

A good example of this is a service that fetches content from a remote server. If you call this service twice, the system doesn’t have any automatic mechanism to reclaim resources that the first, now-unneeded call used, which is an unnecessary waste of resources.
원격 서버에서 컨텐츠를 가져오는 서비스가 좋은 예시입니다. 이 서비스를 두 번 호출하면 시스템에 처음에 불필요한 호출로 사용한 리소스를 회수하는 자동 매커니즘이 없으므로 불필요한 리소스 낭비가 발생합니다.

The new model breaks your code into partials, providing suspension points where you check in with the runtime. This gives the system the opportunity to not only suspend your code but to **cancel it** altogether, at its discretion.
새로운 모델은 코드를 부분적으로 분할하여 런타임에 체크인할 때 일시 중단 지점을 제공합니다. 이를 통해 시스템은 코드를 일시 중단할 뿐만 아니라 **cancel**도 임의로 수행할 수 있습니다.

Thanks to the new asynchronous model, when you cancel a given task, the runtime can walk down the async hierarchy and cancel all the child tasks as well.
새로운 비동기 모델 덕분에 주어진 작업을 취소하면 런타임이 비동기 계층 구조를 탐색하고 모든 하위 작업도 취소할 수 있습니다.

But what if you have a hard-working task performing long, tedious computations without any suspension points? For such cases, Swift provides APIs to detect if the current task has been canceled. If so, you can manually give up its execution.
만약 당신이 어떤 중단점도 없이 길고 지루한 계산들을 열심히 수행하는 작업이 있다면 어떨까요? 이러한 경우 스위프트는 현재 작업이 취소되었는지 감지하기 위해 API를 제공합니다. 그렇다면, 당신은 수동으로 작업의 실행을 포기할 수있습니다. 

Finally, the suspension points also offer an **escape route** for errors to bubble up the hierarchy to the code that catches and handles them.
마지막으로 중단점은 오류를 포착하고 처리하는 코드로 계층 구조를 확장하는 오류에 대한 **escape route도 제공합니다.** 

The new model provides an error-handling infrastructure similar to the one that synchronous functions have, using modern and well-known **throwing functions**. It also optimizes for quick memory release as soon as a task throws an error.
새로운 모델은 현대적이고 잘 알려진 **throwing functions**를 사용하여 동기 함수와 유사한 에러 처리 인프라를 제공하며, 작업에서 에러가 발생하는 즉시 신속한 메모리 해제를 위해 최적화됩니다.

You already see that the recurring topics in the modern Swift concurrency model are safety, optimized resource usage and minimal syntax. Throughout the rest of this chapter, you’ll learn about these new APIs in detail and try them out for yourself.
최신 스위프트 concurrency model 에서 반복되는 주제는 안정성, 최적화된 리소스 사용 및 최소 구분입니다. 이 장의 나머지 부분에서 새로운 API에 대해 자세히 알아보고 직접 사용해 보십시오

<br>

### **Getting started**
시작하기

**SuperStorage** is an app that lets you browse files you’ve stored in the cloud and download them for local, on-device preview. It offers three different “subscription plans”, each with its own download options: “Silver”, “Gold” and “Cloud 9”.
**SuperStorage**는 클라우드에 저장한 파일을 탐색하고 다운로드하여 로컬 온디바이스 미리보기를 할 수 있는 앱입니다. 이 앱은 “Silver”, “Gold” and “Cloud 9”의 세 가지 구독 플랜을 제공하며, 각각의 다운로드 옵션이 있습니다.

Open the starter version of SuperStorage in this chapter’s materials, under **projects/starter**.
이 장의 자료인 **projects/starter** 에서 SuperStorage 의 스타터 버전을 엽니다.

Like all projects in this book, **SuperStorage**’s SwiftUI views, navigation and data model are already wired up and ready to go. This app has more UI code compared to **LittleJohn**, which you worked on in the previous chapter, but it provides more opportunities to get your hand dirty with some asynchronous work.
이 책의 모든 프로젝트와 마찬가지로 **SuperStorage** 의 SwiftUI 뷰, 네비게이션 및 데이터 모델은 이미 연결되어 있으며, 이 앱은 이전 장에서 작업한 **LittleJohn** 에 비해 UI 코드가 더 많지만, 비동기 작업으로 손을 더럽힐 수 있는 기회가 더 많습니다.  

> Note: The server returns mock data for you to work with; it is not, in fact, a working cloud solution. It also lets you reproduce slow downloads and erroneous scenarios, so don’t mind the download speed. There’s nothing wrong with your machine.
> 

Note. 서버는 사용자가 작업할 수 있도록 모의 데이터를 반환합니다. 사실 클라우드 솔루션이 아닙니다. 느린 다운로드와 잘못된 시나리오를 재현할 수 있음으로 다운로드 속도에 신경 쓰지 마십시오. 컴퓨터에는 아무 문제가 없습니다.

While working on SuperStorage in this and the next chapter, you’ll create async functions, design some concurrent code, use async sequences and more.
이 장과 다음장에서 SuperStorage를 작업하는 동안 비동기 기능을 만들고, 동시 코드를 설계하고, 비동기 시퀀스를 사용하는 등의 작업을 수행하게 됩니다.

<br>

### **A bird’s eye view of async/await**

async/await 조감도

`async`/`await` has a few different flavors depending on what you intend to do:
`async`/`await` 는 사용자의 의도에 따라 몇 가지 다른 맛이 있습니다:

- To declare a function as asynchronous, add the `async` keyword before `throws` or the return type. Call the function by prepending `await` and, if the function is throwing, `try` as well. Here’s an example:
함수를 비동기로 선언하려면 `throws` 또는 return type 앞에 `async` 키워드를 추가합니다. `await` 을 붙여서 함수를 호출하고 함수가 throwing 일 경우 `try` 도 호출합니다. 다음은 예입니다:

```swift
func myFunction() async throws -> String {
  ...
}

let myVar = try await myFunction()

```

- To make a computed property asynchronous, simply add `async` to the getter and access the value by prepending `await`, like so:
계산된 속성을 비동기로 만들려면 다음과 같이 getter에 `async` 를 추가하고 `await`를 붙여 값에 액세스 하기만 하면 됩니다:

```swift
var myProperty: String {
  get async {
    ...
  }
}

print(await myProperty)

```

- For closures, add `async` to the signature:
클로저인 경우 기호에 `async` 붙입니다:

```swift
func myFunction(worker: (Int) async -> Int) -> Int {
  ...
}

myFunction {
  return await computeNumbers($0)
}

```

Now that you’ve had a quick overview of the `async`/`await` syntax, it’s time to try it for yourself.
이제 `async`/`await` 구문에 대해 간략히 살펴 보았으니 직접 사용해보시기 바랍니다.

<br>

