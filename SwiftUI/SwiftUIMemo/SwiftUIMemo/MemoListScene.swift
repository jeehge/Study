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
	
    var body: some View {
		NavigationView {
			List(store.list) { memo in
				VStack(alignment: .leading) {
					Text(memo.content)
						.font(.body)
						.lineLimit(1)
					
					Text("\(memo.insertDate, formatter: self.formatter)")
						.font(.caption)
						.foregroundColor(Color(UIColor.secondaryLabel))
						
				}
			}
			.navigationBarTitle("내 메모")
		}
    }
}

struct MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
		.environmentObject(MemoStore())
			.environmentObject(DateFormatter.memoDateFormatter)
    }
}
