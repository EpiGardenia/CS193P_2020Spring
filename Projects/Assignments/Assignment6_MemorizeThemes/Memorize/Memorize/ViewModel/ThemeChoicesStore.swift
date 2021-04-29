//
//  Themes.swift
//  Memorize
//
//  Created by T  on 2021-04-28.
//

import Foundation
import Combine

class ThemeChoicesStore: ObservableObject {

    @Published private var allThemes: [Theme]
    private var autoSave: AnyCancellable?
    private let themesKey = "themeChoices"

    init() {
        allThemes = ThemeChoicesStore.decode(UserDefaults.standard.data(forKey: themesKey))
        if allThemes.isEmpty {
            allThemes = ThemeChoicesStore.initial
        }

        autoSave = $allThemes.sink { themes in
            UserDefaults.standard.set(ThemeChoicesStore.encode(themes), forKey: self.themesKey)
        }
    }

    static func encode(_ themes: [Theme]) -> Data? {
       return try? JSONEncoder().encode(themes)
    }

    static func decode(_ data: Data?) -> [Theme] {
        if let data = data {
            let decode =  try? JSONDecoder().decode([Theme].self, from: data)
            return decode ?? [Theme]()
        }
        return [Theme]()
    }

    func getAllthemes() -> [Theme] {
        return allThemes
    }

    func addTheme() {
        allThemes.append(Theme())
    }

    func removeTheme(theme: Theme) {
        if let rmIndex = allThemes.firstIndex(matching: theme)  {
            allThemes.remove(at: rmIndex)
        }
    }

    func update(theme: Theme) {
        let index = allThemes.firstIndex(matching: theme)!
        allThemes[index] = theme
    }

    func updateNumber(theme: Theme, num: Int) {
        var newTheme = theme
        newTheme.numberOfPairsOfCards = num
        update(theme: newTheme)
    }

    func getTheme(id: UUID) -> Theme {
        if let theme = allThemes.first(where: {$0.id == id}) {
            return theme
        } else {
            fatalError("Theme ID \(id) not found.")
        }
    }

    static let initial: [Theme] =
        [Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "🍬", "🧙🏻", "🌕"], color: colorDict[.orange]!, number: 5),
         Theme(name: "Animal", emojis: ["🐍", "🐷", "🐰", "🐑", "🐙", "🦑", "🐥", "🐯"], color: colorDict[.purple]!, number: 7),
         Theme(name: "Sports", emojis: ["🏸", "🏀", "🏓", "🎱", "⚽️"], color: colorDict[.green]!, number: 4),
         Theme(name: "Food", emojis: ["🍣", "🍜", "🍔", "🥙", "🌮", "🥘", "🥗", "🥐", "🍕"], color: colorDict[.yellow]!, number: 8),
         Theme(name: "Weather", emojis: ["☃️", "☀️", "☁️", "☔️", "🌦", "🌬"], color: colorDict[.blue]!, number: 5),
         Theme(name: "Fruit", emojis: ["🍒", "🍊", "🍍", "🍉", "🍌", "🍓"], color: colorDict[.pink]!, number: 5),
        ]




}
