//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by T  on 2021-03-14.
//

import SwiftUI


class SetGameViewModel: ObservableObject {
    typealias setGame = SetGame<SetColor, SetNumber, SetSymbol, SetShading>
    var score: Int {
        model.getScore()
    }
    
    @Published var model: SetGame<SetColor, SetNumber, SetSymbol, SetShading>
    
    init() {
        model = SetGame<SetColor, SetNumber, SetSymbol, SetShading>()
    }
    
    var cardsInDeck: [SetGame<SetColor, SetNumber, SetSymbol, SetShading>.Card] {
        model.getCardsInDeck()
    }
    var cardsOnTable: [SetGame<SetColor, SetNumber, SetSymbol, SetShading>.Card] {
        model.getCardsOnTable()
        
    }


    
    func getInitialCardsOnTable() {
        model.getInitialCardsOnTable()
    }
    
    enum SetColor: CaseIterable, Equatable {
        case gray, red, blue
        var color: Color {
            switch self {
                case .gray:
                    return Color.black
                case .blue:
                    return Color.blue
                case .red:
                    return Color.red
            }
        }
    }
    
    enum SetNumber: CaseIterable, Equatable{
        case one, two, three
        var number: Int {
            switch self {
                case .one:
                    return 1
                case .two:
                    return 2
                case .three:
                    return 3
            }
        }
    }
    
    enum SetSymbol: CaseIterable, Equatable {
        case diamond, squiggles, oval
    }
    
    enum SetShading: CaseIterable, Equatable {
        case solid, striped, open
        
        var opacity: Double {
            switch self {
                case .solid:
                    return 1
                case .striped:
                    return 0.5
                case .open:
                    return 0
            }
        }
    }
    
    
    static func getSymbolWithColorShading(symbol: SetSymbol, color: SetColor, shading: SetShading) -> some View {
        return ZStack {
            switch symbol {
                case .diamond:
                    Diamond().fill(color.color).opacity(shading.opacity)
                    Diamond().stroke()
                case .oval:
                    Oval().fill(color.color).opacity(shading.opacity)
                    Oval().stroke()
                case .squiggles:
                    SetRectangle().fill(color.color).opacity(shading.opacity)
                    SetRectangle().stroke()
            }
        }.foregroundColor(color.color)
    }
    
    
    func startNewGame() {
        model = SetGame<SetColor, SetNumber, SetSymbol, SetShading>()
        model.getInitialCardsOnTable()
    }

    func dealThreeCards() {
        model.dealThreeCards()
    }

    func select(card: setGame.Card) {
        model.select(card)
    }

    static var cardExample: setGame.Card {
       var  model = SetGame<SetColor, SetNumber, SetSymbol, SetShading>()
        model.getInitialCardsOnTable()
        let card = model.cardsOnTable[0]
        model.select(card)
        return card
    }
    
}
