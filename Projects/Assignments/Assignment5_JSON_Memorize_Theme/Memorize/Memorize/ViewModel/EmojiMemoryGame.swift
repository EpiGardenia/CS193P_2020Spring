//
//  EmojiMemorizeGame.swift
//  CS193p_2020_Assignment1
//
//  Created by T  on 2021-03-10.
//

import SwiftUI
class EmojiMemoryGame: ObservableObject {
    // @Published: everytime model change, it is going to objectWillChange.send()
    @Published var model: MemoryGame<String>
    var theme: Theme

    static func createMemoryGame(theme: Theme) -> MemoryGame<String> { // Required Task #5
        let numbers = theme.numberOfPairsOfCards ?? Int.random(in: 2...theme.emojis.count)
        return MemoryGame<String>(numberOfPairsOfCards: numbers) { pairIndex in
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
    // Required Tasks #3 #4
    struct Theme {
        var name: String
        var emojis: [String]
        var color: Color
        var numberOfPairsOfCards: Int?

    static let themes: [Theme] = {
        [Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "🍬", "🧙🏻", "🌕"], color: Color.orange, numberOfPairsOfCards: 6),
         Theme(name: "Animal", emojis: ["🐍", "🐷", "🐰", "🐑", "🐙", "🦑"], color: Color.purple),
         Theme(name: "Sports", emojis: ["🏸", "🏀", "🏓", "🎱", "⚽️"], color: Color.gray),
         Theme(name: "Food", emojis: ["🍣", "🍜", "🍔", "🥙", "🌮", "🥘", "🥗"], color: Color.yellow),
         Theme(name: "Weather", emojis: ["☃️", "☀️", "☁️", "☔️", "🌦", "🌬"], color: Color.blue),
         Theme(name: "Fruit", emojis: ["🍒", "🍊", "🍍", "🍉", "🍌", "🍓"], color: Color.pink),
        ]
    }()

    }

}
