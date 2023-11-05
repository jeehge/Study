# Concurrency Study

[Modern Concurrency: Getting Started](https://www.kodeco.com/28434449-modern-concurrency-getting-started)

스위프트 5.5 | iOS 15 | Xcode 13.4

스터디 날짜

- [x] 10.27 (금) 온라인 OT 진행

- [ ] 11.05 (일) 온라인 예정 section 1 스크립트 다 보고 올 것 

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

- [x] [i. What You Need](https://github.com/jeehge/Study/blob/master/Concurrency/Section0)
- [x] [ii. Book Source Code & Forums](https://github.com/jeehge/Study/blob/master/Concurrency/Section0)
- [x] [iii. Dedications](https://github.com/jeehge/Study/blob/master/Concurrency/Section0)
- [x] iv. About the Team
- [x] v. Acknowledgments
- [x] [vi. Introduction](https://github.com/jeehge/Study/blob/master/Concurrency/Section0)

<br>

## Section I: Modern Concurrency in Swift
### Section 1: 11 chapters

- [x] [1. Why Modern Swift Concurrency?](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [ ] [1.1 Understanding asynchronous and concurrent code](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [x] [1.2 Introducing the modern Swift concurrency model](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [x] [1.3 Running the book server](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [x] [1.4 Getting started with LittleJohn](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [x] [1.5 Writing your first async/await](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [x] [1.6 Using async/await in SwiftUI](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [x] [1.7 Using asynchronous sequences](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [x] [1.8 Canceling tasks in structured concurrency](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [x] [1.9 Handling cancellation errors](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [x] [1.10 Challenges](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)
- [x] [1.11 Key points](https://github.com/jeehge/Study/blob/master/Concurrency/Section1.md)

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

<br>

