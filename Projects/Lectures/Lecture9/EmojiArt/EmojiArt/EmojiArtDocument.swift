//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by T  on 2021-03-29.
//

import SwiftUI

//VM
class EmojiArtDocument: ObservableObject {
    static let palette: String = "🐹🐰🐱🐣🦊🐮🐤🦉🦄🐙🐝"

    //@Published => workaaround for property observer problem with property wrapper
    private var emojiArt: EmojiArt = EmojiArt() {  //Model
        willSet {
            objectWillChange.send()
        }
        didSet {
            UserDefaults.standard.set(emojiArt.json, forKey: EmojiArtDocument.untitled)
            print("json = \(emojiArt.json?.utf8 ?? "nil")")
        }

    }

    private static let untitled = "EmojiArtDocument.Untitled"

    init() {
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocument.untitled)) ?? EmojiArt()
        fetchBackgroundImageData()
    }


    @Published private(set) var backgroundImage: UIImage?
    
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis }
    // MARK: - Intent(s)
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(text: emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }

    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }

    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }

    var backgroundURL: URL? {
        get {
            emojiArt.backgroundURL
        }
        set {
            emojiArt.backgroundURL = newValue?.imageURL
            fetchBackgroundImageData()
        }
    }



    private func fetchBackgroundImageData() {
        backgroundImage = nil
        if let url = self.emojiArt.backgroundURL {
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url) {  // <--- Data(..) can take few seconds to few minutes
                    DispatchQueue.main.async {
                        if url == self.emojiArt.backgroundURL {  // **** check it's the image the user still want
                            self.backgroundImage = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }

}



extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
