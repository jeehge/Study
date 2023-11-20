### 4. Custom Asynchronous Sequences With AsyncStream
AsyncStream 을 사용한 사용자 정의 비동기 시퀀스

In previous chapters, you’ve learned a few different ways to integrate asynchronous code in your apps. By now, you’re hopefully comfortable calling and writing `async` functions and iterating over asynchronous sequences.
이전 장에서는 앱에 비동기 코드를 통합하는 몇 가지 다양한 방법을 배웠습니다. 이제 `async` 함수를 호출하고 작성하고 비동기 시퀀스를 반복하는데 익숙해졌기를 바랍니다.

In this chapter, you’ll dive deeper into how to create your very own custom async sequences using `AsyncStream`. Using this method grants you complete control over the asynchronous sequence and makes it trivial to wrap your own existing asynchronous APIs as async sequences.
이 장에서는 `AsyncStream` 을 사용하여 자신만의 맞춤형 비동기 시퀀스를 만드는 방법에 대해 자세히 알아보겠습니다.  이 방법을 사용하면 비동기 시퀀스를 완전히 제어할 수 있으며 기존의 비동기 API를 비동기 시퀀스로 래핑하는 것이 간단한 일이 됩니다.

In this chapter, you’ll work through the **Blabber** app to explore these topics.
이 장에서는 **Blabber** 앱을 통해 이러한 주제를 살펴보겠습니다.

<br>

### Getting started with the Blabber app

Blabber 앱 시작하기

**Blabber** is a messaging app that lets you chat with friends. It has some neat features like location sharing, a countdown timer and a friendly — but somewhat unpredictable — chatbot.
**Blabber** 는 친구들과 채팅할 수 있는 메시징 앱입니다. 위치 공유, 카운트다운 타이머, 친절하지만 다소 예측하기 어려운 챗봇과 같은 몇 가지 멋진 기능이 있습니다.

Like all projects in this book, Blabber’s SwiftUI views, navigation and data model are already wired up and ready for you. Blabber has a similar foundation to the projects you’ve already worked on, like LittleJohn and SuperStorage. It’s a connected app powered by a server API. Some of that code is already included in the starter because it works the same as in earlier projects.
이 책의 모든 프로젝트와 마찬가지로 Blabber 의 SwiftUI view, navigation 그리고 데이터 모델은 이미 연결되어 준비되어 있습니다. Blabber 는 LittleJohn 및 SuperStorage 와 같이 이미 작업한 프로젝트와 유사한 기반을 갖추고 있습니다. 서버 API로 구동되는 연결된 앱입니다. 해당 코드 중 일부는 이전 프로젝트와 동일하게 작동하므로 스타터에 이미 포함되어 있습니다. 

Open the starter version of Blabber in this chapter’s materials, under **projects/starter**. When you complete the app, it will feature a working login screen, where you can choose your user name, and a chat screen to socialize with friends:
이 장의 자료에서 **projects/starter** 아래에 있는 Blabber 의 스타터 버전을 엽니다. 앱을 완성하면 사용자이름을 선택할 수 있는 로그인 화면과 친구들과 어울릴 수 있는 채팅 화면이 표시됩니다.

At the moment, you can enter a user name, but nothing else works. Your goal is to make asynchronous calls to the server, then provide live updates in the app by reading from a long-living server request.
현재는 사용자 이름을 입력할 수 있지만 다른 것은 작동하지 않습니다. 목표는 서버에 대한 비동기 호출을 수행한 다음 오래 지속되는 서버 요청을 읽어 앱에 실시간 업데이트를 제공하는 것입니다.

Before starting to work on the app, start the book server. If you haven’t already done that, navigate to the server folder **00-book-server** in the book materials-repository and enter `swift run`. The detailed steps are covered in Chapter 1, “Why Modern Swift Concurrency?”.
앱 작업을 시작하기 전에 북 서버를 시작하세요. 아직 수행하지 않은 경우 자료 저장소의 서버 폴더 **00-book-server** 로 이동하여 `swift run` 을 입력합니다. 자세한 단계는 “Why Modern Swift Concurrency?” 에서 다룹니다.

#### Adding functionality to Blabber
Blabber 에 기능 추가

In the first section of this chapter, you’ll work on finishing some missing app functionality. That will give you a solid start when you work on your own custom sequences in the following sections.
이 장의 첫 번째 섹션에서는 일부 누락된 앱 기능을 마무리하는 작업을 수행하게 됩니다. 그러면 다음 섹션에서 자신만의 사용자 정의 시퀀스를 작업할 때 확실한 시작이 될 것입니다.

Go to **BlabberModel.swift**, where you’ll add most of the app’s logic throughout this and the following chapters.
**BlabberModel.swift** 로 이동하여 이 장과 다음 장 전체에 걸쳐 대부분의 앱 로직을 추가하게 됩니다.

The `chat()` method in `BlabberModel` includes the code to open a long-living request that will return real-time updates.
`BlabberModel` 의 `chat()` 메서드는 실시간 업데이트를 반환하는 장수 요청을 여는 코드를 포함합니다.

> Note: Just as in previous chapters, “long-living” means the URL request doesn’t time out. This lets you keep it open so you can constantly receive server updates in real time.
> 
Note. 이전 장에서와 마찬가지로 “long-living”은 URL 요청이 시간 초과되지 않음을 의미합니다. 이를 통해 서버 업데이트를 지속적으로 실시간으로 받을 수 있도록 열어두는 것이 가능합니다. 

Once it establishes a connection, that method calls `readMessages(stream:)`. This is the method you’ll work on in this section.
연결이 설정되면 해당 메서드는 `readMessages(stream:)` 를 호출합니다. 이 섹션에서 작업할 메서드입니다.

#### Parsing the server responses

서버 응답 구문 분석
The custom chat protocol that the book server implements sends a status as the first line, then continues with chat messages on the following lines. Each line is a JSON object, and new lines appear whenever users add chat messages. This is all part of the same long-living request/response. Here’s an example:
북 서버가 구현하는 사용자 정의 채팅 프로토콜은 첫 번째 줄에 상태를 보낸 후 다음 줄에 채팅 메시지를 계속 보냅니다. 각 줄은 JSON 개체이며 사용자가 채팅 메시지를 추가할 때마다 새 줄이 나타납니다. 이는 모두 동일한 오래 지속되는 요청/응답의 일부입니다. 예는 다음과 같습니다. 

```json
{"activeUsers": 4}
...
{"id": "...", "message": "Mr Anderson connected", "date": "..."}
...
{"id": "...", "user": "Mr Anderson", "message": "Knock knock...", "date": "..."}
/// and so on ...
```

This is a bit different from what you’ve done in previous chapters — it requires more work to handle the response.
이는 이전 장에서 수행한 작업과 약간 다릅니다. 응답을 처리하려면 더 많은 작업이 필요합니다. 

Scroll down to `readMessages(stream:)` and add this code to read the first line of the server response:
아래로 스크롤하여 `readMessages(stream:)` 로 이동한 후 이 코드를 추가하여 서버 응답의 첫 번째 행을 읽습니다:

```swift
var iterator = stream.lines.makeAsyncIterator()

guard let first = try await iterator.next() else {
  throw "No response from server"
}
```

In the code above, you first create an iterator over the `lines` sequence of the response. Remember, the server sends each piece of data on a separate text line. You then wait for the first line of the response using `next()`.
위 코드에서 당신은 먼저 응답의 시퀀스 `lines` 위에 만듭니다. 서버는 각각의 데이터를 별도의 텍스트 줄 위에 보냅니다. 그런 다음 `next()` 를 사용하여 응답의 첫 줄을 기다립니다. 

> Note: Using an iterator and next() instead of a for await loop lets you be explicit about the number of items you expect to deal with. In this case, you initially expect one, and only one, server status.
> 
Note. next() 루프 대신 반복자를 사용하면 for await 처리할 것으로 예상되는 항목 수를 명시적으로 지정할 수 있습니다. 이 경우 처음에는 서버 상태가 하나만 예상됩니다. 

Next, decode that server status by adding:
다음으로 다음을 추가하여 해당 서버 상태를 디코딩 합니다:

```swift
guard let data = first.data(using: .utf8),
      let status = try? JSONDecoder()
        .decode(ServerStatus.self, from: data) else {
  throw "Invalid response from server"
}
```

Here, you convert the text line to `Data` and then try to decode it to a `ServerStatus`. The starter project includes a `ServerStatus` data model containing a single property called `activeUsers`. This is how the server tells you how many users are in the chat at the moment.
여기서 텍스트 라인을 `Data` 로 변환한 다음 `ServerStatus` 로 디코딩을 시도합니다. 시작 프로젝트에는 단일 속성인 `activeUsers` 가 포함된 `ServerStatus` 데이터 모델이 포함됩니다. 서버가 현재 대화에 참여하고 있는 사용자 수를 알려주는 방식입니다.
