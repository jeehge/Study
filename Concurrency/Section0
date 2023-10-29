### What You Need

이 책을 학습하기 위해 다음이 필요합니다:
- macOS Monterey (12.0) 이상 실행되는 Mac.
- Xocde 13 이상. Xcode 13.2 이상을 사용하는 경우 iOS 13 / macOS 10.15 SDK(또는 그 이상)부터 새로운 async/await 구문과 나머지 현대 동시성 기능이 작동합니다. 이전 버전의 Xcode 13을 사용하는 경우 iOS 15 / macOS 12를 대상으로 할 때만 현대 concurrency 지원을 받을 수 있습니다. 최신 버전의 Xcode는 Apple의 개발자 사이트에서 다운로드할 수 있습니다.
- 스위프트의 중간 수준. 일반적인 Concurrency는 비교적 진보된 주제이므로 스위프트와 기존의 동시성 기능에 대해 최소한 중간 수준의 지식이 있어야 합니다. 이 책은 Grand Central Dispatch와 같은 Swift 5.5 이전의 concurrency 기능을 가르치지는 않지만, 비록 완전히 능숙하지는 않더라도 이 책의 내용을 따를 수 있어야 합니다.

이 책은 물리적인 장치를 필요로 하지는 않지만 실제 장치에서 고급 cuncurrency 기능의 일부를 사용해 볼 수 있습니다.

<br>

### Book Source Code & Forums
이 책의 자료 다운로드 위치

이 책의 자료는 Github 저장소에서 복제하거나 다운로드할 수 있습니다. : [https://github.com/raywenderlich/mcon-materials/tree/editions/1.0](https://github.com/raywenderlich/mcon-materials/tree/editions/1.0)

Forums

[https://forums.raywenderlich.com/c/books/modern-concurrency-in-swift](https://forums.raywenderlich.com/c/books/modern-concurrency-in-swift)

<br>

### Dedications

```
  “Dedicated to my daughter and family. Warm thanks to everyone on the extended team that made this book possible.”
    — Marin Todorov
```

<br>

### Introduction

Swift 5.5에 소개된 놀랍고 새로운 concurrency API를 소개하는 Modern Concurrency in Swift에 오신 것을 환영합니다.

Swift는 현재 Apple의 플랫폼(iOS, macOS, tvOS 등)을 넘어 Linux, Windows 등과 같은 새로운 플랫폼으로 확장되고 있는 강력한 다목적 프로그래밍 언어입니다.

언어가 완전히 새로운 일련의 작업을 수행할 수 있도록 돕기 위해 Swift 5.5는 비동기 연산을 위한 새로운 네이티브 구문과 concurrent API, 컴파일러 및 런타임 간의 보다 긴밀한 통합을 갖춘 modern concurrency model을 도입했습니다.

raywenderlich.com 의 대부분의 책들은 "By Tutuals"입니다. 하지만 이 책은 이미 중급/고급 Swift 기술을 가진 개발자들을 대상으로 하기 때문에 책 제목의 그 부분은 생략했습니다.

책 챕터는 새로운 개념과 API를 소개하는 이론 섹션과 단계별 튜토리얼의 건강한 혼합으로 구성되어 있습니다.

만약 여러분이 모든 프로젝트를 다 진행한다면, 여러분이 끝날 때쯤이면, new concurrency model은 여러분에게 어떤 비밀도 주지 못할 것입니다!


- How to read this book

이 책의 대부분의 장은 하나의 개념에서 다음 개념으로 구성됩니다. 한 장 한 장씩 읽는 것을 추천합니다.
