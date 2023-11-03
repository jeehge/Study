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

If everything goes well, when you stop the server while watching the live updates in the app, LittleJohn will automatically dismiss the updates screen and go back to the list of symbols.

If you get stuck in the challenge or if something doesn’t work as you expect, be sure to check the solution in this chapter’s materials.
