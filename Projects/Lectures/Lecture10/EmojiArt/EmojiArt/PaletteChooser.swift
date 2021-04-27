//
//  PaletteChooser.swift
//  EmojiArt
//
//  Created by T  on 2021-04-25.
//

import SwiftUI

struct PaletteChooser: View {
    @ObservedObject var document: EmojiArtDocument
    @Binding var chosenPalette: String
    @State private var showPaletteEditor = false

    var body: some View {
        HStack {
            Stepper(
                onIncrement: {
                    self.chosenPalette = self.document.palette(after: self.chosenPalette)
                },
                onDecrement: {
                    self.chosenPalette = self.document.palette(before: self.chosenPalette)
                },
                label: { EmptyView() })
            Text(self.document.paletteNames[self.chosenPalette] ?? "")
            Image(systemName: "keyboard").imageScale(.large)
                .onTapGesture {
                    showPaletteEditor = true
                }
                // if user click outside of popover, $showPaletteEditor will turn false
                .popover(isPresented: $showPaletteEditor) {
                    PaletteEditor(chosenPalette: $chosenPalette, isShowing: $showPaletteEditor)
                        .environmentObject(self.document)
                        .frame(minWidth: 300, minHeight: 500)
                }

        }
        .fixedSize(horizontal: true, vertical: false)
    }
}


struct PaletteEditor: View {
    @EnvironmentObject var document: EmojiArtDocument
    @Binding var chosenPalette: String
    @Binding var isShowing: Bool
    @State private var paletteName: String = ""
    @State private var emojisToAdd: String = ""

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Palette Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        self.isShowing = false
                    }, label: { Text("Done")}).padding()
                }
            }
            Divider()
            Form {
                TextField("Palette Name", text: $paletteName, onEditingChanged: { began in
                    if !began {
                        self.document.renamePalette(chosenPalette, to: paletteName)
                    }
                })
                TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                    if !began {
                        self.chosenPalette = document.addEmoji(emojisToAdd, toPalette: chosenPalette)
                    }
                })

                Section(header: Text("Remove Emoji")) {
                    Grid(chosenPalette.map { String($0)}, id: \.self) { emoji in
                        Text(emoji).font(Font.system(size: fontSize))
                            .onTapGesture {
                                self.chosenPalette = self.document.removeEmoji(emoji, fromPalette: chosenPalette)
                            }
                    }
                    .frame(height: self.height)
                }
            }
        }
        .onAppear {
            self.paletteName = self.document.paletteNames[chosenPalette] ?? ""
        }
    }

    // MARK: - Drawing Constants
    var height: CGFloat {
        CGFloat((chosenPalette.count - 1) / 6) * 70 + 70
    }

    let fontSize: CGFloat = 40
}


struct PaletteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser(document: EmojiArtDocument(), chosenPalette: .constant(""))
    }
}
