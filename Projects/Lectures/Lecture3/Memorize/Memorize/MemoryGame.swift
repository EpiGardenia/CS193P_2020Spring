//
//  MemorizeGame.swift
//  CS193p_2020_Assignment1
//
//  Created by T  on 2021-03-10.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }

    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0
    }

    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenIndex: Int = index(of: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }

    struct Card: Identifiable {
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}



