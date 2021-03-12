//
//  ContentView.swift
//
//
//  Created by T  on 2021-03-10.
//
import SwiftUI

struct EmojiMemoryGameView: View {
    // Redraw when viewModel do "objectWillChange.send()"
    // SwiftUI just updates the view which has change, not everything in whole views
    @ObservedObject var viewModel: EmojiMemoryGame 

    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    // Angle 0 is right middle

    private func body(for size: CGSize) -> some View {
        ZStack{
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }


    // MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10
    private let lineWidth: CGFloat = 3

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height)*0.7
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[1])

        return EmojiMemoryGameView(viewModel: game)
    }
}

