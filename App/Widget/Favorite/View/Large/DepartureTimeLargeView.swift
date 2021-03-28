import WidgetKit
import SwiftUI
import Intents
import Domain

struct DepartureTimeLargeView: View {
    
    let time: DepartureTime
    
    var body: some View {
        HStack(spacing: 0) {
            Text(time.line)
                .font(Font(AppFont.heavy(size: 30)))
                .foregroundColor(Color(Asset.primaryColor.color))
                .frame(width: 74, alignment: .center)
            Text(time.direction)
                .foregroundColor(Color(Asset.secondaryColor.color))
                .font(Font(AppFont.titleFont))
                .lineLimit(2)
            Spacer()
            Text(time.departure, style: .time)
                .foregroundColor(Color(Asset.primaryColor.color))
                .padding([.trailing], Constants.UI.systemSpacing)
                .font(Font(AppFont.titleFont))
        }
        .background(Color.white)
        .cornerRadius(Constants.UI.cornerRadius)
        .padding([.leading, .trailing, .bottom], Constants.UI.systemSpacing)
        
    }
}
