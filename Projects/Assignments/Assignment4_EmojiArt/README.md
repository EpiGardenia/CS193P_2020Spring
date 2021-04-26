# Assignment 4 Emoji Art

## Required Task 1
Download Lecture 8 from website and start from it.

## Required Task 2-5  -- Tap
### Requirement
2. Support the selection of  one or more of  the emojis which have been dragged into your EmojiArt document (i.e. you’re selecting the emojis in the document, not the ones in the palette at the top).  You can show which emojis are selected in any way you’d like.  The selection is not persistent (in other words, restarting your app will not preserve the selection). 
3. Tapping on an unselected emoji should select it. 
4. Tapping on a selected emoji should unselect it. 
5. Single-tapping on the background of  your EmojiArt (i.e. single-tapping anywhere except on an emoji) should deselect all emoji.

### Solution
When selected, show a green square around the emoji.

Add 
`selectedEmojis` , 
`func tapOn(emoji: EmojiArt.Emoji)`, 
`func clearSelectedEmojis()` , 
`func borderColor(_ emoji: EmojiArt.Emoji) -> Color`
in ViewModel ( EmojiArtDocument.swift )

Called in View ( EmojiArtDocumentView.swift )


## Required Task 6-7 -- Drag

### Requirement
6. Dragging a selected emoji should move the entire selection to follow the user’s finger. 
7. If  the user makes a dragging gesture when there is no selection, pan the entire document. 

### Solution
Add `dragGesture` 
Add the value into emoji position


## Required Task 8-9 -- Pinching

### Requirement
8. If the user makes a pinching gesture anywhere in the EmojiArt document and there is a selection, 
    all of  the emojis in the selection should be scaled by the amount of  the pinch. 
9. If there is no selection at the time of  a pinch, the entire document should be scaled. 

### Solution
Add new updating/ended to listen in zoomGesture, depending on if selectedEmoji array is empty


## Required Task 10 -- Delete
### Requirement

10.Make it possible to delete emojis from the EmojiArt document.  This Required Task is intentionally not saying what user-interface actions should cause this.  Be creative and try to find a way to delete the emojis that feels comfortable and intuitive. 

### Solution
