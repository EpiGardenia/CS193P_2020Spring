//
//  ContentView.swift
//  EmojiArt
//
//  Created by T  on 2021-03-29.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(EmojiArtDocument.palette.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .font(Font.system(size: defaultEmojiSize))
                        .onDrag { NSItemProvider(object: emoji as NSString)}
                }
            }
        }
        .padding(.horizontal)

        GeometryReader { geometry in
            ZStack {
                Color.white.overlay(
                    OptionalImage(uiImage: self.document.backgroundImage)
                        .scaleEffect(self.zoomScale)
                )
                .gesture(self.doubleTapToZoom(in: geometry.size))

                if self.isLoading {
                    Image(systemName: "hourglass").imageScale(.large).spinning()
                } else {
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .font(animatableWithSize: emoji.fontSize * steadyStateZoomScale)
                            .position(self.position(for: emoji, in: geometry.size))
                    }
                }
            }
            .clipped()
            .gesture(zoomGesture())
            .edgesIgnoringSafeArea([.horizontal, .bottom])
            .onDrop(of: ["public.image","public.text"], isTargeted: nil) { providers, location in
                //print("location: (\(location.x), \(location.y))")
                var location = geometry.convert(location, from: .global)
                // print("location(global): (\(location.x), \(location.y))")
                location = CGPoint(x: location.x - geometry.size.width/2, y: location.y - geometry.size.height/2)
                location = CGPoint(x: location.x / self.steadyStateZoomScale, y: location.y / self.steadyStateZoomScale)
                //  print("location(convert): (\(location.x), \(location.y))")
                return self.drop(providers: providers, at: location)
            }
        }



    }

    var isLoading: Bool {
        document.backgroundURL != nil && document.backgroundImage == nil
    }




    @State private var steadyStateZoomScale: CGFloat = 1.0
    @GestureState private var gestureZoomScale: CGFloat = 1.0

    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }

    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, transaction in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { finalGestureScale in
                steadyStateZoomScale *= finalGestureScale
            }
    }

    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation (.linear(duration: 4)){
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }

    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            steadyStateZoomScale = min(hZoom, vZoom)
        }
    }

    private func font(for emoji: EmojiArt.Emoji) -> Font {
        Font.system(size: emoji.fontSize * steadyStateZoomScale)
    }

    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        var location = emoji.location
        location = CGPoint(x: location.x / self.steadyStateZoomScale, y: location.y / self.steadyStateZoomScale)
        location = CGPoint(x: location.x + size.width/2, y: location.y + size.height/2)

        return location
    }


    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            print("dropped \(url)")
            self.document.backgroundURL = url
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.addEmoji(string, at: location, size:  defaultEmojiSize)

            }
        }
        return found
    }


    private let defaultEmojiSize: CGFloat = 40
}






//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiArtDocumentView()
//    }
//}
