//
//  OptionalView.swift
//  EmojiArt
//
//  Created by T  on 2021-03-30.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?

    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}

