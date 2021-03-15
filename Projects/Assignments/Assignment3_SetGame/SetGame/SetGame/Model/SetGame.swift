//
//  SetGame.swift
//  SetGame
//
//  Created by T  on 2021-03-14.
//

import SwiftUI


struct SetGame<ColorContent, NumberContent, SymbolContent, ShadingContent> where
    ColorContent: CaseIterable, NumberContent: CaseIterable,
    SymbolContent: CaseIterable, ShadingContent: CaseIterable {

    private var cardsInDeck = [Card]()
    private var cardsOnTable = [Card]()
    private var cardsMatched = [Card]()

    static private func createNewGameDeck() -> [Card] {
        var id = 0
        var newDeck = [Card]()
        for color in ColorContent.allCases {
            for number in NumberContent.allCases {
                for symbol in SymbolContent.allCases {
                    for shading in ShadingContent.allCases {
                        newDeck.append(Card(id: id, color: color, number: number, symbol: symbol, shading: shading))
                        id += 1
                    }
                }
            }
        }

        return newDeck.shuffled()
    }

    func getCardsInDeck() -> [Card] {
        return cardsInDeck
    }

    func getCardsOnTable() -> [Card] {
        return cardsOnTable
    }


    mutating func getInitialCardsOnTable() {
        cardsOnTable.append(contentsOf: self.cardsInDeck[0...11])
        cardsInDeck.removeFirst(12)
    }


    init() {
        self.cardsInDeck = Self.createNewGameDeck()
        self.cardsOnTable = [Card]()
        self.cardsMatched = [Card]()
    }

    mutating func resetGame() {
        self.cardsInDeck = Self.createNewGameDeck()
        self.cardsOnTable = [Card]()
        self.cardsMatched = [Card]()
    }


    struct Card: Identifiable {
        let id: Int
        let color: ColorContent
        let number: NumberContent
        let symbol: SymbolContent
        let shading: ShadingContent
        var isMatched: Bool = false
    }
}



