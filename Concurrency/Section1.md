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

### Understanding asynchronous and concurrent code
비동기 및 동기 코드 이해

Most code runs the same way you see it written in your code editor: from top to bottom, starting at the beginning of your function and progressing line-by-line to the end.
대부분의 코드는 코드 편집기에서 작성된 것과 같은 방식으로 실행됩니다. 위에서 아래로, 기능의 시작 부분에서 시작하여 줄 단위로 끝까지 진행됩니다.

This makes it easy to determine when any given code line executes — it simply follows the one before it. The same is true for function calls: When your code runs **synchronously**, the execution happens sequentially.
이를 통해 주어진 코드 라인이 실행되는 시기를 쉽게 결정할 수 있습니다. 단순히 이전 코드 라인을 따릅니다. 함수 호출에 대해서도 마찬가지입니다. 코드가 동시에 실행되면 실행이 순차적으로 발생합니다.

In a synchronous context, code runs in one **execution thread** on a single CPU core. You can imagine synchronous functions as cars on a single-lane road, each driving behind the one in front of it. Even if one vehicle has a higher priority, like an ambulance on duty, it cannot “jump over” the rest of the traffic and drive faster.
동기적 맥락에서 코드는 하나의 CPU 코어의 하나의 실행 스레드에서 실행됩니다. 단일 차선 도로에서 자동차와 같은 동기식 기능을 상상할 수 있으며, 한 차량이 근무 중인 구급차와 같이 우선 순위가 높은 경우 나머지 차량을 "jump over" 하여 더 빠르게 운전할 수 없습니다.

On the other hand, iOS apps and Cocoa-based macOS apps are inherently **asynchronous**.
반면 iOS 앱과 Cocoa 기반 maOS 앱은 본질적으로 비동기적입니다.

Asynchronous execution allows different pieces of the program to run in any order on one thread — and, sometimes, *at the same time* on multiple threads, depending on many different events like user input, network connections and more.
비동기 실행을 사용하면 사용자 입력, 네트워크 연결 등 여러 가지 이벤트에 따라 하나의 thread에서 다른 프로그램 조작을 순서대로 실행할 수 있고 때로는 여러 thread에서 동시에 실행할 수도 있습니다. 특히 여러 비동기 함수가 동일한 thread를 사용해야 하는 경우에는 비동기적인 맥락에서 함수가 실행되는 순서를 정확히 말하기가 어렵습니다.

In an asynchronous context, it’s hard to tell the *exact order* in which functions run, especially when several asynchronous functions need to use the same thread. Just like driving on a road where you have stoplights and places where traffic needs to yield, functions must sometimes wait until it’s their turn to continue, or even stop until they get a green light to proceed.

신호등이 있는 도로와 교통질서가 필요한 곳에서 운전하는 것처럼, 기능은 때때로 차례가 될 때까지 기다리거나 녹색 빛이 진행될 때까지 멈춰야합니다. 신호등이있는 도로와 트래픽이 필요한 곳에서 운전하는 것처럼, 기능은 때때로 차례가 계속 될 때까지 기다리거나 녹색 빛이 진행될 때까지 멈추어야합니다.

One example of an asynchronous call is making a network request and providing a completion closure to run when the web server responds. While waiting to run the completion callback, the app uses the time to do other chores.

비동기 호출의 한 예는 네트워크 요청을 하고 웹 서버가 응답할 때 실행할 완료 폐쇄를 제공하는 것이고, 완료 콜백을 실행하기 위해 대기하는 동안 앱은 다른 작업를 수행하는 시간을 사용합니다.

To intentionally run parts of your program **in parallel**, you use **concurrent** APIs. Some APIs support executing a fixed number of tasks at the same time; others start a concurrent group and allow an arbitrary number of concurrent tasks.
프로그램의 일부를 의도적으로 병렬로 실행하려면 동시 API를 사용합니다. 어떤 API는 고정된 수의 작업을 동시에 실행할 수 있도록 지원하고, 다른 API는 동시 그룹을 시작하여 임의 수의 동시 작업을 허용합니다.

This also causes a myriad of concurrency-related problems. For example, different parts of the program might block each other’s execution, or you might encounter the much-loathed **data-races**, where two or more functions simultaneously access the same variable, crashing the app or unexpectedly corrupting your app’s state.
이로 인해 수많은 동시성 관련 문제가 발생하기도 합니다. 예를 들어, 프로그램의 서로 다른 부분이 서로의 실행을 차단하거나 둘 이상의 함수가 동일한 변수에 동시에 액세스하여 앱이 다운되거나 예기치 않게 앱의 상태가 손상되는, 혐오스러운 데이터 레이스와 마주칠 수 있습니다.

However, when used with care, concurrency can help your program run faster by executing different functions simultaneously on multiple CPU cores, the same way careful drivers can move much faster on a multi-lane freeway.
그러나 주의 깊게 사용할 때 동시성은 여러 CPU 코어에서 동시에 다른 기능을 실행함으로써 프로그램을 더 빠르게 실행할 수 있도록 도와주며, 이는 주의 깊은 운전자들이 다차선 고속도로에서 훨씬 더 빠르게 이동할 수 있게 해줍니다.

Multiple lanes allow faster cars to go around slower vehicles. Even more importantly, you can keep the emergency lane free for high-priority vehicles, like ambulances or firetrucks.
여러 차선을 통해 더 빠른 차량이 느린 차량을 돌아 다닐 수 있습니다. 더 중요한 것은 구급차 나 소방차와 같은 우선 순위가 높은 차량의 응급 차선을 무료로 유지할 수 있습니다.

Similarly, when executing code, high-priority tasks can “jump” the queue before lower-priority tasks, so you avoid blocking the main thread and keep it free for critical updates to the UI.
마찬가지로 코드를 실행할 때 우선 순위가 높은 작업은 우선 순위가 낮은 작업 전에 큐를 "jump"할 수 있으므로 기본 스레드를 차단하지 않고 UI에 대한 중요한 업데이트를 위해 무료로 유지합니다.

A real use-case for this is a photo browsing app that needs to download a group of images from a web server *at the same time*, scale them down to thumbnail size and store them in а cache.

이를 위한 실제 사용 사례는 웹 서버*에서 동시에*에서 이미지 그룹을 다운로드 해야하는 사진 브라우징 앱입니다.

While asynchrony and concurrency both sound great, you might ask yourself: “Why did Swift need a *new* concurrency model?”. You’ve probably worked on apps that used at least some of the features described above in the past.
비동기성과 동시성이 둘 다 잘 들리지만, "Swift가 왜 *new* 동시성 모델을 필요로 했는가?"라고 스스로에게 물을 수도 있습니다. 여러분은 아마 과거에 위에서 설명한 기능 중 적어도 일부를 사용한 앱을 작업한 적이 있을 것입니다.

Next, you’ll review the pre-Swift 5.5 concurrency options and learn what’s different about the new `async`/`await` model.
다음은 스위프트 5.5 이전 동시 옵션을 검토하고 새로운 비동기/기다림 모델의 차이점에 대해 알아보겠습니다.

**Reviewing the existing concurrency options**
기존 concurrency 옵션 검토

Pre-Swift 5.5, you used GCD to run asynchronous code via dispatch queues — an abstraction over threads. You also used older APIs that are ‘closer to the metal’, like `Operation`, `Thread` or even interacting with the C-based `pthread` library directly.
스위프트 5.5 이전에는 GCD를 사용하여 디스패치큐를 통해 비동기 코드를 실행했습니다. 스레드에 대한 추상화입니다. 또한 `Operation`,`Thread` 등과 같이 ‘closer to the metal’ 오래된 API를 사용하거나 C 기반의 `pthread` 라이브러리와 직접 상호작용하는 방법도 사용했습니다.

> **Note**: You won’t use GCD in this book because the new Swift concurrency APIs have replaced it. If you’re curious, read Apple’s GCD documentation: [Dispatch documentation](https://apple.co/3tOlEuO).
> 

Note. 새로운 Swift concurrency API가 GCD를 대체했기 때문에 이 책에서는 GCD를 사용하지 않을 것입니다. 궁금하다면 Apple의 GCD 문서: [Dispatch documentation](https://apple.co/3tOlEuO) 를 읽어보세요

Those APIs all use the same foundation: **POSIX threads**, a standardized execution model that doesn’t rely on any given programming language. Each execution flow is a **thread**, and multiple threads might overlap and run at the same time, similarly to the multi-lane car example presented above.
이 API들은 모두 동일한 기초를 사용합니다. **POSIX threads**, 주어진 프로그래밍 언어에 의존하지 않는 표준화된 실행 모델입니다. 각 실행 흐름은 **thread**이며, 위에 제시된 다차선 차량 예제와 같이 여러 개의 스레드가 겹쳐서 동시에 실행될 수 있습니다.

Thread wrappers like `Operation` and `Thread` require you to **manually manage** execution. In other words, you’re responsible for creating and destroying threads, deciding the order of execution for concurrent jobs and synchronizing shared data across threads. This is error-prone and tedious work.
`Operation` and `Thread`와 같은 스레드 래퍼에서는 수동으로 실행을 관리해야 합니다. 즉, 스레드를 생성하고 삭제하며 동시 작업에 대한 실행 순서를 결정하고 스레드 간 공유 데이터를 동기화하는 역할을 수행합니다. 오류가 발생하기 쉽고 지루한 작업입니다. 

GCD’s queue-based model worked well. However, it would often cause issues, like:
GCD의 큐 기반 모델은 잘 작동했지만 종종 다음과 같은 문제가 발생했습니다:

- **Thread explosion**: Creating too many concurrent threads requires constantly switching between active threads. This ultimately *slows down* your app.
너무 많은 동시 스레드를 만들려면 활성 스레드 간에 지속적으로 전환해야 합니다. 이렇게 하면 궁극적으로 속도가 느려집니다.
- **Priority inversion**: When arbitrary, low-priority tasks block the execution of high-priority tasks waiting in the same queue.
임의의 우선순위가 낮은 작업이 동일한 대기열에서 대기 중인 우선순위가 높은 작업의 실행을 차단하는 경우
- **Lack of execution hierarchy**: Asynchronous code blocks lacked an execution hierarchy, meaning each task was managed independently. This made it difficult to cancel or access running tasks. It also made it complicated for a task to return a result to its caller.
비동기 코드 블록은 실행 계층이 부족하여 각 작업을 독립적으로 관리할 수 없습니다. 또한 작업이 호출자에게 결과를 반환하는 것을 어렵게 했습니다. 또한 작업이 호출자에게 결과를 반환하는 것을 어렵게 했습니다.

To address these shortcomings, Swift introduced a brand-new concurrency model. Next, you’ll see what modern concurrency in Swift is all about!
이러한 단점을 해결하기 위해 스위프트는 새로운 동시성 모델을 도입했습니다. 다음은 스위프트의 modern concurrency가 무엇인지 확인하실 수 있을 것입니다.

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

<br>

### **Using async/await in SwiftUI**

SwiftUI에서 async/await 사용

Press **Command-B** to compile the project and verify you correctly added all the code so far, but don’t run it just yet. Next, open **SymbolListView.swift**, where you’ll find the SwiftUI code for the symbol list screen.
**Command-B**를 눌러 프로젝트를 컴파일하고 지금까지의 모든 코드를 올바르게 추가했는지 확인하지만 아직 실행하지 마십시오. 다음으로 **SymbolListView.swift**를 열면 symbol 목록 화면에 대한 SwiftUI 코드가 나타납니다.

The essential part here is the `ForEach` that displays the `symbols` in a list onscreen. You need to call `LittleJohnModel.availableSymbols()`, which you just created, and assign its result to `SymbolListView.symbols` to get everything to work together.
여기서 가장 중요한 부분은 화면에 `symbol`을 나열하는 `ForEach` 입니다. 방금 만든 `LittleJohnModel.availableSymbols()`에 호출해서 `SymbolListView.symbols`에 그 결과를 할당하면 모든 것이 함께 작동합니다.

Inside `SymbolListView.body`, find the `.padding(.horizontal)` view modifier. Add the following code immediately below it:
`SymbolListView.body` 안에서 `.padding(.horizontal)` view modifier를 찾습니다. 바로 아래에 다음 코드를 추가합니다.

```swift
.onAppear {
  try await model.availableSymbols()
}
```

If you’re paying attention to Xcode, you’ll notice that the method `availableSymbols()` is grayed out in the code’s autocompletion:
xcode에 주의를 기울인다면 `availableSymbols()`가 코드의 자동 완성에서 회색으로 표시됩니다.

You’ll also see the compiler rightfully complain:
또한 컴파일러가 정당하게 불만을 제기할 수 있습니다:

```
Invalid conversion from throwing function of type '() async throws -> Void' to non-throwing function type '() -> Void'
```

Xcode tells you that `onAppear(...)` runs code synchronously; however, you’re trying to call an asynchronous function in that non-concurrent context.
xcode는 `onAppear(...)`가 코드를 동기적으로 실행한다는 것을 알려주지만, 비동기적인 상황에서 비동기 함수를 호출하려고 하는 것입니다. 

Luckily, you can use the `.task(priority:_:)` view modifier instead of `onAppear(...)`, which will allow you to call asynchronous functions right away.
다행히 `onAppear(...)` 대신 `.task(priority:_:)`  view modifier 를 사용하면 비동기 함수를 바로 호출할 수 있습니다.

Remove `onAppear(...)` and replace it with:
`onAppear(...)` 를 제거하고 다음 항목으로 바꿉니다:

```swift
.task {
  guard symbols.isEmpty else { return }
}
```

`task(priority:_:)` allows you to call asynchronous functions and, similarly to `onAppear(_:)`, is called when the view appears onscreen. That’s why you start by making sure you don’t have symbols already.
`task(priority:_:)`를 사용하면 비동기 함수를 호출할 수 있고, 화면에 화면이 나타나면 `onAppear(_:)` 와 마찬가지로 호출하기 대문에 이미 symbol가 없는지 확인하는 것부터 시작합니다.

Now, to call your new async function, append the following inside the `task { ... }` modifier:
이제 새 비동기 함수를 호출하면 `task { ... }` modifier 안에 다음을 추가합니다.

```swift
do {
  symbols = try await model.availableSymbols()
} catch {

}
```

As before, you use both `try` and `await` to signify that the method might either throw an error or asynchronously return a value. You assign the result to `symbols`, and … that’s all you need to do.
이전과 마찬가지로 `try` 와 `await` 를 모두 사용하여 메서드가 오류를 던지거나 값을 비동기적으로 반환할 수 있음을 나타냅니다. 결과를 `symbol`에 할당하면 됩니다.

You’ll notice the `catch` portion is still empty. You’ll definitely want to handle the erroneous case where `availableSymbols` can’t provide a valid response.
`catch` 부분은 아직 비어 있습니다. `availableSymbols`에서 제대로 된 응답을 할 수 없는 잘못된 경우를 처리해야 합니다.

The UI in the starter project has already been wired to display an alert box if you update `lastErrorMessage`, so you’ll use that functionality here. Add the following line inside the empty `catch` block:
starter project의 UI는 `lastErrorMessage`를 업데이트하면 alert box 가 표시되도록 이미 유선으로 연결되어 있으므로 여기서 해당 기능을 사용합니다. 빈 `catch` 블록 안에 다음 줄을 추가합니다:

```swift
lastErrorMessage = error.localizedDescription
```

Swift catches the error, regardless of which thread throws it. You simply write your error handling code as if your code is entirely synchronous. Amazing!
어떤 thread가 오류를 던지든 상관없이 스위프트가 오류를 잡아냅니다. 코드가 완전히 동기화된 것처럼 오류 처리 코드를 작성하면 됩니다. 놀랍습니다!

Quickly check that the server is still running in your Terminal, then build and run the app.
터미널에서 서버가 아직 실행 중인지 빠르게 확인한 다음 앱을 빌드하고 실행합니다.

As soon as the app launches, you’ll briefly see an activity indicator and then a list of stock symbols:
앱이 실행되는 즉시 활동 표시기와 주식 심볼 목록이 표시됩니다.

Awesome! Your next task is to test that the asynchronous error handling works as expected. Switch to Terminal and press **Control-C** to stop the book server.
대단합니다! 다음 작업은 비동기 오류 처리가 예상대로 작동하는지 테스트하는 것입니다. 터미널로 전환하고  **Control-C** 눌러서 book server를 중지합니다.

Run your project one more time. Now, your `catch` block will handle the error and assign it to `lastErrorMessage`. Then, the SwiftUI code will pick it up and an alert box will pop up:
프로젝트를 한 번 더 실행합니다. 이제 `catch` 블록에서 오류를 처리하여 `lastErrorMessage` 에 할당합니다. 그러면 SwiftUi 코드가 해당 오류를 수신하고 경고 팝업이 나타납니다.

Writing modern Swift code isn’t that difficult after all, is it?
I get it if you’re excited about how few lines you needed here for your networking. To be honest, I’m excited, too; I really needed to restrain myself from ending every sentence with an exclamation mark!
modern Swift 코드를 쓰는 것이 그렇게 어렵지 않죠?

(감탄)

<br>

### **Using asynchronous sequences**

Even though this is just the introduction of this book, you’ll still get to try out some more advanced topics — namely, asynchronous sequences.
이 책은 책의 서론에 불과하지만 몇 가지 비동기 순서를 시도해 볼 수 있는 토픽이 있습니다.

Asynchronous sequences are similar to the “vanilla” Swift sequences from the standard library. The *hook* of asynchronous sequences is that you can iterate over their elements asynchronously as more and more elements become available over time.
비동기 시퀀스는 표준 라이브러리의  “vanilla”  스위프트 시퀀스와 비슷합니다. 비동기 시퀀스는 hook은 시간이 지남에 따라 점점 더 많은 요소를 사용할 수 있게 됨에 따라 요소를 비동기적으로 반복할 수 있다는 것입니다. 

Open **TickerView.swift**. This is a SwiftUI view, similar in structure to `SymbolListView`. It revolves around a `ForEach` that displays stock price changes over time.
**TickerView.swift** 를 여십시오. `SymbolListView` 와 유사한 SwiftUI 뷰입니다. 시간에 따른 주가 변동을 보여주는 `ForEach` 를 중심으로 구성되어 있습니다.

In the previous section, you “fired” an async network request, waited for the result, and then returned it. For `TickerView`, that same approach won’t work because you can’t wait for the request to complete and *only then* display the data. The data needs to keep coming in indefinitely and bring in those price updates.
이전 섹션에서 비동기 네트워크 요청을 “fired”하고 결과를 기다렸다가 반환했습니다. `TickerView` 의 경우 요청이 완료될 때까지 기다릴 수 없기 때문에 동일한 접근 방식은 작동하지 않습니다. 데이터는 계속해서 유입되어 가격 업데이트를 가져와야 합니다.

Here, the server will send you a single long-living response, adding more and more text to it over time. Each text line is a complete JSON array that you can decode on its own:
여기서 서버는 하나의 long-living 응답을 전송하여 시간이 지남에 따라 점점 더 많은 텍스트를 추가합니다. 각 텍스트 라인은 자체적으로 디코딩할 수 있는 완벽한 JSON 배열입니다:

```jsx
[{"AAPL": 102.86}, {"BABA": 23.43}]
// .. waits a bit ...
[{"AAPL": 103.45}, {"BABA": 23.08}]
// .. waits some more ...
[{"AAPL": 103.67}, {"BABA": 22.10}]
// .. waits even some more ...
[{"AAPL": 104.01}, {"BABA": 22.17}]
// ... continuous indefinitely ...

```

On the live ticker screen, you’ll iterate over each line of the response and update the prices onscreen in real time!
실시간 티커 화면에서는 반응의 각 라인을 반복하며 실시간으로 가격을 업데이트할 수 있습니다.

In `TickerView`, find `.padding(.horizontal)`. Directly below that line, add a `task` modifier and call the model’s method that starts the live price updates:
`TickerView` 에서 `.padding(.horizontal)` 을 찾고 그 선 바로 아래에 task modifier를 추가하고 실시간 가격 업데이트를 시작하는 모델의 메소드를 호출합니다:

```swift
.task {
  do {
    try await model.startTicker(selectedSymbols)
  } catch {
    lastErrorMessage = error.localizedDescription
  }
}

```

The code looks similar to what you did in `SymbolListView`, except that the method doesn’t return a result. You’ll be handling continuous updates, not a single return value.
코드는 `SymbolListView` 에서 했던 것과 비슷하게 생겼지만 결과를 반환하지 않는다는 점을 제외하고는 하나의 반환 값이 아닌 지속적인 업데이트를 처리하게 됩니다.

Open **LittleJohnModel.swift** and find the `startTicker(_:)` placeholder method, where you’ll add your live updates. A published property called `tickerSymbols` is already wired up to the UI in the ticker screen, so updating this property will propagate the changes to your view.
**LittleJohnModel.swift** 를 열고 라이브 업데이트를 추가할 `startTicker(_:)` placeholder 메서드를 찾습니다. `tickerSymbols` 라는 게시된 속성이 이미 티커 화면의 UI에 연결되어 있으므로 이 속성을 업데이트하면 변경 내용이 뷰에 전파됩니다. 

Next, add the following code to the end of `startTicker(_:)`:
다음으로 `startTicker(_:)` 의 끝에 다음 코드를 추가합니다.

```swift
let (stream, response) = try await liveURLSession.bytes(from: url)

```

`URLSession.bytes(from:delegate:)` is similar to the API you used in the previous section. However, instead of data, it returns an asynchronous sequence that you can iterate over time. It’s assigned to `stream` in your code.
`URLSession.bytes(from:delegate:)` 는 앞에서 사용한 API와 유사합니다. 그러나 데이터 대신 시간을 두고 반복할 수 있는 비동기 시퀀스를 반환합니다. 코드의 stream에 할당됩니다. 

Additionally, instead of using the shared URL session, you use a custom pre-configured session called `liveURLSession`, which makes requests that never expire or time out. This lets you keep receiving a super-long server response indefinitely.
또한 공유 URL 세션을 사용하는 대신 사전에 설정된 사용자 정의 세션인 `liveURLSession` 을 사용하여 절대 만료되지 않거나 타임아웃되지 않는 요청을 할 수 있으므로 서버 응답이 무한정 길어질 수 있습니다.

Just as before, the first thing to do is check for a successful response code. Add the following code at the end of the same function:
이전과 마찬가지로 가장 먼저 성공한 응답 코드를 확인하는 것입니다. 동일한 기능의 끝에 다음 코드를 추가합니다:

```swift
guard (response as? HTTPURLResponse)?.statusCode == 200 else {
  throw "The server responded with an error."
}

```

Now comes the fun part. Append a new loop:
이제 재미있는 부분이 나옵니다. 새로운 루프를 추가합니다:

```swift
for try await line in stream.lines {

}

```

`stream` is a sequence of bytes that the server sends as a response. `lines` is an abstraction of that sequence that gives you that response’s lines of text, one by one.
`stream` 은 서버가 응답으로 보내는 바이트 시퀀스입니다. `lines` 은 해당 시퀀스를 추상화한 것으로 응답의 텍스트 라인을 하나씩 제공합니다.

You’ll iterate over the lines and decode each one as JSON. To do that, insert the following inside the `for` loop:
line을 반복하거나 각각의 JSON을 디코딩합니다. 이를 위해서는 `for` 문 안에 다음을 삽입합니다.

```swift
let sortedSymbols = try JSONDecoder()
  .decode([Stock].self, from: Data(line.utf8))
  .sorted(by: { $0.name < $1.name })

tickerSymbols = sortedSymbols

```

If the decoder successfully decodes the line as a list of symbols, you sort them and assign them to `tickerSymbols` to render them onscreen. If the decoding fails, `JSONDecoder` simply throws an error.
디코더가 line을 symbol 목록으로 디코딩에 성공하면 line을 정렬한 후 `tickerSymbols` 로 지정하여 화면에 표시합니다. 디코딩에 실패하면 `JSONDecoder` 는 오류만 발생합니다.

Run the book server again if it’s still turned off from your last error handling test. Then, build and run the app. In the first screen, select a few stocks:
마지막 오류 처리 테스트에서 여전히 꺼져 있는 경우 book server를 다시 실행한 다음 앱을 빌드하고 실행합니다. 첫 화면에서 몇 가지 항목을 선택합니다:

Then tap **Live ticker** to see the live price updates on the next screen:
그런 다음 **Live ticker**를 눌러 다음 화면에서 라이브 가격 업데이트를 확인합니다:

Though you’ll most likely see some price updates, you’ll also notice glitches and a big purple warning in your code editor saying `Publishing changes from background threads is not allowed...`.

가격 업데이트가 있을 가능성이 높지만 코드 편집기에 `배경 스레드에서 변경된 내용을 게시할 수 없습니다.` 라는 경고문이 크게 뜹니다.

### Updating your UI from the main thread

메인 스레드에서 UI 업데이트

Earlier, you published updates by updating a `@State` property, and SwiftUI took care to route the updates through the main thread. Now, you update `tickerSymbols` from within the same context where you’re running your asynchronous work, without specifying that it’s a UI update, so the code ends up running on an arbitrary thread in the pool.
이전에는 `@State` 속성을 업데이트하여 업데이트를 게시했는데 SwiftUI는 업데이트를 메인 스레드로 라우팅하는데 주의했습니다. 이제는 UI 업데이트라고 명시하지 않고 비동기 작업을 실행하는 동일한 컨텍스트 내에서 `tickerSymbols` 를 업데이트하므로 코드가 풀의 임의 스레드에서 실행됩니다.

This causes SwiftUI some grief because it naturally expects your code to be kosher when it updates the UI.
이것은 SwiftUI가 UI 업데이트를 할 때 자연스럽게 당신의 코드가 더 간결해질 것을 기대하기 때문에 약간의 슬픔을 야가힙니다.

Luckily, you can switch to the main thread any time you need to. Replace the line `tickerSymbols = sortedSymbols` with the following code:
다행히 필요할 때 언제든지 메인 스레드로 전환할 수 있습니다. `tickerSymbols = sortedSymbols` 행을 다음 코드로 바꿔줍니다.

```swift
await MainActor.run {
  tickerSymbols = sortedSymbols
  print("Updated: \(Date())")
}

```

`MainActor` is a type that runs code on the main thread. You can easily run any code with it by calling `MainActor.run(_:)`
`MainActor` 는 메인 스레드에서 코드를 실행하는 타입입니다. `MainActor.run(_:)` 을 호출하면 어떤 코드라도 쉽게 실행할 수 있습니다.

The extra `print` in there helps you check that your updates come through.
거기에 있는 여분의 `print` 은 업데이트가 완료되었는지 확인하는데 도움이 됩니다.

Run the app and go to the live prices screen. This time around, you’ll see the prices continuously go up and down:
앱을 실행하고 라이브 가격 화면으로 이동하면 이번에는 가격이 계속해서 오르내리는 것을 볼 수 있습니다.

Hopefully, you enjoyed this first encounter with asynchronous sequences. You’ll learn a great deal more about them in Chapter 3, “AsyncSequence & Intermediate Task”.
여러분이 비동기 시퀀스를 처음 접하셨어도 즐거웠기를 바랍니다. 3장 AsyncSequence & Intermediate Task”.에서 이들에 대해 더 많은 것을 배울것입니다.

<br>

### **Canceling tasks in structured concurrency**

As mentioned earlier, one of the big leaps for concurrent programming with Swift is that modern, concurrent code executes in a structured way. Tasks run in a strict hierarchy, so the runtime knows who’s the parent of a task and which features new tasks should inherit.
앞서 언급했듯이 스위프트와의 동시 프로그래밍을 위한 큰 도약 중 하나는 현대적인 동시 코드가 구조화된 방식으로 실행된다는 것입니다. task는 엄격한 계층 구조에서 실행되므로 런타임은 누가 task의 상위이고 어떤 기능이 새로운 task를 상속해야 하는지 알 수 있습니다. 

For example, look at the `task(_:)` modifier in `TickerView`. Your code calls `startTicker(_:)` asynchronously. In turn, `startTicker(_:)` asynchronously *awaits* `URLSession.bytes(from:delegate:)`, which returns an async sequence that you iterate over:
예를 들어 `TickerView` 에 있는 `task(_:)` modifier를 보면 코드는 `startTicker(_:)` 를 비동기적으로 호출합니다. 그러면 `startTicker(_:)` 는 비동기적으로 `URLSession.bytes(from:delegate:)`를 반환합니다.

At each suspension point — that is, every time you see the `await` keyword — the thread could potentially change. Since you start the entire process inside `task(_:)`, the async task is the parent of all those other tasks, regardless of their execution thread or suspension state.
각 서스펜드 포인트에서 즉 `await` 키워드를 볼 때마다 스레드가 변경될 수 있습니다. `task(_:)` 에서 전체 프로세스를 시작하므로 비동기 task는 실행 스레드 또는 서스펜드 상태와 관계없이 다른 모든 task의 상위 task 가 됩니다. 

The `task(_:)` view modifier in SwiftUI takes care of canceling your asynchronous code when its view goes away. Thanks to structured concurrency, which you’ll learn much more about later in this book, all asynchronous tasks are also canceled when the user navigates out of the screen.
SwfitUI의 `task(_:)` view modifier는 뷰가 사라지면 비동기 코드를 취소하는 처리를 수행합니다. 이 책에서 자세히 다루게 될 구조화된 동시성 덕분에 사용자가 화면을 벗어나면 비동기 작업도 모두 취소됩니다.

To verify how this works in practice, navigate to the updates screen and look at the Xcode console to check that you see the debug prints from `LittleJohnModel.startTicker(_:)`:
이것이 실제로 어떻게 작동하는지 확인하려면 업데이트 화면으로 이동하여 xcode 콘솔을 보고 `LittleJohnModel.startTicker(_:)` 의 디버그 print가 표시되는지 확인합니다.

```
Updated: 2021-08-12 18:24:12 +0000
Updated: 2021-08-12 18:24:13 +0000
Updated: 2021-08-12 18:24:14 +0000
Updated: 2021-08-12 18:24:15 +0000
Updated: 2021-08-12 18:24:16 +0000
Updated: 2021-08-12 18:24:17 +0000
Updated: 2021-08-12 18:24:18 +0000

```

Now, tap **Back**. `TickerView` disappears and the `task(_:)` view modifier’s task is canceled. This cancels all child tasks, including the call to `LittleJohnModel.startTicker(_:)`. As a result, the debug logs in the console stop as well, verifying that all execution ends!
이제 **Back** 누릅니다. `TickerView` 가 사라지고 `task(_:)` view modifier의 작업이 취소됩니다. 그러면 `LittleJohnModel.startTicker(_:)` 에 대한 호출을 포함한 모든 하위 작업이 취소됩니다. 따라서 콘솔의 디버그 로그도 중지되고 모든 실행이 종료됨을 확인합니다.

You’ll notice, however, an additional message in the console that looks something like:
그러나 콘솔에 다음과 같은 추가 메시지가 표시됩니다.

```csharp
[Presentation] Attempt to present <SwiftUI.PlatformAlertController: 0x7f8051888000> on ... whose view is not in the window hierarchy.

```

SwiftUI is logging an issue with your code trying to present an alert after you dismiss the ticker view. This happens because some of the inner tasks throw a cancellation error when the runtime cancels your call to `model.startTicker(selectedSymbols)`.
사용자가 티커 뷰를 취소한 후 SwiftUI가 코드에 경고를 표시하는 문제를 출력하고 있습니다. 이 문제는 런타임이 `model.startTicker(selectedSymbols)` 에 대한 호출을 취소할 때 내부 작업 중 일부에서 취소 오류가 발생하기 때문에 발생합니다.

<br>

### Handling cancellation errors

Sometimes you don’t care if one of your suspended tasks gets canceled. Other times — like the current situation with that pesky alert box — you’d like to do something special when the runtime cancels a task.
때로는 중단 된 작업 중 하나가 취소더라도 신경쓰지 않습니다. 어떤 경우(현재 상황과 같은 성가신 알림 상자)에는 런타임이 작업을 취소할 때 특별한 작업을 수행하고자 할 때도 있습니다.
Scroll to the task { ... } modifier in TickerView. Here, you catch all the errors and store their messages for display. However, to avoid the runtime warning in your console, you have to handle cancellation differently than other errors.
TickerView의 task { ... } modifier로 스크롤합니다. 여기서는 오류를 모두 잡고 메시지를 저장하여 표시합니다. 그러나 콘솔에서 런타임 경고를 방지하려면 다른 오류와 다르게 취소를 처리해야 합니다.
Newer asynchronous APIs like Task.sleep(nanoseconds:) throw a CancellationError. Other APIs that throw custom errors have a dedicated cancellation error code, like URLSession.
Task.sleep(nanoseconds:)과 같은 새로운 비동기 API는 CancellationError를 생성합니다. 다른 사용자 정의 오류를 생성하는 API는 URLSession과 같이 전용 취소 오류 코드를 가집니다.
Replace the catch block with the following code:
catch 블록을 다음 코드로 바꿉니다:
} catch {
  if let error = error as? URLError,
    error.code == .cancelled {
    return
  }

  lastErrorMessage = error.localizedDescription
}

​
The new catch block checks if the thrown error is a URLError with the cancelled error code. If it is, you return without presenting the message onscreen.
새로운 catch 블록은 thrown erro r가 cancelled 에러 코드의 URLError인지 확인합니다. 그러면 화면에 메시지를 표시하지 않고 돌아갑니다.
You get a URLError from the ongoing URLSession that fetches the live updates. If you use other modern APIs, they might throw a CancellationError instead.
진행 중인 URLSession에서 실시간 업데이트를 가져오는 URLError가 발생합니다. 다른 최신 API를 사용하면 CancellationError가 발생할 수 있습니다.
Run the app one more time and confirm that this last change fixes the behavior and you don’t get the runtime warning anymore.
앱을 한 번 더 실행하고 이 마지막 변경으로 동작이 수정되는지 확인하면 런타임 경고가 더 이상 표시되지 않습니다.
Now, you’ve finished working on LittleJohn. Congratulations, you completed the first project in this book!
이제 LittleJohn 작업을 마쳤습니다. 축하합니다. 이 책의 첫 번째 프로젝트를 완료했습니다!
Stick around if you’d like to work through a challenge on your own. Otherwise, turn the page and move on to learning about async/await and Task in more detail!
혼자 힘으로 해보고 싶다면 도전을 해보세요. 그렇지 않으면, 페이지를 넘겨서 async/await과 Task에 대해 더 자세히 알아보세요!

<br>

### **Challenges**

### Challenge: Adding extra error handling

There’s one edge case that the app still doesn’t handle graciously: What if the server becomes unavailable while the user is observing the price updates?
앱이 여전히 처리하지 못하는 엣지 케이스가 하나 있습니다. 사용자가 price 업데이트를 observing 하는 동안 서버를 사용할 수 없게 되면 어떻게 됩니까?

You can reproduce this situation by navigating to the prices screen, then stopping the server by pressing **Control-C** in the terminal window.
price 화면으로 이동한 후 단말기 창에서 **Control-C**를 눌러 서버를 중지하면 이 상황을 재현할 수 있습니다.

No error messages pop up in the app because there is no error, per se. In fact, the response sequence simply completes when the server closes it. In this case, your code continues to execute with no error, but it produces no more updates.
오류가 없기 때문에 앱에 오류 메시지가 표시되지 않습니다. 실제로 서버가 닫을 때 응답 시퀀스가 완료됩니다. 이 경우 코드는 오류 없이 계속 실행되지만 더 이상의 업데이트는 발생하지 않습니다.

In this challenge, you’ll add code to reset `LittleJohnModel.tickerSymbols` when the async sequence ends and then navigate out of the updates screen.
이 챌린지에서는 비동기 시퀀스가 종료되면 `LittleJohnModel.tickerSymbols`를 리셋하기 위해 코드를 추가한 후 업데이트 화면을 벗어나야 합니다.

In `LittleJohnModel.startTicker(_:)`, after the `for` loop, append code to set `tickerSymbols` to an empty array if the async sequence unexpectedly ends. Don’t forget to make this update using `MainActor`.
`LittleJohnModel.startTicker(_:)`에서 `for` 루프 뒤에 코드를 추가하여 비동기 시퀀스가 예기치 않게 종료되면 `tickerSymbols`를 빈 배열로 설정합니다. `MainActor`를 사용하여 업데이트하는 것도 잊지 마십시오.

Next, in `TickerView`, add a new view modifier that observes the number of observed ticker symbols and dismisses the view if the selection resets:
다음으로 `TickerView`에서 관찰된 티커 기호의 수를 관찰하고 선택 항목이 재설정되면 뷰를 무시하는 새로운 뷰 수정자를 추가합니다:

```swift
.onChange(of: model.tickerSymbols.count) { newValue in
  if newValue == 0 {
    presentationMode.wrappedValue.dismiss()
  }
}
```

Note that the starter already includes an environment `presentationMode` ready to use.
시동 장치에는 사용할 수 있는 환경 `presentationMode`'가 이미 포함되어 있습니다.

If everything goes well, when you stop the server while watching the live updates in the app, LittleJohn will automatically dismiss the updates screen and go back to the list of symbols.
모든 일이 잘 진행되면 앱에서 라이브 업데이트를 보다가 서버를 중지하면 LittleJohn이 자동으로 업데이트 화면을 종료하고 기호 목록으로 돌아갑니다.

If you get stuck in the challenge or if something doesn’t work as you expect, be sure to check the solution in this chapter’s materials.
문제가 해결되지 않거나 문제가 예상대로 되지 않으면 이 장의 자료에서 해결책을 확인해야 합니다.

<br>

### **Key points**

- Swift 5.5 introduces a **new concurrency model** that solves many of the existing concurrency issues, like thread explosion, priority inversion, and loose integration with the language and the runtime.
    
    Swift 5.5는 hread explosion, 우선 순위 반전, 언어 및 런타임과의 느슨한 통합 등 기존의 많은 동시성 문제를 해결하는 새로운 동시성 모델을 소개합니다.
    
- The `async` keyword defines a function as asynchronous. `await` lets you wait in a non-blocking fashion for the result of the asynchronous function.
    
    `async` 키워드는 함수를 비동기로 정의합니다. `await`를 사용하면 non-blocking 방식으로 비동기 함수의 결과를 기다릴 수 있습니다.
    
- Use the `task(priority:_:)` view modifier as an `onAppear(_:)` alternative when you want to run asynchronous code.
    
    비동기 코드를 실행하려는 경우 `task(priority:_:)` **view modifier를 `onAppear(_:)` 대안으로 사용합니다.
    
- You can naturally loop over an asynchronous sequence over time by using a `for try await` loop syntax.
    
    `for try await` 루프 구문을 사용하여 시간이 지남에 따라 비동기 시퀀스를 자연스럽게 뒤집을 수 있습니다.
