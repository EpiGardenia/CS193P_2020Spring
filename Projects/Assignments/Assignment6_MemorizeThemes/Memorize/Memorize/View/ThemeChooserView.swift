//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by T  on 2021-04-28.
//

import SwiftUI

struct ThemeChooserView: View {
    @EnvironmentObject var themeChoices: ThemeChoicesStore
    @State private var editMode: EditMode = EditMode.inactive
    @State private var showEditView = false
    @State private var chosenTheme: Theme?

    
    var body: some View {
        NavigationView {
            /* Required Task #2 */
            List {
                ForEach(themeChoices.getAllthemes()) { theme in
                    /* Required Task #4 */
                    HStack {
                        if editMode.isEditing { editButton(theme)}
                        NavigationLink(destination: EmojiMemoryGameView(theme: theme)) {
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
            .sheet(item: $chosenTheme) { _ in
                ThemeEditorView(chosenTheme: $chosenTheme)
                    .environmentObject(themeChoices)
            }
            .navigationTitle("Theme Chooser")
            .toolbar {
                addThemeToolbar
                editToolbar
            }
            .environment(\.editMode, $editMode)
            WelcomeView
        }
    }


    private var addThemeToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {themeChoices.addTheme()}, label: {
                Image(systemName: "plus")
            })
        }
    }

    private var editToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            EditButton()
        }
    }

    @ViewBuilder var WelcomeView: some View {
        VStack {
            Text("Emoji Theme Memory Game")
                .font(.title)
            Text("Please choose a theme to the left to start")
        }
    }

    @ViewBuilder func editButton(_ theme: Theme) -> some View {
        Image(systemName: "pencil.circle")
            .foregroundColor(Color(theme.color))
            .onTapGesture {
                showEditView = true
                chosenTheme = theme
            }
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView()
            .environmentObject(ThemeChoicesStore())
        
    }
}
