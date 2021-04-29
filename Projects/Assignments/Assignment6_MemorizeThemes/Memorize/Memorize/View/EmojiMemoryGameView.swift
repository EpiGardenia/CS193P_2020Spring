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
    let theme: Theme

    init(theme: Theme) {
        self.theme = theme
        viewModel = EmojiMemoryGame(theme: theme)
    }


    var body: some View {
        let color = viewModel.theme.color
        VStack {
            Spacer()
            Text(viewModel.theme.name)
                .font(.title)
            Text("\(viewModel.point)")
                .font(.headline)
            Divider()
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            Divider()
            Button(action: { viewModel.start() }) {
                Text("New Game".uppercased())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
            }
        } .foregroundColor(Color(color))

    }
}


//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame.init())
//    }
//}

