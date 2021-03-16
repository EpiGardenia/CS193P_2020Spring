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

    private func body(size: CGSize) -> some View {
        Group {
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(indicatedColor)
                .opacity(backGroundOpacity)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: strokeWidth)
            VStack{
                ForEach(0..<card.number.number) { _ in
                    SetGameViewModel.getSymbolWithColorShading(symbol: card.symbol, color: card.color, shading: card.shading)
                        .font(.system(size: fontSize(areaSize: size)))
                }
            }
            .foregroundColor(.orange)
            .padding(padInsideCard)
            // animation here has no effect
        }
        .aspectRatio(2/3, contentMode: .fit)
        }      
    }


    private var indicatedColor: Color {
        if card.isMatched {
            return  Color.green
        } else if card.isUnMatched {
            return Color.pink
        } else if card.isSelected {
            return Color.purple
        } else {
            return Color.white
        }
    }


    // MARK: - Drawing Constants
    private let padInsideCard: CGFloat = 10
    private let cornerRadius: CGFloat = 20
    private let strokeWidth: CGFloat = 3
    private let backGroundOpacity: Double = 0.5
    private func fontSize(areaSize: CGSize) -> CGFloat {
       return min(areaSize.height, areaSize.width)*0.25
    }


}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
            CardView(of: SetGameViewModel.cardExample)
    }
}
