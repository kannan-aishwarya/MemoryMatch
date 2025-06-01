//
//  CardView.swift
//  MemoryMatch
//
//  Created by Aishwarya Kannan on 26/05/25.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let imageName: String
    var isFlipped: Bool = false
    var isMatched: Bool = false
}

struct CardView: View {
    let card: Card
    var body: some View {
        ZStack{
            if card.isFlipped {
                Image(card.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipped()
                    .cornerRadius(9)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 120, height: 120)
                    .cornerRadius(9)
                    .overlay(
                      Image(systemName: "questionmark")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    )
            }
        }
        .animation(.easeInOut, value: card.isFlipped)
    }
}
