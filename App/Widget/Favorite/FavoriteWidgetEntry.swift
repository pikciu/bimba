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
            stopPoint: StopPoint(id: "", name: L10n.editToSelectStop),
            times: DepartureTimeFactory.create(count: 7)
        )
    }
}
