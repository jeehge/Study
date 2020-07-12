//
//  ComposeScene.swift
//  SwiftUIMemo
//
//  Created by JH on 2020/07/11.
//  Copyright © 2020 JH. All rights reserved.
//

import SwiftUI

struct ComposeScene: View {
	// 옵져버를 주입할 속성
	@EnvironmentObject var keyboard: KeyboardObserver
	@EnvironmentObject var store: CoreDataManager
	// 입력한 속성 바인딩하는
	@State private var content: String = ""
	
	@Binding var showComposer: Bool
	
	// 메모가 전달되면 편집 모드
	// 전달되지 않으면 쓰기 모드
	var memo: MemoEntity? = nil
	
    var body: some View {
		NavigationView {
			VStack {
				// content 와 TextField 바인딩됨
				// To way binding
				TextView(text: $content)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.padding(.bottom, keyboard.context.height)
					.animation( .easeInOut(duration: keyboard.context.animationDuration ))
					.background(Color.yellow) // swift ui에선 뷰를 중앙에 위치시킴
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity) // 사용가능한 최대 크기로 설정
				.navigationBarTitle(memo != nil ? "메모 편집" : "새 메모", displayMode:  .inline)// 기본이 라지타이틀 displayMode를 사용해서 비활성화시킴
				.navigationBarItems(leading: DismissButton(show: $showComposer), trailing: SaveButton(show: $showComposer, content: $content, memo: memo))
		}
		.onAppear {
			// 화면이 표시되는 시점에 초기화 코드를 구현하고 싶다면 여기서 구현합니다
			// 메모가 전달되었다면 텍스트뷰에 편집할 내용을 표시하고 전달되지 않으면 빈 내용
			self.content = self.memo?.content ?? ""
		}
    }
}

fileprivate struct DismissButton: View {
	@Binding var show: Bool
	
	var body: some View {
		Button(action: {
			self.show = false
		}, label: {
			Text("취소")
		})
	}
}

fileprivate struct SaveButton: View {
	@Binding var show: Bool
	
	// 자동으로 주입
	@EnvironmentObject var store: CoreDataManager
	@Binding var content: String
	
	var memo: MemoEntity? = nil
	
	var body: some View {
		Button(action: {
			if let memo = self.memo { // 편집 모드
				self.store.update(memo: memo, content: self.content)
			} else {
				self.store.addMemo(content: self.content) // 호출할 때 접근하는 store가 초기화되어 있지 않아 에러 발생
			}
			
			
			self.show = false
		}, label: {
			Text("저장")
		})
	}
}

struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
		ComposeScene(showComposer: .constant(false))
			.environmentObject(CoreDataManager.shared)
			.environmentObject(KeyboardObserver())
    }
}
