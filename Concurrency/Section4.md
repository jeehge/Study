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
