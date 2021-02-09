import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteWidgetView: View {
    let entry: FavoriteWidgetEntry
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.stopPoint.name)
                    .frame(width: geometry.size.width, alignment: .center)
                    .foregroundColor(.white)
                ForEach(entry.times, id: \.self) { (time) in
                    DepartureTimeView(time: time)
                }
                Spacer()
            }
            .background(Color(Asset.backgroundColor.color))
        }
        .widgetURL(DeepLink.stop(entry.stopPoint).url)
    }
}

struct FavoriteWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteWidgetView(entry: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
