import WidgetKit
import SwiftUI
import Intents
import Domain

struct FavoriteWidgetSmallView: View {
    
    let entry: FavoriteWidgetEntry
    
    var items: [Item] {
        Item.items(from: entry, count: 3)
    }
    
    var spacing: CGFloat {
        Constants.UI.defaultSpacing / 2
    }
    
    var smallSpacing: CGFloat {
        Constants.UI.systemSpacing / 2
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
                .lineLimit(1)
                .font(Font(AppFont.regular(size: .small)))
            
            VStack(spacing: 0) {
                ForEach(items, id: \.self) { (item) in
                    DepartureTimeSmallView(time: item.time)
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
            bottom: 10,
            trailing: spacing
        ))
    }
}
