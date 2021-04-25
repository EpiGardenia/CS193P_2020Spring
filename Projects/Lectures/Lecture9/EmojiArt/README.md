# Lecture 9: Data Flow


## @Published

### `sink()`
@Published can not use `didset`, but we can use `$xxx.sink()`to subscribe to the publisher xxx and handling.

There are two sink func:
1. `$emojiArt.sink(receiveValue: ((EmojiArt) -> Void)` 
2. `$emojiArt.sink(receiveCompletion: ((Subscribers.Completion<Never)->Void),
                        receiveValue: ((EmojiArt) -> Void))`

For emojiArt publisher, it will always publish and never stop, failure type: Never. They can never fail and complete.
Thus Alt 1. is enough


### `onReceive($...)`
listen to @published parameter and do handling


### dataTaskPublisher

Use this to replace DispatchQueue.global to handle data and then passing..etc
`
fetchImageCancellable = URLSession.shared.dataTaskPublisher(for: url)
                                                .map { data, urlResponse in UIImage(data: data) }
                                                .receive(on: DispatchQueue.main)
                                                .replaceError(with: nil)
                                                .assign(to: \.backgroundImage, on: self)
`

with 
` fetchImageCancellable?.cancel() `
Assure image in process is the latest one by cancel previous task before process a new url






## Add Features

### hourglass spinning when the background is loading
### Add Emoji Palette

## Problems Fixed

### Problem
Whenever changing background image, while loading, user see only whitebackground with previous emojis
#### Solution
Only show emoji when not in loading state (i.e. backgroundURL exists but not backgroundImage)


