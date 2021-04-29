//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by T  on 2021-04-28.
//

import SwiftUI

struct ThemeChooserView: View {
    @State private var editMode: EditMode = EditMode.inactive
    @EnvironmentObject var themeChoices: ThemeChoices
    @State private var showEditView = false
    @State private var chosenTheme: Theme?
    @ViewBuilder private func validView(_ theme: Theme) -> some View {
        if theme.emojis.isEmpty {
            Text("Please add some emoji before starting play")
        } else {
            EmojiMemoryGameView(theme: theme)
        }
    }
    
    var body: some View {
        NavigationView {
            /* Required Task #2 */
            List {
                ForEach(themeChoices.getAllthemes()) { theme in
                    /* Required Task #4 */
                    HStack{
                        if editMode.isEditing {
                            Image(systemName: "pencil.circle")
                                .foregroundColor(Color(theme.color))
                                .onTapGesture {
                                    showEditView = true
                                    chosenTheme = theme
                                    print("chosenTheme: \(chosenTheme!.name)")
                                }
                            
                        }
                        NavigationLink(destination: validView(theme)) {
                            ThemeRowView(themeChoices: themeChoices, theme: theme)
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { themeChoices.getAllthemes()[$0] }.forEach { theme in
                        themeChoices.removeTheme(theme: theme)
                    }
                }
                
            }
            /* Important to use chosenTheme because popover doesn't inherit value theme */
            .sheet(item: $chosenTheme) {
                
                Text("\($0.name)")
                ThemeEditorView(themeId: $0.id, chosenTheme: $chosenTheme)
                    .environmentObject(themeChoices)
                //}
            }
            .navigationTitle("Theme Chooser")
            .navigationBarItems(leading:
                                    Button(action: {themeChoices.addTheme()}, label: {
                                        Image(systemName: "plus")
                                    })
                                , trailing:
                                    EditButton()
                                
            )
            .environment(\.editMode, $editMode)
            
        }
        
    }
}

//struct ThemeChooserView_Previews: PreviewProvider {
//    static var previews: some View {
//        //ThemeChooserView(themes: Theme.themes)
//    }
//}
