//
//  MemorizeApp.swift
//  Memorize
//
//  Created by T  on 2021-03-11.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame.init())  //To adapt Xcode12
        }
    }
}
