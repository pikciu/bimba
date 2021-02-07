import WidgetKit
import SwiftUI
import Intents

@main
struct Widgets: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        FavoriteWidget()
    }
}
