import WidgetKit
import SwiftUI
import Intents
import Domain

struct DepartureTimeSmallView: View {
    
    let time: DepartureTime
    
    var body: some View {
        HStack(spacing: 0) {
            Text(time.line)
                .font(Font(AppFont.heavy(size: 30)))
                .foregroundColor(Color(Asset.primaryColor.color))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            Text(time.departure, style: .time)
                .foregroundColor(Color(Asset.secondaryColor.color))
                .font(Font(AppFont.titleFont))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }
        .background(Color.white)
        .cornerRadius(Constants.UI.cornerRadius)
        .padding([.leading, .trailing, .bottom], Constants.UI.systemSpacing)
    }
}
