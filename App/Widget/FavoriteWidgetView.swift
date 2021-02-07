import WidgetKit
import SwiftUI
import Intents

struct FavoriteWidgetView: View {
    let entry: FavoriteWidgetEntry
    
    var body: some View {
        Text(entry.stopPoint.name)
    }
}

struct FavoriteWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteWidgetView(entry: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
