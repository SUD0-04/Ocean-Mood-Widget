//
//  ContentView.swift
//  DemoWidget
//
//  Created by Kngmin Kang on 9/30/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Demo Widget")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text("For KeyNote")
                .padding(.bottom, 400)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
