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
                ForEach(entry.times, id: \.departure) { (time) in
                    DepartureTimeView(time: time)
                }
                Spacer()
            }
            .background(Color(Asset.backgroundColor.color))
        }
    }
}

struct DepartureTimeView: View {
    let time: DepartureTime
    
    var body: some View {
        HStack {
            Text(time.line)
            Text(time.departure, style: .time)
                .foregroundColor(.white)
            Text(time.direction)
        }
        
    }
}

struct FavoriteWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteWidgetView(entry: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
