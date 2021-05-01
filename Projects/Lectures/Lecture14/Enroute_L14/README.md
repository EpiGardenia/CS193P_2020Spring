# Lecture 14: UIKit Integration


## Basic Structure


    `struct MapView: UIViewRepresentable {
        func makeUIView(context: Context) -> MKMapView {
            let mkMapView = MKMapView()
            mkMapView.delegate = context.coordinator
            return mkMapView
        }

        func updateUIView(_ uiView: MKMapView, context: Context) {
        }

        func makeCoordinator() -> Coordinator {
            return Coordinator()
        }

        class Coordinator: NSObject, MKMapViewDelegate {
        }
    } `



`context.coordinator` is generated from `makeCoordinator()`



## Annotation

Make the entity of annotation conform `MKAnnotation` protocol, and implement `coordinate` function

    `extension Airport: MKAnnotation {
        func coordinator ...
    }`


## @Binding, @State, @ObservedObject

###  Destination Airport  in Text -> Map annotation

To update center annotation in map, we can pass in
    `
    @State private var draft: FlightSearch
    MapView(annotations: airports.sorted(), selection: draft.destination)`

while 
    `
    struct MapView: UIViewRepresentable {
        let annotations: [MKAnnotation]
        var selection: MKAnnotation?
        ...
    `


### Choose Annotation in Map -> Change Destination Airport in Text

Change to Binding:  ` @Binding var selection: MKAnnotation?`

How about the data input  `MapView(... , selction: draft.destination)` ?

If draft is `@ObservedObject`, change it to `$draft.destination` would work.
But draft is `@State`, the binding of State binds to the entire struct (FlightSearch), can't bind to a variable under the struct

The solution is to use `.., selection: destination`:

    ` 
    var destination: Binding<MKAnnotation?> {
        return Binding<MKAnnotation?>(
            get: { return self.draft.destination },
            set: { annotation in
            if let airport = annotation as? Airport {
            self.draft.destination = airport
            }
        }
    )
    }
    `
