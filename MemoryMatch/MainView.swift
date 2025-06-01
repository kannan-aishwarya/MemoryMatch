//
//  MainView.swift
//  MemoryMatch
//
//  Created by Aishwarya Kannan on 26/05/25.
//

import SwiftUI

struct MainView: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    @State private var cards: [Card] = MainView.generateCards()
    @State private var score: Int = 0
    @State private var flippedCards: [Int] = []
    @State private var timer: Timer? = nil
    @State private var timeRemaining = 30
    @State private var showAlert = false
    func startTimer() {
        timer?.invalidate()
        timeRemaining = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                for i in cards.indices {
                    cards[i].isFlipped = true
                }
                showAlert = true
                print("Time's up! Final score: \(score)")
            }
        }
    }
    static func generateCards() -> [Card] {
            let images = ["dog","cat","rabbit","cub"]
            return (0..<9).map { _ in
                Card(imageName: images.randomElement() ?? "dog")
            }
    }
    
    func handleClick(index: Int) {
        guard !cards[index].isFlipped && !cards[index].isMatched && flippedCards.count < 2 else {
            return
        }
        cards[index].isFlipped = true
        flippedCards.append(index)

        if flippedCards.count == 2 {
            let firstIndex = flippedCards[0]
            let secondIndex = flippedCards[1]
            if cards[firstIndex].imageName == cards[secondIndex].imageName {
                score += 1
                cards[firstIndex].isMatched = true
                cards[secondIndex].isMatched = true
                // Keep them flipped
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    flippedCards.removeAll()
                }
            } else {
                // Flip them back after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    cards[firstIndex].isFlipped = false
                    cards[secondIndex].isFlipped = false
                    flippedCards.removeAll()
                }
            }
        }
    }
    var body: some View {
        VStack {
            Text("Memory Match")
                .font(.title)
                .padding(60)
            Text("Score: \(score)")
                .font(.title)
                .padding()
            Text("Time Left: \(timeRemaining)s")
                .font(.headline)
                .foregroundColor(.red)
            Spacer()
            LazyVGrid(columns: columns,spacing: 20 ){
                ForEach(cards.indices) {index in
                    CardView(card: cards[index])
                        .onTapGesture{
                            handleClick(index: index)
                        }
                        .allowsHitTesting(!cards[index].isMatched)
                }
                
            }
            Button("Retry") {
                score = 0
                cards = MainView.generateCards()
                startTimer()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            Spacer()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Time's Up!"),
                        message: Text("Your final score is \(score)"),
                        dismissButton: .default(Text("OK"),
                                                action: {
                                                    cards = MainView.generateCards()
                                                })
                    )
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            startTimer()
        }
        
    }
}

#Preview {
    MainView()
}
