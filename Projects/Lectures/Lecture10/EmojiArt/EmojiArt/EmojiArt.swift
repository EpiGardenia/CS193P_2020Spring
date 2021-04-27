//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by T  on 2021-03-29.
//

import Foundation

struct EmojiArt: Codable {
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Codable {
        let text: String
        var x: Int
        var y: Int
        var size: Int
        let id: Int
        
        
        fileprivate init(text: String, x:Int,  y: Int, size: Int, id: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }


    var json: Data? {
        return try? JSONEncoder().encode(self)
    }

    init?(json: Data?) { //<--failable init
        if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!) {
            self = newEmojiArt
        } else {
            return nil
        }
    }


    init() {
        
    }
    private var uniqureEmojiId = 0
    mutating func addEmoji(text: String, x: Int, y: Int, size: Int) {
        uniqureEmojiId += 1
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqureEmojiId))
    }
}
