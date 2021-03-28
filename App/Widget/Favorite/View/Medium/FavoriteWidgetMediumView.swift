import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteWidgetMediumView: View {
    
    let entry: FavoriteWidgetEntry
    
    var body: some View {
        GeometryReader { (geometry) in
            VStack(alignment: .leading, spacing: 0) {
                Text(entry.stopPoint.name)
                    .frame(width: geometry.size.width, alignment: .center)
                    .foregroundColor(.white)
                    .padding(.vertical, Constants.UI.systemSpacing / 2)
                    .font(Font(AppFont.regular(size: .small)))
                
                if entry.times.count > 3 {
                    HStack(spacing: Constants.UI.systemSpacing) {
                        VStack(spacing: Constants.UI.defaultSpacing / 2) {
                            ForEach(entry.times.prefix(3), id: \.self) { (time) in
                                DepartureTimeSmallView(time: time)
                            }
                            Spacer()
                        }
                        VStack(spacing: Constants.UI.defaultSpacing / 2) {
                            ForEach(entry.times.suffix(from: 3).prefix(3), id: \.self) { (time) in
                                DepartureTimeSmallView(time: time)
                            }
                            Spacer()
                        }
                    }
                    .padding(.horizontal, Constants.UI.defaultSpacing / 2)
                } else {
                    ForEach(entry.times.prefix(3), id: \.self) { (time) in
                        DepartureTimeLargeView(time: time)
                    }
                }
                
                
                Spacer()
            }
        }
    }
}
