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
	@EnvironmentObject var store: CoreDataManager
	@EnvironmentObject var formatter: DateFormatter
	
	@State var showComposer: Bool = false
	
	// 속성에 적용할 특성
	// SwiftUI 뷰 내부에서 사용할때 가능하고 일반 구조체에서 사용할 땐 사용안됨
	@FetchRequest(entity: MemoEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MemoEntity.insertDate, ascending: false)])
	// 목록을 저장할 속성
	// 속성이 초기화되는 시점에 데이터를 읽어와서 여기에 자동으로 저장
	// 데이터가 업데이트 되면 배열의 업데이트도 자동으로 업데이트됨
	// FetchRequest 실행되지 않아 아무것도 저장되지 않아 error 발생했었음 <- CoreDataManager에  있었을때
	var memoList: FetchedResults<MemoEntity>
	
	
    var body: some View {
		NavigationView {
			List {
				ForEach(memoList) { memo in
					// 네비게이션 링크를 사용해야함 - 네비게이션 뷰와 사용하는 특별한 뷰 뷰를 터치하면 새로운 화면을 표시
					NavigationLink(destination: DetailScene(memo: memo), label: {
						MemoCell(memo: memo)
					})
				}
				.onDelete(perform: delete)
			}
			.navigationBarTitle("내 메모")
			.navigationBarItems(trailing: ModalButton(show: $showComposer)) // $ 값이 복사된게 아니라 바인딩이 전달됨 여기서 전달한 속성은 ModalButton show 에 바인딩이 저장됨 뷰 외부의 속성을 변경하고 싶을땐 뷰 바인딩으로 변경해야 한다
			.sheet(isPresented: $showComposer, content: {
				ComposeScene(showComposer: self.$showComposer) // 자동 주입되고 있지 않음
					.environmentObject(self.store) //  주입되도록 코드 추가
					.environmentObject(KeyboardObserver())
			}) // sheet 모달
		}
    }
	
	func delete(set: IndexSet) {
		for index in set {
			store.delete(memo: memoList[index])
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
			.environmentObject(CoreDataManager.shared)
			.environmentObject(DateFormatter.memoDateFormatter)
    }
}

