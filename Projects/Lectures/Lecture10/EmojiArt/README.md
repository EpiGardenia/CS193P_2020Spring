# Lecture 10: Navigation + TextField


## Special Note
In [Lecture10 video](https://www.youtube.com/watch?v=CKexGQuIO7E), 
The way Dr. Hegarty recommended, and worked in video was 

` 
  .navigationBarItems ( ....., 
        trailing: EditButton( )
        })
        .environment(\.EditMode, $editMode)
        )
`

Unfortunatelly in Xcode12, by using above code, all BarItems are gone, meaning we can't add new document.

I found out that with a little twist, it will work in Xcode12:

` 
    .navigationBarItems ( ....., 
        trailing: EditButton( )
            .environment(\.EditMode, $editMode)
        })
        )
`




## Contents

#### .sheet, .popover

#### TextField
`onEditingChanged` can be used to update the persistent value while TextField is updating


#### Grid enhancement
More about Constraints and Gains via Grid enhancement Dismissing modally presented Views via @Bindings Multiple MVVMs in a single application

#### Hashable and Equaltable

#### @Environment variable

#### NavigationView, NavigationLink, navigationBarTitle

#### Alert

#### EditButton, EditMode, Deleting

#### .zIndex

