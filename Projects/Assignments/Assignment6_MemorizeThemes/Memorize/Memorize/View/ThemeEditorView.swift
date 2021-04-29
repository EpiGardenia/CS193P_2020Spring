//
//  EditThemeView.swift
//  Memorize
//
//  Created by T  on 2021-04-28.
//

import SwiftUI
/* Required Task 8-10 */
struct ThemeEditorView: View {
    @Binding var chosenTheme: Theme?
    @EnvironmentObject var allThemesStore: ThemeChoicesStore
    @State private var themeId: UUID?
    @State private var theme: Theme?
    @State private var name = ""
    @State private var count = 5
    @State private var newEmojis:String = ""
    @State private var emojis = Set<String>()
    private var minPairs: Int { Theme.minPair }
    private var maxPairs: Int {
        return allThemesStore.getTheme(id: (themeId ?? chosenTheme!.id)!).maxPairs
    }
    
    private let columns = [ GridItem(.adaptive(minimum: 44)) ]
    
    var body: some View {
        NavigationView {
            /* Required Task #9*/
            Form {
                /* Required Task #10 */
                Section(header: Text("Name")) { nameView }
                
                Section(header: Text("Number of Pairs of Card")
                        , footer: Text("Range: \(minPairs) - \(maxPairs)")
                ) { numView }
                
                Section(header: Text("Add Emojis")) { addEmojiView }
                
                Section(header: removeEmojiHeader,
                        footer: Text("At Least 4 emojis")) { removeEmojiView }
            }
            .onAppear(perform: {
                            themeId = chosenTheme!.id
                            reload()
                        }
            )
            .navigationTitle("Edit Theme")
            .navigationBarItems(trailing:
                                    Button("Done") { chosenTheme = nil })
        }
    }
    
    private func update() {
        if theme!.numberOfPairsOfCards > theme!.emojis.count {
            theme!.numberOfPairsOfCards = theme!.emojis.count 
        }
        allThemesStore.update(theme: theme!)
        reload()
    }
    
    private func reload() {
        theme = allThemesStore.getTheme(id: themeId!)
        name = self.theme!.name
        count = self.theme!.numberOfPairsOfCards
        emojis = self.theme!.emojis
        newEmojis = ""
    }


    @ViewBuilder var nameView: some View {
        TextField("Theme Name", text: $name)
            .onChange(of: name, perform: { value in
                theme!.name = value
                update()
            })
    }

    @ViewBuilder var numView: some  View {
        Stepper(value: $count, in: minPairs...maxPairs,
                label: { Text("\(count) Pairs of Card") })
            .onChange(of: count, perform: { value in
                theme!.numberOfPairsOfCards = count
                update()
            })
    }


    @ViewBuilder var addEmojiView: some View {
        HStack {
            TextField("New Emojis", text: $newEmojis)
            Spacer()
            Button("Add") {
                _ = newEmojis.map{String($0)}.map{theme!.addEmoji(emoji: $0) }
                update()
            }
        }
    }


    @ViewBuilder var removeEmojiView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(allThemesStore.getTheme(id: (themeId ?? chosenTheme!.id)!).emojis.map{String($0)}, id: \.hashValue) {  emoji  in
                    Text("\(emoji) ")
                        .onTapGesture {
                            if allThemesStore.getTheme(id: themeId!).emojis.count > 4 {
                                theme!.removeEmoji(emoji: emoji)
                                update()
                            }
                        }

                } .padding(.vertical)
            }
        }
    }

    @ViewBuilder var removeEmojiHeader: some View {
        HStack {
            Text("Emojis")
            Spacer()
            Text("Tap to remove")
                .font(.caption)
        }
    }
}


//
//struct ThemeEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditorView(chosenTheme: .constant(Theme.examples.first))
//            .environmentObject(ThemeChoices)
//    }
//}

