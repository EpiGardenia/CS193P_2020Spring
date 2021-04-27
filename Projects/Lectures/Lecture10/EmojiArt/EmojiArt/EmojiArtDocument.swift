//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by T  on 2021-03-29.
//

import SwiftUI
import Combine

//VM
class EmojiArtDocument: ObservableObject, Hashable, Identifiable {
    static func == (lhs: EmojiArtDocument, rhs: EmojiArtDocument) -> Bool {
        lhs.id == rhs.id
    }
    let id: UUID
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static let palette: String = "🐹🐰🐱🐣🦊🐮🐤🦉🦄🐙🐝"
    @Published private var emojiArt: EmojiArt

    // this will be alive as long as this viewModel alive
    private var autosaveCancellable: AnyCancellable?

    init(id: UUID? = nil) {
        self.id = id ?? UUID()
        let defaultKey = "EmojiArtDocument.\(self.id.uuidString)"
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: defaultKey)) ?? EmojiArt()
        // start to listen to emojiArt change and auto save to userdefault
        autosaveCancellable = $emojiArt.sink { emojiArt in
            print("json = \(emojiArt.json?.utf8 ?? "nil")")
            UserDefaults.standard.set(emojiArt.json, forKey: defaultKey)
        }
        fetchBackgroundImageData()
    }


    @Published private(set) var backgroundImage: UIImage?
    @Published var steadyStatePanOffset: CGSize = .zero
    @Published var steadyStateZoomScale: CGFloat = 1.0
    
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


    private var fetchImageCancellable: AnyCancellable?
    private func fetchBackgroundImageData() {
        backgroundImage = nil
        if let url = self.emojiArt.backgroundURL {
            // Cancel the outdated value, to assure the image is the last one user chosen
            fetchImageCancellable?.cancel()
            // publish content of url
            fetchImageCancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { data, urlResponse in UIImage(data: data) }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)
                // assign only work with error type Never. If not, we need replaceError
                // \EmojiArtDocument.backgroundImage on self = \.backgroundImage
                .assign(to: \.backgroundImage, on: self)
        }
    }
}


extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
