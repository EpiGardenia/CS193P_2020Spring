# Lecture 11: Enroute

##  Hightlights:


### @Binding <---> @State
#### Correct
```swift   
    @Binding var flightSearch: FlightSearch
    @State private var draft: FlightSearch

    init(flightSearch: Binding<FlightSearch>) {
    _flightSearch = flightSearch
    _draft = State(wrappedValue: flightSearch.wrappedValue)
    }
```
#### InCorrect


`self.draft = flightSearch`
 Error => " Cannot assigne value of type 'Binding<FlightSearch>' to type 'FlightSearch' "
`draft` is a wrappedValue of 

```swift  
    @State private var draft: FlightSearch
```


```swift
_draft = State(wrappedValue: flightSearch)
```
Binding's wrappedValue is the value it is bond to.
_draft is the value @State binding to.


### Optional String
```swift   
    Picker("Origin", selection: $draft.origin) {
    Text("Any").tag(String?.none)
    ForEach(allAirports.codes, id: \.self) { (airport: String?) in
    Text("\(self.allAirports[airport]?.friendlyName ?? airport ?? "Any")").tag(airport)
    }
    }
```

`tag(String?.none)` is the way to define tag for nil



## Other Contents

Picker
