//
//  SetGame.swift
//  SetGame
//
//  Created by T  on 2021-03-14.
//

import SwiftUI


struct SetGame<ColorContent: Equatable, NumberContent: Equatable, SymbolContent: Equatable, ShadingContent: Equatable> where
    ColorContent: CaseIterable, NumberContent: CaseIterable,
    SymbolContent: CaseIterable, ShadingContent: CaseIterable {

    private(set) var cardsInDeck: [Card]
    private(set) var cardsOnTable: [Card]
    private(set) var matchedSetOnTable = false
    private(set) var selectedIndexes: [Int] {
        get {
            cardsOnTable.indices.filter{ cardsOnTable[$0].isSelected }
        }
        set {
            _ = cardsOnTable.indices.map{cardsOnTable[$0].isSelected = false }
            _ = newValue.map{cardsOnTable[$0].isSelected = true }

            if newValue.count == 3 {
                if Self.isValidSet(selectedCards: [cardsOnTable[newValue[0]], cardsOnTable[newValue[1]], cardsOnTable[newValue[2]]]) {
                    _ = newValue.map{cardsOnTable[$0].isMatched = true }
                }
            }
        }
    }

    private var cardsArchive = [Card]()  // TODO: maybe can be removed?

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
      //  self.cardsMatched = [Card]()
    }

    mutating func resetGame() {
        self.cardsInDeck = Self.createNewGameDeck()
        self.cardsOnTable = [Card]()
    //    self.cardsMatched = [Card]()
    }

    mutating func dealThreeCards() {
        if cardsInDeck.count >= 3 {
            cardsOnTable.append(contentsOf: self.cardsInDeck[0..<3])
            cardsInDeck.removeFirst(3)
        }
    }


    static func isValidSet(selectedCards: [Card]) -> Bool {
        selectedCards.map{$0.color}.validSetType() &&
            selectedCards.map{$0.symbol}.validSetType() &&
            selectedCards.map{$0.shading}.validSetType() &&
            selectedCards.map{$0.number}.validSetType()
    }



    mutating func select(_ card: Card) {
        // find the index of card in cardsOnTable
        if let selectedCardIndex = cardsOnTable.firstIndex(matching: card) {
            if selectedIndexes.count == 3 {
                if !matchedSetOnTable {
                    selectedIndexes = [selectedCardIndex]
                }
                // there is a matched set, and user click on 4th card, match fly away and refill, hightlight 4th card
                else if !selectedIndexes.contains(selectedCardIndex) {
                    if cardsInDeck.count >= 3 {
                        for index in 0..<3 {
                            // refill new card in matched position
                            let newCard =  cardsInDeck.removeFirst()
                            cardsOnTable[selectedIndexes[index]] = newCard
                            cardsArchive.append(newCard)
                        }
                    }
                    // only 4th is selected
                    selectedIndexes = [selectedCardIndex]
                }
            } else if selectedIndexes.contains(selectedCardIndex) {   // select a selected card
                // unselect it
                selectedIndexes.removeFirst(selectedCardIndex)
            }
        }
    }


    struct Card: Identifiable {
        let id: Int
        let color: ColorContent
        let number: NumberContent
        let symbol: SymbolContent
        let shading: ShadingContent
        var isMatched: Bool = false
        var isSelected: Bool = false
    }
}



extension Array where Element: Equatable {
    func allEqual() -> Bool {
        return self.allSatisfy{ $0 == self[0] }
    }

    func firstThreeUnique() -> Bool {
        if self.count >= 3 {
            return self[0] == self[1] && self[1] == self[2]
        } else {
            return false
        }
    }

    func validSetType() -> Bool {
        return self.allEqual() || self.firstThreeUnique()
    }

}






