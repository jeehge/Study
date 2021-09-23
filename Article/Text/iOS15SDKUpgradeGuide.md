

[Braze iOS 15 SDK Upgrade Guide](https://www.braze.com/docs/developer_guide/platform_integration_guides/ios/ios_15/)


이 가이드는 iOS 15(WWDC21)에 도입된 변경 사항과 Braze iOS SDK 통합에 필요한 업그레이드 단계를 간략하게 설명합니다.

새로운 iOS 15 업데이트의 전체 목록은 Apple의 [iOS 15 릴리스 노트](https://developer.apple.com/documentation/ios-ipados-release-notes/ios-ipados-15-beta-release-notes)를 참조하세요.

## Transparency Changes to UI Navigations

iOS 베타의 연간 테스트의 일환으로, 우리는 특정 UI navigation bar를 불투명 대신 투명하게 보이게 하는 Apple의 변화를 확인했습니다. 
이는 컨텐츠 카드, 뉴스 피드에 Braze의 기본 UI를 사용하거나 별도의 브라우저 앱 대신 앱 내부에서 웹 딥 링크를 열 때 iOS 15에서 볼 수 있습니다.

iOS 15에서 이러한 시각적 변화를 방지하려면 사용자가 새 iOS 15 운영체제로 폰을 업그레이드 하기 전에 가능한 빨리 [Braze iOS SDK v4.3.2](https://github.com/Appboy/appboy-ios-sdk/releases/tag/4.3.2)로 업그레이드 하는 것이 좋습니다.

## New Notification Settings

iOS 15는 사용자가 하루 종일 집중을 유지하고 잦은 중단을 방지하는 데 도움이 되는 새로운 알림 기능을 도입했습니다. 
이러한 새로운 기능에 대한 지원을 제공할 수 있게 되어 기쁩니다. 
자세한 내용은 iOS 알림 옵션을 참조하십시오.

### Focus Modes

iOS 15 사용자는 Focus mode를 만들 수 있습니다.  Focus mode를 통해 표시하고자 하는 알림을 결정할 수 있습니다. 

### Interruption Levels ( 👉 [애플문서](https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel?changes=la) )

iOS 15에서는 푸시 알림을 다음 네 가지 레벨 중 하나로 보낼 수 있습니다.

- Passive(new) - 시스템은 화면을 켜거나 소리를 재생하지 않고 알림 목록에 알림을 추가
- Active(default) - 알림을 즉시 표시하고, 화면에 불이 들어오고, 소리를 재생
- Time-Sensitive(new) - 알림을 즉시 표시하고, 화면에 불이 들어오고, 소리를 재생할 수 있지만 시스템 알림 컨트롤을 실행하지는 않습니다.
- Critical - 시스템이 알림을 즉시 표시하고 화면을 켜고 음소거 스위치를 우회하여 소리를 재생

 **** 시스템 컨트롤을 실행하지 않는다는 무슨 의미지?**

### Notification Summary

iOS 15에서 사용자는 하루 중 특정 시간을 선택하여 알림 써머리를 받을 수 있습니다. 
즉각적인 확인이 필요하지 않은 알림(예: "Passive"로 전송되거나 사용자가 포커스 모드에 있는 동안)은 하루 종일 지속적인 중단을 방지하기 위해 그룹화됩니다.

각 노티에 대해 상단 써머리에 표시할 노티를 제어하는 "relevance Score"를 설정할 수 있습니다
(👉 [시스템이 앱의 알림을 정렬하는 데 사용하는 값](https://developer.apple.com/documentation/usernotifications/unnotificationcontent/3821031-relevancescore))

새로운 기능에 대한 지원을 제공할 수 있게 되어 기쁩니다. 
iOS 15 정식 릴리즈에 대한 자세한 정보가 발표될 때까지 기다려주세요

## Location Buttons

iOS 15는 사용자가 앱 내에서 위치 접근을 일시적으로 부여 할 수있는 새로운 편리한 방법을 소개합니다.

new location button은 동일한 세션에서 여러 번 클릭하는 사용자를 반복적으로 묻지 않고도 기존 "한 번 허용"권한을 빌드합니다.

자세한 내용은 올해 [전세계 개발자 회의(WWDC)에서 Apple 's Video](https://developer.apple.com/videos/play/wwdc2021/10102/)에서 확인할 수 있습니다

### Using Location Buttons with Braze

Braze와 함께 location button을 사용할 때는 추가적으로 통합이 필요하지 않습니다. 
평소처럼 앱이 사용자 위치(사용 권한을 부여한 후)를 전달할 수 있습니다.

Apple에 따르면, 이미 백그라운드 위치 접근을 공유한 사용자들은 "앱을 사용하는 동안" 옵션을 iOS 15로 업그레이드한 후에도 해당 레벨의 권한을 계속 부여할 것이다.

## Apple Mail

올해, Apple은 이메일 추적 및 개인 정보 보호에 대한 많은 업데이트를 발표했습니다.
자세한 내용은 [블로그](https://www.braze.com/resources/articles/9-ways-email-marketers-can-respond-to-apples-mail-privacy-protection-feature) 게시물을 참조하십시오.

## Safari IP Address Location

iOS 15에서는 사용자는 IP 주소에서 확인할 수 있는 위치를 익명화하거나 일반화하도록 Safari를 구성할 수 있습니다. 위치 기반 타켓팅 또는 세분화를 사용할 때 이 점을 염두해 주십시오.
