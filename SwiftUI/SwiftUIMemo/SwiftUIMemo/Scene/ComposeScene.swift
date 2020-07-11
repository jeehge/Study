//
//  ComposeScene.swift
//  SwiftUIMemo
//
//  Created by JH on 2020/07/11.
//  Copyright © 2020 JH. All rights reserved.
//

import SwiftUI

struct ComposeScene: View {
	@EnvironmentObject var store: MemoStore
	// 입력한 속성 바인딩하는
	@State private var content: String = ""
	
	@Binding var showComposer: Bool
	
    var body: some View {
		NavigationView {
			VStack {
				// content 와 TextField 바인딩됨
				// To way binding
				TextField("", text: $content)
					.background(Color.yellow) // swift ui에선 뷰를 중앙에 위치시킴
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity) // 사용가능한 최대 크기로 설정
			.navigationBarTitle("새 메모", displayMode:  .inline)// 기본이 라지타이틀 displayMode를 사용해서 비활성화시킴
			.navigationBarItems(leading: DismissButton(show: $showComposer), trailing: SaveButton(show: $showComposer, content: $content))
			
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
	@EnvironmentObject var store: MemoStore
	@Binding var content: String
	
	var body: some View {
		Button(action: {
			self.store.insert(memo: self.content) // 호출할 때 접근하는 store가 초기화되어 있지 않아 에러 발생
			
			self.show = false
		}, label: {
			Text("저장")
		})
	}
}

struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
		ComposeScene(showComposer: .constant(false))
			.environmentObject(MemoStore())
    }
}
