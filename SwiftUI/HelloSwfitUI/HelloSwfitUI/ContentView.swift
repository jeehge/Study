//
//  ContentView.swift
//  HelloSwfitUI
//
//  Created by JH on 2020/07/09.
//  Copyright © 2020 JH. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	var a = 0
	
    var body: some View {
		VStack {
			Text("Hello, SwiftUI!!!!!!!")
				.font(.largeTitle)
				.foregroundColor(Color.blue)
				.background(Color.yellow)
			
			Text("Have a nice day :)")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
