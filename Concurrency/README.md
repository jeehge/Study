# Concurrency Study

[Modern Concurrency: Getting Started](https://www.kodeco.com/28434449-modern-concurrency-getting-started)

스위프트 5.5 | iOS 15 | Xcode 13.4

스터디 날짜

- [x] 10.27 (금) 온라인 OT 진행

- [ ] 11.02 (목) 오프라인 예정 section 1 스크립트 다 보고 올 것 

목차

Part 1: Asynchronous Code
- [x] Introduction (7:45)
- [x] Getting Started (11:27)
- [ ] Your First Asynchronous App (9:04)
- [ ] Asynchronous Sequences (13:14)
- [ ] Using AsyncSequence in Views (10:51)
- [ ] Additional Error Handling (2:44)
- [ ] Conclusion (1:22)


Part 2: Asynchronous Sequences

- [ ] Introduction (1:34)
- [ ] Your Second Asynchronous App (5:56)
- [ ] Concurrency With async let (4:10)
- [ ] Using Asynchronous Methods in Views (7:51)
- [ ] Displaying a Progress View (1:42)
- [ ] Downloading Chunks (8:56)
- [ ] Canceling Tasks (7:27)
- [ ] Using Combine (4:59)
- [ ] Concurrent Downloads (6:10)
- [ ] Conclusion (2:19)

<br>

[Modern Concurrency in Swift 디스크립션](https://www.kodeco.com/books/modern-concurrency-in-swift/v1.0/chapters/i-what-you-need)

## Before You Begin
### Section 0: 6 chapters

- [x] i. What You Need
  이 책을 학습하기 위해 다음이 필요합니다:
  - macOS Monterey (12.0) 이상 실행되는 Mac.
  - Xocde 13 이상. Xcode 13.2 이상을 사용하는 경우 iOS 13 / macOS 10.15 SDK(또는 그 이상)부터 새로운 async/await 구문과 나머지 현대 동시성 기능이 작동합니다.
    이전 버전의 Xcode 13을 사용하는 경우 iOS 15 / macOS 12를 대상으로 할 때만 현대 concurrency 지원을 받을 수 있습니다. 최신 버전의 Xcode는 Apple의 개발자 사이트에서 다운로드할 수 있습니다.
  - 스위프트의 중간 수준. 일반적인 Concurrency는 비교적 진보된 주제이므로 스위프트와 기존의 동시성 기능에 대해 최소한 중간 수준의 지식이 있어야 합니다.
    이 책은 Grand Central Dispatch와 같은 Swift 5.5 이전의 concurrency 기능을 가르치지는 않지만, 비록 완전히 능숙하지는 않더라도 이 책의 내용을 따를 수 있어야 합니다.
  이 책은 물리적인 장치를 필요로 하지는 않지만 실제 장치에서 고급 cuncurrency 기능의 일부를 사용해 볼 수 있습니다.

- [x] ii. Book Source Code & Forums
  이 책의 자료 다운로드 위치

  이 책의 자료는 Github 저장소에서 복제하거나 다운로드할 수 있습니다. : [https://github.com/raywenderlich/mcon-materials/tree/editions/1.0](https://github.com/raywenderlich/mcon-materials/tree/editions/1.0)

  Forums
    [https://forums.raywenderlich.com/c/books/modern-concurrency-in-swift](https://forums.raywenderlich.com/c/books/modern-concurrency-in-swift)

- [x] iii. Dedications
  ```
  “Dedicated to my daughter and family. Warm thanks to everyone on the extended team that made this book possible.”
    — Marin Todorov
  ```

- [x] iv. About the Team
- [x] v. Acknowledgments
- [x] vi. Introduction

  Swift 5.5에 소개된 놀랍고 새로운 concurrency API를 소개하는 Modern Concurrency in Swift에 오신 것을 환영합니다.

  Swift는 현재 Apple의 플랫폼(iOS, macOS, tvOS 등)을 넘어 Linux, Windows 등과 같은 새로운 플랫폼으로 확장되고 있는 강력한 다목적 프로그래밍 언어입니다.
  
  언어가 완전히 새로운 일련의 작업을 수행할 수 있도록 돕기 위해 Swift 5.5는 비동기 연산을 위한 새로운 네이티브 구문과 concurrent API, 컴파일러 및 런타임 간의 보다 긴밀한 통합을 갖춘 modern concurrency model을 도입했습니다.

  raywenderlich.com 의 대부분의 책들은 "By Tutuals"입니다. 하지만 이 책은 이미 중급/고급 Swift 기술을 가진 개발자들을 대상으로 하기 때문에 책 제목의 그 부분은 생략했습니다.
  
  책 챕터는 새로운 개념과 API를 소개하는 이론 섹션과 단계별 튜토리얼의 건강한 혼합으로 구성되어 있습니다.
  
  만약 여러분이 모든 프로젝트를 다 진행한다면, 여러분이 끝날 때쯤이면, new concurrency model은 여러분에게 어떤 비밀도 주지 못할 것입니다!

- How to read this book

  이 책의 대부분의 장은 하나의 개념에서 다음 개념으로 구성됩니다. 한 장 한 장씩 읽는 것을 추천합니다.

<br>

## Section I: Modern Concurrency in Swift
### Section 1: 11 chapters

- [ ] 1. Why Modern Swift Concurrency?
- [ ] 1.1 Understanding asynchronous and concurrent code
- [ ] 1.2 Introducing the modern Swift concurrency model
- [ ] 1.3 Running the book server
- [ ] 1.4 Getting started with LittleJohn
- [ ] 1.5 Writing your first async/await
- [ ] 1.6 Using async/await in SwiftUI
- [ ] 1.7 Using asynchronous sequences
- [ ] 1.8 Canceling tasks in structured concurrency
- [ ] 1.9 Handling cancellation errors
- [ ] 1.10 Challenges
- [ ] 1.11 Key points

<br>

- [ ] 2. Getting Started With async/await
- [ ] 2.1 Pre-async/await asynchrony
- [ ] 2.2 Separating code into partial tasks
- [ ] 2.3 Controlling a task’s lifetime
- [ ] 2.4 Getting started
- [ ] 2.5 A bird’s eye view of async/await
- [ ] 2.6 Getting the list of files from the server
- [ ] 2.7 Getting the server status
- [ ] 2.8 Grouping asynchronous calls
- [ ] 2.9 Asynchronously downloading a file
- [ ] 2.10 Running async requests from a non-async context
- [ ] 2.11 A quick detour through Task
- [ ] 2.12 Routing code to the main thread
- [ ] 2.13 Updating the download screen’s progress
- [ ] 2.14 Challenges
- [ ] 2.15 Key points

<br>

- [ ] 3. AsyncSequence & Intermediate Task
- [ ] 3.1 Getting to know AsyncSequence
- [ ] 3.2 Getting started with AsyncSequence
- [ ] 3.3 Canceling tasks
- [ ] 3.4 Canceling an async task
- [ ] 3.5 Manually canceling tasks
- [ ] 3.6 Storing state in tasks
- [ ] 3.7 Bridging Combine and AsyncSequence
- [ ] 3.8 Challenges
- [ ] 3.9 Key points

<br>

- [ ] 4. Custom Asynchronous Sequences With AsyncStream
- [ ] 4.1 Getting started with the Blabber app
- [ ] 4.2 Digging into AsyncSequence, AsyncIteratorProtocol and AsyncStream
- [ ] 4.3 Creating an asynchronous timer with AsyncStream
- [ ] 4.4 Adding an asynchronous stream to NotificationCenter
- [ ] 4.5 Extending AsyncSequence
- [ ] 4.6 Challenges
- [ ] 4.7 Key points

<br>

- [ ] 5. Intermediate async/await & CheckedContinuation
- [ ] 5.1 Introducing continuations
- [ ] 5.2 Creating continuations manually
- [ ] 5.3 Wrapping the delegate pattern
- [ ] 5.4 Wrapping callback APIs with continuation
- [ ] 5.5 Challenges
- [ ] 5.6 Key points

<br>

- [ ] 6. Testing Asynchronous Code
- [ ] 6.1 Capturing network calls under test
- [ ] 6.2 Creating a model for testing
- [ ] 6.3 Adding a simple asynchronous test
- [ ] 6.4 Testing values over time with AsyncStream
- [ ] 6.5 Adding TimeoutTask for safer testing
- [ ] 6.6 Using async let to produce effects and observe them at the same time
- [ ] 6.7 Speeding up asynchronous tests
- [ ] 6.8 Key points

<br>

- [ ] 7. Concurrent Code With TaskGroup
- [ ] 7.1 Introducing TaskGroup
- [ ] 7.2 Getting started with Sky
- [ ] 7.3 Spawning tasks in a simple loop
- [ ] 7.4 Creating a concurrent task group
- [ ] 7.5 Controlling task execution
- [ ] 7.6 Getting results from a task group
- [ ] 7.7 Mutating shared state
- [ ] 7.8 Processing task results in real time
- [ ] 7.9 Controlling the group flow
- [ ] 7.10 Running code after all tasks have completed
- [ ] 7.11 Group error handling
- [ ] 7.12 Using the Result type with TaskGroup
- [ ] 7.13 Key points

<br>

- [ ] 8. Getting Started With Actors
- [ ] 8.1 Understanding thread-safe code
- [ ] 8.2 Meeting actor
- [ ] 8.3 Recognizing the main actor
- [ ] 8.4 Getting started with actors
- [ ] 8.5 Mutating state concurrently
- [ ] 8.6 Showing the art and updating the progress
- [ ] 8.7 Detecting race conditions
- [ ] 8.8 Using actors to protect shared mutable state
- [ ] 8.9 Sharing data across actors
- [ ] 8.10 Understanding Sendable
- [ ] 8.11 Making safe methods nonisolated
- [ ] 8.12 Designing more complex actors
- [ ] 8.13 Sharing the actor
- [ ] 8.14 Key points

<br>

- [ ] 9. Global Actors
- [ ] 9.1 Getting to meet GlobalActor
- [ ] 9.2 Continuing with the EmojiArt project
- [ ] 9.3 Creating a global actor
- [ ] 9.4 Creating a safe silo
- [ ] 9.5 Initializing the database actor
- [ ] 9.6 Writing files to disk
- [ ] 9.7 Fetching images from disk (or elsewhere)
- [ ] 9.8 Purging the cache
- [ ] 9.9 Wiring up the persistence layer
- [ ] 9.10 Adding a cache hit counter
- [ ] 9.11 Displaying the counter
- [ ] 9.12 Purging the in-memory cache
- [ ] 9.13 Challenges
- [ ] 9.14 Key points

<br>

- [ ] 10. Actors in a Distributed System
- [ ] 10.1 Going from local to distributed
- [ ] 10.2 Getting started with SkyNet
- [ ] 10.3 Enabling the network layer
- [ ] 10.4 Creating an actor system
- [ ] 10.5 Connecting to remote systems
- [ ] 10.6 Adding a connectivity indicator
- [ ] 10.7 Sending a task to a remote system
- [ ] 10.8 Managing a network request lifetime
- [ ] 10.9 Receiving a response from a remote system
- [ ] 10.10 Executing requests from other systems
- [ ] 10.11 Sending a result back
- [ ] 10.12 Handling incoming data
- [ ] 10.13 Putting everything together
- [ ] 10.14 Adding some UI bling
- [ ] 10.15 Retrying failed tasks
- [ ] 10.16 Key points
- [ ] 10.17 Where to go from here?

<br>

- [ ] 11. Conclusion

