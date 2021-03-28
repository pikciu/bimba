import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteWidgetSmallView: View {
    
    let entry: FavoriteWidgetEntry
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack(alignment: .leading, spacing: 0) {
                Text(entry.stopPoint.name)
                    .frame(width: geometry.size.width, alignment: .center)
                    .foregroundColor(.white)
                    .font(Font(AppFont.regular(size: .small)))
                    .padding(.vertical, Constants.UI.systemSpacing / 2)
                ForEach(entry.times.prefix(3), id: \.self) { (time) in
                    DepartureTimeSmallView(time: time)
                        .padding([.leading, .trailing, .bottom], Constants.UI.defaultSpacing / 2)
                }
                Spacer()
            }
        }
    }
}
