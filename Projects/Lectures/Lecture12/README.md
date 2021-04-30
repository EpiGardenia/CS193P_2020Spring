# Lecture 12: Core Data


### Fetch core data inside viewmodel
    `
    extension Airport: Identifiable, Comparable {
            ... func() ... {
            let request = fetchRequest(NSPredicate(format: "icao_ = %@", icao))
            let airports = (try? context.fetch(request)) ?? []
            ...
    }`


with `NSFetchRequest`  and  `context.fetch()`

    `static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Airport> {
        let request = NSFetchRequest<Airport>(entityName: "Airport")
        request.sortDescriptors = [NSSortDescriptor(key: "location", ascending: true)]
        request.predicate = predicate
        return request
    }
    `


###  Update View with data change : `objectWillChange.send()`

`airport.objectWillChange.send()`  will fire all views containing `Airport` to be refreshed



### Make Relationship NSSet to be Set
    ` var flightsTo: Set<Flight> {
        get { (flightsTo_ as? Set<Flight>) ?? [] }
        set { flightsTo_ = newValue as NSSet }
    }
    `

### Get `managedObjectContext` directly from Entity 

There is no need to pass context as argument into `fetchIncomingFlights()`

`managedObjectContext`  is an instance method of Airport,
All objects come out of Core Data (Airport, Airline...), they knows the context they come out of.
    `extension Airport {
        func fetchIncomingFlights() {
            Self.flightAwareRequest?.stopFetching()
            if let context = managedObjectContext {
                .....
                }
                ...
    }`



### sheet()
It is important to pass context into` sheet()` via `.environment` :
        `
        .sheet(isPresented: $showFilter) {
            FilterFlights(flightSearch: self.$flightSearch, isPresented: self.$showFilter)
            .environment(\.managedObjectContext, self.context)
        }
        `
    




## Design Choices

### add _ in `.xcdatamodeld` for those parameters "Couldn't be nil"
For example, icao could never be nil, so use name of `icao_` in `.xcdatamodeld` and
declare new parameter icao in extension
Save us from dealing with optional everywhere.

    `
    extension Airport: .... {
        var icao: String {
            get { icao_! }
            set { icao_ = newValue }
        }
    }
    `



