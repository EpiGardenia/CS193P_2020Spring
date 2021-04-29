//
//  ThemeRowView.swift
//  Memorize
//
//  Created by T  on 2021-04-28.
//

import SwiftUI

/* Required Task #3 */
struct ThemeRowView: View {
    @ObservedObject var themeChoices: ThemeChoicesStore
    var theme: Theme
    private let maxEmoji = 8
    @State private var showEditView = false
    var body: some View {
        HStack {
            VStack {
                Text("\(theme.numberOfPairsOfCards)")
                    .font(.title)
                Text("Pairs")
                    .font(.body)
            }

            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Text(theme.name)
                        .font(.title3)
                        .foregroundColor(Color(theme.color))
                    Text(theme.emojis.joined().takeFirst(k: maxEmoji))
                        .lineLimit(1)
                }
            }
        }
    }
}

//struct ThemeRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeRowView(theme: Theme.themes[0])
//            .frame(height: 50)
//
//        ThemeRowView(theme: Theme.themes[0])
//            .frame(height: 50)
//    }
//}



