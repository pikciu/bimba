import WidgetKit
import SwiftUI
import Intents

struct FavoriteWidget: Widget {
    
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: String(describing: FavoriteWidget.self),
            intent: ConfigurationIntent.self,
            provider: FavoriteTimelineProvider()
        ) { (entry) in
            FavoriteWidgetView(entry: entry)
        }
        .configurationDisplayName(L10n.favoriteStop)
        .description(L10n.favoriteStopDescription)
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
