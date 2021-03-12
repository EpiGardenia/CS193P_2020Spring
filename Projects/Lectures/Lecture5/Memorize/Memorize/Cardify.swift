//
//  Cardify.swift
//  Memorize
//
//  Created by T  on 2021-03-12.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool

    func body(content: Content) -> some View {
        ZStack{
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }

    private let cornerRadius: CGFloat = 10
    private let lineWidth: CGFloat = 3
}



extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))

    }
}
