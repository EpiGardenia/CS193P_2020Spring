//
//  CardView.swift
//  SetGame
//
//  Created by T  on 2021-03-15.
//

import SwiftUI

struct CardView: View {
    var card: SetGameViewModel.setGame.Card

    init(of card: SetGameViewModel.setGame.Card) {
        self.card = card
    }

    var body: some View {
        GeometryReader { geometry in
            body(size: geometry.size)
        }
    }

    func body(size: CGSize) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            VStack{
                ForEach(0..<card.number.number) { _ in
                    SetGameViewModel.getSymbolWithColorShading(symbol: card.symbol, color: card.color, shading: card.shading)
                        .font(.system(size: min(size.height, size.width)*0.25))
                }
            } .padding()
        }
        .aspectRatio(2/3, contentMode: .fit)
    }    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(of: SetGameViewModel.cardExample)
    }
}
