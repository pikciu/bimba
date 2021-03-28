import WidgetKit
import SwiftUI
import Intents
import Domain

struct DepartureTimeSmallView: View {
    
    let time: DepartureTime
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(time.line)
                    .font(Font(AppFont.heavy(size: .small)))
                    .foregroundColor(Color(Asset.primaryColor.color))
                Text(time.direction)
                    .font(Font(AppFont.regular(size: .small)))
                    .foregroundColor(Color(Asset.secondaryColor.color))
                    .lineLimit(1)
            }
            .padding(2)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            
            Text(time.departure, style: .time)
                .foregroundColor(Color(Asset.primaryColor.color))
                .font(Font(AppFont.titleFont))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }
        .background(Color.white)
        .cornerRadius(Constants.UI.cornerRadius)
    }
}
