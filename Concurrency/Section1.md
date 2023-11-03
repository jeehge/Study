# Section I: Modern Concurrency in Swift

### 1. Why Modern Swift Concurrency?

애플이 비동기식 프레임워크에 대해 큰 관심을 보인 것은 2009년 Mac OS X 스노우 레오파드와 함께 GCD(Grand Central Dispatch)가 나왔을 때 입니다.

GCD는 2014년 Swift부터 동시성과 비동기성을 지원하면서 출시하는 데 도움을 주었지만, 이러한 지원이 기본적인 것은 아니었습니다.

이는 Objective-C의 요구와 능력을 중심으로 설계되었으며, Swift는 언어에 맞게 특별히 설계된 자체 메커니즘을 갖출 때까지 이러한 동시성을 "빌려" 왔습니다.

이 모든 것은 비동기 동시 코드 작성을 위한 새로운 네이티브 모델을 도입한 Swift 5.5와 함께 바뀌었습니다.

<br>

새로운 concurrency model은 Swift에서 안전하고 성능이 뛰어난 프로그램을 작성하는 데 필요한 다음과 같은 모든 것을 제공합니다:
- 구조화된 방식으로 비동기 작업을 실행하기 위한 새로운 기본 구문입니다.
- 비동기 코드와 동시 코드를 설계하기 위한 표준 API 묶음.
- libdispatch framework(?)의 low-level 변경으로 모든 상위 수준 변경이 운영 체제에 직접 통합됩니다.
- 안전한 동시 코드를 만들기 위한 새로운 수준의 컴파일러 지원.

<br>

Swift 5.5는 이러한 기능을 지원하기 위해 새로운 언어 구문과 API를 소개합니다. 
앱에서는 최근 Swift 버전을 사용하는 것 외에 특정 플랫폼 버전을 대상으로 해야 합니다:

- Xcode 13.2 이상을 사용하는 경우 새로운 동시 실행 시간을 앱과 함께 번들로 제공하여 iOS 13 및 macOS 10.15(네이티브 앱용)를 대상으로 할 수 있습니다.

- Xcode 13에서 13.2보다 이전 버전인 경우 iOS 15 또는 macOS 12(또는 그 이상)만 대상으로 지정할 수 있습니다.

책의 첫 장에서는 스위프트의 새로운 concurrency 지원에 대해 검토하고 기존 API와 비교하여 어떻게 구현되는지 확인할 것입니다. 

나중에 chapter의 실용적인 부분에서는  `async/await` 구문을 사용해보고 멋진 asynchronous error-handling을 추가하여 실제 프로젝트를 수행할 것입니다.


### 1-1. Understanding asynchronous and concurrent code 비동기 및 동기 코드 이해

대부분의 코드는 코드 편집기에서 작성된 것과 같은 방식으로 실행됩니다. 위에서 아래로, 기능의 시작 부분에서 시작하여 줄 단위로 끝까지 진행됩니다.

이를 통해 주어진 코드 라인이 실행되는 시기를 쉽게 결정할 수 있습니다. 단순히 이전 코드 라인을 따릅니다. 함수 호출에 대해서도 마찬가지입니다. 코드가 동시에 실행되면 실행이 순차적으로 발생합니다.

동기적 맥락에서 코드는 하나의 CPU 코어의 하나의 실행 스레드에서 실행됩니다. 

단일 차선 도로에서 자동차와 같은 동기식 기능을 상상할 수 있으며, 한 차량이 근무 중인 구급차와 같이 우선 순위가 높은 경우 나머지 차량을 "jump over" 하여 더 빠르게 운전할 수 없습니다.

(차선이 하나인 곳에 자동차가 순서대로 있는 모습)

반면 iOS 앱과 Cocoa 기반 maOS 앱은 본질적으로 비동기적입니다.

비동기 실행을 사용하면 사용자 입력, 네트워크 연결 등 여러 가지 이벤트에 따라 하나의 thread에서 다른 프로그램 조작을 순서대로 실행할 수 있고 때로는 여러 thread에서 동시에 실행할 수도 있습니다.

특히 여러 비동기 함수가 동일한 thread를 사용해야 하는 경우네느 비동기적인 맥락에서 함수가 실행되는 순서를 정확히 말하기가 어렵습니다.

신호등이 있는 도로와 교통질서가 필요한 곳에서 운전하는 것처럼, 기능은 때때로 차례가 될 때까지 기다리거나 녹색 빛이 진행될 때까지 멈춰야합니다.

신호등이있는 도로와 트래픽이 필요한 곳에서 운전하는 것처럼, 기능은 때때로 차례가 계속 될 때까지 기다리거나 녹색 빛이 진행될 때까지 멈추어야합니다.

(자동차 신호대기 이미지)

비동기 호출의 한 예는 네트워크 요청을 하고 웹 서버가 응답할 때 실행할 완료 폐쇄를 제공하는 것이고, 

완료 콜백을 실행하기 위해 대기하는 동안 앱은 다른 작업를 수행하는 시간을 사용합니다.

(순서도 이미지)

프로그램의 일부를 의도적으로 병렬로 실행하려면 동시 API를 사용합니다. 

어떤 API는 고정된 수의 작업을 동시에 실행할 수 있도록 지원하고, 다른 API는 동시 그룹을 시작하여 임의 수의 동시 작업을 허용합니다.

이로 인해 수많은 동시성 관련 문제가 발생하기도 합니다. 예를 들어, 프로그램의 서로 다른 부분이 서로의 실행을 차단하거나 둘 이상의 함수가 동일한 변수에 동시에 액세스하여 앱이 다운되거나 예기치 않게 앱의 상태가 손상되는, 혐오스러운 데이터 레이스와 마주칠 수 있습니다.

그러나 주의 깊게 사용할 때 동시성은 여러 CPU 코어에서 동시에 다른 기능을 실행함으로써 프로그램을 더 빠르게 실행할 수 있도록 도와주며, 이는 주의 깊은 운전자들이 다차선 고속도로에서 훨씬 더 빠르게 이동할 수 있게 해줍니다.

<br>

# **Handling cancellation errors**

Sometimes you don’t care if one of your suspended tasks gets canceled. Other times — like the current situation with that pesky alert box — you’d like to do something special when the runtime cancels a task.
때로는 중단 된 작업 중 하나가 취소더라도 신경쓰지 않습니다. 어떤 경우(현재 상황과 같은 성가신 알림 상자)에는 런타임이 작업을 취소할 때 특별한 작업을 수행하고자 할 때도 있습니다.

Scroll to the `task { ... }` modifier in `TickerView`. Here, you catch all the errors and store their messages for display. However, to avoid the runtime warning in your console, you have to handle cancellation differently than other errors.
`TickerView`의 `task { ... }` modifier로 스크롤합니다. 여기서는 오류를 모두 잡고 메시지를 저장하여 표시합니다. 그러나 콘솔에서 런타임 경고를 방지하려면 다른 오류와 다르게 취소를 처리해야 합니다.

Newer asynchronous APIs like `Task.sleep(nanoseconds:)` throw a `CancellationError`. Other APIs that throw custom errors have a dedicated cancellation error code, like `URLSession`.
`Task.sleep(nanoseconds:)`과 같은 새로운 비동기 API는 `CancellationError`를 생성합니다. 다른 사용자 정의 오류를 생성하는 API는 `URLSession`과 같이 전용 취소 오류 코드를 가집니다.

Replace the `catch` block with the following code:
`catch` 블록을 다음 코드로 바꿉니다:

```swift
} catch {
  if let error = error as? URLError,
    error.code == .cancelled {
    return
  }

  lastErrorMessage = error.localizedDescription
}

```

The new `catch` block checks if the thrown error is a `URLError` with the `cancelled` error code. If it is, you return without presenting the message onscreen.
새로운 `catch` 블록은 thrown erro r가 `cancelled` 에러 코드의 `URLError`인지 확인합니다. 그러면 화면에 메시지를 표시하지 않고 돌아갑니다.

You get a `URLError` from the ongoing `URLSession` that fetches the live updates. If you use other modern APIs, they might throw a `CancellationError` instead.
진행 중인 `URLSession`에서 실시간 업데이트를 가져오는 `URLError`가 발생합니다. 다른 최신 API를 사용하면 `CancellationError`가 발생할 수 있습니다.

Run the app one more time and confirm that this last change fixes the behavior and you don’t get the runtime warning anymore.
앱을 한 번 더 실행하고 이 마지막 변경으로 동작이 수정되는지 확인하면 런타임 경고가 더 이상 표시되지 않습니다.

Now, you’ve finished working on LittleJohn. Congratulations, you completed the first project in this book!
이제 LittleJohn 작업을 마쳤습니다. 축하합니다. 이 책의 첫 번째 프로젝트를 완료했습니다!

Stick around if you’d like to work through a challenge on your own. Otherwise, turn the page and move on to learning about `async`/`await` and `Task` in more detail!
혼자 힘으로 해보고 싶다면 도전을 해보세요. 그렇지 않으면, 페이지를 넘겨서 `async`/`await`과 `Task`에 대해 더 자세히 알아보세요!

<br>

# Challenges

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

# Key points

- Swift 5.5 introduces a **new concurrency model** that solves many of the existing concurrency issues, like thread explosion, priority inversion, and loose integration with the language and the runtime.
    
    Swift 5.5는 hread explosion, 우선 순위 반전, 언어 및 런타임과의 느슨한 통합 등 기존의 많은 동시성 문제를 해결하는 새로운 동시성 모델을 소개합니다.
    
- The `async` keyword defines a function as asynchronous. `await` lets you wait in a non-blocking fashion for the result of the asynchronous function.
    
    `async` 키워드는 함수를 비동기로 정의합니다. `await`를 사용하면 non-blocking 방식으로 비동기 함수의 결과를 기다릴 수 있습니다.
    
- Use the `task(priority:_:)` view modifier as an `onAppear(_:)` alternative when you want to run asynchronous code.
    
    비동기 코드를 실행하려는 경우 `task(priority:_:)` **view modifier를 `onAppear(_:)` 대안으로 사용합니다.
    
- You can naturally loop over an asynchronous sequence over time by using a `for try await` loop syntax.
    
    `for try await` 루프 구문을 사용하여 시간이 지남에 따라 비동기 시퀀스를 자연스럽게 뒤집을 수 있습니다.

