### 3. AsyncSequence & Intermediate TaskWritten by Marin Todorov

Throughout this book, you’ll use async sequences to make your life easier when it comes to asynchronous programming. Async sequences make consuming asynchronous results as simple as iterating over a Swift sequence.
이 책 전체에서 비동기 시퀀스를 사용하여 비동기 프로그래밍과 관련하여 생활을 더 쉽게 도와줄 겁니다. 비동기 시퀀스를 사용하면 스위프트 시퀀스를 반복하는 것만큼 간단하게 비동기 결과를 사용할 수 있습니다.

You’ve already tried async sequences briefly in Chapter 1, “Why Modern Swift Concurrency?”, but you’ll take a more detailed deep dive into them now.
여러분은 이미 1장 Why Modern Swift Concurrency? 에서 간략하게 비동기 시퀀스를 시도해 보았지만 이제 이에 대해 더 자세히 살펴보겠습니다. 

You’ll do this while continuing to work on the **SuperStorage** app from the last chapter, so you don’t need an introduction to the project; you can jump right in. When you’ve finished working through this chapter, you’ll have given SuperStorage parallel download superpowers.
마지막 장으로 부터 **SuperStorage** 앱 작업을 이어서 작업을 할 것임으로 프로젝트에 대한 소개가 필요하지 않습니다. 바로 시작합시다. 이 장의 작업을 마치면 SuperStorage 병렬 다운로드 능력을 갖게 됩니다.
