//
//  ContentView.swift
//  MemoryMatch
//
//  Created by Aishwarya Kannan on 26/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplashScreen = true
    var body: some View {
        if showSplashScreen {
            SplashScreen()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showSplashScreen = false
                    }
                }
        } else {
            MainView()
        }
    }
}

#Preview {
    ContentView()
}
