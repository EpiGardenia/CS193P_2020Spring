//
//  EmojiMemorizeGame.swift
//  CS193p_2020_Assignment1
//
//  Created by T  on 2021-03-10.
//

import SwiftUI
class EmojiMemoryGame: ObservableObject {
    let theme: Theme
    @Published var model: MemoryGame<String>

    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let num = theme.numberOfPairsOfCards
        var chosenEmojis = theme.emojis.shuffled()
        chosenEmojis = chosenEmojis.takeFirst(k: num)
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { _ in
            return chosenEmojis.popLast()!
        }
    }

    init(theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
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
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
//        print("json = \(theme.json?.utf8 ?? "nil")")
    }
}

extension Data {
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
