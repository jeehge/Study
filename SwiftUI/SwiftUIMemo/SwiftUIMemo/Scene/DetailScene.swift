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
	@ObservedObject var memo: MemoEntity
	
	// 주입할 속성
	@EnvironmentObject var store: CoreDataManager
	@EnvironmentObject var formatter: DateFormatter
	
	@State private var showEditSheet = false
	@State private var showDeleteAlert = false
	
	// presentationMode 속성에 화면전화을 관리하는 객체가 저장됨
	// 네비게이션 챕터에서 자세히 배움
	@Environment(\.presentationMode) var presentationMode
	
    var body: some View {
		VStack {
			ScrollView { // 스크롤뷰가 VStack 임베디드 되어 있다
				VStack { // 기본 수직
					HStack {
						Text(self.memo.content ?? "")
							.padding() // 기본 여백 추가
						
						Spacer()
					}
					
					Text("\(self.memo.insertDate ?? Date(), formatter: formatter)")
						.padding()
						.font(.footnote)
						.foregroundColor(Color(UIColor.secondaryLabel))
				}
			}
			
			HStack {
				Button(action: {
					// 경고창 표시하고 삭제여부 표시
					self.showDeleteAlert.toggle()
				}, label: {
					Image(systemName: "trash")
						.foregroundColor(Color(UIColor.systemRed))
				})
				.padding()
					.alert(isPresented: $showDeleteAlert, content: {
						Alert(title: Text("삭제 확인"), message: Text("메모를 삭제할까요?"),
							  primaryButton: .destructive(Text("삭제"), action: {
								self.store.delete(memo: self.memo)
								self.presentationMode.wrappedValue.dismiss()
							}),
							secondaryButton: .cancel())
					})
				
				Spacer() // 버튼이 양쪽끝에 배치됨
				
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
			.padding(.leading)
			.padding(.trailing)
		}
		.navigationBarTitle("메모 보기")
    }
	// SwiftUI에선 모든 뷰를 가운데 정렬합니다 <- 기본적인 레이아웃 규칙
}

struct DetailScene_Previews: PreviewProvider {
    static var previews: some View {
		DetailScene(memo: MemoEntity(context: CoreDataManager.mainContext))
			.environmentObject(CoreDataManager.shared)
			.environmentObject(DateFormatter.memoDateFormatter)
    }
}
