

원문 👉👉 [Support Universal Links](https://developer.apple.com/library/archive/documentation/General/Conceptual/AppSearch/UniversalLinks.html)


### universal link

언제 지원하나 ? 

<br>

iOS 사용자가 웹사이트를 탭 했을 때 

사파리를 통하지 않고 설치된 앱으로 리다이렉트 시킬 때

앱이 설치되어 있지 않으면 태깅 된 링크, 너의 웹사이트를 사파리에서 열어줌

<br>

Unique → custom URL scheme와 달리 universal link는 다른 앱에 의해 요청되지 않을 수 있기 때문에 표준 HTTP 또는 HTTPS 사용해야 함

Secure → 사용자가 앱을 설치할 때, iOS는 웹 서버에 확실히 업로드된 파일인지 체크해서, 앱을 대신해서 URL 열 때 웹사이트를 허용했는지 확인. 오직 사용자만이 파일을 업로드하고 생성할 수 있음으로, 웹사이트와 앱 연결은 안전하다

Flexible → 앱이 설치되지 않은 경우에도 동작한다. 앱이 설치되어 있지 않을 때 사용자가 웹사이티 링크를 태깅한 경우에도 사용자가 예상한 대로 사파리에서 열린다. 

Simple → 하나의 URL로 웹사이트와 앱 모두 작동 가능

Private → 다른 앱들은 앱이 설치되어 있는지 알 필요 없이 통신할 수 있음

<br>

note.

universal link는 사용자가 WKWebView, UIWebView 의 view나 safari 페이지에서 웹사이트 링크를 탭해서 메일, 메시지 및 기타 앱에서 실행되는 것과 같이 앱을 열 수 있습니다.

사용자가 safari에서 웹 사이트를 둘러보고 현재 웹페이지에서 같은 도메인 URL의 universal link를 탭하면, iOS는 사용자의 가장 가능성 높은 시도를 존중하여 safari의 링크를 엽니다.

만약 사용자가 다른 도메인 URL의 universal link를 탭했을 때 iOS는 앱 내에서 link를 열 수 있습니다.

9.0 이전 버전의 iOS를 사용중인 사용자의 경우 웹사이트에 대한 universal link를 탭하면 safari에서 링크가 열립니다.

<br>

universal links 지원은 간단합니다.

세가지 단계가 있습니다.

1. 앱이 처리할 수 있는 URL에 대한 JSON data가 포함된 apple-app-site-association file 생성합니다.
2. HTTP 웹 서버에 apple-app-site-association 파일을 업로드 한다. 서버의 root 또는 .well-known 하위 경로 내에 파일을 설치할 수 있습니다.
3. universal link를 처리하도록 앱을 준비합니다.

universal link를 기기에서 테스트할 수 있습니다!

<br>

Association File 업로드 및 생성

웹사이트와 앱 간의 안전한 연결을 만들어서, 신뢰 관계와 팀을 확고히 합니다.

두가지로 관계를 설정합니다.

- 웹사이트에 apple-app-site-association 파일 추가
- 앱에 com.apple.developer.associated-domains entitlement 추가 (Preparing Your App to Handle Universal Links에서 서술되었습니다)

<br>

앱이 지원하는 유니크한 컨텐츠가 포함된 각각의 도메인에 대한 별도의 apple-app-site-association 파일을 제공해야 합니다.

예를 들면 apple.com과 developer.apple.com은 서로 다른 컨텐츠를 서비스하기 때문에 별도의 apple-app-site-association 파일이 필요합니다. 

그에 비해 apple.com과 www.apple.com은 두 도메인이 동일한 콘텐츠를 제공하기 때문에  별도 사이트의 association file이 필요하지 않지만 두 도메인은 파일은 사용할 수 있어야 합니다. 

iOs 9.3.1 이상에서 실행되는 앱은 app-site-association 파일의 압축되지 않은 크기가 128KB 이하여야 하며, 파일 서명 여부와 상관없이 사용할 수 있습니다.

app-site-association 파일에서, universal link로 처리되어야 하는 path와 함께 universal link로 처리되어서는 안되는 path를 지정할 수 있습니다.

리스트의 상당히 짧은 경로를 유지하고 wildcard 매칭에 의존하여 더 큰 path의 셋을 매칭할 수 있습니다.

Listing 6-1은 universal link로 처리해야 하는 세 가지 경로를 식별하는 apple-app-site-association 파일의  예시를 보여줍니다.

![스크린샷 2021-09-06 오전 12.12.14.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ec76108f-ab52-499a-9367-a094b487c300/스크린샷_2021-09-06_오전_12.12.14.png)

<br>

note.

apple-app-site-association 파일 이름에 .json을 추가하지 마세요!

Listing 6-1에 표시된 것처럼 apple-app-site-association 파일의 앱 키가 있어야 하며 값은 빈 배열이어야 합니다. 

details 키의 값은 dictionary 배열로, 웹 사이트에서 지원하는 앱당 dictionary 하나씩입니다.

배열에 있는 dictionary의 순서는 일치하는 항목을 찾을 때 시스템이 따르는 순서를 결정하므로 웹사이트의 특정 부분을 처리하는 앱을 지정할 수 있습니다.

각 앱에는 ID 키와 path 키를 가진 특정한 dictionary가 포함되어 있습니다.

app ID 키의 값은 team ID 또는 app ID의 접두사이며 그 다음에 bundle ID가 나옵니다.

path 키의 값은 앱에서 지원하는 웹 사이트 일부와 앱과 연결하지 않을 웹 사이트 일부를 지정하는 문자열 배열입니다.

universal link로 처리되지 않아야 하는 영역을 지정하려면 path 문자열의 시작에 "NOT "(T 뒤에 공백 포함)을 추가해야 합니다.

예를 들면 Listing 6-1에 표시된 apple-app-site-association 파일은 다음과 같이 path 배열을 업데이트하여 웹 사이트의 /videos/wwdc/2010/* 영역을 universal link로 처리하지 못하도록 할 수 있습니다. 

![스크린샷 2021-09-06 오전 1.23.21.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/252a5db5-4ffc-4e1e-8042-4597614421ff/스크린샷_2021-09-06_오전_1.23.21.png)

때문에 시스템은 path 배열의 각 path를 지정된 순서대로 가하고 긍정 또는 부정적인 항목이 발견되면 평가를  중지하므로 우선 순위가 높은 경로를 낮은 경로보다 먼저 지정해야 합니다.

URL의 경로 구성요소만 비교에 사용됩니다.

쿼리 문자열 또는 fragment identifier와 같은 다른 구성 요소는 무시됩니다.

apple-app-site-association 파일에서 웹 사이트 경로를 지정하는 방법은 다양하다. 예를 들어 다음과 같습니다.

- 전체 웹 사이트를 지정하려면 *를 사용합니다.
- /wwdc/news/ 와 같은 특정 링크를 지정하려면 URL을 포함해야 합니다.
- /videos/wwdc/2015/*와 같은 특정 URL에 *를 추가하여 웹 사이트의 부분을 지정한다. *를 사용하여 하위 문자열을 일치시킬 뿐만 아니라 ?를 사용하여 단일 문자를 일치시킬 수도 있다. /foo/*/bar/201?/mypage 와 같은 단일 경로에서 두 와일드카드를 결합할 수 있습니다.


<br>

** 단어

seamlessly 부사 매끄럽게, 균일하게

without 전치사 ~없이 부사 ~없이, ~없는

several 형용사 각각의

benefits 명사 헤택, 이득

Unlike 전치사 ~와 다른, ~와는 달리

claimed 동사 주장하다, 요구하다

behalf 명사 이익, 지지

make sure 반드시 (~하도록) 하다 (~을 확실히 하다)

Flexible 형용사 유연한

even 형용사 평편한, 균등한

communicate 동사 의사소통하다, 전달하다

within 전치사 이내에

occur 동사 일어나자, 발생하다, 존재하다

in addition to ~에 더하여

browsing 동사 둘러보다

most likely 아마, 필시

intent 명사 시도

place 동사 설치[배치]하다

Prepare 동사 준비하다

secure 동사 얻어 내다, 획득[확보]하다

establish 동사 성립[설정]하다, 수립하다, 확고히 하다

trust relationship 신뢰 관계

described 동사 서술되었다

supply 명사 공급

separate 형용사 분리된

serve 동사 제공하다

In contrast 그에 반해

uncompressed 압축되지 않은

regardless 부사 개의치[상관하지] 않고

specify 동사 명시하다, 지정하다

fairly 부사 상당히, 꽤

Keep 동사 ~을 계속하다[반복하다]

rely  의지하다 의존하다 

identifies 동사 식별하다

determines 결정하다

evaluates 동사 평가하다
