//
//  MemoListScene.swift
//  SwiftUIMemo
//
//  Created by JH on 2020/07/11.
//  Copyright © 2020 JH. All rights reserved.
//

import SwiftUI

struct MemoListScene: View {
	@EnvironmentObject var store: MemoStore
	
    var body: some View {
		NavigationView {
			List(store.list) { memo in
				Text(memo.content)
			}
			.navigationBarTitle("내 메모")
		}
    }
}

struct MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
		.environmentObject(MemoStore())
    }
}
