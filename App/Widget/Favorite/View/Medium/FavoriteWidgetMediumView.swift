import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteWidgetMediumView: View {
    
    let entry: FavoriteWidgetEntry
    
    var items: [Item] {
        Item.items(from: entry, count: 3)
    }
    
    var spacing: CGFloat {
        Constants.UI.systemSpacing
    }
    
    var smallSpacing: CGFloat {
        spacing / 2
    }
    
    var addSpacing: Bool {
        items.allSatisfy({ $0.addSpacing })
    }
    
    var minSpacerSize: CGFloat {
        if addSpacing {
            return spacing
        }
        return smallSpacing
    }
    
    var body: some View {
        VStack(spacing: smallSpacing) {
            Text(entry.stopPoint.name)
                .frame(alignment: .center)
                .foregroundColor(.white)
                .font(Font(AppFont.regular(size: .small)))
            
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
        .padding(EdgeInsets(
            top: smallSpacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing
        ))
    }
}
