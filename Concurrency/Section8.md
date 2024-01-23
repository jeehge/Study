# 8. Getting Started With Actors

In the last chapter, you used the TaskGroup and ThrowingTaskGroup APIs to execute tasks in parallel. This lets you do work faster should a single CPU core not suffice your needs.

You explored TaskGroup‘s ingenious design, which allows you to run tasks in parallel but still collect the execution’s results in a safe, serial manner by iterating the group as an asynchronous sequence.


## Key Points

- The **actor** type is a type that protects its internals from concurrent access, supported by compile-time checks and diagnostics.
    
    actor 타입은 컴파일 타임 검사 및 진단을 통해 지원되는 동시 액세스(concurrent access)로부터 내부를 보호하는 타입입니다.
    
- Actors allow **“internal” synchronous access** to their state while the compiler enforces **asynchronous calls for access** from the “outside”.
    
    actor는 자신의 상태를 “**internal**” 동기 액세스(**synchronous access**)를 허용하는 반면, 컴파일러는 “outside”에서의 액세스를 위해 비동기 호출을 시행합니다.
    
- Actor methods prefixed with the **nonisolated** keyword behave as standard class methods and provide no isolation mechanics.
    
    **nonisolated** 키워드가 붙은 actor 메소드는 표준 클래스 메소드처럼 작동하며 분리 매커니즘을 제공하지 않습니다. 
    
- Actors use a runtime-managed **serial executor** to serialize calls to methods and access to properties.
    
    actor는 런타임 관리 **serial executor를 사용하여 메서드 호출을 직렬화하고 속성에 접근합니다.**
    
- The **Sendable** protocol indicates a value is safe to use in a concurrent context. The **@Sendable** attribute requires a sendable value for a method or a closure parameter.
    
    Sendable 프로토콜은 값이 동시 컨텍스트에서 사용하기에 안전함을 나타냅니다.  @Sendable 속성에는 메소드 또는 클로저 매개변수에 대한 전송 가능한 값이 필요합니다. 
    

In this hands-on chapter, you designed both simple and complex actor-based code. Most importantly, you experienced some of the hurdles of converting unsafe class code to thread-safe actor code.

이 실습 장에서는 단순하고 복잡한 행위자 기반 코드를 모두 디자인 했습니다. 가장 중요한 것은 안전하지 않은 클래스 코드를 스레드로부터 안전한 actor 코드로 변환하는데 몇 가지 장애물을 경험했다는 것입니다.

The fun isn’t over yet, though. You’ll keep working on the EmojiArt app as you learn about **global actors** in the next chapter.

하지만 재미는 아직 끝나지 않았습니다. 다음 장에서는 **global actors** 에 대해 배우면서 EmojiArt 앱 작업을 계속하게 됩니다.

For the grand finale, you’ll once again search for alien life in Chapter 10, “Actors in a Distributed System”, where you’ll learn about using actors that work together across different devices.

마지막으로 10장 “Actors in a Distributed System” 에서 다시 한 번 이종의 생명을 검색하게 됩니다. 여기서는 여러 장치에서 함께 작동하는 actor를 사용하는 방법을 배우게 됩니다.
