//
//  EmojiMemorizeGame.swift
//  CS193p_2020_Assignment1
//
//  Created by T  on 2021-03-10.
//

import SwiftUI
class EmojiMemoryGame: ObservableObject {
    @Published var model: MemoryGame<String>
    var theme: Theme

    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            return theme.emojis[pairIndex]
        }
    }


    static func printJSON(theme: Theme) {
        
    }

    init() {
        theme = Theme.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }



    // MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    var point: Int {
        model.point
    }



    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }

    func start() {
        theme = Theme.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        print("json = \(theme.json?.utf8 ?? "nil")")
    }


}

extension Data {
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
