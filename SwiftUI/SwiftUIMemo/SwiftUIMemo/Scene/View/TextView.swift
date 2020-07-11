//
//  TextView.swift
//  SwiftUIMemo
//
//  Created by JH on 2020/07/12.
//  Copyright © 2020 JH. All rights reserved.
//

import UIKit
import SwiftUI

// SwiftUI에서 UIKit이 제공하는 View를 사용하려면 이 프로토콜을 구현해야한다
struct TextView: UIViewRepresentable {
	@Binding var text: String // 바인딩 속성 추가
	
	// 프로토콜이 요구하는 멤버 구현
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeUIView(context: Context) -> UITextView {
		let myTextView = UITextView()
		myTextView.delegate = context.coordinator
		
		return myTextView
	}
	
	func updateUIView(_ uiView: UITextView, context: Context) {
		uiView.text = text
	}
	
	//델리게이트를 처리할 코디네이터 클래스를 구현
	class Coordinator: NSObject, UITextViewDelegate {
		var parent: TextView
		
		init(_ uiTextView: TextView) {
			self.parent = uiTextView
		}
		
		func textViewDidChange(_ textView: UITextView) {
			self.parent.text = textView.text
		}
	}
}
