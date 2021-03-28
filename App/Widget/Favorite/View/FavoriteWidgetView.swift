import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteWidgetView: View {
    @Environment(\.widgetFamily) var widgetFamily
    
    let entry: FavoriteWidgetEntry
    
    @ViewBuilder
    private var widgetView: some View {
        switch widgetFamily {
        case .systemSmall:
            FavoriteWidgetSmallView(entry: entry)
        case .systemMedium:
            FavoriteWidgetMediumView(entry: entry)
        case .systemLarge:
            FavoriteWidgetLargeView(entry: entry)
        @unknown default:
            FavoriteWidgetLargeView(entry: entry)
        }
    }
    
    var body: some View {
        widgetView
            .background(Color(Asset.backgroundColor.color))
            .widgetURL(DeepLink.stop(entry.stopPoint).url)
    }
    
}
