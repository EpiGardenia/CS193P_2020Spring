//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by T  on 2021-03-29.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDocument())
        }
    }
}
