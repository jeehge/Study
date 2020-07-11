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
	
    var body: some View {
		NavigationView {
			
			VStack {
				// content 와 TextField 바인딩됨
				// To way binding
				TextField("", text: $content)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity) // 사용가능한 최대 크기로 설정
			.navigationBarTitle("새 메모", displayMode:  .inline)// 기본이 라지타이틀 displayMode를 사용해서 비활성화시킴
			.navigationBarItems(leading: DismissButton(), trailing: SaveButton())
			
		}
    }
}

fileprivate struct DismissButton: View {
	var body: some View {
		Button(action: {
			//
		}, label: {
			Text("취소")
		})
	}
}

fileprivate struct SaveButton: View {
	var body: some View {
		Button(action: {
			//
		}, label: {
			Text("저장")
		})
	}
}

struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene()
			.environmentObject(MemoStore())
    }
}
