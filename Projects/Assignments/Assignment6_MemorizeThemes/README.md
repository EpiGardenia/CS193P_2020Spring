# Assignment 6: Memorize Themes

https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_6.pdf

## Demo
![Demo](Demo/Assignment6.gif)

### IPhone
<img src="Demo/ThemeChooser_iphone.png" >
<img src="Demo/ThemeChooser_Edit_iphone.png" >
<img src="Demo/ThemeEditor_iphone.png" >

### iPad
<img src="Demo/ThemeChooser_IPad.png" >
<img src="Demo/ThemeChooser_Edit_IPad.png" >
<img src="Demo/ThemeEditor_IPad.png" >
<img src="Demo/GameView_IPad.png" >



## Design
### ThemeChoiceStore   ( ViewModel )
Store `@Published allThemes: [Theme]` in UserDefaults.
Create `autoSave:AnyCancellable` to subscribe to  `allTemes`  and store json in UserDefaults 

`autoSave = $allThemes.sink { themes in
    UserDefaults.standard.set(ThemeChoicesStore.encode(themes), forKey: self.themesKey)
}`

### ThemeChooserView 
View loads data from `ThemeChoiceStore` in ForEach
Each theme is passing  to `ThemeRowView`
With `+` and `EditButton`  on toolbar, user can "Add Theme", "Edit Theme", "Remove Theme"
Above three actions are executed in ViewModel (ThemeChoiceStore)
The view is automatically refreshed.

Sheet of  `ThemeEditorView` is declared here.  
Due to there can only be one Sheet per view, adding inside ForEach causing problem.
`theme` inside ForEach can not be passed to Sheet() either.
Thus, another type of sheet is chosen, to be able to pass the theme of chosen.

`.sheet(item: $chosenTheme) { _ in
    ThemeEditorView(chosenTheme: $chosenTheme)
    .environmentObject(themeChoices)
}`


### ThemeRowView
The row in List View, providing UI for Theme name, pairs of cards, and emojis
Create an edit icon to enable sheet of  `ThemeEditorView` pop out.



### ThemeEditorView
ThemeEditorView receives `$chosenTheme` as input, and   `@EnvironmentObject var allThemesStore: ThemeChoicesStore`
Parameters of live editing are caught by `@State private var`, 
viewModel is updated whenever user change values.

When User Add or Remove Emoji, the max limit of pairsOfCard stepper will update accordingly.



## Required Tasks

1. Your Memorize application should now show a “theme chooser” UI when it launches.  See attached images for examples, but you can be creative with how you show each theme. 

2. Use a List to display the themes.

3. Each row in the List shows the name of  the theme, the color of  the theme, how many cards in the theme and some sampling of  the emoji in the theme.

4. Touching on a theme in the List navigates (i.e. the List is in a NavigationView) to playing a game with that theme. 

5. While playing a game, the name of  the theme should be on screen somewhere and you should also continue to support existing functionality like score, new game, etc. (but you may rearrange the UI if  you wish). 

6. It is okay if  going from playing a game back to the chooser and then back to the game in progress restarts the game, though savvy implementations would probably not do that (except when the theme in question is modified (see below) since that would almost certainly want to restart the game). 

7. Provide some UI to add a new theme to the List in your chooser. 

8. The chooser must support an Edit Mode where you can delete themes and where you can access some UI (i.e. a button or image in each row) which will bring up a Theme Editor UI for that theme modally (i.e. via sheet or popover). 

### Solution
Due to it is only allowed one sheet/popover over one view, this popover need to be outside of foreach and also passing "selectedTheme" instead of "$showingThemeEditor", so it passes theme info correctly.


9. The Theme Editor must use a Form. 

10. In the Theme Editor, allow the user to edit the name of  the theme, to add emoji to the theme, to remove emoji from the theme and to specify how many cards are in the theme.  (It is Extra Credit to be able to edit the color of  the theme.) 

11. The themes must be persistent (i.e. relaunching your app should not cause all the theme editing you’ve done to be lost). 

12. Your UI should work and look nice on both iPhone and iPad. 

13. Get your application work on a physical iOS device of  your choice.
