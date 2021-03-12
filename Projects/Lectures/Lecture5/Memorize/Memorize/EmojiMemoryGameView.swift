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

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        // Lecture code shows "if card.isFaceUp || !card.isMatched {"  but I feel the latter is enough
        if !card.isMatched {
            ZStack{
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }


    // MARK: - Drawing Constants
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

