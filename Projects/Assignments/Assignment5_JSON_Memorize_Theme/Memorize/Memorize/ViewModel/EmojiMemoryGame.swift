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
    }




    // MARK: - Theme Constants
    struct Theme {
        var name: String
        var emojis: [String]
        var color: Color
        /* Required Task #1 */
        var numberOfPairsOfCards: Int {
            emojis.count
        }

    static let themes: [Theme] = {
        [Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "🍬", "🧙🏻", "🌕"], color: Color.orange),
         Theme(name: "Animal", emojis: ["🐍", "🐷", "🐰", "🐑", "🐙", "🦑", "🐥", "🐯"], color: Color.purple),
         Theme(name: "Sports", emojis: ["🏸", "🏀", "🏓", "🎱", "⚽️"], color: Color.gray),
         Theme(name: "Food", emojis: ["🍣", "🍜", "🍔", "🥙", "🌮", "🥘", "🥗", "🥐", "🍕"], color: Color.yellow),
         Theme(name: "Weather", emojis: ["☃️", "☀️", "☁️", "☔️", "🌦", "🌬"], color: Color.blue),
         Theme(name: "Fruit", emojis: ["🍒", "🍊", "🍍", "🍉", "🍌", "🍓"], color: Color.pink),
        ]
    }()

    }

}
