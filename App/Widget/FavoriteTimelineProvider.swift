import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteTimelineProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> FavoriteWidgetEntry {
        .placeholder
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (FavoriteWidgetEntry) -> Void) {
        
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<FavoriteWidgetEntry>) -> Void) {
        
    }
}
