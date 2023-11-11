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

### **Getting the list of files from the server**
서버에서 파일 목록 가져오기

Your first task is to add a method to the app’s model that fetches a list of available files from the web server in JSON format. This task is almost identical to what you did in the previous chapter, but you’ll cover the code in more detail.
첫 번째 작업은 웹 서버에서 사용 가능한 파일 목록을 JSON 형식으로 가져오는 메소드를 앱의 모델에 추가하는 것 입니다. 이 작업은 이전 장에서 수행한 작업과 거의 동일하지만 코드에 대해 더 자세히 다루게 됩니다. 

Open **SuperStorageModel.swift** and add a new method anywhere inside `SuperStorageModel`:
**SuperStorageModel.swift** 파일 내 어느 곳에서나 새 메서드를 추가합니다: 

```swift
func availableFiles() async throws -> [DownloadFile] {
  guard let url = URL(string: "http://localhost:8080/files/list") else {
    throw "Could not create the URL."
  }
}
```

Don’t worry about the compiler error Xcode shows; you’ll finish this method’s body momentarily.
xcode가 보여주는 컴파일러 오류에 대해 걱정하지 마십시오. 이 메서드는 본문을 잠시 후에 완료할 수 있습니다.

You annotate the method with `async throws` to make it a **throwing, asynchronous function**. This tells the compiler and the Swift runtime how you plan to use it:
당신은 **throwing, asynchronous function** 로 만들기 위해 `async throws` 로 메소드에 코드를 달았습니다. 이것은 컴파일러와 스위프트 런타임에 당신이 그것을 어떻게 사용할 것인지를 알려줍니다:

- The compiler makes sure you don’t call this function from synchronous contexts where the function can’t suspend and resume the task.
컴파일러는 함수가 작업을 일시 중단하고 재개할 수 없는 동기적인 컨텍스트에서 이 함수를 호출하지 않도록 합니다.
- The runtime uses the new cooperative thread pool to schedule and execute the method’s partial tasks.
런타임은 새 협력 스레드 풀을 사용하여 메서드의 부분 작업을 예약하고 실행합니다.

In the method, you fetch a list of decodable `DownloadFile`s from a given `url`. Each `DownloadedFile` represents one file available in the user’s cloud.
이 방법에서는 특정 `url`에서 디코딩 가능한 `DownloadFile` 목록을 가져옵니다. 각각의 `DownloadedFile` 은 사용자의 클라우드에서 사용 가능한 하나의 파일을 나타냅니다.

#### Making the server request

서버 요청하기
At the end of the method’s body, add this code to execute the server request:
메서드 본문 끝에 다음 코드를 추가하여 서버 요청을 실행합니다:

```swift
let (data, response) = try await
  URLSession.shared.data(from: url)

```

You use the shared `URLSession` to asynchronously fetch the data from the given URL. It’s vital that you do this asynchronously because doing so lets the system use the thread to do other work while it waits for a response. It doesn’t block others from using the shared system resources.
공유 `URLSession` 을 사용하여 주어진 URL에서 데이터를 비동기적으로 가져옵니다. 이렇게 하면 시스템이 응답을 기다리는 동안 스레드를 사용하여 다른 작업을 수행할 수 있기 때문에 비동기적으로 수행하는 것이 중요합니다. 다른 사용자가 공유 시스템 리소스를 사용하는 것을 막지 않습니다.

Each time you see the `await` keyword, think **suspension point**. `await` means the following:
`await` 키워드를 볼 때마다 `await` 가 following 을 의미하는 **suspension point** 를 생각합니다.

- The current code will suspend execution.
현재 코드 실행을 중지합니다.
- The method you await will execute either immediately or later, depending on the system load. If there are other pending tasks with higher priority, it might need to wait.
대기 중인 메서드는 시스템 로드에 따라 즉시 실행되거나 나중에 실행됩니다. 우선 순위가 더 높은 다른 보류 중인 작업이 있으면 기다려야 할 수도 있습니다.
- If the method or one of its child tasks throws an error, that error will bubble up the call hierarchy to the nearest `catch` statement.
메서드 또는 하위 작업 중 하나에 오류가 발생하면 해당 오류는 호출 계층을 가장 가까운 `catch` 문으로 흘려보낸다.

Using `await` funnels each and every asynchronous call through the central dispatch system in the runtime, which:
`await` 을 사용하면 런타임에 중앙 디스패치 시스템을 통해 모든 비동기 호출을 전송합니다.

- Prioritizes jobs.
- Propagates cancellation.
- Bubbles up errors.
- And more.

  
#### Verifying the response status

응답 여부 확인
Once the asynchronous call completes successfully and returns the server response data, you can verify the response status and decode the data as usual. Add the following code at the end of `availableFiles()`:
비동기 호출이 성공적으로 완료되어 서버 응답 데이터를 반환하면 응답 상태를 확인하고 평소와 같이 데이터를 디코딩할 수 있습니다. `availableFiles()` 끝에 다음 코드를 추가합니다:

```swift
guard (response as? HTTPURLResponse)?.statusCode == 200 else {
  throw "The server responded with an error."
}

guard let list = try? JSONDecoder()
  .decode([DownloadFile].self, from: data) else {
  throw "The server response was not recognized."
}

```

You first inspect the response’s HTTP status code to confirm it’s indeed **HTTP 200 OK**. Then, you use a `JSONDecoder` to decode the raw `Data` response to an array of `DownloadFile`s.
먼저 응답의 HTTP 상태 코드를 검사하여 **HTTP 200 OK** 임을 확인한 다음, `JSONDecoder` 를 사용하여 `DownloadFile` 배열의 원시 데이터 응답을 디코딩합니다.

#### Returning the list of files

파일 목록 반환
Once you decode the JSON into a list of `DownloadFile` values, you need to return it as the asynchronous result of your function. How simple is it to do that? Very.
일단 JSON을 `DownloadFile` 값의 목록으로 디코딩하면 함수의 비동기 결과로 반환해야 합니다. 얼마나 간단합니까? 매우 간단합니다.

Simply add the following line to the end of `availableFiles()`:
`availableFiles()` 끝에 다음 행을 추가하기만 하면 됩니다.

```swift
return list
```

While the execution of the method is entirely *asynchronous*, the code reads entirely *synchronously* which makes it relatively easy to maintain, read through and reason about.
메소드의 실행은 전적으로 비동기적이지만 코드는 전적으로 동기적으로 읽으므로 유지보수, 읽기 및 추론이 비교적 용이합니다.

#### Displaying the list

목록 표시
You can now use this new method to feed the file list on the app’s main screen. Open **ListView.swift** and add one more view modifier directly after `.alert(...)`, near the bottom of the file:
이제 이 새로운 방법을 사용하여 앱의 메인 화면에서 파일 목록을 제공할 수 있습니다. **ListView.swift** 를 열고 파일 하단에 `.alert(...)` 바로 뒤에 view modifier를 하나 더 추가합니다:

```swift
.task {
  guard files.isEmpty else { return }

  do {
    files = try await model.availableFiles()
  } catch {
    lastErrorMessage = error.localizedDescription
  }
}

```

As mentioned in the previous chapter, `task` is a view modifier that allows you to execute asynchronous code when the view appears. It also handles canceling the asynchronous execution when the view disappears.
앞 장에서 언급한 바와 같이 `task` 는 뷰가 나타나면 비동기 코드를 실행할 수 있도록 해주는 view modifier 입니다. 또한 뷰가 사라지면 비동기 실행을 취소할 수 있도록 처리합니다.

In the code above, you:
위의 코드는:

1. Check if you already fetched the file list; if not, you call `availableFiles()` to do that.
파일 목록을 이미 가져왔는지 확인하고, 가져오지 않는다면 `availableFiles()` 를 호출하여 이를 수행합니다.
2. Catch and store any errors in `lastErrorMessage`. The app will then display the error message in an alert box.
`lastErrorMessage` 오류를 파악하여 저장하면 오류 메시지가 알림창에 표시됩니다. 

#### Testing the error handling

오류 처리 테스트
If the book server is still running from the previous chapter, stop it. Then, build and run the project. Your code inside `.task(...)` will catch a networking error, like so:
북 서버가 이전 장에서 계속 실행 중이면 중지하고 프로젝트를 빌드하고 실행합니다. `.task(...)` 의 코드에서 네트워킹 오류가 발생합니다. 

Asynchronous functions propagate errors up the call hierarchy, just like synchronous Swift code. If you ever wrote Swift code with asynchronous error handling before `async`/`await`‘s arrival, you’re undoubtedly ecstatic about the new way to handle errors.
비동기 함수는 동기 스위프트 코드처럼 오류를 호출 계층 위로 전파합니다. 만약 당신이 비동기 오류 처리와 함께 스위프트 코드를 `async`/`await` 이 도착하기 전에 작성했다면, 당신은 의심할 여지 없이 오류를 처리하는 새로운 방법에 열광하게 될 것입니다.

#### Viewing the file list

파일 목록 보기

Now, start the book server. If you haven’t already done that, navigate to the server folder **00-book-server** in the book materials-repository and enter `swift run`. The detailed steps are covered in Chapter 1, “Why Modern Swift Concurrency?”.
이제 북서버를 시작합니다. 아직 시작하지 않았다면 북 자료 저장소에 있는 서버 폴더 **00-book-server** 로 이동하여 `swift run` 을 입력하면 됩니다. 자세한 단계는 1장 “Why Modern Swift Concurrency?” 에서 설명합니다.

Restart the SuperStorage app and you’ll see a list of files:
SuperStorage 앱을 다시 시작하면 파일 목록이 나타납니다:

Notice there are a few TIFF and JPEG images in the list. These two image formats will give you various file sizes to play with from within the app.
목록에 TIFF 와 JPEG 이미지가 몇 개 있습니다. 이 두 가지 이미지 형식은 앱 내에서 사용할 수 있는 다양한 파일 크기를 제공합니다.

<br>

### **Getting the server status**

서버 상태 가져오기

Next, you’ll add one more asynchronous function to the app’s model to fetch the server’s status and get the user’s usage quota.
다음으로 당신은 서버의 상태를 가져오고 사용자의 사용 할당량을 얻기 위해 앱의 모델에 비동기 기능을 하나 더 추가할 것입니다.

Open **SuperStorageModel.swift** and add the following method to the class:
**SuperStorageModel.swift** 를 열고 다음 메서드를 클래스에 추가합니다:

```swift
func status() async throws -> String {
  guard let url = URL(string: "http://localhost:8080/files/status") else {
    throw "Could not create the URL."
  }
}

```

A successful server response returns the status as a text message, so your new function asynchronously returns a `String` as well.
서버 응답이 성공하면 상태가 텍스트 메시지로 반환되므로 새 함수는 `String` 도 비동기적으로 반환됩니다.

As you did before, add the code to asynchronously get the response data and verify the status code:
이전과 마찬가지로 코드를 추가하여 비동기적으로 응답 데이터를 얻고 상태 코드를 확인합니다:

```swift
let (data, response) = try await
  URLSession.shared.data(from: url, delegate: nil)

guard (response as? HTTPURLResponse)?.statusCode == 200 else {
  throw "The server responded with an error."
}

```

Finally, decode the response and return the result:
마지막으로 응답을 디코딩한 후 결과를 반환합니다:

```swift
return String(decoding: data, as: UTF8.self)

```

The new method is now complete and follows the same pattern as `availableFiles()`.
새로운 방법은 이제 완성되었으며 `availableFiles()` 와 같은 패턴을 따릅니다.

### Showing the service status

서비스 상태 표시

For your next task, you’ll use `status()` to show the server status in the file list.
다음 작업에서는 `status()` 를 사용하여 파일 목록에 서버 상태를 표시합니다.

Open **ListView.swift** and add this code inside the `.task(...)` view modifier, after assigning `files`:
**ListView.swift** 를 열고 `files` 를 할당한 후 `.task(...)` view modifier 안에 이 코드를 추가합니다:

```swift
status = try await model.status()
```

Build and run. You’ll see some server usage data at the bottom of the file list:
Build and run. 파일 목록 하단에 서버 사용량 데이터가 표시됩니다:

Everything works great so far, but there’s a hidden optimization opportunity you might have missed. Can you guess what it is? Move on to the next section for the answer.
지금까지는 모든 것이 잘 작동하지만, 여러분이 놓쳤을 수도 있는 최적화 기회가 숨겨져 있습니다. 무엇인지 알아맞힐 수 있는 최적화 기회가 숨겨져 있습니다. 무엇인지 알 수 있습니까? 다음 섹션으로 이동하여 답을 알아봅시다.

<br>

### **Grouping asynchronous calls**
비동기 호출 그룹화

Revisit the code currently inside the `task` modifier:
현재 `task` modifier 안에 있는 코드를 다시 확인합니다:

```swift
files = try await model.availableFiles()
status = try await model.status()
```

Both calls are asynchronous and, in theory, could happen at the same time. However, by explicitly marking them with `await`, the call to `status()` doesn’t start until the call to `availableFiles()` completes.
두 호출 모두 비동기식이며 이론적으로는 동시에 발생할 수 있습니다. 그러나 `await` 로 명시적으로 표시하면 `availableFiles()` 호출이 완료될 때까지 `status()` 호출이 시작되지 않습니다.

Sometimes, you need to perform sequential asynchronous calls — like when you want to use data from the first call as a parameter of the second call.
때로는 첫 번째 호출의 데이터를 두 번째 호출의 매개 변수로 사용하려는 경우와 같이 순차적 비동기 호출을 수행해야 합니다. 

This isn’t the case here, though!
하지만 여기서는 그렇지 않아요!

For all you care, both server calls can be made *at the same time* because they don’t depend on each other. But how can you await *both* calls without them blocking each other? Swift solves this problem with a feature called **structured concurrency**, via the `async let` syntax.
상관없이, 두 서버 호출은 서로 의지하지 않기 때문에 동시에 걸릴 수 있습니다. 하지만 어떻게 서로 차단하지 않고 둘 다 호출을 기다릴 수 있을까요? 스위프트는 `async let` 구문을 통해 **structured concurrency** 이라는 기능으로 이 문제를 해결합니다.

#### Using async let
비동기 사용

Swift offers a special syntax that lets you group several asynchronous calls and await them all together.
스위프트는 여러 비동기 호출을 그룹화하여 모두 대기할 수 있는 특별한 구문을 제공합니다. 

Remove all the code inside the `task` modifier and use the special `async let` syntax to run two concurrent requests to the server:
`task` modifier 안의 모든 코드를 제거하고 특수한 `async let` 구문을 사용하여 서버에 대한 두 개의 동시 요청을 실행합니다:

```swift
guard files.isEmpty else { return }

do {
  async let files = try model.availableFiles()
  async let status = try model.status()
} catch {
  lastErrorMessage = error.localizedDescription
}

```

An `async let` binding allows you to create a local constant that’s similar to the concept of promises in other languages. **Option-Click** `files` to bring up Quick Help:
`async let` binding 을 사용하면 다른 언어의 개념과 유사한 상태를 만들 수 있습니다. **Option-Click** `files` 을 클릭하여 빠른 도움말을 표시합니다:

The declaration explicitly includes `async let`, which means you can’t access the value without an `await`.
선언문에는 `await` 없이는 값에 접근할 수 없음을 의미하는 `async let` 이 명시적으로 포함되어 있습니다.

The `files` and `status` bindings promise that either the values of the specific types or an error will be available later.
`files` 과 `status` 바인딩은 특정 유형의 값 또는 오류를 나중에 사용할 수 있음을 약속합니다. 

To read the binding results, you need to use `await`. If the value is already available, you’ll get it immediately. Otherwise, your code will suspend at the `await` until the result becomes available:
바인딩 결과를 읽으려면 `await` 을 사용해야 합니다. 값이 이미 사용 가능하면 즉시 얻을 수 있습니다. 그렇지 않으면 결과가 사용 가능해질 때까지 코드가 `await` 에서 일시 중단됩니다. 

> Note: An async let binding feels similar to a promise in other languages, but in Swift, the syntax integrates much more tightly with the runtime. It’s not just syntactic sugar but a feature implemented into the language.
> 
Note. 비동기 바인딩은 다른 언어의 약속과 유사하게 느껴지지만 스위프트에서는 구문이 런타임과 훨씬 더 긴밀하게 통합됩니다. 이는 단순히 구문이 아니라 언어에 구현된 특징입니다.

#### Extracting values from the two requests
두 요청에서 값 추출

Looking at the last piece of code you added, there’s a *small detail* you need to pay attention to: The async code in the two calls starts executing right away, *before* you call `await`. So `status` and `availableFiles` run in parallel to your main code, inside the `task` modifier.
마지막으로 추가한 코드를 보면 주의해야 할 작은 세부사항이 있습니다. 두 호출의 비동기 코드는 즉시 실행되기 시작합니다. `await` 호출하기 전에 `task` modifier 안에서 `status` 와 `availableFiles` 가 메인 코드와 병렬로 실행됩니다. 

To group concurrent bindings and extract their values, you have two options:
동시 바인딩을 그룹화하고 해당 값을 추출하려면 다음 두 가지 옵션이 있습니다:

- Group them in a collection, such as an array.
배열과 같은 집합으로 그룹화 합니다.
- Wrap them in parentheses as a tuple and then destructure the result.
괄호 안에 튜플로 싼 다음 결과를 구조화합니다.

The two syntaxes are interchangeable. Since you have only two bindings, you’ll use the tuple syntax here.
두 구문은 서로 교환할 수 있습니다. 바인딩이 두 개뿐이므로 여기서는 튜플 구문을 사용합니다. 

Add this code at the end of the `do` block:
다음 코드를 `do` 블록 끝에 추가합니다:

```swift
let (filesResult, statusResult) = try await (files, status)
```

And what are `filesResult` and `statusResult`? **Option-Click** `filesResults` to check for yourself:
그리고 `filesResult` 와 `statusResult` 란 무엇입니까? **Option-Click** `filesResults` 를 클릭하여 직접 확인합니다:

This time, the declaration is simply a `let` constant, which indicates that by the time you can access `filesResult` and `statusResult`, both requests have finished their work and provided you with a final result.
이번 선언은 단순히 `let` 으로 `filesResult` 와 `statusResult` 에 접근할 수 있을 때까지 두 요청 모두 작업을 완료하고 최종 결과를 제공했음을 나타냅니다. 

At this point in the code, if an `await` didn’t throw in the meantime, you know that all the concurrent bindings resolved successfully.
코드의 이 시점에서, `await` 이 그 사이에 던져지지 않았다면, 모든 동시 바인딩이 성공적으로 해결되었음을 알 수 있습니다. 

#### Updating the view
뷰 업데이트 중

Now that you have both the file list and the server status, you can update the view. Add the following two lines at the end of the `do` block:
이제 파일 목록과 서버 상태가 모두 확보되었으므로 뷰를 업데이트할 수 있습니다. `do` 블록 끝에 다음 두 줄을 추가합니다:

```swift
self.files = filesResult
self.status = statusResult
```

Build and run. This time, you execute the server requests in parallel, and the UI becomes ready for the user a little faster than before.
Build and run. 이번에는 서버 요청을 병렬로 실행하면 UI가 이전 보다 조금 빠르게 사용자를 위한 준비가 됩니다. 

Take a moment to appreciate that the same `async`, `await` and `let` syntax lets you run non-blocking asynchronous code serially and *also* in parallel. That’s some amazing API design right there!
동일한 `async`, `await` 그리고 `let` 구문을 사용하면 non-blocking 비동기 코드를 일련의 비동기 코드를 일련의 병렬로 실행할 수 있음을 알 수 있습니다. 정말 놀라운 API 디자인입니다!

<br>

### **Asynchronously downloading a file**
비동기적으로 파일 다운로드

Open **SuperStorageModel.swift** and scroll to the method called `download(file:)`. The starter code in this method creates the endpoint URL for downloading files. It returns empty data to make the starter project compile successfully.
**SuperStorageModel.swift** 를 열고 `download(file:)` 메서드로 스크롤합니다. 이 메서드의 스타터 코드는 파일을 다운로드하기 위한 엔드포인트 URL을 생성합니다. 빈 데이터를 반환하여 스타터 프로젝트를 성공적으로 컴파일합니다. 

`SuperStorageModel` includes two methods to manage the current app downloads:
`SuperStorageModel` 은 현재 앱 다운로드를 관리하는 두 가지 방법을 포함됩니다:

- **addDownload(name:)**: Adds a new file to the list of ongoing downloads.
**addDownload(name:)**: 진행중인 다운로드 목록에 새 파일을 추가합니다.
- **updateDownload(name:progress:)**: Updates the given file’s progress.
**updateDownload(name:progress:)**: 지정된 파일의 진행상황을 업데이트합니다.

You’ll use these two methods to update the model and the UI.
이 두 가지 방법을 사용하여 모델과 UI를 업데이트 합니다. 

#### Downloading the data
데이터 다운로드

To perform the actual download, add the following code directly before the `return` line in `download(file:)`:
실제 다운로드를 수행하려면 `download(file:)` 의 `return` 행 바로 앞에 다음 코드를 추가합니다:

```swift
addDownload(name: file.name)

let (data, response) = try await
  URLSession.shared.data(from: url, delegate: nil)

updateDownload(name: file.name, progress: 1.0)
```

`addDownload(name:)` adds the file to the published `downloads` property of the model class. `DownloadView` uses it to display the ongoing download statuses onscreen.
`addDownload(name:)` 는 모델 클래스의 공개된 `downloads` 프로퍼티에 파일을 추가합니다. `DownloadView` 는 이 파일을 사용하여 현재 진행 중인 다운로드 상태를 화면에 표시합니다. 

Then, you fetch the file from the server. Finally, you update the progress to `1.0` to indicate the download finished.
그런 다음 서버에서 파일을 가져옵니다. 마지막으로 진행 상황을 `1.0` 으로 업데이트하여 다운로드가 완료되었음을 나타냅니다. 

#### Adding server error handling
서버 오류 처리 추가 중

To handle any possible server errors, also append the following code before the `return` statement:
발생 가능한 서버 오류를 처리하려면 `return` 문 앞에 다음 코드를 추가해야 합니다:

```swift
guard (response as? HTTPURLResponse)?.statusCode == 200 else {
  throw "The server responded with an error."
}
```

Finally, replace `return Data()` with:
마지막으로, `return Data()` 를 다음으로 바꿉니다. 

```swift
return data
```

Admittedly, emitting progress updates here is not very useful because you jump from 0% directly to 100%. However, you’ll improve this in the next chapter for the premium subscription plans — Gold and Cloud 9.
여기서 진행률 업데이트를 실행하는 것은 0%에서 100%로 바로 이동하기 때문에 그다지 유용하지 않습니다. 하지만 다음 장에서 프리미엄 구독 계획인 Gold 와 Cloud 9 에 대해 이를 향상시킬 것입니다.

For now, open **DownloadView.swift**. Scroll to the code that instantiates the file details view, `FileDetails(...)`, then find the closure parameter called `downloadSingleAction`.
일단 **DownloadView.swift** 를 열고 파일 상세 보기를 인스턴스화하는 코드인 `FileDetails(...)` 로 스크롤한 후 `downloadSingleAction` 이라는 클로저 파라미터를 찾습니다.

This is the action for the leftmost button — the cheapest download plan in the app.
이것은 앱에서 가장 저렴한 다운로드 요금제인 가장 왼쪽 버튼에 대한 조치입니다.

So far, you’ve only used `.task()` in SwiftUI code to run async calls. But how would you await `download(file:)` inside the `downloadSingleAction` closure, which doesn’t accept async code?
지금까지는 SwiftUI 코드의 `.task()` 만 사용하여 비동기 호출을 실행 했는데 비동기 코드를 허용하지 않는 `downloadSingleAction` 의  `download(file:)` 클로저 안에서 어떻게 다운로드를 기다릴까요?

Add this inside the closure to double-check that the closure expects synchronous code:
클로저 내부에 이 정보를 추가하여 클로저에 동기 코드가 예상되는지 다시 확인합니다:

```swift
fileData = try await model.download(file: file)
```

The error states that your code is asynchronous — it’s of type `() async throws -> Void` — but the parameter expects a synchronous closure of type `() -> Void`.
오류는 코드가 `() async throws -> Void` 을 나타내지만 매개 변수는  `() -> Void` 유형의 동기 클로저를 예상합니다. 

One viable solution is to change `FileDetails` to accept an asynchronous closure. But what if you don’t have access to the source code of the API you want to use? Fortunately, there is another way.
`FileDetails`을 비동기 클로저를 허용하도록 변경하는 것도 한 방법입니다.  하지만 사용하고자 하는 API 의 소스코드에 접근할 수 없는 경우에는 어떻게 할까요? 다행히 다른 방법이 있습니다.

<br>

### Running async requests from a non-async context
비동기 컨텍스트에서 비동기 요청 실행

While still in **DownloadView.swift**, replace `fileData = try await model.download(file: file)` with:
**DownloadView.swift** 에 있는 동안, `fileData = try await model.download(file: file)` 을 다음과 같이 바꿉니다:

```swift
Task {
  fileData = try await model.download(file: file)
}

```

It seems like the compiler is happy with this syntax! But wait, what is this `Task` type you used here?
컴파일러가 이 구문에 만족하는 것 같군요! 그런데 잠깐, 여기서 사용한 이 `Task` 유형은 뭘까요?


