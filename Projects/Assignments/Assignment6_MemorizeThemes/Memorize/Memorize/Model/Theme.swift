//
//  Theme.swift
//  Memorize
//
//  Created by T  on 2021-04-27.
//

import SwiftUI


struct Theme: Codable, Identifiable {
    var id: UUID
    var name: String
    var emojis: Set<String>
    var color: UIColor.RGB
    var numberOfPairsOfCards: Int 

    var json: Data? {
        return try? JSONEncoder().encode(self)
    }

    static let minPair = 4
    var maxPairs: Int {
        return emojis.count
    }
    
    // return false if emoji already exist
    mutating func addEmoji(emoji: String) -> Bool {
        let result = emojis.insert(emoji)
        return result.inserted
    }


    mutating func removeEmoji(emoji: String) {
        emojis.remove(emoji)
    }


    init() {
        self.id = UUID()
        self.name = "New Theme"
        self.emojis = ["🎱", "🌕", "🐍", "🐷", "🍊", "🍍"]
        self.color = colorDict[.blue]!
        self.numberOfPairsOfCards = 5
    }

    init(name: String, emojis: Set<String>, color: UIColor.RGB, number: Int) {
        self.id = UUID()
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numberOfPairsOfCards = number
    }


    static let examples: [Theme] = {
        [Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "🍬", "🧙🏻", "🌕"], color: colorDict[.orange]!, number: 5),
         Theme(name: "Animal", emojis: ["🐍", "🐷", "🐰", "🐑", "🐙", "🦑", "🐥", "🐯"], color: colorDict[.purple]!, number: 7),
         Theme(name: "Sports", emojis: ["🏸", "🏀", "🏓", "🎱", "⚽️"], color: colorDict[.green]!, number: 4),
         Theme(name: "Food", emojis: ["🍣", "🍜", "🍔", "🥙", "🌮", "🥘", "🥗", "🥐", "🍕"], color: colorDict[.yellow]!, number: 8),
         Theme(name: "Weather", emojis: ["☃️", "☀️", "☁️", "☔️", "🌦", "🌬"], color: colorDict[.blue]!, number: 5),
         Theme(name: "Fruit", emojis: ["🍒", "🍊", "🍍", "🍉", "🍌", "🍓"], color: colorDict[.pink]!, number: 5),
        ]
    }()
}

