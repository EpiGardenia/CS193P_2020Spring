//
//  SetGameView.swift
//  SetGame
//
//  Created by T  on 2021-03-14.
//

import SwiftUI

struct SetGameView: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @ObservedObject var viewModel: SetGameViewModel
    init() {
        viewModel = SetGameViewModel()
    }
    var body: some View {
        GeometryReader { geometry in
            body(size: geometry.size)
        }
    }
    private func body(size: CGSize) -> some View {
        VStack(alignment: .center) {
            Grid(viewModel.cardsOnTable) { card in
                CardView(of: card)
                    .padding(3)
                    .onTapGesture {
                        viewModel.select(card: card)
                    }
            }
            .foregroundColor(.orange)
            .onAppear {
                viewModel.getInitialCardsOnTable()
            }

            HStack {
                Button(action:{viewModel.startNewGame()}) {
                    roundFontRectButton(text: "New Game", size: size)
                }
                ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.orange)
                    .frame(width: size.width*0.3)
                    Text("Score: \(viewModel.score)")
                }
                Button(action: { viewModel.dealThreeCards() }) {
                    roundFontRectButton(text: "Deal Three Cards", size: size)
                }.disabled(viewModel.cardsInDeck.count == 0)
            }
            .frame(height: size.height*0.2)
            .padding(.bottom)
        }
    }
}

@ViewBuilder
func roundFontRectButton(text: String, size: CGSize) -> some View {
    Text(text)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .frame(width: size.width*0.3)
        .font(.system(size: min(size.width, size.height)*0.33*0.15))
}


struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
