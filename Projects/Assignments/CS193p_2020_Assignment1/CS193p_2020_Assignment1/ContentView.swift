//
//  ContentView.swift
//  CS193p_2020_Assignment1
//
//  Created by T  on 2021-03-10.
//

//Required Task #6 is automatically done

import SwiftUI

struct ContentView: View {
    private var viewModel = EmojiMemoryGame()  //To adapt Xcode12

    var body: some View {
        HStack{
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        viewModel.choose(card: card)
                    }
                    .aspectRatio(2/3, contentMode: .fit) //Required Task #3
            }
        }
        .padding()
        .foregroundColor(.orange)
        .font(viewModel.cards.count > 8 ? .headline: .largeTitle) //Required Task #5

    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        ZStack{
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
