### 3. AsyncSequence & Intermediate TaskWritten by Marin Todorov

Throughout this book, you’ll use async sequences to make your life easier when it comes to asynchronous programming. Async sequences make consuming asynchronous results as simple as iterating over a Swift sequence.
이 책 전체에서 비동기 시퀀스를 사용하여 비동기 프로그래밍과 관련하여 생활을 더 쉽게 도와줄 겁니다. 비동기 시퀀스를 사용하면 스위프트 시퀀스를 반복하는 것만큼 간단하게 비동기 결과를 사용할 수 있습니다.

You’ve already tried async sequences briefly in Chapter 1, “Why Modern Swift Concurrency?”, but you’ll take a more detailed deep dive into them now.
여러분은 이미 1장 Why Modern Swift Concurrency? 에서 간략하게 비동기 시퀀스를 시도해 보았지만 이제 이에 대해 더 자세히 살펴보겠습니다. 

You’ll do this while continuing to work on the **SuperStorage** app from the last chapter, so you don’t need an introduction to the project; you can jump right in. When you’ve finished working through this chapter, you’ll have given SuperStorage parallel download superpowers.
마지막 장으로 부터 **SuperStorage** 앱 작업을 이어서 작업을 할 것임으로 프로젝트에 대한 소개가 필요하지 않습니다. 바로 시작합시다. 이 장의 작업을 마치면 SuperStorage 병렬 다운로드 능력을 갖게 됩니다.

<br>

### Getting to know AsyncSequence
AsyncSequence 알아보기

**AsyncSequence** is a protocol describing a sequence that can produce elements **asynchronously**. Its surface API is identical to the Swift standard library’s `Sequence`, with one difference: You need to `await` the next element, since it might not be immediately available, as it would in a regular `Sequence`
**AsyncSequence** 는 요소를 비동기적(**asynchronously**)으로 생성할 수 있는 sequence 를 설명하는 프로토콜입니다. **AsyncSequence** API는 스위프트 표준 라이브러리 `Sequence` 와 동일하며, 한 가지 차이점은 다음 요소를 일반 `Sequence` 와 같이 즉시 사용할 수 없기 때문에 `await` 필요합니다. 

Here are some common tasks you’d use an asynchronous sequence for:
비동기 시퀀스를 사용하는 몇 가지 일반적인 작업은 다음과 같습니다. 

- Iterating over the sequence in a `for` loop, using `await` and, if the `AsyncSequence` is throwing, `try`. The code suspends **at each loop iteration** to get the next value:
시퀀스를 `for`문으로 반복하면서, `await` 사용하고, `AsyncSequence` 가 throwing 하면, `try` 를 사용합니다.  코드는 다음 값을 얻기 위해 각 루프 반복에서 일시 중단됩니다:

```swift
for try await item in asyncSequence {
  // Next item from `asyncSequence`
}
```

- Using the asynchronous alternative of a standard library iterator with a `while` loop. This is similar to using a synchronous sequence: You need to make an iterator and repeatedly call `next()` using `await` until the sequence is over:
`while` 문이 있는 표준 라이브러리 iterator 의 비동기 대안으로 사용합니다.  이는 동기 시퀀스를 사용하는 것과 유사합니다.  iterator 를 만들고 시퀀스가 끝날 때가지 `await` 을 사용하여 `next()` 를 반복적으로 호출해야 합니다.

```swift
var iterator = asyncSequence.makeAsyncIterator()
while let item = try await iterator.next() {
  ...
}
```

- Using standard sequence methods like `dropFirst(_:)`, `prefix(_:)` and `filter(_:)`:
`dropFirst(_:)`, `prefix(_:)` 및 `filter(_:)` 와 같은 표준 시퀀스 메소드 사용

```swift
for await item in asyncSequence
  .dropFirst(5)
  .prefix(10)
  .filter { $0 > 10 }
  .map { "Item: \($0)" } {
    ...
  }
```

- Using special raw-byte sequence wrappers, such as for file contents or when fetching from a server URL:
파일 내용이나 서버 URL에서 가져올 때와 같은 특별한 원시 바이트 시퀀스 래퍼 사용:

```swift
let bytes = URL(fileURLWithPath: "myFile.txt").resourceBytes

for await character in bytes.characters {
  ...
}

for await line in bytes.lines {
  ...
}
```

- Creating custom sequences by adopting `AsyncSequence` in your own types.
자신만의 유형에 `AsyncSequence` 를 채택하여 사용자 지정 시퀀스를 만듭니다.
- Finally, you can create your very own custom async sequences by leveraging `AsyncStream`. You’ll learn all about this option in the next chapter.
마지막으로, `AsyncStream` 을 활용하여 자신만의 맞춤형 비동기 시퀀스를 생성할 수 있습니다. 이 옵션에 대해서는 다음 장에서 모두 알게 될 것입니다.

For an overview of all the Apple-provided types that are asynchronous sequences, visit `AsyncSequence`‘s [online documentation](https://apple.co/3AS4Tkw). You’ll find the available types listed under **Conforming Types**.
비동기 시퀀스인 모든 APPLE 제공 타입에 대한 개요를 보면서 `AsyncSequence` 의 [온라인 문서](https://apple.co/3AS4Tkw)를 방문하세요. **Conforming Types** 아래에 나열된 사용 가능한 유형을 찾을 수 있습니다.

<br>
