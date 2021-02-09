import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteWidgetView: View {
    @Environment(\.widgetFamily) var widgetFamily
    
    let entry: FavoriteWidgetEntry
    
    var elementsCount: Int {
        switch widgetFamily {
        case .systemSmall, .systemMedium:
            return 2
        case .systemLarge:
            return 6
        @unknown default:
            return 6
        }
    }
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.stopPoint.name)
                    .frame(width: geometry.size.width, alignment: .center)
                    .foregroundColor(.white)
                    .padding([.top, .bottom], Constants.UI.systemSpacing)
                    .font(Font(AppFont.titleFont))
                ForEach(entry.times.prefix(elementsCount), id: \.self) { (time) in
                    if case .systemSmall = widgetFamily {
                        DepartureTimeSmallView(time: time)
                    } else {
                        DepartureTimeView(time: time)
                    }
                }
                Spacer()
            }
            .background(Color(Asset.backgroundColor.color))
        }
        .widgetURL(DeepLink.stop(entry.stopPoint).url)
    }
}
