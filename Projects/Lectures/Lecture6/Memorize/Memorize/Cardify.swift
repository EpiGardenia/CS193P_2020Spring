//
//  Cardify.swift
//  Memorize
//
//  Created by T  on 2021-03-12.
//

import SwiftUI

// : AnimatableModifier => signal system : I am modifier want to participate in animation
// instead of using : Animatable, viewModifier
struct Cardify: AnimatableModifier {
    var rotation: Double

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    var isFaceUp: Bool {
        rotation < 90
    }

    // computed property
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }

    func body(content: Content) -> some View {
        ZStack{
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)

            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
    }

    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
}



extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))

    }
}
