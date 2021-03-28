import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteWidgetLargeView: View {
    
    let entry: FavoriteWidgetEntry
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack(alignment: .leading, spacing: 0) {
                Text(entry.stopPoint.name)
                    .frame(width: geometry.size.width, alignment: .center)
                    .foregroundColor(.white)
                    .padding([.top, .bottom], Constants.UI.systemSpacing)
                    .font(Font(AppFont.titleFont))
                
                ForEach(entry.times.prefix(7), id: \.self) { (time) in
                    DepartureTimeLargeView(time: time)
                }
                Spacer()
            }
        }
    }
}
