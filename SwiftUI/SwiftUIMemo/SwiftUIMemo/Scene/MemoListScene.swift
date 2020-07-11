//
//  MemoListScene.swift
//  SwiftUIMemo
//
//  Created by JH on 2020/07/11.
//  Copyright © 2020 JH. All rights reserved.
//

import SwiftUI

struct MemoListScene: View {
	// 뷰가 생성되는 시점에 자동으로 초기화 됨
	@EnvironmentObject var store: MemoStore
	@EnvironmentObject var formatter: DateFormatter
	
	@State var showComposer: Bool = false
	
    var body: some View {
		NavigationView {
			List(store.list) { memo in
				MemoCell(memo: memo)
			}
			.navigationBarTitle("내 메모")
			.navigationBarItems(trailing: ModalButton(show: $showComposer)) // $ 값이 복사된게 아니라 바인딩이 전달됨 여기서 전달한 속성은 ModalButton show 에 바인딩이 저장됨 뷰 외부의 속성을 변경하고 싶을땐 뷰 바인딩으로 변경해야 한다
			.sheet(isPresented: $showComposer, content: {
				ComposeScene(showComposer: self.$showComposer) // 자동 주입되고 있지 않음
					.environmentObject(self.store) //  주입되도록 코드 추가
					.environmentObject(KeyboardObserver())
			})
		}
    }
}

fileprivate struct ModalButton: View {
	// 값을 직접 저장하는 속성이 아니라 다른 곳에 있는 속성을 바꾸기 위한 속성
	@Binding var show: Bool
	
	var body: some View {
		Button(action: {
			self.show = true
		}, label: {
			Image(systemName: "plus")
		})
	}
}

struct MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
		.environmentObject(MemoStore())
			.environmentObject(DateFormatter.memoDateFormatter)
    }
}

