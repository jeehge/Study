//
//  DetailScene.swift
//  SwiftUIMemo
//
//  Created by JH on 2020/07/12.
//  Copyright © 2020 JH. All rights reserved.
//

import SwiftUI

struct DetailScene: View {
	// 이전 화면에서 전달한 메모를 저장하는 속성
	// 퍼블리시드 선언된 속성이 바뀔때마다 뷰를 자동으로 업데이트합니다
	@ObservedObject var memo: Memo
	
	// 주입할 속성
	@EnvironmentObject var store: MemoStore
	@EnvironmentObject var formatter: DateFormatter
	
	@State private var showEditSheet = false
	
	
    var body: some View {
		VStack {
			ScrollView { // 스크롤뷰가 VStack 임베디드 되어 있다
				VStack { // 기본 수직
					HStack {
						Text(self.memo.content)
							.padding() // 기본 여백 추가
						
						Spacer()
					}
					
					Text("\(self.memo.insertDate, formatter: formatter)")
						.padding()
						.font(.footnote)
						.foregroundColor(Color(UIColor.secondaryLabel))
				}
			}
			
			HStack {
				Button(action: {
					// 모달로 표현
					self.showEditSheet.toggle()
				}, label: {
					Image(systemName: "square.and.pencil")
				})
				.padding()
				.sheet(isPresented: $showEditSheet, content: {
					ComposeScene(showComposer: self.$showEditSheet, memo: self.memo)
						.environmentObject(self.store)
					.environmentObject(KeyboardObserver())
				})
			}
		}
		.navigationBarTitle("메모 보기")
    }
	// SwiftUI에선 모든 뷰를 가운데 정렬합니다 <- 기본적인 레이아웃 규칙
}

struct DetailScene_Previews: PreviewProvider {
    static var previews: some View {
		DetailScene(memo: Memo(content: "SwiftUI"))
			.environmentObject(MemoStore())
			.environmentObject(DateFormatter.memoDateFormatter)
    }
}
