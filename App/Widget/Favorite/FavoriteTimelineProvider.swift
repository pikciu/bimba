import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteTimelineProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> FavoriteWidgetEntry {
        .placeholder
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (FavoriteWidgetEntry) -> Void) {
        guard
            let favorite = configuration.favorite,
            context.isPreview == false
        else {
            completion(.placeholder)
            return
        }
        let stopPoint = StopPoint(favorite: favorite)
        _ = GetDepartureTime(stopPointID: stopPoint.id)
            .execute()
            .subscribe(onSuccess: { (times) in
                let entry = FavoriteWidgetEntry(
                    date: Date(),
                    stopPoint: stopPoint,
                    times: times
                )
                completion(entry)
            })
        
        
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<FavoriteWidgetEntry>) -> Void) {
        getSnapshot(for: configuration, in: context) { (entry) in
            let now = Date().date(withComponents: [.year, .month, .day, .hour, .minute])
            let updateTime = now.byAdding(value: 5, component: .minute)
            guard let last = entry.times.last else {
                completion(Timeline(entries: [entry], policy: .after(updateTime)))
                return
            }
            let diffSeconds = last.departure.timeIntervalSinceNow
            let diffMinutes = Int(diffSeconds / 60)
            let minutesRange = 0..<diffMinutes
            let entries = minutesRange.map({ (offset) -> FavoriteWidgetEntry in
                let time = now.byAdding(value: offset, component: .minute)
                return FavoriteWidgetEntry(
                    date: time,
                    stopPoint: entry.stopPoint,
                    times: entry.times.filter({ $0.departure >= time })
                )
            })
            
            completion(Timeline(entries: entries, policy: .after(updateTime)))
        }
    }
}

extension StopPoint {
    init(favorite: FavoriteStopPoint) {
        self.init(id: favorite.identifier ?? "", name: favorite.displayString)
    }
}
