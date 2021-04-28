//
//  Theme.swift
//  Memorize
//
//  Created by T  on 2021-04-27.
//

import SwiftUI


struct Theme: Codable {
    var name: String
    var emojis: [String]
    var color: UIColor.RGB
    /* Required Task #1 */
    var numberOfPairsOfCards: Int 

    var json: Data? {
        return try? JSONEncoder().encode(self)
    }

    init(name: String, emojis: [String], color: UIColor.RGB) {
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numberOfPairsOfCards = emojis.count
    }


    static let themes: [Theme] = {
        [Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "🍬", "🧙🏻", "🌕"], color: colorDict[.orange]!),
         Theme(name: "Animal", emojis: ["🐍", "🐷", "🐰", "🐑", "🐙", "🦑", "🐥", "🐯"], color: colorDict[.purple]!),
         Theme(name: "Sports", emojis: ["🏸", "🏀", "🏓", "🎱", "⚽️"], color: colorDict[.green]!),
         Theme(name: "Food", emojis: ["🍣", "🍜", "🍔", "🥙", "🌮", "🥘", "🥗", "🥐", "🍕"], color: colorDict[.yellow]!),
         Theme(name: "Weather", emojis: ["☃️", "☀️", "☁️", "☔️", "🌦", "🌬"], color: colorDict[.blue]!),
         Theme(name: "Fruit", emojis: ["🍒", "🍊", "🍍", "🍉", "🍌", "🍓"], color: colorDict[.pink]!),
        ]
    }()



}

