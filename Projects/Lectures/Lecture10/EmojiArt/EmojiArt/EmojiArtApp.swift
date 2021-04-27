//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by T  on 2021-03-29.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let store = EmojiArtDocumentStore(named: "Emoji Art")

    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentChooser().environmentObject(store)
          // EmojiArtDocumentView(document: EmojiArtDocument())
        }
    }
}
