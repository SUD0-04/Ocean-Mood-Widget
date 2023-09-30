//
//  ContentView.swift
//  DemoWidget
//
//  Created by Kngmin Kang on 9/30/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(UIColor(red: 0x4E / 255.0, green: 0x6A / 255.0, blue: 0x78 / 255.0, alpha:1))
                .ignoresSafeArea() // Fill the entire widget area
            VStack {
                Text("OCEAN MOOD")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(UIColor(red: 0xF1 / 255.0, green: 0xA0 / 255.0, blue: 0x8D / 255.0, alpha:1)))
                Text("For Demo")
                    .padding(.bottom, 400)
                    .foregroundColor(Color(UIColor(red: 0x1A / 255.0, green: 0x32 / 255.0, blue: 0x34 / 255.0, alpha:1)))
            }
        }
    }
}

#Preview {
    ContentView()
}
