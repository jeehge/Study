//
//  MemoCell.swift
//  SwiftUIMemo
//
//  Created by JH on 2020/07/11.
//  Copyright © 2020 JH. All rights reserved.
//

import SwiftUI

struct MemoCell: View {
	// 메모객체가 업데이트 되는 시점마다 뷰가 그려짐 - 최신데이터 표시
	@ObservedObject var memo: MemoEntity
	@EnvironmentObject var formatter: DateFormatter
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(memo.content ?? "")
				.font(.body)
				.lineLimit(1)
			
			Text("\(memo.insertDate ?? Date(), formatter: self.formatter)")
				.font(.caption)
				.foregroundColor(Color(UIColor.secondaryLabel))
		}
	}
}

struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
		MemoCell(memo: MemoEntity(context: CoreDataManager.mainContext))
			.environmentObject(DateFormatter.memoDateFormatter)
    }
}
