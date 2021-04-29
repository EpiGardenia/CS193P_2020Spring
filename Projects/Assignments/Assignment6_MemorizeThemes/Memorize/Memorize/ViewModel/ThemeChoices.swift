//
//  Themes.swift
//  Memorize
//
//  Created by T  on 2021-04-28.
//

import Foundation
import Combine

class ThemeChoices: ObservableObject {

    @Published private var allThemes: [Theme]
    private var autoSave: AnyCancellable?

    init() {
        allThemes = ThemeChoices.decode(UserDefaults.standard.data(forKey: "themeChoices"))
        if allThemes.isEmpty {
            allThemes = ThemeChoices.initial
        }
        allThemes.forEach { theme in
            print("theme: \(theme.name)")
        }

        autoSave = $allThemes.sink { themes in
            UserDefaults.standard.set(ThemeChoices.encode(themes), forKey: "themeChoices")
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
        print("Update(theme: \(theme.name)")

        let index = allThemes.firstIndex(matching: theme)!

        allThemes[index] = theme
    }


    func updateNumber(theme: Theme, num: Int) {
        var newTheme = theme
        newTheme.numberOfPairsOfCards = num
        update(theme: newTheme)

    }


    func findTheme(id: UUID) -> Theme? {
        print("Find Theme ID: \(id) \n \(allThemes.debugDescription)")
      return allThemes.first(where: {$0.id == id})
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
