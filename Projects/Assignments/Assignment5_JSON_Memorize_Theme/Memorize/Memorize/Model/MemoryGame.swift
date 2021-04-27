//
//  MemorizeGame.swift
//  Model
//
//  Created by T  on 2021-03-10.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Hashable {
    var cards: [Card]
    var point: Int
    private var unmatchedSeenCardContents: [CardContent] = []

    private var indexOfTheOnlyAndOnlyFaceUpCard: Int? { // all optionals init to nil by default
        get { cards.indices.filter{cards[$0].isFaceUp}.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }


    mutating func choose(card: Card) {
       // print("card chosen: \(card)")
        //" ," is like sequential And, the condition is checked in sequence
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOnlyAndOnlyFaceUpCard {
                if card.content == cards[potentialMatchIndex].content {
                    _ = [chosenIndex, potentialMatchIndex].map { cards[$0].isMatched = true }
                    if let index = unmatchedSeenCardContents.firstIndex(of: card.content) {
                        unmatchedSeenCardContents.remove(at: index)
                    }
                    point += 2
                } else {
                    _ = [chosenIndex, potentialMatchIndex].map {
                        if unmatchedSeenCardContents.contains(cards[$0].content) {
                            point -= 1
                        } else {
                            unmatchedSeenCardContents.append(cards[$0].content)
                        }
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOnlyAndOnlyFaceUpCard = chosenIndex
            }
        }
    }

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        point = 0
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }

        cards.shuffle() 
    }

    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
