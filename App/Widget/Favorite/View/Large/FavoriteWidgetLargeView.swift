import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteWidgetLargeView: View {
    
    let entry: FavoriteWidgetEntry
    
    var items: [Item] {
        Item.items(from: entry, count: 7)
    }
    
    var addSpacing: Bool {
        items.allSatisfy({ $0.addSpacing })
    }
    
    var minSpacerSize: CGFloat {
        if addSpacing {
            return Constants.UI.systemSpacing
        }
        return Constants.UI.systemSpacing / 2
    }
    
    var body: some View {
        VStack(spacing: Constants.UI.systemSpacing) {
            Text(entry.stopPoint.name)
                .frame(alignment: .center)
                .foregroundColor(.white)
                .font(Font(AppFont.titleFont))
            
            VStack(spacing: 0) {
                ForEach(items, id: \.self) { (item) in
                    DepartureTimeLargeView(time: item.time)
                    if item.addSpacing {
                        Spacer(minLength: minSpacerSize)
                    }
                }
            }
            
            if addSpacing {
                Spacer(minLength: 0).layoutPriority(1)
            }
        }
        .padding(Constants.UI.systemSpacing)
    }
}
