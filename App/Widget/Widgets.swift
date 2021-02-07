import WidgetKit
import SwiftUI
import Intents
import Domain
import Data

@main
struct Widgets: WidgetBundle {
    
    init() {
        Container.register(modules: DataModule.self)
    }
    
    @WidgetBundleBuilder
    var body: some Widget {
        FavoriteWidget()
    }
}
