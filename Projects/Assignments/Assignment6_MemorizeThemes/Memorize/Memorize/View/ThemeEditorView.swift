//
//  EditThemeView.swift
//  Memorize
//
//  Created by T  on 2021-04-28.
//

import SwiftUI
/* Required Task 8-10 */
struct ThemeEditorView: View {
    var themeId: UUID
    @State private var theme: Theme?
    @EnvironmentObject var allThemes: ThemeChoices
    @Binding var chosenTheme: Theme?
    @State private var name = ""
    @State private var count = 5
    private let minPairs = 4
    private var maxPairs: Int {
        theme?.emojis.count ?? 10
    }
    var body: some View {
        NavigationView {
            /* Required Task #9*/
            Form {
                /* Required Task #10 */
                Section(header: Text("Name")) {
                    TextField("Theme Name", text: $name)
                        .onChange(of: name, perform: { value in
                            theme!.name = value
                            update()
                        })
                }

                Section(header: Text("Number of Pairs of Card")
                        , footer: Text("Range: \(minPairs) - \(maxPairs)")
                ){
                    Stepper(value: $count, in: minPairs...maxPairs,
                            label: { Text("\(count) Pairs ") })
                        .onChange(of: count, perform: { value in
                            theme!.numberOfPairsOfCards = count
                            update()
                        })
                }

                //            Section(header: Text("Add Emojis")) {
                //                TextField()
                //
                //            }
                //
                //            Section(header: Text("Remove Emojis")) {
                //
                //            }

            }
            .onAppear {
                print("\(themeId)")
                self.theme = allThemes.findTheme(id: themeId)!
                name = self.theme!.name
                count = self.theme!.numberOfPairsOfCards
            }
            .navigationTitle("Edit Theme")
            .navigationBarItems(trailing:
                                    Button("Done") {
                                        chosenTheme = nil
                                    })
        }
    }

    private func update() {
        allThemes.update(theme: theme!)
    }
}

//struct EditThemeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditorView(theme: Theme.themes.last!, isShowing: .constant(true))
//    }
//}

