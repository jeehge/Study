//
//  keyboardObserver.swift
//  SwiftUIMemo
//
//  Created by JH on 2020/07/12.
//  Copyright © 2020 JH. All rights reserved.
//

import UIKit
import Combine

class KeyboardObserver: ObservableObject {
	struct Context {
		let animationDuration: TimeInterval
		let height: CGFloat
		
		// 키보드가 숨겨진 상태 값
		static let hide = Self(animationDuration: 0.25, height: 0)
	}
	
	// 바인딩에 사용할 속성
	// 값이 업데이트 되면 연관된 뷰도  자동으로 업데이트 되도록
	@Published var context = Context.hide
	
	// 메모리관리에 사용될 속성
	private var cancellables = Set<AnyCancellable>()
	
	// 생성자
	init() {
		// 옵져버 등록
		// 컴바인 사용해서 구현
		let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
		let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
		
		// 두 퍼블리셔를 머지 연산자로 합침
		willShow.merge(with: willHide)
			.compactMap(parse) // 노티피케이션에서 필요한 데이터를를 추출한 다음 컴펙트맵 연산자를 사용해서 컨텍스트 형식으로 변환
			.assign(to: \.context, on: self) // 어사인 연산자를 추가하고 변환된 컨텍스트 인스턴스를 컨텍스트 속성에 바인딩
			.store(in: &cancellables) // 메모리처리에 필요한 코드
		
		// 키보드 willshow 노티피케이션과 willhide 노티피케이션이 전달되면 parse 메서드가 실행되고 이 메서드가 리턴하는 결과가 context 속성에 자동으로 저장됩니다 그리고 키보드 옵져버 객체가 사라지면 관련된 메모리가 자동으로 정리됩니다
	}
	
	func parse(notification: Notification) -> Context? {
		// userinfo 상수에 바인딩
		guard let userInfo = notification.userInfo else { return nil }
		
		let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
		let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
		
		// 높이 저장
		var height: CGFloat = 0
		
		// 프레임 값을 꺼내
		if let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let frame = value.cgRectValue
			
			// 키보드가 표시되는 시점이라면
			if frame.origin.y < UIScreen.main.bounds.height {
				height = frame.height - (safeAreaInsets?.bottom ?? 0)
			}
		}
		
		return Context(animationDuration: animationDuration, height: height)
	}
}
