//
//  SplashScreen.swift
//  MemoryMatch
//
//  Created by Aishwarya Kannan on 26/05/25.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack(spacing: 50){
          Image(systemName: "square.stack.3d.up")
                .resizable()
                .scaledToFit()
                .frame(width: 200,height: 200)
          Text("Memory Match")
                .font(.title)
                .foregroundStyle(.indigo)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
        .ignoresSafeArea()
    }
}

#Preview {
    SplashScreen()
}
