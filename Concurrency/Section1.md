# Section I: Modern Concurrency in Swift

### 1. Why Modern Swift Concurrency?

The last time Apple made a big deal about an asynchronous framework was when **Grand Central Dispatch (GCD)** came out, along with Mac OS X Snow Leopard, in 2009.
애플이 비동기식 프레임워크에 대해 큰 관심을 보인 것은 2009년 Mac OS X 스노우 레오파드와 함께 GCD(Grand Central Dispatch)가 나왔을 때 입니다.

While GCD helped Swift launch in 2014 with support for concurrency and asynchrony from day one, that support wasn’t native — it was designed around the needs and abilities of Objective-C. Swift just “borrowed” that concurrency until it had its own mechanism, designed specifically for the language.
GCD는 2014년 Swift부터 동시성과 비동기성을 지원하면서 출시하는 데 도움을 주었지만, 이러한 지원이 기본적인 것은 아니었습니다. 이는 Objective-C의 요구와 능력을 중심으로 설계되었으며, Swift는 언어에 맞게 특별히 설계된 자체 메커니즘을 갖출 때까지 이러한 동시성을 "빌려" 왔습니다.

All that changed with Swift 5.5, which introduced a new, native model for writing asynchronous, concurrent code.
이 모든 것은 비동기 동시 코드 작성을 위한 새로운 네이티브 모델을 도입한 Swift 5.5와 함께 바뀌었습니다.

The new **concurrency model** provides everything you need to write safe and performant programs in Swift, including:
새로운 concurrency model은 Swift에서 안전하고 성능이 뛰어난 프로그램을 작성하는 데 필요한 다음과 같은 모든 것을 제공합니다:

- A new, native syntax for running asynchronous operations in a structured way.
구조화된 방식으로 비동기 작업을 실행하기 위한 새로운 기본 구문입니다.
- A bundle of standard APIs to design asynchronous and concurrent code.
비동기 코드와 동시 코드를 설계하기 위한 표준 API 묶음.
- Low-level changes in the `libdispatch` framework, which make all the high-level changes integrate directly into the operating system.
libdispatch framework(?)의 low-level 변경으로 모든 상위 수준 변경이 운영 체제에 직접 통합됩니다.
- A new level of compiler support for creating safe, concurrent code.
안전한 동시 코드를 만들기 위한 새로운 수준의 컴파일러 지원.

Swift 5.5 introduces the new language syntax and APIs to support these features. In your apps, besides using a recent Swift version, you also need to target certain platform versions:
Swift 5.5는 이러한 기능을 지원하기 위해 새로운 언어 구문과 API를 소개합니다.
앱에서는 최근 Swift 버전을 사용하는 것 외에 특정 플랫폼 버전을 대상으로 해야 합니다:

- If you’re using Xcode 13.2 or newer, it will bundle the new concurrency runtime with your app so you can target iOS 13 and macOS 10.15 (for native apps).
Xcode 13.2 이상을 사용하는 경우 새로운 동시 실행 시간을 앱과 함께 번들로 제공하여 iOS 13 및 macOS 10.15(네이티브 앱용)를 대상으로 할 수 있습니다.
- In case you’re on Xcode 13 but earlier version than 13.2, you’ll be able to target only iOS 15 or macOS 12 (or newer).
Xcode 13에서 13.2보다 이전 버전인 경우 iOS 15 또는 macOS 12(또는 그 이상)만 대상으로 지정할 수 있습니다.

In the first chapter of the book, you’ll review the new concurrency support in Swift and see how it fares compared to the existing APIs. Later, in the practical part of the chapter, you’ll work on a real-life project by trying out the `async`/`await` syntax and adding some cool asynchronous error-handling.
책의 첫 장에서는 스위프트의 새로운 concurrency 지원에 대해 검토하고 기존 API와 비교하여 어떻게 구현되는지 확인할 것입니다. 나중에 chapter의 실용적인 부분에서는  `async/await` 구문을 사용해보고 멋진 asynchronous error-handling을 추가하여 실제 프로젝트를 수행할 것입니다.

<br>

<br>

### **Introducing the modern Swift concurrency model**

concurrency model 소개

The new concurrency model is tightly integrated with the language syntax, the Swift runtime and Xcode. It abstracts away the notion of threads for the developer. Its key new features include:
새로운 concurrency model은 언어 문법이 swift runtime과 xcdoe와 긴밀하게 연결되어 있습니다. 개발자를 위한 thread의 개념을 추상화합니다. 주요한 새로운 기능은 다음과 같습니다 :

1. A cooperative thread pool.
2. `async`/`await` syntax.
3. Structured concurrency.
4. Context-aware code compilation.

With this high-level overview behind you, you’ll now take a deeper look at each of these features.
이 high-level overview를 통해 이제 이러한 기능을 자세히 살펴보겠습니다.

#### 1. A cooperative thread pool

The new model transparently manages a pool of threads to ensure it doesn’t exceed the number of CPU cores available. This way, the runtime doesn’t need to create and destroy threads or constantly perform expensive thread switching. Instead, your code can suspend and, later on, resume very quickly on any of the available threads in the pool.
새로운 모델은 사용 가능한 CPU 코어의 수를 초과하지 않도록 스레드 풀을 투명하게 관리합니다. 이렇게 하면 런타임에서 스레드를 생성하고 파괴하거나 값비싼 스레드 전환을 지속적으로 수행할 필요가 없습니다. 대신 코드가 풀의 사용 가능한 스레드에서 일시 중단되었다가 나중에 아주 빠르게 재개될 수 있습니다. 

#### 2. async/await syntax

Swift’s new `async`/`await` syntax lets the compiler and the runtime know that a piece of code might suspend and resume execution one or more times in the future. The runtime handles this for you seamlessly, so you don’t have to worry about threads and cores.
스위프트의 새로운 `async`/`await` 문법을 통해 컴파일러와 런타임은 코드 조각이 미래에 한 번 이상 실행을 중단했다가 재개할 수 있음을 알 수 있습니다. 런타임은 이를 원활하게 처리하므로 스레드와 코어에 대해 걱정할 필요가 없습니다.

 As a wonderful bonus, the new language syntax often removes the need to weakly or strongly capture `self` or other variables because you don’t need to use escaping closures as callbacks.
새로운 언어 문법을 사용하면 escaping closure를 콜백으로 사용할 필요가 없기 때문에 종종 `self` 나 다른 변수를 weak 또는 strong 표시할 필요가 없어집니다.

#### 3. Structured concurrency

Each asynchronous task is now part of a hierarchy, with a parent task and a given priority of execution. This hierarchy allows the runtime to cancel all child tasks when a parent is canceled. Furthermore, it allows the runtime to *wait* for all children to complete before the parent completes. It’s a tight ship all around.

This hierarchy provides a huge advantage and a more obvious outcome, where high-priority tasks will run before any low-priority tasks in the hierarchy.

#### 4. Context-aware code compilation

The compiler keeps track of whether a given piece of code *could* run asynchronously. If so, it won’t let you write potentially unsafe code, like mutating shared state.
컴파일러는 주어진 코드 조각이 비동기적으로 실행될 수 있는지 여부를 추적합니다. 만약 그렇다면, 공유 상태를 변형시키는 것과 같이 잠재적으로 안전하지 않은 코드를 쓸 수 없게 됩니다.

This high level of compiler awareness enables elaborate new features like **actors**, which differentiate between synchronous and asynchronous access to their state at compile time and protects against inadvertently corrupting data by making it harder to write unsafe code.
이러한 high level의 컴파일러 인식은 **actors**와 같은 정교한 새로운 기능을 가능하게 합니다. **actors**는 컴파일 시 상태에 대한 동기식 및 비동기식 액세스를 구별하고 안전하지 않은 코드를 쓰기 어렵게 함으로써 의도치 않게 데이터가 손상되는 것을 방지합니다.

With all those advantages in mind, you’ll move on to writing some code with the new concurrency features right away and see how it feels for yourself!
이러한 장점을 모두 염두에 두고 새로운 concurrency 기능이 포함된 코드를 바로 작성하고 직접 어떤 느낌인지 확인할 수 있습니다!

<br>

### **Running the book server**

book server 실행

Throughout the rest of this chapter, you’ll create a fully-fledged stock trading app with live price monitoring called **LittleJohn**.
이 장의 나머지 부분에서는 **LittleJohn**이라는 실시간 가격을 모니터링 할 수 있는 본격적인 주식 거래앱을 만들 것 입니다. 

You’ll work through the code at a *quick pace*, with a somewhat brief explanation of the APIs. Enjoy the process and don’t worry about the mechanics right now. You’ll go into the nitty-gritty details at length in the coming chapters.
API에 대한 간단한 설명과 함께 빠른 속도로 코드를 작성해 봅시다. 프로세스를 즐기고 지금 당장 기계적인 부분에 대해 걱정하지 마십시오. 다음 장에서 자세한 내용을 설명합니다.

First things first: Most of the projects in this book need access to a web API to fetch JSON data, download images and more. The book comes with its own server app, called the **book server** for short, that you need to run in the background at all times while working through the chapters.
첫번째 사항 : 이 책의 대부분의 프로젝트는 JSON 데이터를 가져오고 이미지를 다운로드하는 웹 API에 대한 액세스가 필요합니다. 이 책은 챕터를 작업하는 동안 항상 백그라운드에서 실행해야 하는 **book server**라고 불리는 자체 서버 앱과 함께 제공됩니다.

Open your Mac’s Terminal app and navigate to the **00-book-server** folder in the book materials repository. Start the app by entering:
Mac’s Terminal 앱을 열고 자료 저장소의 **00-book-server** 폴더로 이동합니다. 다음을 입력하여 앱을 시작합니다.

```
swift run
```

The first time you run the server, it will download a few dependencies and build them — which might take a minute or two. You’ll know the server is up and running when you see the following message:
서버를 처음 실행하면 몇 개의 종속성을 다운로드하여 구축합니다. 1~2분 정도 걸릴 수 있습니다. 다음 메시지가 나타나면 서버가 가동 중임을 알 수 있습니다 :

```csharp
[ NOTICE ] Server starting on http://127.0.0.1:8080
```

To double-check that you can access the server, launch your favorite web browser and open the following address: http://localhost:8080/hello.
서버에 액세스할 수 있는지 다시 확인하려면 즐겨찾기 웹 브라우저를 실행하고 다음 주소( http://localhost:8080/hello)를 엽니다.

This contacts the book server running on your computer, which will respond with the current date:
컴퓨터에서 실행 중인  book server 에 연락하여 현재 날짜로 응답 받습니다.

Later, when you’ve finished working on a given project and want to stop the server, switch to your Terminal window and press **Control-C** to end the server process.
나중에 지정된 프로젝트 작업을 완료하고 서버를 중지하려면 터미널 창으로 전환하고 **Control-C** 를 눌러 서버 프로세스를 종료합니다.

> Note: The server itself is a Swift package using the Vapor framework, but this book won’t cover that code. If you’re curious, you’re welcome to open it in Xcode and read through it. Additionally, you can learn all about using Vapor by working through Server-Side Swift with Vapor.
> 

Note. 서버 자체는 Vapor 프레임워크를 사용하는 스위프트 패키지지만 이 책에서는 해당 코드를 다루지 않습니다. 궁금하다면 xcode로 열어서 읽어보셔도 좋습니다. 또한 Server-Side Swift with Vapor를 통해 사용에 대한 모든 것을 배울 수 있습니다.

<br>

### Getting started with LittleJohn
LittleJohn 부터 시작하기

As with all projects in this book, LittleJohn’s SwiftUI views, navigation, and data model are already wired up and ready for you. It’s a simple ticker app that displays selected “stock prices” live:
이 책의 모든 프로젝트와 마찬가지로 LittleJohn의 SwiftUI의 화면, 네비게이션 및 데이터 모델은 이미 연결되어 있으며 선택한 “stock prices”를 실시간으로 보여주는 간단한 앱입니다 :

> Note: The server sends random numbers to the app. Don’t read anything into any upward or downward trends of these fictitious prices!
> 

Note. 서버는 앱에 임의의 숫자를 보냅니다. 이러한 가상의 가격의 상승 또는 하락 추세를 어떤 것도 읽지 마십시오!

As mentioned earlier, simply *go with the flow* in this chapter and enjoy working on the app. Don’t worry if you don’t entirely understand every detail and line of code. You’ll revisit everything you do here in later chapters, where you’ll learn about all the APIs in greater detail.
앞서 언급했듯이, 이 장에서 간단히 흐름에 따라 작업하고 앱 작업을 즐기십시오. 모든 세부 사항과 코드 라인을 완전히 이해하지 못하더라도 걱정하지 마십시오. 여기서 수행하는 모든 작업은 나중에 다시 확인할 수 있으며, 모든 API에 대해 자세히 배울 수 있습니다.

The first thing you need to do is to add some asynchronous code to the main app screen.
먼저 메인 앱 화면에 비동기 코드를 추가해야 합니다.

<br>

### **Writing your first `async`/`await`**

첫번째 async/await 작성하기

As your first task, you’ll add a function to the app’s model that fetches a list of available stocks from the web server in JSON format. That’s a very common task in iOS programming, so it’s a fitting first step.
첫번째 작업으로 웹 서버에서 사용 가능한 주식 목록을 JSON 형식으로 가져오는 기능을 앱 모델에 추가합니다. iOS 프로그래밍에서 첫번째 작업으로 적합합니다.

Open the starter version of LittleJohn in this chapter’s materials, under **projects/starter**. Then, open **LittleJohnModel.swift** and add a new method inside `LittleJohnModel`:
이 장의 자료인 **projects/starter**에서 LittleJohn의 starter version을 엽니다. 그런 다음 **LittleJohnModel.swift** 를 열고 `LittleJohnModel`에 새 메서드를 추가합니다.

```swift
 func availableSymbols() async throws -> [String] {
  guard let url = URL(string: "http://localhost:8080/littlejohn/symbols")
  else {
    throw "The URL could not be created."
  }
}
```

Whoa, those are some major modern-concurrency features right here!
와, 이게 바로 modern-concurrency 특징들입니다.

The `async` keyword in the method’s definition lets the compiler know that the code runs in an asynchronous context. In other words, it says that the code might suspend and resume at will. Also, regardless of how long the method takes to complete, it ultimately returns a value much like a synchronous method does.
메소드 정의에 있는 `async` 키워드는 컴파일러 코드가 비동기적인 상황에서 실행된다는 것을 알려줍니다. 다시 말해, 코드가 마음대로 중단되었다가 재개될 수도 있다는 것입니다. 또한 메소드가 완료하는데 걸리는 시간에 관계없이 궁극적으로 동기적 메소드처럼 값을 반환합니다.

> **Note**: The starter projects in this book contain an extension on `String` so you can simply throw strings instead of creating custom error types.
> 

Note. 이 책의 스타터 프로젝트는 `String` 의 확장자를 포함하고 있으므로 사용자 지정 오류 유형을 만들지 않고 간단하게 문자열을 던질 수 있습니다.

Next, at the bottom of the new `availableSymbols()` method, add the code below to call `URLSession` and fetch data from the book server:
다음으로, 새로운 `availableSymbols()` 메서드의 하단에 아래 코드를 추가하여 `URLSession`을 호출하고 book server에서 데이터를 가져옵니다:

```swift
let (data, response) = try await URLSession.shared.data(from: url)
```

Calling the `async`  method  `URLSession.data(from:delegate:)`  suspends  `availableSymbols()`  and resumes it when it gets the data back from the server:
`async` 메서드 `URLSession.data(from:delegate:)`를 호출하면 `availableSymbols()`를 일시 중단하고 서버에서 데이터를 가져올 때 다시 시작합니다:

Using `await` gives the runtime a **suspension point**: a place to *pause* your method, consider if there are other tasks to run first and then continue running your code.
`await`를 사용하면 런타임이  **suspension point**를 제공합니다: 메서드를 일시 중지할 수 있습니다. 먼저 실행해야 할 다른 작업이 있는지 고려한 다음 코드를 계속 실행하십시오.

It’s *so neat* that you make an asynchronous call but never have to worry about threads or passing closures around!
비동기식으로 호출하는 것은 *so neat*이지만 thread 또는 passing closures 를 전달하는 것에 대해 걱정할 필요가 없습니다.

Next, you need to verify the server response and return the fetched data. Append this code to complete your method:
다음으로 서버 응답을 확인하고 가져온 데이터를 반환해야 합니다. 이 코드를 추가하면 메소드가 완성됩니다:

```swift
guard (response as? HTTPURLResponse)?.statusCode == 200 else {
  throw "The server responded with an error."
}

return try JSONDecoder().decode([String].self, from: data)
```

First, you check that the response code is `200`. In server language, this indicates a successful **OK** response. Then, you try to decode the response data as a list of `String`s. If that succeeds, you return the result.
먼저 응답 코드가 `200` 인지 확인합니다. 서버 언어에서 이는 `OK` 는 응답이 성공했음을 나타냅니다. 그런 다음 응답 데이터를 String의 목록으로 디코딩하려고 합니다. 성공하면 결과를 반환합니다.

You’ll learn about `async`/`await` in greater detail in Chapter 2, “Getting Started With async/await”.
`async`/`await`에 대해서는 2장 “Getting Started With async/await”에서 자세히 설명합니다.

> **Note**: Web servers can respond with a myriad of status codes; this book won’t cover them all. Check out this list if you want to know more: [HTTP status codes](https://bit.ly/2YzI2ww).
> 

Note. 웹 서버는 무수히 많은 상태 코드로 대응할 수 있습니다. 이 책이 모든 것을 다 다루는 것은 아닙니다. 더 알고 싶다면 이 목록을 확인하세요 : [HTTP status codes](https://bit.ly/2YzI2ww).
