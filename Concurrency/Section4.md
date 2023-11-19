### 4. Custom Asynchronous Sequences With AsyncStream

AsyncStream 을 사용한 사용자 정의 비동기 시퀀스

In previous chapters, you’ve learned a few different ways to integrate asynchronous code in your apps. By now, you’re hopefully comfortable calling and writing `async` functions and iterating over asynchronous sequences.
이전 장에서는 앱에 비동기 코드를 통합하는 몇 가지 다양한 방법을 배웠습니다. 이제 `async` 함수를 호출하고 작성하고 비동기 시퀀스를 반복하는데 익숙해졌기를 바랍니다.

In this chapter, you’ll dive deeper into how to create your very own custom async sequences using `AsyncStream`. Using this method grants you complete control over the asynchronous sequence and makes it trivial to wrap your own existing asynchronous APIs as async sequences.
이 장에서는 `AsyncStream` 을 사용하여 자신만의 맞춤형 비동기 시퀀스를 만드는 방법에 대해 자세히 알아보겠습니다.  이 방법을 사용하면 비동기 시퀀스를 완전히 제어할 수 있으며 기존의 비동기 API를 비동기 시퀀스로 래핑하는 것이 간단한 일이 됩니다.

In this chapter, you’ll work through the **Blabber** app to explore these topics.
이 장에서는 **Blabber** 앱을 통해 이러한 주제를 살펴보겠습니다.

<br>
