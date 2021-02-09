import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteWidgetEntry: TimelineEntry {
    let date: Date
    let stopPoint: StopPoint
    let times: [DepartureTime]
    
    static var placeholder: FavoriteWidgetEntry {
        FavoriteWidgetEntry(
            date: Date(),
            stopPoint: StopPoint(id: "", name: "Ratajczaka"),
            times: [
                DepartureTime(
                    departure: Date().byAdding(value: 2, component: .minute),
                    direction: "Franowo",
                    line: "16",
                    minutesToDeparture: 2,
                    isOnStopPoint: false,
                    isRealTime: true
                )
            ]
        )
    }
}
