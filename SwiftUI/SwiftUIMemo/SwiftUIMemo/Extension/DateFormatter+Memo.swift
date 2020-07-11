//
//  DateFormatter+Memo.swift
//  SwiftUIMemo
//
//  Created by JH on 2020/07/11.
//  Copyright © 2020 JH. All rights reserved.
//

import Foundation

extension DateFormatter {
	static let memoDateFormatter: DateFormatter = {
		let f = DateFormatter()
		f.dateStyle = .long
		f.timeStyle = .none
		f.locale = Locale(identifier: "ko_kr")
		return f
	}()
}

extension DateFormatter: ObservableObject {
	
}
