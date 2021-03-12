//
//  EmojiMemorizeGame.swift
//  CS193p_2020_Assignment1
//
//  Created by T  on 2021-03-10.
//

import SwiftUI
class EmojiMemoryGame: ObservableObject {
    // @Published: everytime model change, it is going to objectWillChange.send()
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: 3) { pairIndex in
           return emojis[pairIndex]
        }
    }

    init() {
        
    }

    // MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }


    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
}
